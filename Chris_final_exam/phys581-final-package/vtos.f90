
















!   =======================================================================
!   //////////////////////  SUBROUTINES VTOS,STOV  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine vtos(s1,s2,s3)
!   
!     PURPOSE: Computes momentum densities S1, S2 and S3 from linear
!     velocities V1, V2, and V3, while the
!     accompanying routine STOV does the reverse.  
!   
!     INPUT ARGUMENTS: [none]
!   
!     OUTPUT ARGUMENTS:
!      s1,s2,s3 = momentum densities in the 1,2 and 3 directions
!   
!     EXTERNALS: [none]
!   
!     LOCALS:
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      real    s1(in,jn),s2(in,jn),s3(in,jn)
      integer i,j
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////
!   =======================================================================
!   
      do 20 j=js,je
        do 10 i=is,ie
          s1(i,j) = 0.5*(d(i-1,j) + d(i,j))*v1(i,j)
10      continue
20    continue
!   
      do 40 i=is,ie
        do 30 j=js,je
          s2(i,j) = 0.5*(d(i,j-1) + d(i,j))*v2(i,j)*g2b(i)
30      continue
40    continue
      return
      end
!   =======================================================================
      subroutine stov(s1,s2,s3)
!   
!     PURPOSE: Computes velocities from updates momentum densities
!   
!     INPUT ARGUMENTS:
!      s1,s2,s3 = momentum densities in the 1,2 and 3 directions
!   
!     OUTPUT ARGUMENTS: [none]
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      real    s1(in,jn),s2(in,jn),s3(in,jn)
      integer i,j
!   =======================================================================
      do 20 j=js,je
        do 10 i=is,ie
          v1(i,j) = s1(i,j)/(0.5*(d(i-1,j) + d(i,j)))
10      continue
20    continue
!   
      do 40 i=is,ie
        do 30 j=js,je
          v2(i,j) = s2(i,j)/(0.5*(d(i,j-1) + d(i,j))*g2bn(i))
30      continue
40    continue
      return
      end
