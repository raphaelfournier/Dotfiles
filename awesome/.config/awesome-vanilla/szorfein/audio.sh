#!/bin/sh

audio_card=""
volume=""
alsa=""
pulse=""
log_file="/tmp/audio.log"
log=false # true or false
time=$(date)
mpc=$(which mpc 2>/dev/null 2>&1)

log() {
  if [ $log == true ] ; then
    echo "$time - $1" >> $log_file
  fi
}

die() {
  log "[DIE]: $1"
  exit 1
}

detect_bin() {
  alsa=$(which amixer 2>/dev/null 2>&1)
  pulse=$(which pactl 2>/dev/null 2>&1)
  log "detect_bin - alsa : $alsa , pulse : $pulse"
  if [[ ! -x $alsa ]] && [[ ! -x $pulse ]] ; then
	  die "detect_bin - fail to detect amixer or pulse"
  fi
}

check_audio_card() {
  local card
  if card=$(cat /proc/asound/card*/id | grep -i "^$1$") ; then
    audio_card=$1
  fi
}

for_pulse() {
  local sink
  log "Attemp with pulse $pulse"
  sink=$($pulse list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
  volume=$($pulse list sinks | grep '^[[:space:]]Volume:' | head -n $(( $sink + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
  if [[ ! -z $sink ]] && [[ ! -z $volume ]] ; then
    echo "pactlPulse$1: $volume%"
    return 0
  fi
  die "Card no found with pulse s:$sink - n:$now -a:$1"
}

for_alsa() {
  local p a
  log "Attemp with alsa $alsa"
  p=$($alsa -c $1 -M -D pulse sget Master 2>/dev/null | grep -o -E "[[:digit:]]+%" | head -n 1)
  a=$($alsa -c $1 -M get Master 2>/dev/null | grep -o -E "[[:digit:]]+%" | head -n 1)

  if [ ! -z $p ] ; then
    echo "amixerPulse$1: $p"
    return 0
  elif [ ! -z $a ] ; then
    echo "amixerAlsa$1: $a"
    return 0
  fi
  die "ALSA - No found with $alsa and $1 , p:<<  $p >>, a:<< $a >>"
}

alsa_or_pulse() {
  if [[ -x $pulse ]] ; then
    for_pulse
  elif [[ -x $alsa ]] ; then
    for_alsa $1
  else
	  die "No found $alsa or $pulse"
  fi
}

# Check first a card given as argument else try card n2 or n1
show_volume() {
	detect_bin
  if [ ! -z $audio_card ] ; then
    alsa_or_pulse $audio_card
  elif alsa_or_pulse 2 ; then
    echo
  elif alsa_or_pulse 1 ; then
    echo
  elif alsa_or_pulse 0 ; then
    echo
  else
    die "volume no found with amixer"
  fi
}

music_state() {
  local music_info
  [ -z $mpc ] && die "mpc no found"
  if music_info="$(mpc | grep  "playing\|paused\|stop" | awk '{print $3,$4}' | tr -d '()')" ; then
    echo "$music_info"
  fi
}

draw() {
  local v inc out size cur_lenght bar
  cur_lenght="$(mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}')"
  size=28
  inc=$(( cur_lenght * size / 100 ))
  out=
  #bar=$(grep "^progressbar" ~/.ncmpcpp/config | awk '{print $3}' | tr -d '"')
  bar="■"
  for v in $(seq 0 $(( size - 1 )) ) ; do
    test "$v" -le "$inc" && \
      out="${out}${bar:--}" || \
      out="${out}┄"
  done
  echo $out
}

searchAlbumCover() {
  local MUSIC_DIR="$1"
  local file="$(mpc --format %file% current)"
  local album_dir="${file%/*}"
  local cover=""
  local src=""
  album_dir="$MUSIC_DIR/$album_dir"
  if [ -d "$album_dir" ] ; then
    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    if [ -f "$src" ] ; then
      echo "$src"
    fi
  fi
}

call_mpc_details() {
  local img title album artist

  img=$(searchAlbumCover "$1")
  artist="$(mpc current -f %artist% | tr -d "%([]){}\1/")"
  #album="$(mpc current -f %album% | tr -d "%([]){}\1/")"
  title="$(mpc current -f %title% | tr -d "%([]){}\1/")"

  echo "img:[$img] title:[${title:0:30}] artist:[$artist] percbar:[$(draw)]"
}

music_details() {
  local mpd_is_playing="$(mpc | grep "playing\|paused")"
  if [[ ! -z $mpd_is_playing ]] ; then
    call_mpc_details "$1"
  else
    exit 1
  fi
}

case $1 in
  volume) 
    check_audio_card $2
    show_volume $2
    shift
    shift
    ;;
  music)
    music_state
    shift
    ;;
  music_details)
    music_details "$2"
    shift
    shift
    ;;
  *)
    die "arg: $1 not recognized"
esac

exit 0
