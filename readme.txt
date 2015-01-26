* dm2:
*.
    * An directory/path management tool, POR
    *.
        * list all the available trees in your scrach.
        * map the index with mnemonic

//this script was managemented in svn, didn't find a easy way to covert svn repository to git repository. So just paste the history logs from svn repos
----
------------------------------------------------------------------------
r52 | hren | 2015-01-19 02:11:51 -0800 (Mon, 19 Jan 2015) | 2 lines

Fixed bugs in dm2 in last change 

------------------------------------------------------------------------
r51 | hren | 2015-01-19 02:06:21 -0800 (Mon, 19 Jan 2015) | 16 lines

Updated dm2.pl to make it easier to install; Added some scripts which only be workable in sc:
   cron/sc_cron_gm20x.csh
   cron/cron_ar2_gm20x
   cron/nvgpu_as2
   cron/sc_cron_se.csh
   cron/as2_regress.pl.as2_gm20x
   cron/tgen.pl.as2
   cron/cron_ar2_se
   bin/pld
   bin/cpso
   bin/rf
   bin/ascc



------------------------------------------------------------------------
r50 | hren | 2014-11-10 01:54:55 -0800 (Mon, 10 Nov 2014) | 2 lines

fixed a bug for dm2 tag

------------------------------------------------------------------------
r49 | hren | 2014-11-10 01:45:22 -0800 (Mon, 10 Nov 2014) | 3 lines

Added tag schem in dm2


------------------------------------------------------------------------
r27 | hren | 2013-12-06 01:42:19 -0800 (Fri, 06 Dec 2013) | 2 lines

Updated windows environment

------------------------------------------------------------------------
r26 | hren | 2013-12-03 18:20:51 -0800 (Tue, 03 Dec 2013) | 2 lines

Rename dm2parse.csh to dm2parse.sh to syncup env with windows.

------------------------------------------------------------------------
r16 | hren | 2013-09-11 18:42:37 -0700 (Wed, 11 Sep 2013) | 2 lines

update cdt cmd

------------------------------------------------------------------------
r13 | hren | 2013-08-07 04:05:43 -0700 (Wed, 07 Aug 2013) | 2 lines

Added stack mode in dm2.

------------------------------------------------------------------------
r10 | hren | 2013-07-07 20:36:41 -0700 (Sun, 07 Jul 2013) | 3 lines

Added -dc (delete contex) option in dm2; Added alias gi==gvim in custom cshrc;

------------------------------------------------------------------------
r7 | hren | 2013-05-13 00:54:05 -0700 (Mon, 13 May 2013) | 2 lines

    1.fixed a bug in dm/g2.csh

------------------------------------------------------------------------
r6 | hren | 2013-05-10 05:50:03 -0700 (Fri, 10 May 2013) | 2 lines

    1. added context switch feature in dm2.

------------------------------------------------------------------------
r4 | hren | 2013-05-06 20:00:25 -0700 (Mon, 06 May 2013) | 6 lines

Moidfication:
    1. Moved most of the configuration in .vimrc to custom.vim
    2. Added some known configruation
    3. Added -ddel option in dm2.pl
    4. Added two alias in cshrc_custom2

------------------------------------------------------------------------
r3 | hren | 2013-05-05 22:39:04 -0700 (Sun, 05 May 2013) | 5 lines

Issued the seconde version for dm2. 
    1. Added -del option;
    2. Fixed -pop 0 bug;
    3. Improved -list view;

------------------------------------------------------------------------
r2 | hren | 2013-05-05 21:08:27 -0700 (Sun, 05 May 2013) | 2 lines

Finished dm2 initial version ... haha.

