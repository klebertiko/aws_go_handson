go-mod:
	go mod init

go-tidy:
	go mod tidy

go-build:
	GOOS=linux GOARCH=amd64 go build -v -ldflags '-d -s -w' -a -tags netgo -installsuffix netgo -o bin/lambda lambda/lambda.go