#!/bin/bash

if [ $1 == "-list" ]; then
    if [ ! -z "$2" ]; then
        if [ $2 == "a" ]; then
            ~/test/coderepos/dm/dm2.pl -list 9;
        else
            ~/test/coderepos/dm/dm2.pl -list $2;
        fi
    else 
        ~/test/coderepos/dm/dm2.pl -list 8;
    fi
elif [ $1 == "-ps" ]; then
    if [ ! -z $2 ]; then
        ~/test/coderepos/dm/dm2.pl -push $2 -ps 0;
    else 
        ~/test/coderepos/dm/dm2.pl -push .  -ps 0;
    fi
elif [ $1 == "-push" ]; then
    if [ ! -z $4 ]; then
        ctx=$4;
        ~/test/coderepos/dm/dm2.pl -push $2 -tag $3 -ctx $4;
    elif [ ! -z $3 ]; then
        ctx=$3;
        if [[ $3 == [0-7] ]]; then
            ~/test/coderepos/dm/dm2.pl -push $2 -ctx $3;
        else
            ~/test/coderepos/dm/dm2.pl -push $2 -tag $3;
        fi
    else 
        ~/test/coderepos/dm/dm2.pl -push $2;
    fi
elif [ $1 == "-pop" ] || [ $1 == "-del" ] || [ $1 == "-ddel" ]; then #pop del ddel
    if [ ! -z $3 ]; then
        ctx=$2;
        ~/test/coderepos/dm/dm2.pl $1 $3 -ctx $2;
    else 
        ~/test/coderepos/dm/dm2.pl $1 $2;
    fi
fi
#cd `/home/hren/test/coderepos/dm/dm2.pl -pop $1`
