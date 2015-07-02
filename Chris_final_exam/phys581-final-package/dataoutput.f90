

















!  =======================================================================
!  /////////////////////////  SUBROUTINE DATAOUTPUT  \\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine dataoutput(filename)
!  
!    PURPOSE: Makes an ascii dump of all the active variables
!    (d, v1, v2). Data is written in ascii format to a file called datXXX.
!    The ascii file contains five columns:
!    1st column: x1b
!    2nd column: x2b
!    3rd column: d
!    4th column: v1
!    5th column: v2
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      integer :: i,j
      character*8 ::  filename
!  
      real :: data(5,in*jn),xscale(in),yscale(jn)
      equivalence (data,wb),(xscale,wi0),(yscale,wj0)
!  
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////
!  =======================================================================
!  
      do 10 i=is,ie
        xscale(i-is+1) = x1b(i)
10    continue
      do 20 j=js,je
        yscale(j-js+1) = x2b(j)
20    continue
!  
!    density
!  
      open(unit=20,file=filename,status='replace')
      do 110 j=js,je
        do 100 i=is,ie
          data(1,(j-js)*nx1z + i -is+1) = x1b(i)
          data(2,(j-js)*nx1z + i -is+1) = x2b(j)
          data(3,(j-js)*nx1z + i -is+1) = d(i,j)
          data(4,(j-js)*nx1z + i -is+1) = v1(i,j)
          data(5,(j-js)*nx1z + i -is+1) = v2(i,j)
          write(20,*) data(:,(j-js)*nx1z + i -is+1)
100     continue
        write(20,*) ""
110   continue
      close(unit=20)
!  
      return
      end
