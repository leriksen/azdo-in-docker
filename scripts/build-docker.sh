cd ../docker
az acr build --registry azdocr --image "leriksen/pipelines-azp-docker-linux" --file "./Dockerfile" .
cd -
