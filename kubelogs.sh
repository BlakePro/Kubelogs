#!/bin/bash
createdAt=$(date '+%Y%m%d%H%M')
dir=./logs/ #Default directory
echo ""
echo "Log Date $createdAt"
names=$(kubectl get namespace | awk '{print $1}')
for nombrespace in $names ; do
	#if [[ "$nombrespace" == "wordstartwith"* ]] ; then #if you need certain namespaces starts with
		echo ""
		echo "Creating log $nombrespace"
		filename=${dir}${nombrespace}.${createdAt}.log
		test -f $filename || touch $filename
    pods=$(kubectl get pods --namespace $nombrespace | awk '{print $1}')
    for nombrepod in $pods ; do
			if [ ! -z "$nombrepod" ] ; then
				if [[ "$nombrepod" != "NAME"* ]] ; then
					echo "  -> $nombrepod"
		    	kubectl logs -n $nombrespace $nombrepod >> $filename
				fi
			fi
    done
	#fi
done
