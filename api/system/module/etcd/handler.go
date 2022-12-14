package etcd

import (
	"log"
	"sync"
	"time"

	clientv3 "go.etcd.io/etcd/client/v3"
	"google.golang.org/grpc/connectivity"
)

func init() {}

func Run() {
	log.Println("etcd run")
}

// TODO. connection auto close proxy 가 있다면, 싱글톤 말고 그때그때 go routine 으로 생성하고 닫고 하는 방식이 더 좋을것 같다.
type handler struct {
	client *clientv3.Client
}
var (
	hdl *handler
	hdlOnce sync.Once
)
func connect() *clientv3.Client {
	cli, err := clientv3.New(clientv3.Config{
		Endpoints: []string{"localhost:2379"},
		DialTimeout: 5 * time.Second,
		DialKeepAliveTime:    2 * time.Second,
		DialKeepAliveTimeout: 2 * time.Second,
	})
	if err != nil {
		panic("etcd can not connect")
	}
	return cli
}
func Connection() *clientv3.Client {
	hdlOnce.Do(func () {
		hdl = &handler{
			client: connect(),
		}
	})

	con := hdl.client.ActiveConnection()
	state := con.GetState()
	if (state != connectivity.Ready && state != connectivity.Connecting) {
		log.Printf("state: %s", state)
		hdl.client = connect()
	}

	return hdl.client
}
