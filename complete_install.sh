#!/bin/bash
set -e
EMAIL=$1
LASTEST_VERSION="latest.tar.gz"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


############ FUNCTION ############
send_email()
{
	cat <<EOF
{
"email": "$EMAIL"
}
EOF
}
############ GET KEYS ############
if [[ ! -f $DIR/response.json ]]; then
	curl 'https://api.bitwarden.com/installations'   -H 'authority: api.bitwarden.com'   -H 'accept: application/json, text/javascript, */*; q=0.01'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36'   -H 'content-type: application/json; charset=UTF-8'   -H 'origin: https://bitwarden.com'   -H 'sec-fetch-site: same-site'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-dest: empty'   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data-binary "$(send_email)"   --compressed > $DIR/response.json
fi

Id=$(cat $DIR/response.json | jq '.Id' | sed 's/"//g')
Key=$(cat $DIR/response.json | jq '.Key' | sed 's/"//g')

############ INSTALL BITWARDEN ############
bash $DIR/bitwarden.sh install <<EOF
localhost
$Id
$Key
n
n
n
EOF
############ START BITWARDEN ############
bash $DIR/bitwarden.sh start
rm -r $LASTEST_VERSION
