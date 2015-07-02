

















!   =======================================================================
!   ////////////////////////  SUBROUTINE X1INTZC  \\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine x1intzc(q,vel,p,j,iord,istp,qi)
!   
!     PURPOSE: The interface values (qi) for a vector of an advected 
!     quantity (q) are returned.  The interface values are first order
!     accurate for iord=1 (donor cell), second order accurate for iord=2
!     (van Leer) and third order accurate for iord=3 (PPA).  All
!     interpolation schemes are monotonic and upwinded, and for iord=3,
!     contact discontinuities are steepened when istp=1.  Global extrema
!     are not monotonised when iord=3. This ensures monotonous derivatives.
!   
!     INPUT ARGUMENTS:
!      q    = vector to be interpolated
!          NOTE: active zones for q should be i=ii(j),io(j); j given below
!      vel  = relative fluid velocity at interpolation points (vector)
!      p    = total pressure needed to detect contact discontinuities
!      j    = index of row being interpolated
!      iord = desired order of interpolation
!      istp = steepener switch (0 = off, 1 = on)
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
      real  ::  q  (in), vel(in), p(in), qi (in)
!   
      integer:: i
      real ::   deltq (in), deltq2(in), dq    (in), d2q   (in) &
           , qri   (in), qli   (in), xi    (in), dqi   (in) &
           , ql3   (in), qr3   (in), dql   (in), dqr   (in), dv (in)
      real :: d2qmin, q1, q2, q3, q4, q5, zeta, eta 
      real :: dqm,q6,dqq6,dqsq,flag,xi2
      equivalence   (deltq,dql,wi14) , (deltq2,dqr,wi15) , (dq,wi16) &
              , (dv,d2q,wi17) , (qri ,wi18) , (qli  ,wi19) , (xi,wi20) &
               , (dqi,wi21) , (ql3 ,wi22) , (qr3  ,wi23)
      logical:: global(in)
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////////
!   =======================================================================
!   
!   ---------------  2nd order (van Leer) interface values ----------------
!     the algorithm used accounts for a non-uniform grid
!   
!   
!     Evaluate left- and right-interface slopes, monotonise.
!   
        deltq(iim1(j)) = (q(iim1(j)) - q(iim2(j)))*dx1bi(iim1(j))
        do 100 i=iim1(j),iop1(j)
          deltq (i+1) = (q(i+1) - q(i))*dx1bi(i+1)
          deltq2(i  ) = deltq(i) * deltq(i+1)
          dq(i)       = 0.0
          if (deltq2(i) .gt. 0.0) dq(i)=deltq2(i)/(deltq(i)+deltq(i+1))
100     continue
!   
!     choose time averaged, upstream value
!   
        do 110 i=ii(j),iop1(j)
          xi(i) = vel(i)*dt
          if (vel(i) .ge. 0.0) qi(i)= q(i-1) + (dx1a(i-1)-xi(i))*dq(i-1)
          if (vel(i) .lt. 0.0) qi(i)= q(i  ) - (dx1a(i  )+xi(i))*dq(i  )
110     continue
        return
      end
