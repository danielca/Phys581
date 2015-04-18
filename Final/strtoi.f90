

















!   =======================================================================
!   ////////////////////////  FUNCTION STRTOI  \\\\\\\\\\\\\\\\\\\\\\\\\\\c
      integer function strtoi(string,istrt,iend)
!   
!     CONVERTS A SEGMENT OF A CHARACTER*8 STRING INTO AN INTEGER NUMBER
!   
!   -----------------------------------------------------------------------
      implicit NONE
!   
      character*8 ::string
      integer ::istrt,iend,asciic(48:57),ishift,ival,i
      data asciic / 0,1,2,3,4,5,6,7,8,9 /
      save asciic
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////
!   =======================================================================
!   
      ishift = 1
      ival   = 0
      do 10 i=iend,istrt,-1
        ival = ival + ishift*asciic(ichar(string(i:i)))
        ishift = ishift*10
10    continue
      strtoi = ival
!   
      return
      end
