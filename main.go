package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/careless3/bank_go/api"
	db "github.com/careless3/bank_go/db/sqlc"
	"github.com/careless3/bank_go/util"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("no connect", err)
	}

	store := db.NewStore(conn)
	fmt.Println(config)

	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create server:", err)
	}
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server", err)
	}
}
