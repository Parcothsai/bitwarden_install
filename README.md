# BITWARDEN AUTO INSTALL
## REQUIREMENTS
 
	-  Docker
	-  docker-compose
	-  wget
	-  jq

## GET LAST RELEASE

` wget https://github.com/Parcothsai/bitwarden_install/archive/latest.tar.gz `

## Execution

` tar xvf latest.tar.gz `

` bash bitwarden_install-latest/complete_install.sh YOUR_EMAIL@YOUR_EMAIL `

` rm response.json `

### OTHER DIRECTORY INSTALLATION

#### GET LAST RELEASE

` wget https://github.com/Parcothsai/bitwarden_install/archive/latest.tar.gz -P /opt/bitwarden/ `

#### Execution

` tar xvf /home/ec2-user/latest.tar.gz --directory=/opt/bitwarden/ `
` bash /opt/bitwarden/bitwarden_install-latest/complete_install.sh YOUR_EMAIL@YOUR_EMAIL `
` rm /opt/bitwarden/response.json `
