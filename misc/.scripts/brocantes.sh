#! /bin/bash

# TODO s/Lyon/whatever/, s/69/whatever/, s/10/distance in kilometers/
echo "à 20km de Rennes, modif le script sinon"
curl -s 'https://vide-greniers.org/evenements/Rennes-35?distance=20' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'cache-control: no-cache' \
  -H 'dnt: 1' \
  -H 'pragma: no-cache' \
  -H 'priority: u=0, i' \
  -H 'referer: https://vide-greniers.org/' \
  -H 'sec-ch-ua: "Not:A-Brand";v="24", "Chromium";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
    | sed -n '/<script type="application\/ld+json">/,/<\/script>/ { s///; p }' \
    | jq -sr '
        map(select(."@type" == "Event"))[] 
            | [.name[0:40], .startDate, .location.address.addressLocality, .location.name]
            | @tsv
    ' \
    | column -t -s $'\t'
