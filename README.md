Experimental

Looking to create a control plane for building applications either with Cloud Foundry and Kubernetes. What makes this different from other control planes is
we are trying to minized cost and integrate docker images.

![Model](docs/images/control-plane_2021-04-02_at_1.32.22_pm.png)

Used a self signed cert generated by

```
openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout registry/certs/domain.key \
  -x509 -days 365 -out registry/certs/domain.crt
```
Make has two targets:
* merge 
* deploy

The merge target creates a file called cp-deploy.yml used by makefile target deploy.

The containers-boshrelease allows us to access the docker daemon if we add in the bind
stanza. The value represents a port number which this POC is using 5010.  

Run the commmand `bosh -e <your bosh> -d control-plane vms` to get the ip address.

You can set DOCKER_HOST environment variable "tcp://\<ip-address>:5010".  The docker and docker-compose commands will reference the remote docker daemon.

This becomes painful when switching between your local docker and your remote docker.

Docker provides another mechanism called contexts and then then we can pass the context
argument when you want to communicate to the remote docker daemon.

```
docker context create cp --docker 'host=tcp://10.128.104.132:5010'
docker context ls
docker --context cp ps
docker-compose --context cp -p running ps
```

NOTE: I am not sure why "docker-compose --context cp ps" does not show anything  
Answer: James explained that he created a project his deployment.  So docker displays o
everything while docker-compose needs to display by project.

NOTE: Kludge in the jumpbox shared by using my pubic key for tpol and norm.  I did not
try to save this information yet in the repository.

NOTE: Had issues with trying to increase the persistent disk size. It only seemed to work
when I delete-deployment and deploy.   I did not try all combinations of bosh recreate.

