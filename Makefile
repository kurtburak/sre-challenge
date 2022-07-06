REGISTRY=localhost:5000/pleo

deploy:
	./deploy.sh

create_k8s_cluster:
	./create-cluster-with-registry.sh

delete_k8s_cluster:
	kind delete cluster --name pleo

build:
	# Build invoice-app
	docker build -t ${REGISTRY}/invoice-app -f invoice-app/Dockerfile ./invoice-app
	# Push ${REGISTRY}/invoice-app
	docker push ${REGISTRY}/invoice-app

	# Build payment-provider
	docker build -t ${REGISTRY}/payment-provider -f payment-provider/Dockerfile ./payment-provider
	# Push ${REGISTRY}/payment-provider
	docker push ${REGISTRY}/payment-provider
