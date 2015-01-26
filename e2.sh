#!/bin/bash

if [ $1 == "-ps" ]; then
    temp=`$DM2_INST/dm2.pl -ps 1`
elif [ $# == 1 ]; then
    if [[ $1 != *[!0-9]* ]]; then
        temp=`$DM2_INST/dm2.pl -pop $1`
    else
        temp=`$DM2_INST/dm2.pl -tag $1`
    fi
elif [ $# == 2 ]; then 
    if [[ $2 != *[!0-9]* ]]; then
        temp=`$DM2_INST/dm2.pl -pop $2 -ctx $1`
    else
        temp=`$DM2_INST/dm2.pl -tag $2 -ctx $1`
    fi
else 
    echo "Num of arguments is wrong $#!"
fi
temp=`echo $temp | sed 's/^\/c/C:/'`
temp=`echo $temp | sed 's/\//\\\/g'`
#sed 's/\//\/g' $temp

#echo $temp


`explorer "$temp"`
