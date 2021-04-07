all: deploy

merge: cp-boshrelease.yml
	spruce merge cp-boshrelease.yml  >cp-deploy.yml

deploy: merge cp-deploy.yml
	bosh -d control-plane deploy cp-deploy.yml
