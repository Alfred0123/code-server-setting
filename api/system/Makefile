BINARY_NAME=system-api

air_build: air_clean
air_build:
	GOARCH=amd64 GOOS=darwin go build -tags=nomsgpack -o ./tmp/main ./main.go
air_clean:
	go clean
	-rm -r ./tmp

# # build: clean pre_build
# build: wire clean
# build:
# 	GOARCH=amd64 GOOS=linux go build -tags=nomsgpack -o ./build/${BINARY_NAME}-linux ./cmd/main.go
# 	zip ./build/function.zip ./build/${BINARY_NAME}-linux
# # GOARCH=amd64 GOOS=darwin go build -o ./build/${BINARY_NAME}-darwin main.go
# # GOARCH=amd64 GOOS=window go build -o ./build/${BINARY_NAME}-windows main.go

run: export SAMPLE=sample
run: export GO_ENV=local
run: export PORT=8080
run: export KO_DATA_PATH=cmd/kodata
run:
	$(shell go env GOPATH)/bin/air

build_and_run: build run

#* - 를 앞에 붙이면 오류무시
clean:
	go clean
	-rm -r ./build 
# rm ${BINARY_NAME}-darwin
# rm ${BINARY_NAME}-linux
# rm ${BINARY_NAME}-windows

