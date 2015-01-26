#! /usr/bin/perl
##! /home/utils/perl-5.8.8/bin/perl
use strict;
use Getopt::Long;
use Data::Dumper;
#use File::Find;
#use XML::Simple;
#use File::Basename;
#use Data::DumpXML qw(dump_xml);
#use Expect;

my $DBHOME=$ENV{'DM2_HOME'};
die "DM2_HOME :$DBHOME: not configed or exists!\n" if(-d $DBHOME);
$DBHOME=`cd $DBHOME; pwd;`;
chomp($DBHOME);
my $dbfile      ="$DBHOME/.dmfile";
my $dbtag       ="$DBHOME/.dmtag";
my $dm2cfgfile  ="$DBHOME/.dm2cfg";
my $dm2stackfile="$DBHOME/.dm2stack";
#my %dbhash=();
my $dbhash;
my $taghash;
my $help;
my @dbpush;
my $tag;
my $list;
my $del;
my $ddel;
my $dc; # delete contex
my $pop;
my $ctx;
my $dm2cfg;
my $chctx;
my $ps; #push/pop stack

my $mpath;
my @showpaths=();
my $i;
my $strdir;

GetOptions(
    "help+"         =>  \$help,
    "dbfile=s"      =>  \$dbfile,
    "push=s"        =>  \@dbpush,
    "tag=s"         =>  \$tag,
    "pop=i"         =>  \$pop,
    "list=i"        =>  \$list,
    "del=i"         =>  \$del,
    "ddel=i"        =>  \$ddel,
    "dc=i"          =>  \$dc,
    "ctx=i"         =>  \$ctx,
    "chctx=i"       =>  \$chctx,
    "ps=i"          =>  \$ps,
    );

my $dm2stackarray;
if(defined($ps)){
    if($ps == 0){ #push
        print "Warning: dm2 stack file not exist!\n" if(!-e $dm2stackfile);

        if(-e $dm2stackfile){
            $dm2stackarray = do $dm2stackfile if(-e $dm2stackfile);
        }else{
            $dm2stackarray = [];
        }
        die "Pushed dir not defined!\n" if(!@dbpush);
        $strdir = $dbpush[0];
        $strdir = `cd $strdir; pwd`;
        chomp ($strdir);
        push @$dm2stackarray, $strdir;
    }else{ #pop
        die "dm2 stack file not exist!\n" if(!-e $dm2stackfile);
        $dm2stackarray = do $dm2stackfile;
        die "Cannot parse stack file!\n" if(!defined $dm2stackarray);
        die "Stack empty!\n" if(!@$dm2stackarray);
        $strdir = pop @$dm2stackarray;
        #$strdir = shift @$dm2stackarray;
        #push @$dm2stackarray, $strdir if(!@$dm2stackarray);
        print ($strdir);
    }
    open (DC, '+>', $dm2stackfile) or die "Can not open dm2stack file!\n";
    print DC Dumper($dm2stackarray);
    exit(0);
}
if(-e "$dm2cfgfile"){
    $dm2cfg = do $dm2cfgfile || print "Warning: can not read dm2cfg file!\n";
}else{ # default cfg
    ${$dm2cfg}{'defaultctx'} = 0;
}
if(defined($chctx)){
    open (DC, '+>', $dm2cfgfile) or die "Can not open dm2cfg file : $dm2cfgfile";
    if($chctx < 8 && $chctx >= 0){
        ${$dm2cfg}{'defaultctx'} = $chctx;
    }else{
        ${$dm2cfg}{'defaultctx'} = 0;
    }
    print DC Dumper($dm2cfg);
    exit(0);
}

if(defined($list)){
    my $emptyflag = 1;
    if($list > 8){ #list all ctx
        for($i = 0; $i < 8; $i ++){
            if(-e "$dbfile$i"){
                if(&listdirs("$dbfile$i", $i)){
                    $emptyflag = 1;
                }
            }
        }
        die "all dbhash empty" if(!$emptyflag);
        exit(0);
    }else{
        if($list == 8 || $list < 0){
            $list = ${$dm2cfg}{'defaultctx'};
        }

        if(-e $dbfile.$list){
            if(&listdirs($dbfile.$list, $list)){
                exit(0);
            }else{
                die "Can not read path file: $dbfile.$list\n"
            }
        }else{
            die "Contex $list doesn't exist!\n";
        }
    }
}

if(!defined ($ctx)){
    $ctx = ${$dm2cfg}{'defaultctx'}; 
}

if(-e "$dbfile$ctx"){
    $dbhash = do "$dbfile$ctx" || die "Can not read path file: $dbfile$ctx\n";
}else{
    %{$dbhash} = ();
    print "WARNING: No dbfile exists!\n";
}

if(defined($tag) || defined($del) || defined($ddel)){
    #print "dbtagctx : $dbtag$ctx\n\n";
    if(-e "$dbtag$ctx"){
        $taghash = do "$dbtag$ctx" || die "Can not read tag file: $dbtag$ctx\n";
    }elsif(defined($tag) && !@dbpush){ 
        print "WARNING: No dbtag exists!\n";
    }
}

#print Dumper(\@dbpush);
if(defined ($tag)){
    if(@dbpush){
        if(-e $dbpush[0]){
            open (DF, '+>', $dbtag.$ctx) or die "Can not open tag file : $dbtag$ctx";
            $strdir = $dbpush[0];
            $strdir =~ s/ /\\ /g;
            $strdir =~ s/\(/\\\(/g;
            $strdir =~ s/\)/\\\)/g;
            $strdir = `cd $strdir; pwd`;
            chomp ($strdir);
            ${$taghash}{$tag} = $strdir;
            print DF Dumper($taghash);
            #exit(0);
        }else{
            print "WARNING: tagged path not exists!\n";
        }
    }else{#print a taged path
        #print Dumper($taghash);
        die "taghash empty!\n" if (!keys %{$taghash});
        die "tag not exist!\n" if (!-e ${$taghash}{$tag});
        print ${$taghash}{$tag};
    }
}

if(@dbpush){
    open (DF, '+>', $dbfile.$ctx) or die "Can not open path file : $dbfile$ctx";
    foreach (0..$#dbpush){
        $strdir = shift (@dbpush);
        $strdir =~ s/ /\\ /g;
        $strdir =~ s/\(/\\\(/g;
        $strdir =~ s/\)/\\\)/g;
        $strdir = `cd $strdir; pwd`;
        chomp ($strdir);
        push @dbpush, $strdir;
    }
    foreach $mpath (@dbpush){
        #if(-e $mpath && !exists ${$dbhash}{$mpath}){
        if(-e $mpath){
            if(defined($tag)){
                ${$dbhash}{$mpath} = $tag;
            }else{
                ${$dbhash}{$mpath} = 1;
            }
        }
    }
    print DF Dumper($dbhash); 
    exit(0);
}

if(defined ($pop)){
    @showpaths = ();
    die "dbhash empty!\n" if (!keys %{$dbhash});
    foreach $mpath (sort keys %{$dbhash}){
        if(${$dbhash}{$mpath} != 0 || ${$dbhash}{$mpath} =~ /^(\D)/){
            push @showpaths, $mpath;
        } 
    }
    print "$showpaths[$pop]\n";
    exit(0);
}

if(defined($ddel) || defined($del)){
    my $del_index;
    if(defined($ddel)){
        $del_index = $ddel;
    }else{
        #not supported
        $ddel = $del;
        $del_index = $del;
    }
    open (DF, '+>', $dbfile.$ctx) or die "Can not open path file : $dbfile$ctx";
    $i = 0;
    die "dbhash empty!\n" if (!keys %{$dbhash});
    foreach $mpath (sort keys %{$dbhash}){
        if($i == $del_index){
            my $tag = ${$dbhash}{$mpath};
            if(${$dbhash}{$mpath} != 0 || ${$dbhash}{$mpath} =~ /^(\D)/){
                if(defined($ddel)){
                    delete ${$dbhash}{$mpath};
                }else{
                    ${$dbhash}{$mpath} = 0;
                }
            }elsif($tag =~ /^(\D)/){#with a tag
                if(exists ${$taghash}{$tag}){
                    delete ${$taghash}{$tag};
                }
            }
            print "DDELing\t\t$mpath\n";
        }
        $i ++;
    }
    print DF Dumper($dbhash); 
    exit(0);
}

if(defined($dc)){
    die "Contex $dc doesn't exist!\n" if(! -e $dbfile.$dc);
    print "Deleting contex $dc, y/n?:";
    my $x = getc;
    if($x eq "y"){
        print "RMing\t\t$dbfile$dc\n";
        system("rm $dbfile$dc");
    }
    exit(0);
}

sub listdirs{
    my ($dmfile, $ctx) = @_;
    my $dmhash = do "$dmfile" || return 0; 
    my $j = 0;
    printf "Listing dirs in context $ctx ......................................................:\n";
    foreach my $mpath (sort keys %{$dmhash}){
        if(${$dmhash}{$mpath} != 0 || ${$dmhash}{$mpath} =~ /^(\D)/){
            #print "$i\t\t$mpath\n";
            if(${$dmhash}{$mpath} =~ /^(\D)/){
                printf "%2d.......`$mpath````%2d....${$dmhash}{$mpath}\n", $j, $j;
            }else{
                printf "%2d.......`$mpath```$j\n", $j;
            }
            $j ++;
        } 
    }
    return 1;
}


