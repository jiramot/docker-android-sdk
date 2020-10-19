.PHONY: build

build:
	docker build -t jiramot/android .

push:
	docker push jiramot/android

run:
	docker run -it --rm jiramot/android bash