docker build -t henholm/multi-client:latest -t henholm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t henholm/multi-server:latest -t henholm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t henholm/multi-worker:latest -t henholm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push henholm/multi-client:latest
docker push henholm/multi-server:latest
docker push henholm/multi-worker:latest

docker push henholm/multi-client:$SHA
docker push henholm/multi-server:$SHA
docker push henholm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=henholm/multi-server:$SHA
kubectl set image deployments/client-deployment client=henholm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=henholm/multi-worker:$SHA