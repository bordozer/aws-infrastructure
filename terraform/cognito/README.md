# AWS lambda security with Cognito

## Create infrastructure
There are two environments are supported (provided as **ENV** script parameter)
- test
- prod  

To build infrastructure run
```
./tf_apply.sh <ENV>
```

## Destroy infrastructure
```
./tf_destroy.sh <ENV>
```
or (no confirmation)
```
./tf_destroy.sh <ENV> force
```
 

