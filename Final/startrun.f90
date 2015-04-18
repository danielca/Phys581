

















!   =======================================================================
!   /////////////////////////////  SUBROUTINE STARTRUN  \\\\\\\\\\\\\\\\\\\\c
      subroutine startrun
!   
!     PURPOSE:  Starts a run.
!   
!     EXTERNALS: SETUP, MGET, restart
!   
!     LOCALS:
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'root.h'
      integer:: irestart
!   
      integer:: incr,strtoi
      external ::setup, mget, strtoi
      namelist /iocon/ tout,dtout
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////
!   =======================================================================
!   
      open(unit=1,file='final581input',status='old')
      open(unit=2,file='final581lp'  ,status='unknown')
!   
!   ------------------------  restart CONTROL  ----------------------------
!   
!     irestart: set to one for calculation restarted from restart dump
!     tdump: time of last restart dump
!     dtdump: time between restart dumps
!     id: character*2 tag attended to filenames to identify run
!     resfile: name of restart file to restart from
!   
      irestart = 0
!   
      if (irestart .eq. 0) then
        call setup
      endif
!   
!   ------------------------  I/O CONTROL ---------------------------------
!   
!     tout: time of last  dump
!     dtout: time between  dumps
!   
      if (irestart .eq. 0) then
         tout  = 0.0
        dtout  = 0.0
      endif
      read (1,iocon)
      write(2,iocon)
!   
      if (irestart .eq. 0) then
        write(outfile,"(a3,i3.3,a2)") 'ouy',0,id
      endif
!   
!     Close unit=1 (input deck).  Unit=2 (final581lp) is kept open throughout
!     entire run to accept warning messages.  It is closed in "final581.f" 
!   
      close(unit=1)
!   
      return
      end
