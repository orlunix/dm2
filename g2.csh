#!/bin/tcsh

if ( "$1" == "-t" ) then
    cd `depth`
else if ( "$1" == "-ps" ) then
    cd `~/test/coderepos/dm/dm2.pl -ps 1`
else if ( $#argv == 2) then 
    if( "$2" =~ [0-9]* ) then
        cd `~/test/coderepos/dm/dm2.pl -pop $2 -ctx $1`
    else
        cd `~/test/coderepos/dm/dm2.pl -tag $2 -ctx $1`
    endif
else if ( $#argv == 1 ) then
    if( "$1" =~ [0-9]* ) then
        cd `~/test/coderepos/dm/dm2.pl -pop $1`
    else
        cd `~/test/coderepos/dm/dm2.pl -tag $1`
    endif
else 
    echo "Num of arguments is wrong!"
endif
