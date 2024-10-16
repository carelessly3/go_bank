postgres:
	docker run --name postgres_go --netowork bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=admin -d postgres
createdb:
	docker exec -it postgres_go createdb --username=root --owner=root bank_go
dropdb:
	docker exec -it postgres_go dropdb bank_go
migrateup: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose up 
migrateup1: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose up 1
migratedown: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose down
migratedown1: 
	migrate -path db/migration -database "postgresql://root:admin@localhost:5432/bank_go?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server: 
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/careless3/bank_go/db/sqlc Store
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock migratedown1 migrateup1