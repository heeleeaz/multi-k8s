docker build -t heeleeaz/multi-client -f ./client/Dockerfile ./client
docker build -t heeleeaz/multi-server -f ./client/Dockerfile ./server
docker build -t heeleeaz/multi-worker -f ./client/Dockerfile ./worker
docker push heeleeaz/multi-client
docker push heeleeaz/multi-server
docker push heeleeaz/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=heeleeaz/multi-server
