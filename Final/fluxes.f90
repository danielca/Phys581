

















!  =======================================================================
!  /////////////////////////  SUBROUTINE FLUXES  \\\\\\\\\\\\\\\\\\\\\\c
      subroutine fluxes 
!  
!    PURPOSE: This subroutine transports the variables through the
!    mesh in an unsymmetric directionally split manner. In each succesive
!    call to transport, the order of the directions is reversed (resulting
!    in ......YX......YX...). 
!    Momenta are computed from velocities in VTOS and then transported.
!    Velocities are not updated until the end of the transport step in
!    STOV.  
!  
!    Note the order in which variables are transported is important
!    (especially d).
!  
!  
!    LOCALS:
!     s1,s2,s3 = momentum densities in the 1-,2- and 3-directions
!     mflx1,mflx2 = mass fluxes in the 1- and 2-directions (share storage)
!    These are stored in work arrays wa...wd, which cannot be used again
!    until the end of the transport step.
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'scratch.h'
      INCLUDE 'root.h'
      real ::s1(in,jn),s2(in,jn),s3(in,jn),mflx1(in,jn),mflx2(in,jn)
      equivalence (s1,wa),(s2,wb),(s3,wc),(mflx1,mflx2,wd)
!  
      external:: vtos,tranx1,momx1,tranx2,momx2,stov,bvald&
             ,bvalv1,bvalv2
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////
!  =======================================================================
!  
!    construct momentum densities from velocities
!  

      call vtos(s1,s2,s3)

!  
!    directional split in X1-X2 fashion
!  
      if (ix1x2 .eq. 1) then
!  
        call tranx1(mflx1,s3)
        call momx1(mflx1,s1,s2)
        call bvald
!  
        call tranx2(mflx2,s3)
        call momx2(mflx2,s1,s2)
	ix1x2 = 2
!  
!    directional split in X2-X1 fashion
!  
      else
        call tranx2(mflx2,s3)
        call momx2(mflx2,s1,s2)
        call bvald
        call tranx1(mflx1,s3)
        call momx1(mflx1,s1,s2)
        ix1x2 = 1
      endif
!  
!    velocities from momentum densities, and update boundaries
!  
      call stov(s1,s2,s3)

      call bvald
      call bvalv1
      call bvalv2
      return
      end
