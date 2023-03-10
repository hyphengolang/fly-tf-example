package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/jackc/pgx/v5/pgxpool"
)

func run() error {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	dbConn, err := newCockroachDB(context.Background())
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}
	defer dbConn.Close()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// ping the database
		if err := dbConn.Ping(context.Background()); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// write a response
		w.Write([]byte("Hello, World!"))
	})

	return http.ListenAndServe(":"+port, nil)
}

func newCockroachDB(ctx context.Context) (*pgxpool.Pool, error) {
	dbConn := os.Getenv("DATABASE_URL")
	if dbConn == "" {
		return nil, fmt.Errorf("DATABASE_URL must be set")
	}

	pool, err := pgxpool.New(ctx, dbConn)
	if err != nil {
		return nil, err
	}

	if err := pool.Ping(ctx); err != nil {
		return nil, err
	}

	return pool, nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
