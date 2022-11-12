BINARY_NAME=system-api

air_build: air_clean
air_build:
	GOARCH=amd64 GOOS=darwin go build -tags=nomsgpack -o ./tmp/main ./cmd/main.go
air_clean:
	go clean
	-rm -r ./tmp

build: clean
build:
	GOARCH=amd64 GOOS=linux go build -tags=nomsgpack -o ./build/${BINARY_NAME}-linux ./main.go
# zip ./build/function.zip ./build/${BINARY_NAME}-linux
# GOARCH=amd64 GOOS=darwin go build -o ./build/${BINARY_NAME}-darwin main.go
# GOARCH=amd64 GOOS=window go build -o ./build/${BINARY_NAME}-windows main.go

# run: export SAMPLE=sample
run:
	$(shell go env GOPATH)/bin/air

# build_and_run: build run

#* - 를 앞에 붙이면 오류무시
clean:
	go clean
	-rm -rf ./build 
# rm ${BINARY_NAME}-darwin
# rm ${BINARY_NAME}-linux
# rm ${BINARY_NAME}-windows

