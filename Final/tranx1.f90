

















!   =======================================================================
!   //////////////////////////  SUBROUTINE TRANX1  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine tranx1(mflx1,s3)
!   
!     PURPOSE:  Transports all zone centered variables in the 1-direction
!     only.  Currently transported are: density
!                                       3-momentum
!   
!     INPUT ARGUMENTS:
!      s3 = momentum density in 3-direction
!   
!     OUTPUT ARGUMENTS:
!      mflx1 = mass flux in 1-direction
!      s3 = "half"-updated momentum density in 3-direction
!   
!     EXTERNALS: X1INTZC
!   
!     LOCALS:
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      real::    mflx1(in,jn),s3(in,jn)
!   
      integer ::i,j
      real:: atwid(in),vel1(in),td(in),eod1(in),pr(in),esc &
         ,dtwid1(in),etwid1(in) &
         ,dflx1(in) ,eflx1(in)
      equivalence (atwid,wi0) , (vel1,wi1) , (eod1,eflx1,wi2) &
                ,(dtwid1,wi3) &
                ,(etwid1,wi4) , (td,dflx1,wi5) , (pr,wi13)
      external:: x1intzc
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!   =======================================================================
!     Check for 1-D problem in 2-direction
!     Compute time-centered area factor
!   
      if (nx1z .le. 1) return
      do 10 i=is,ie+1
        atwid(i) = g2ah(i)*g31ah(i)
10    continue
!   
!     Interpolate quantities to zone faces in the 1-direction. 
!     vel is the relative fluid velocity at interpolation points.
!   
      do 100 j=js,je
        do 20 i=ii(j),iop1(j)
          vel1(i) = v1(i,j) - vg1(i)
20      continue
        do 30 i=iim2(j),iop2(j)
          td   (i) = d (i,j)
          pr(i) = d(i,j)**gamma
30      continue
!   
        call x1intzc(td   ,vel1,pr,j,iordd ,istpd ,dtwid1)
!   
!     Construct fluxes at interfaces, including the mass flux which is
!     passed to MOMX1
!   
        do 40 i=ii(j),iop1(j)
          mflx1(i,j) = vel1(i)*dt*dtwid1(i)
          dflx1(i) = mflx1(i,j)*atwid(i)
40      continue
!   
!     Perform advection using fluxes.  Note timestep dt is hidden in the
!     fluxes via the mass fluxes.
!   
        do 50 i=ii(j),io(j)
          d (i,j) = (d (i,j)*dvl1a(i)-(dflx1(i+1)-dflx1(i)))/dvl1an(i)
50      continue
100   continue
!   
      return
      end
