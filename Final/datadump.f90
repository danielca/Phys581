

















!  =======================================================================
!  ////////////////////////  SUBROUTINE DATADUMP \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine datadump(iswout,iswhst,iswusr)
!  
!    PURPOSE:  Controls data I/O for restart, OUTPUT, history, and USER
!    dumps.  The latter is an arbitrary routine the user can add for
!    problem dependent i/o included using the cpp macroname user
!  
!    INPUT ARGUMENTS: iswout,iswhst=switches for restart,outout, and
!      history dumps.  Values of 1 ensure dumps will be made.
!  
!    OUTPUT ARGUMENTS: none
!  
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'

!  -----------------------------------------------------------------------
      integer:: iswout,iswhst,iswusr
      integer:: incr,strtoi
      external dataoutput, strtoi, printd, user
      character*9:: binfile
      real:: fis,fie
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////
!  =======================================================================
!  
      if (dtout  .gt. 0.0 .and. time  .ge. (tout+dtout)) then
        tout = tout + dtout
        iswout = 1
      endif
!  
!    OUTPUT dump
!  
      if (iswout .eq. 1) then
        call dataoutput(outfile)
        incr = strtoi(outfile,4,6) + 1
        write(outfile,"(a3,i3.3,a2)") 'ouy',incr,id
        iswout=0
      endif
!  
      return
      end
