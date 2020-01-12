VERSION := $(shell cat app/version.txt)
build:
	sudo docker build --tag mbigras/weather:$(VERSION) .
run:
	sudo docker run --publish 80:80 mbigras/weather:$(VERSION)
push:
	sudo docker push mbigras/weather
publish: push
upload: push
clean:
	sudo docker images \
	| awk '/mbigras\/weather/ { print $$2 }' \
	| grep -v '<none>' \
	| xargs -I {} sudo docker rmi mbigras/weather:{}
