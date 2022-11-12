package config

import (
	"fmt"
	"log"
	"os"

	"github.com/spf13/viper"
)

const (
	ENV_LOCAL = "local"
	ENV_PRODUCTION = "production"
)

var RuntimeConf = RuntimeConfig{}

type RuntimeConfig struct {
	// Datasource Datasource `yaml:"datasource"`
	SAMPLE string `mapstructure:"SAMPLE"`
	ENV string `mapstructure:"ENV"`
	PORT int ``
}

func SetEnv () {
	// env := os.Getenv("GO_ENV")
	env, exists := os.LookupEnv("GO_ENV")
	if !exists {
		env = "local"
	}

	viper.SetConfigName(env)
	viper.SetConfigType("yaml")
	viper.AddConfigPath("./env")

	//* system env 값을 기본으로 사용하고 싶을때 다음과 같이 세팅 / 이러면 system env 가 없는경우 yaml 파일 값 세팅
	viper.BindEnv("SAMPLE")

	err := viper.ReadInConfig()
	if err != nil {
		panic("config file not found")
	}
	err = viper.Unmarshal(&RuntimeConf)
	if err != nil {
		panic(err)
	}
	// * 이후 config 을 받아서 다음과 같이 사용하면 된다.
	// log.Printf("GO_ENV: %s", config.RuntimeConf.ENV)
	// fmt.Println("SAMPLE: %s", RuntimeConf.SAMPLE)
	log.Printf(fmt.Sprintf("SAMPLE: %s", RuntimeConf.SAMPLE))
}

func IsLocal () bool {
	return RuntimeConf.ENV == ENV_LOCAL
}