

















!  =======================================================================
!  //////////////////////////  SUBROUTINE MAXMIN  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine maxmin(qin,q1,q2,ii,io,js,je,qmin,qmax)
!  
!    PURPOSE: This subroutine returns the minimum and maximum of the
!    2-D zone centered array qin over all active grid zones.  Uneven
!    boundaries, eg steps and jumps, can be accounted for.
!  
!    INPUT ARGUMENTS:
!      qin   = the 2-D array to be searched
!      q1,q2 = 1-D worker arrays with dimensions of the trailin index of q
!      ii,io = vectors of starting and ending indices in the 1-direction
!              (permits using uneven boundaries, eg steps and jumps)
!      js,je = scalars of smallest starting index and largest ending index
!              in 2-direction
!  
!    OUTPUT ARGUMENTS:
!      qmin = minimum value
!      qmax = maximum value
!  
!    LOCALS:
!  ----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      real::     qin(in,jn),q1(jn),q2(jn),qmin,qmax
      integer::  ii(jn),io(jn),js,je
!  
      integer::  i,j
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!  
      do 20 j=js,je
        q1(j)= qin(ii(j),j)
        q2(j)= qin(ii(j),j)
	do 10 i=ii(j),io(j)
	  q1(j) = max(q1(j), qin(i,j))
	  q2(j) = min(q2(j), qin(i,j))
10      continue
20    continue
!  
      qmax = q1(js)
      qmin = q2(js)
      do 30 j=js,je
	qmax = max(qmax, q1(j))
	qmin = min(qmin, q2(j))
30    continue
!  
      return
      end
