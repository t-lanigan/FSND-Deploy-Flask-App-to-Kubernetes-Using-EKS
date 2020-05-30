build:
	docker build --tag jwt-api-test .

run: build
	docker run jwt-api-test --env-file=env_file

test-auth-endpoint:
	export TOKEN=`curl -d '{"email":"tyler@gmail.com","password":"123supercoolpassword"}' -H "Content-Type: application/json" -X POST localhost:8080/auth  | jq -r '.token'`