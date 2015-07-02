

















!   =======================================================================
!   /////////////////////////  SUBROUTINE STV2  \\\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine stv2(i,st2)
!   
!     PURPOSE: Calculates the source terms in the momentum equation for v2
!     over the entire grid.  Currently, the source terms
!     are:   ST = - (GRAD(P))/rho   -- pressure   gradient
!   
!     Source terms due to artificial viscosity are in the routine VISCUS.
!   
!     INPUT  ARGUMENTS:
!      i  = index of i sweep
!   
!     OUTPUT ARGUMENTS:
!      st2 = array of source terms at interfaces along 2-direction.
!   
!     EXTERNALS: [none]
!   
!     LOCALS:
!     rhoi = inverse density at interfaces in 1-direction
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'

      real ::st2(ijn)
!   
      integer:: i,j
      real ::   rhoi,r2i,j1
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////
!   =======================================================================
!   
      do 10 j=js,je
        rhoi = 2.0/(d(i,j-1) + d(i,j))
        st2(j) =     -rhoi*(p  (i,j) - p  (i,j-1))*dx2bi(j)/g2b(i)
10    continue
      return
      end
