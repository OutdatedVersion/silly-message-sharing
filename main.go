package main

import (
        "net/http"
)

func main() {
        http.Handle("/", http.FileServer(http.Dir("/serve")))
        http.ListenAndServe(":2000", nil)
}
