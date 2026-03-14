# Define the variable for the Makefile to use
DATABASE_URL=postgres://postgres:foobarbaz@localhost:5432/postgres

.PHONY: run-postgres
run-postgres:
	@echo Starting postgres container
	docker run -d --rm \
		--name my-postgres \
		-e POSTGRES_PASSWORD=foobarbaz \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		postgres:15.1-alpine

.PHONY: run-api-node
run-api-node:
	@echo Starting node api
	powershell -Command "$$env:DATABASE_URL='${DATABASE_URL}'; cd api-node; npm run dev"

.PHONY: run-api-golang
run-api-golang:
	@echo Starting golang api
	powershell -Command "$$env:DATABASE_URL='${DATABASE_URL}'; cd api-golang; go run main.go"

.PHONY: run-client-react
run-client-react:
	@echo Starting react client
	powershell -Command "cd client-react; npm run dev"