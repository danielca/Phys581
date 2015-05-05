

















!  =======================================================================
!  /////////////////////////  SUBROUTINE MOMX1  \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine momx1(mflx1,s1,s2)
!  
!    PURPOSE:  Transports the 1- and 2-components of vector variables
!    in the 1-direction.  Currently transported are:
!         1- and 2-components of momentum
!  
!    INPUT ARGUMENTS:
!     mflx1 = mass flux in 1-direction 
!     s1    = momentum density in 1-direction
!     s2    = momentum density in 2-direction
!  
!    OUTPUT ARGUMENTS:
!     s1    = "half"-updated momentum density in 1-direction
!     s2    = "half"-updated momentum density in 2-direction
!  
!    EXTERNALS: X1INTFC
!               X1INTZC
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      real ::   mflx1(in,jn),s1(in,jn),s2(in,jn)
!  
      integer:: i,j
      real:: dflx1
      real:: atwid(in),vel1(in),tv1(in),v1twid1(in),s1flx1(in) ,tv2(in),v2twid1(in),s2flx1(in)
      equivalence  (atwid,wi0),(vel1,wi1),(v1twid1,wi2) &
                 ,(tv1,s1flx1,wi3),(v2twid1,wi4),(tv2,s2flx1,wi5)
!  
      external:: x1intfc,x1intzc
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!    Check for 1-D problem in the 2-direction
!  
      if (nx1z .le. 1) return
!  ================ TRANSPORT 1-COMPONENT IN 1-DIRECTION  ================
!    Compute time-centered area factors.
!  
      do 10 i=is,ie
        atwid(i) = g2bh(i)*g31bh(i)
10    continue
!  
!    Interpolate v1 to interfaces in the 1-direction. vel1 is
!    the relative fluid velocity at interpolation points.
!  
      do 100 j=js,je
        do 20 i=ii(j),io(j)
          vel1(i) = 0.5*(v1(i,j) - vg1(i) + v1(i+1,j) - vg1(i+1))
20      continue
        do 30 i=iim1(j),iop2(j)
          tv1(i) = v1(i,j)
30      continue
        call x1intfc(tv1  ,vel1,j,iords1 ,istps1 ,v1twid1)
!  
        do 40 i=ii(j),io(j)
           dflx1 = 0.5*(mflx1(i,j) + mflx1(i+1,j))*atwid(i)
          s1flx1 (i) = dflx1*v1twid1(i)
40      continue
        s1flx1(is-1) = s1flx1(ie)
!  
!    Perform advection using fluxes.  Note timestep dt is hidden in the
!    fluxes.
!  
        do 50 i=is,ie
          s1(i,j) = (s1(i,j)*dvl1b(i)-(s1flx1(i)-s1flx1(i-1)))/dvl1bn(i)
50      continue
100   continue
!  
!  ================  TRANSPORT 2-COMPONENT IN 1-DIRECTION  ===============
!    Compute time centered area factor
!  
      do 110 i=is,ie+1
        atwid(i) = g2ah(i)*g31ah(i)
110   continue
!  
!    Interpolate v2 to zone faces in the 1-direction.
!  
      do 199 i=is,ie+1
        mflx1(i,js-1) = mflx1(i,je)
199   continue
      do 200 j=js,je
        do 120 i=ii(j),iop1(j)
          vel1(i) = 0.5*((v1(i,j-1)-vg1(i)) + (v1(i,j)-vg1(i)))
120     continue
        do 130 i=iim2(j),iop2(j)
          tv2(i) = v2(i,j)
130     continue
        call x1intzc(tv2  ,vel1,wi0,j,iords2 ,0,v2twid1 )
!  
        do 140 i=ii(j),iop1(j)
           dflx1 = 0.5*(mflx1(i,j-1) + mflx1(i,j))*atwid(i)
          s2flx1 (i) = dflx1*v2twid1(i)*g2a(i)
140     continue
!  
!    Perform advection using fluxes.  Note timestep dt is hidden in the
!    fluxes.
!  
        do 150 i=ii(j),io(j)
          s2(i,j) = (s2(i,j)*dvl1a(i)-(s2flx1(i+1)-s2flx1(i)))/dvl1an(i)
150     continue
200   continue
!  
      return
      end
