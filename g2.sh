#!/bin/bash

if [ $1 == "-t" ]; then
    cd `depth`
elif [ $1 == "-ps" ]; then
    cd `$DM2_INST/dm2.pl -ps 1`
elif [ $# == 1 ]; then
    if [[ $1 != *[!0-9]* ]]; then
        cd `$DM2_INST/dm2.pl -pop $1`
    else
        cd `$DM2_INST/dm2.pl -tag $1`
    fi
elif [ $# == 2 ]; then 
    if [[ $2 != *[!0-9]* ]]; then
        cd `$DM2_INST/dm2.pl -pop $2 -ctx $1`
    else
        cd `$DM2_INST/dm2.pl -tag $2 -ctx $1`
    fi
else 
    echo "Num of arguments is wrong $#!"
fi
