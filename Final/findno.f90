

















!  =======================================================================
!  ///////////////////////  SUBROUTINE FINDNO  \\\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine findno(msg,istrt,iend)
!  
!    INPUT ARGUMENTS:
!       msg   = character*80 string containing the message
!  
!    OUTPUT ARGUMENTS:
!       istrt = number of first character of reset number in message
!               If no number is found, a value of -1 is returned
!       iend  = number of last character of reset number in message
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      character*80:: msg
      integer:: istrt,iend,iblnk
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
      istrt=0
      iend =0
!  
      do 10 iblnk=1,80
        if (msg(iblnk:iblnk) .eq. ' ') goto 20
10    continue
20    continue
      do 30 istrt=iblnk,80
        if (msg(istrt:istrt) .ne. ' ') goto 100
30    continue
      istrt = -1
      return
!  
100   continue
      do 110 iend=istrt,80
        if (msg(iend:iend) .eq. ' ') goto 120
110   continue
120   iend=iend-1
!  
      return
      end
