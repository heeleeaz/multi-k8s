docker build -t heeleeaz/multi-client:latest -t heeleeaz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t heeleeaz/multi-server:latest -t heeleeaz/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t heeleeaz/multi-worker:latest -t heeleeaz/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push heeleeaz/multi-client:latest
docker push heeleeaz/multi-server:latest

docker push heeleeaz/multi-worker:latest
docker push heeleeaz/multi-client:$SHA
docker push heeleeaz/multi-server:$SHA
docker push heeleeaz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=heeleeaz/multi-server:$SHA
kubectl set image deployments/client-deployment client=heeleeaz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=heeleeaz/multi-worker:$SHA
