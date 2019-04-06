docker build -t arwedstorm/multi-client:latest -t arwedstorm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arwedstorm/multi-server:latest -t arwedstorm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arwedstorm/multi-worker:latest -t arwedstorm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arwedstorm/multi-client:latest
docker push arwedstorm/multi-server:latest
docker push arwedstorm/multi-worker:latest

docker push arwedstorm/multi-client:$SHA
docker push arwedstorm/multi-server:$SHA
docker push arwedstorm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arwedstorm/multi-server:$SHA
kubectl set image deployments/client-deployment client=arwedstorm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arwedstorm/multi-worker:$SHA
