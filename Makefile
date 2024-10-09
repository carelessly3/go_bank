postgres:
	docker run --name postgres_go -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=admin -d postgres
createdb:
	docker exec -it postgres_go createdb --username=root --owner=root bank_go
dropdb:
	docker exec -it postgres_go dropdb bank_go
migrateup: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose up 
migratedown: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test