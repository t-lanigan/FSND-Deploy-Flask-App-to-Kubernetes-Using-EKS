build:
	docker build --tag jwt-api-test .

run: build
	docker run --env-file=env_file -p 80:8080 jwt-api-test

test-auth:
	export TOKEN=`curl -d '{"email":"tyler@gmail.com","password":"123supercoolpassword"}' -H "Content-Type: application/json" -X POST localhost:80/auth  | jq -r '.token'`
	curl --request GET 'http://127.0.0.1:80/contents' -H "Authorization: Bearer ${TOKEN}" | jq .