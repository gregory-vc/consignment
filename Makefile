build:
		cd vessel-service && $(MAKE) build 
		cd consignment-service && $(MAKE) build 
		cd consignment-cli && $(MAKE) build 
		cd user-service && $(MAKE) build 
		cd user-cli && $(MAKE) build 
		cd email-service && $(MAKE) build 
		cd api-getway && $(MAKE) build 
		docker-compose build
		docker-compose up -d
		git add --all
		git diff-index --quiet HEAD || git commit -a -m 'fix'
		git push origin master
api:
		docker-compose run -p 8080:8080 -e MICRO_REGISTRY=mdns micro api --handler=rpc --address=:8080 --namespace=go.micro.srv

auth_test: 
		curl -XPOST -H 'Content-Type: application/json' -d '{ "service": "go.micro.srv.user", "method": "UserService.Auth", "request": { "email": "ewan.valentine89@gmail.com", "password": "testing123" }}' http://localhost:8080/rpc

rpc_test:
		curl -XPOST -H 'Content-Type: application/json' -d '{ "service": "go.micro.srv.user", "method": "UserService.Create", "request": { "email": "ewan.valentine89@gmail.com", "password": "testing123", "name": "Ewan Valentine", "company": "BBC" } }' http://localhost:8080/rpc

cons_test:
		curl -XPOST -H 'Content-Type: application/json' -H 'token: sdfsdf' -d '{"service": "go.micro.srv.consignment", "token": "sad", "method": "ShippingService.CreateConsignment", "request": { "description": "This is a test", "weight": "500", "containers": []}}' --url http://localhost:8080/rpc
