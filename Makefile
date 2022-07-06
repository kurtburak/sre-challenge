deploy:
	./deploy.sh

create_k8s_cluster:
	./create-cluster-with-registry.sh

delete_k8s_cluster:
	kind delete cluster --name pleo
