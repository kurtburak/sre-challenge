REGISTRY=localhost:5000/pleo

deploy: build_and_push
	./deploy.sh

deploy_no_build:
	./deploy.sh

create_k8s_cluster:
	./create-cluster-with-registry.sh

destroy:
	kind delete cluster --name pleo

build_and_push: create_k8s_cluster
	# Build invoice-app
	docker build -t ${REGISTRY}/invoice-app -f invoice-app/Dockerfile ./invoice-app

	# Build payment-provider
	docker build -t ${REGISTRY}/payment-provider -f payment-provider/Dockerfile ./payment-provider

	# Push ${REGISTRY}/invoice-app
	docker push ${REGISTRY}/invoice-app

	# Push ${REGISTRY}/payment-provider
	docker push ${REGISTRY}/payment-provider

test:
	./test.sh
