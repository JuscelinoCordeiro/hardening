#!/bin/bash

ping -c 5 8.8.8.8 >> $PWD/hardening.log

#if [ $? -eq 0 ]
then
	echo "rede ok"
	#return 10
else
	#return 20
	echo "sem rede"
fi