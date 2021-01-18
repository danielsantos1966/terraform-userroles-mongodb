#!/bin/bash


# vars
CLUSTER=$1
FAIL_COUNT=0
OKAY_COUNT=-8
LOOP_COUNT=0

if [ "$#" -lt "1" ]
  then echo "Enter the cluster name as a parameter"
	  exit 1
fi

sleep 120
while true
do
	STATUS=`mongo mongodb://$CLUSTER --eval "rs.status()" | grep -v stateStr | grep state | awk -F: '{ print $2 }' | sed 's/[ |,]//g'`

	for RESPONSE in $STATUS;
	do

		if [ $RESPONSE -gt 2 ] ; then
			FAIL_COUNT=$[$FAIL_COUNT +3]
			echo "$(date -u) Waiting for Mongo establish cluster service | status:$RESPONSE"
		else
			OKAY_COUNT=$[$OKAY_COUNT +1]
		fi

	done
	#echo ">>>>> [$LOOP_COUNT] Result: ok_count:$OKAY_COUNT FAIL_COUNT:$FAIL_COUNT"

	if [ $OKAY_COUNT -gt $FAIL_COUNT ] ; then
		echo Cluster $CLUSTER is UP and Running
		exit 0
	fi

	if [ $FAIL_COUNT -gt 100 ] ; then
		echo Cluster $CLUSTER FAILED to start mongo service
		exit 1
	fi

	sleep 300
	LOOP_COUNT=$[$LOOP_COUNT + 1]
done

# State codes:
# 0 = Starting up (phase 1)
# 1 = Primary
# 2 = Secondary
# 3 = Recovering
# 4 = Fatal error
# 5 = Starting up (phase 2)
# 6 = Unknown state
# 7 = Arbiter
# 8 = Down
# https://blog.serverdensity.com/mongodb-monitoring-rs-status/
