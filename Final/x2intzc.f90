

















!   =======================================================================
!   ////////////////////////  SUBROUTINE X2INTZC \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine x2intzc(q,vel,p,i,gfct,iord,istp,qi)
!   
!     PURPOSE: The interface values (qi) for a vector of an advected 
!     quantity (q) are returned.  
!   
!     INPUT ARGUMENTS:
!      q    = vector to be interpolated
!          NOTE: active zones for q should be j=ji(i),jo(i); i given below
!      vel  = relative fluid velocity at interpolation point
!      p    = total pressure needed to detect contact discontinuities
!      i    = index of column being interpolated
!      gfct = "g2" metric scale factor at appropriate radius.  Will be
!            either g2a or g2b depending on centering of variable q.
!      iord = desired order of interpolation
!      istp = steepener switch (0 = off, 1 = always on)
!   
!     OUTPUT ARGUMENTS:
!      qi = vector of interface (interpolated) values
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
      integer:: i,iord,istp
      real ::   q (jn),vel(jn),p(jn),gfct(in),qi(jn)
!   
      integer:: j
      real ::   deltq (jn), deltq2(jn), dq    (jn), d2q   (jn) &
           , qri   (jn), qli   (jn), xi    (jn), dqi   (jn) &
           , ql3   (jn), qr3   (jn), dql   (jn), dqr   (jn), dv (jn)
      real :: d2qmin, q1, q2, q3, q4, q5, zeta, eta
      real :: dqm,q6,dqq6,dqsq,flag,xi2
      equivalence   (deltq,dql,wj14) , (deltq2,dqr,wj15) , (dq,wj16) &
               , (dv,d2q,wj17) , (qri ,wj18) , (qli ,wj19) , (xi,wj20) &
               , (dqi,wj21) , (ql3 ,wj22) , (qr3 ,wj23)
      logical ::global(jn)
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////////
!   =======================================================================
!   
!   ---------------  2nd order (van Leer) interface values ----------------
!     the algorithm used accounts for a non-uniform grid
!   
!   
!     Evaluate left- and right-interface slopes, monotonise.
!   
        deltq(jim1(i)) = (q(jim1(i)) - q(jim2(i)))*dx2bi(jim1(i))
        do 100 j=jim1(i),jop1(i)
          deltq(j+1) = (q(j+1) - q(j))*dx2bi(j+1)
          deltq2(j) = deltq(j)*deltq(j+1)
          dq(j)     = 0.0
          if (deltq2(j) .gt. 0.0) dq(j)=deltq2(j)/(deltq(j)+deltq(j+1))
100     continue
!   
!     choose time averaged, upstream value
!   
        do 110 j=ji(i),jop1(i)
          xi(j) = vel(j)*dt/(gfct(i))
          if (vel(j) .ge. 0.0) qi(j)= q(j-1) + (dx2a(j-1)-xi(j))*dq(j-1)
          if (vel(j) .lt. 0.0) qi(j)= q(j  ) - (dx2a(j  )+xi(j))*dq(j  )
110     continue
        return
      end
