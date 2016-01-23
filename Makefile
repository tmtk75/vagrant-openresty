run:
	curl 192.168.1.100:8000

build:
	docker build -t openresty.build .
	docker run -v `pwd`:/target openresty.build 
