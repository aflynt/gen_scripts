#!/bin/bash


case $# in
0)  awk '{print $1%$2}' ;; #no args
*)  echo $1 $2 | awk '{print $1%$2}' ;; #2 args
esac
