docker build -t tussitos/multi-client:latest -t tussitos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tussitos/multi-server:latest -t tussitos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tussitos/multi-worker:latest -t tussitos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tussitos/multi-client:latest
docker push tussitos/multi-server:latest
docker push tussitos/multi-worker:latest

docker push tussitos/multi-client:$SHA
docker push tussitos/multi-server:$SHA
docker push tussitos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tussitos/multi-client:$SHA
kubectl set image deployments/server-deployment server=tussitos/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tussitos/multi-worker:$SHA
