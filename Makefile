all: deploy

merge: cp-deploy.yml

login:
	genesis do -C ${GENESIS_HOME}/bosh ${BOSH_ENVIRONMENT} login

cp-deploy.yml: cp-boshrelease.yml docker-compose.yml
	spruce merge cp-boshrelease.yml  >cp-deploy.yml

deploy: cp-deploy.yml
	bosh -d control-plane deploy cp-deploy.yml
