docker build -t arfanrfn/multi-client:latest -t arfanrfn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arfanrfn/multi-server:latest -t arfanrfn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arfanrfn/multi-worker:latest -t arfanrfn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arfanrfn/multi-client:latest
docker push arfanrfn/multi-server:latest
docker push arfanrfn/multi-worker:latest

docker push arfanrfn/multi-client:$SHA
docker push arfanrfn/multi-server:$SHA
docker push arfanrfn/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=arfanrfn/multi-client:$SHA
kubectl set image deployments/server-deployment server=arfanrfn/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=arfanrfn/multi-worker:$SHA
