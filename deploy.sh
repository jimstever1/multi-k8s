docker build -t deskmonkey/multi-client:latest -t deskmonkey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deskmonkey/multi-server:latest -t deskmonkey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deskmonkey/multi-worker:latest -t deskmonkey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deskmonkey/multi-client:latest
docker push deskmonkey/multi-client:$SHA
docker push deskmonkey/multi-server:latest
docker push deskmonkey/multi-server:$SHA
docker push deskmonkey/multi-worker:latest
docker push deskmonkey/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=deskmonkey/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=deskmonkey/multi-worker:$SHA
kubectl set image deployments/client-deployment client=deskmonkey/multi-client:$SHA