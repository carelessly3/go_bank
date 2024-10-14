package util

import "github.com/spf13/viper"

// Config should store all configurations of the application
// the values are read by viper from config file or env variables
type Config struct {
	DBDriver      string `mapstructure:"DB_Driver"`
	DBSource      string `mapstructure:"DB_Source"`
	ServerAddress string `mapstructure:"Server_Address"`
}

func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("app")
	viper.SetConfigType("env")

	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}
	err = viper.Unmarshal(&config)
	return
}
