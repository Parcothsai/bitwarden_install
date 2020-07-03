#!/bin/bash
set -e
EMAIL=$1
LASTEST_VERSION="latest.tar.gz"
INSTALL_DIR="bitwarden_install-latest"

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
curl 'https://api.bitwarden.com/installations'   -H 'authority: api.bitwarden.com'   -H 'accept: application/json, text/javascript, */*; q=0.01'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36'   -H 'content-type: application/json; charset=UTF-8'   -H 'origin: https://bitwarden.com'   -H 'sec-fetch-site: same-site'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-dest: empty'   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data-binary "$(send_email)"   --compressed >> response.json

Id=$(cat response.json | jq '.Id' | sed 's/"//g')
Key=$(cat response.json | jq '.Key' | sed 's/"//g')

############ INSTALL BITWARDEN ############
bash $INSTALL_DIR/bitwarden.sh install <<EOF
localhost
$Id
$Key
n
n
n
EOF
############ START BITWARDEN ############
bash $INSTALL_DIR/bitwarden.sh start
rm -r $LASTEST_VERSION
