package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handleAPIEvent(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	for key, value := range request.Headers {
		fmt.Printf("key: %v, value: %v\n", key, value)
	}
	fmt.Println("Body: ", request.Body)

	response := events.APIGatewayProxyResponse{}
	var err error

	response.Body = "{ \"message\": \"Hello AWS Lambda\" }"
	response.StatusCode = 200
	return response, err
}

func main() {
	lambda.Start(handleAPIEvent)
}
