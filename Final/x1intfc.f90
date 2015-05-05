

















!   =======================================================================
!   /////////////////////////  SUBROUTINE X1INTFC  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine x1intfc(q,vel,j,iord,istp,qi)
!   
!     PURPOSE: This routine performs the same function for face centered 
!     variables as the routine X1INTZC does for zone centered variables.
!     Thus, see comments for X1INTZC.  Note no contact steepener is used
!     for face centered variables since only the density is ever steepened.
!   
!     INPUT ARGUMENTS:
!      q    = vector to be interpolated
!          NOTE: active zones for q should be i=iip1(j),io(j);j given below
!      vel  = relative fluid velocity at interpolation point
!      j    = index of row being interpolated
!      iord = desired order of interpolation
!      istp = steepener switch (0 = off, 1 = always on)
!   
!     OUTPUT ARGUMENTS:
!      qi   = vector of interface (interpolated) values
!   
!     EXTERNALS: CVMGT
!   
!     LOCALS:
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      integer:: j,iord,istp
      real  ::  q  (in), vel(in), qi (in)
!   
      integer:: i 
      real ::   deltq (in), deltq2(in), dq    (in), d2q   (in) &
           , qri   (in), qli   (in), xi    (in), dqi   (in) &
          , ql3   (in), qr3   (in), dql   (in), dqr   (in), dv (in)
      real::  d2qmin
      real :: dqm,q6,dqq6,dqsq,flag,xi2
      equivalence   (deltq,dql,wi14) , (deltq2,dqr,wi15) , (dq,wi16) &
               , (dv,d2q,wi17) , (qri ,wi18) , (qli  ,wi19) , (xi,wi20)&
               , (dqi,wi21) , (ql3 ,wi22) , (qr3  ,wi23)
      logical:: global(in)
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////////
!   =======================================================================
!   ---------------  2nd order (van Leer) interface values ----------------
!     the algorithm used accounts for a non-uniform grid
!   
!   
!     Evaluate left- and right-interface slopes, monotonise.
!   
        deltq(ii(j)) = (q(ii(j)) - q(iim1(j)))*dx1ai(iim1(j))
        do 100 i=ii(j),iop1(j)
          deltq (i+1) = (q(i+1) - q(i))*dx1ai(i)
          deltq2(i  ) = deltq(i) * deltq(i+1)
          dq(i)       = 0.0
          if (deltq2(i) .gt. 0.0) dq(i)=deltq2(i)/(deltq(i)+deltq(i+1))
100     continue
!   
!     choose time averaged, upstream value
!   
        do 110 i=ii(j),io(j)
          xi(i) = vel(i) * dt
          if (vel(i) .ge. 0.0) qi(i)= q(i  ) + (dx1b(i  )-xi(i))*dq(i  )
          if (vel(i) .lt. 0.0) qi(i)= q(i+1) - (dx1b(i+1)+xi(i))*dq(i+1)
110     continue
        return
      end
