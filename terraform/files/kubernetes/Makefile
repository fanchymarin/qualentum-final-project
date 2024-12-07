GREEN	= \033[0;32m
CYAN	= \033[0;36m
BLUE	= \033[0;34m
BOLD	= \033[1m
RESET	= \033[0m

NAMESPACE		= development
MANIFESTS_DIR	= manifests

all: list

list:
	@echo
	@printf "${BLUE}${BOLD}Available recipes:\n"
	@printf "  ${GREEN}${BOLD}up      ${CYAN}- Build and run the Kubernetes environment using kubectl\n"
	@printf "  ${GREEN}${BOLD}down    ${CYAN}- Remove the Kubernetes resources\n"
	@printf "  ${GREEN}${BOLD}fclean  ${CYAN}- Remove the used Docker images\n"
	@printf "  ${GREEN}${BOLD}re      ${CYAN}- Rebuild the environment (down + up)\n"
	@echo

setup:
	kubectl apply -f $(MANIFESTS_DIR)/namespace.yaml
	kubectl config set-context --current --namespace=$(NAMESPACE)

up: setup
	kubectl apply -f $(MANIFESTS_DIR)

down:
	-kubectl delete -f $(MANIFESTS_DIR)
	kubectl config set-context --current --namespace=default

fclean: down
	docker rmi postgres:17.2 fanchymarin/qualentum-web:latest

re: down up

.PHONY: all list setup up down fclean re