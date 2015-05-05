

















!   =======================================================================
!   //////////////////////////  SUBROUTINE STV1  \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine stv1(j,st1)
!   
!     PURPOSE: Calculates the source terms in the equation of motion for v1
!     over the entire grid.  Currently, the source terms
!     are:  ST = - (GRAD(P))/rho    -- pressure   gradient
!   
!     Source terms due to artificial viscosity are in the routine VISCUS.
!   
!     INPUT ARGUMENTS:
!      j  = index of j sweep
!   
!     OUTPUT ARGUMENTS:
!      st1 = array of source terms at interfaces along 1-direction 
!   
!     EXTERNALS: [none]
!   
!     LOCALS:
!      rhoi = inverse density at interface in 1-direction
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      real:: st1(ijn)
!   
      integer::  i,j
      real  ::   rhoi,r2i,j2
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////
!   =======================================================================
!   
      do 10 i=is,ie
        rhoi = 2.0/(d(i-1,j) + d(i,j))
        st1(i) =    -rhoi*(p  (i,j) - p  (i-1,j))*dx1bi(i) 
        st1(i) = st1(i) +&
             (0.25*( v2(i  ,j) + v2(i  ,j+1) &
                  + v2(i-1,j) + v2(i-1,j+1) ))**2*dg2ad1(i)/g2a(i)
10    continue
      return
      end
