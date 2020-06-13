EXTERNAL_IP := afd1d2b4b1a0c477b8756cfcf286de31-797546638.us-west-2.elb.amazonaws.com

build:
	docker build --tag jwt-api-test .

run: build
	docker run --env-file=env_file -p 80:8080 jwt-api-test

test-auth-local: TOKEN=`curl -d '{"email":"tyler@gmail.com","password":"123supercoolpassword"}' -H "Content-Type: application/json" -X POST localhost:80/auth  | jq -r '.token'`
test-auth-local:
	curl --request GET 'http://127.0.0.1:80/contents' -H "Authorization: Bearer ${TOKEN}" | jq .


test-eks: TOKEN =`curl -d '{"email":"tylerlanigan@gmail.com","password":"password123"}' -H "Content-Type: application/json" -X POST $(EXTERNAL_IP)/auth  | jq -r '.token'`
test-eks:
	curl --request GET '$(EXTERNAL_IP)/contents' -H "Authorization: Bearer ${TOKEN}" | jq
	
