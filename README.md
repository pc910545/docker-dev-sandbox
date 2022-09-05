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

# conntct local redis
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
