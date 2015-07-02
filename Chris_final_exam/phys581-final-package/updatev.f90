

















!   =======================================================================
!   ////////////////////////////  SUBROUTINE updatev  \\\\\\\\\\\\\\\\\\\\c
      subroutine updatev 
!   
!     PURPOSE: Controls the update of velocities (v1,v2) 
!     from source terms in the equation of motion.
!     equations respectively. 
!   
!   
!     LOCALS:
!     st = source terms for v1 in i sweep
!                           v2 in j sweep
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'

      integer:: i,j
      real::    st(ijn)
      equivalence  (st,wij0)
!   
      external ::eos,stv1,stv2,bvalv1,bvalv2, viscus
      external:: pdv
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////
!   =======================================================================
!      
!        get pressure from EOS and send it to stv1 and stv2 to get st(i) to 
!        update the velocity in the momentum equation 

      call eos 

!   
!     Perform an explicit update for velocities. 
!   
      if (nx1z .gt. 1) then
      do 110 j=js,je
        call stv1(j,st)
        do 100 i=is,ie
          v1(i,j) = v1(i,j) + dt*st(i)
100     continue
110   continue
      endif
      call bvalv1
!   
      if (nx2z .gt. 1) then
      do 130 i=is,ie
        call stv2(i,st)
        do 120 j=js,je
          v2(i,j) = v2(i,j) + dt*st(j)
120     continue
130   continue
      endif
      call bvalv2
!   
!   -----------------------------------------------------------------------
      call bvalv1
      call bvalv2
!   
      return
      end
