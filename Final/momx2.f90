

















!  =======================================================================
!  /////////////////////////  SUBROUTINE MOMX2  \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine momx2(mflx2,s1,s2)
!  
!    PURPOSE:  Transports the 1- and 2-components of vector variables
!    in the 2-direction. Currently transported are:
!           1- and 2-components of momentum density
!  
!    INPUT ARGUMENTS:
!     mflx2 = mass flux in 2-direction 
!     s1    = momentum density in 1-direction
!     s2    = momentum density in 2-direction
!  
!    OUTPUT ARGUMENTS:
!     s1    = "half"-updated momentum density in 1-direction
!     s2    = "half"-updated momentum density in 2-direction
!  
!    EXTERNALS: X2INTFC
!               X2INTZC
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      real ::   mflx2(in,jn),s1(in,jn),s2(in,jn)
!  
      integer:: i,j
      real:: dflx2
      real:: atwid(in),vel2(jn),tv1(jn),v1twid2(jn),s1flx2(jn)&
                            ,tv2(jn),v2twid2(jn),s2flx2(jn)
      equivalence  (atwid,wi0),(vel2,wj1),(v1twid2,wj2) &
                 ,(tv1,s1flx2,wj3),(v2twid2,wj4),(tv2,s2flx2,wj5)
!  
      external:: x2intfc,x2intzc
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!    Check for 1-D problem in the 1-direction
!  
      if (nx2z .le. 1) return
!  =================  TRANSPORT 1-COMPONENT IN 2-DIRECTION  ==============
!    Compute time-centered are factors
!  
      do 10 i=is,ie
        atwid(i) = g31a(i)*dx1b(i)/dvl1b(i)
10    continue
!  
!    Interpolate v1 to interfaces in the 2-direction. vel2 is
!    the relative fluid velocity at interpolation points.
!  
      do 99 j=js,je+1
        mflx2(is-1,j) = mflx2(ie,j)
99    continue
      do 100 i=is,ie
        do 20 j=ji(i),jop1(i)
          vel2(j) = 0.5*((v2(i-1,j) - vg2(j)) + (v2(i,j) - vg2(j)))
20      continue
        do 30 j=jim2(i),jop2(i)
          tv1(j) = v1(i,j)
30      continue
        call x2intzc(tv1  ,vel2,wj0,i,g2a,iords1 ,0,v1twid2 )
!  
        do 40 j=ji(i),jop1(i)
           dflx2 = 0.5*(mflx2(i-1,j) + mflx2(i,j))*atwid(i)*g32ah(j)
          s1flx2(j) = dflx2*v1twid2(j)
40      continue
!  
!    Perform advection using fluxes.  Note timestep dt is hidden in the
!    fluxes.
!  
        do 50 j=ji(i),jo(i)
          s1(i,j) = (s1(i,j)*dvl2a(j)-(s1flx2(j+1)-s1flx2(j)))/dvl2an(j)
50      continue
100   continue
!  
!  ===============  TRANSPORT 2-COMPONENTS IN 2-DIRECTION  ===============
!    Compute time centered area factor
!  
      do 110 i=is,ie
        atwid(i) = g31b(i)*dx1a(i)/dvl1a(i)
110   continue
!  
!    Interpolate v2 to zone centers in the 2-direction.
!  
      do 200 i=is,ie
        do 120 j=ji(i),jo(i)
          vel2(j) = 0.5*(v2(i,j) - vg2(j) + v2(i,j+1) - vg2(j+1))
120     continue
        do 130 j=jim1(i),jop2(i)
          tv2(j) = v2(i,j)
130     continue
        call x2intfc(tv2  ,vel2,i,g2b,iords2 ,istps2 ,v2twid2 )
!  
        do 140 j=ji(i),jo(i)
           dflx2 = 0.5*(mflx2(i,j) + mflx2(i,j+1))*atwid(i)*g32bh(j)
          s2flx2(j) = dflx2*v2twid2(j)*g2b(i)
140     continue
        s2flx2(js-1) = s2flx2(je)
!  
!    Perform advection using fluxes.  Note timestep dt is hidden in the
!    fluxes.
!  
        do 150 j=js,je
          s2(i,j) = (s2(i,j)*dvl2b(j)-(s2flx2(j)-s2flx2(j-1)))/dvl2bn(j)
150     continue
200   continue
!  
      return
      end
