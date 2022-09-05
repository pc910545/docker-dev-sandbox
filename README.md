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

$dependency list
(
oracle
kafka
redis
sandbox
)
