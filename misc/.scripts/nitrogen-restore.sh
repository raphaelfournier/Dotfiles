#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

sleep 3 && run nitrogen --restore
