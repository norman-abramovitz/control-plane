all: deploy

merge: cp-deploy.yml

login: test
	genesis do -C ${GENESIS_HOME}/bosh ${BOSH_ENVIRONMENT} login

cp-deploy.yml: cp-boshrelease.yml docker-compose.yml
	spruce merge cp-boshrelease.yml  >cp-deploy.yml

deploy: test cp-deploy.yml
	bosh -d control-plane deploy cp-deploy.yml

test:
	@echo "Checking that GENESIS_HOME was defined in the calling environment"
	@test -n "$(GENESIS_HOME)"
	@echo "Checking that BOSH_ENVIRONMENT was defined in the calling environment"
	@test -n "$(BOSH_ENVIRONMENT)"