# docker-dev-sandbox

# first init
./restart.sh all

#rebuild sandbox or other dependency
./restart.sh
./restart.sh $dependency

# clean init all 
./clean-restart.sh all 

# clean init sandbox or other dependency
./clean-restart.sh 
./clean-restart.sh $dependency

# conntct docker-network kafka 
### using kafdrop: https://hub.docker.com/r/obsidiandynamics/kafdrop

doc: https://cutejaneii.wordpress.com/2017/08/29/kafka-4-kafka%E7%9B%A3%E6%8E%A7%E5%B7%A5%E5%85%B7kafdrop-%E5%AE%89%E8%A3%9D%E5%8F%8A%E7%B0%A1%E4%BB%8B/

```
./restart.sh kafka
vist http://localhost:9000/ to see admin UI
```

### using kcat cmd tool
doc: https://www.cnblogs.com/xdao/p/10674848.html

```
brew install kcat

#non auth
kcat -b localhost:9092 -L 
kcat -b 127.0.0.1:9093 -L 

#auth
kcat -b localhost:9092 -F kafka-client.conf -L 
```

# Generate Kafka keystore 
doc: https://raw.githubusercontent.com/confluentinc/confluent-platform-security-tools/master/kafka-generate-ssl.sh

```
brew install java
cd resource
bash kafka-generate-ssl.sh
```

# conntct docker-network redis
1. install redis-cli 
```
brew install redis
```
2. make sure your local redis is up and set env REDIS_PASSWORD on env_local_overwrite.sh
```
docker ps | grep "redis-db"
```

3. redis-cli-with-password
```
redis-cli -a $REDIS_PASSWORD
```

$dependency list
(
oracle
kafka
redis
sandbox
)
