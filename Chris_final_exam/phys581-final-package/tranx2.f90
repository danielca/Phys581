

















!   =======================================================================
!   //////////////////////////  SUBROUTINE TRANX2  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine tranx2(mflx2,s3)
!   
!     PURPOSE:  Transports all zone centered variables in the 2-direction
!     only.  Currently transported are: density
!                                       3-momentum
!   
!     INPUT ARGUMENTS:
!      s3 = momentum density in 3-direction
!   
!     OUTPUT ARGUMENTS:
!      mflx2 = mass flux in 2-direction
!      s3 = "half"-updated momentum density in 3-direction
!   
!     EXTERNALS: X2INTZC
!   
!     LOCALS:
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      real ::   mflx2(in,jn),s3(in,jn)
!   
      integer:: i,j
      real:: atwid(in),vel2(jn),td(jn),eod2(jn),pr(jn),esc &
         ,dtwid2(jn),etwid2(jn) &
        ,dflx2(jn) ,eflx2(jn)
      equivalence (atwid,wi0) , (vel2,wj1) , (eod2,eflx2,wj2) &
                ,(dtwid2,wj3) &
                ,(etwid2,wj4) , (td,dflx2,wj5),(pr,wj13)
!   
      external:: x2intzc
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!   =======================================================================
!     Check for 1-D problem in 1-direction
!     Compute time-centered area factor
!   
      if (nx2z .le. 1) return
      do 10 i=is,ie
        atwid(i) = g31b(i)*dx1a(i)/dvl1a(i)
10    continue
!   
!     Interpolate quantities to zone faces in the 2-direction.
!     vel is the relative fluid velocity at interpolation points.
!   
      do 100 i=is,ie
        do 20 j=ji(i),jop1(i)
          vel2(j) = v2(i,j) - vg2(j)
20      continue
        do 30 j=jim2(i),jop2(i)
          td   (j) = d (i,j)
!   cccccccccccccccccccccccccccccccccccccccccccccc
!    OUYED: pr=pressure? Let us make pr = rho^gamma!
!   cccccccccccccccccccccccccccccccccccccccccccccc
            pr(i) = d(i,j)**gamma
!   c          if ((gamma-1.0).eq.0.0) then
!   c            pr(j) = ciso**2*d(i,j)
!   c          else
!   c            pr(j) = (gamma-1.0)*e(i,j)
!   c          endif
30      continue
        call x2intzc(td   ,vel2,pr,i,g2b,iordd ,istpd ,dtwid2)
!   
!     Construct fluxes at interfaces, including the mass flux which is
!     passed to MOMX1
!   
        do 40 j=ji(i),jop1(i)
          mflx2(i,j) = vel2(j)*dt*dtwid2(j)
          dflx2(j) = mflx2(i,j)*atwid(i)*g32ah(j)
40      continue
!   
!     Perform advection using fluxes.  Note timestep dt is hidden in the
!     fluxes via the mass fluxes.
!   
        do 50 j=ji(i),jo(i)
          d (i,j) = (d (i,j)*dvl2a(j)-(dflx2(j+1)-dflx2(j)))/dvl2an(j)
50      continue
100   continue
!   
      return
      end
