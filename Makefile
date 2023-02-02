.PHONY: default
default: help

.PHONY: help
##@ Pattern tasks

# No need to add a comment here as help is described in common/
help:
	@make -f common/Makefile MAKEFILE_LIST="Makefile common/Makefile" help

%:
	make -f common/Makefile $*

install: operator-deploy post-install ## installs the pattern, inits the vault and loads the secrets
	echo "Installed"

post-install: ## Post-install tasks - vault init and load-secrets
	@echo "Done"

test:
	make -f common/Makefile PATTERN_OPTS="-f values-global.yaml -f values-hub.yaml" test

.PHONY: kubeconform
KUBECONFORM_SKIP=-skip 'CustomResourceDefinition,Integration,BobbycarZone,Infinispan,Kafka,KafkaBridge,KafkaTopic,ActiveMQArtemis,EventListener,TriggerBinding,TriggerTemplate,Pipeline,Trigger,Task,ApiServerSource,Service,KafkaSource,Broker'
kubeconform:
	make -f common/Makefile KUBECONFORM_SKIP="$(KUBECONFORM_SKIP)" kubeconform
