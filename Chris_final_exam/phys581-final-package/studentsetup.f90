

















!   =======================================================================
!   ///////////////////////  SUBROUTINE STUDENTSETUP  \\\\\\\\\\\\\\\\\\\\\\\\\c
       subroutine studentsetup
!   This subroutine can be used to set up your own initial conditions. 
!   Most tasks in this exam are focused on boundary values; however, 
!   modification of this file is necessary for setting initial conditions.  
!   
!   -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'bndry.h'
      integer :: imin,imax,jmin,jmax,idirect,n0,i,j
      real  ::   d0,e0,v10,v20,v30
      namelist /pgen/ idirect,n0,d0,e0,v10,v20,v30
!   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////
!   =======================================================================
      
!   
      idirect = 1
      n0  = nx1z
      d0  = tiny
      e0  = tiny
      v10 = tiny
      v20 = tiny
      v30 = tiny
!   
10    continue
      read (1,pgen)
      write(2,pgen)
!   
!     Here setup the initial values in the boundary
!     and in the active zones 
!   
      
      !Initialize active zone to low density (1.0) and no velocity. 
      !The boundaries are modified by subsequent calls to bvald, bvalv1 
      !and bvalv2 making their modification here unnecessary and useless. 
      d(is:ie, js:je) = 1.0

      do j=js,je
        do i=iip1(j),io(j)
          v1(i,j) = 0.0
        end do 
      end do 
      
      call finalDefaultInit

    return
    end

subroutine finalDefaultInit
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'root.h'
  INCLUDE 'bndry.h'
  !High pressure points:
  !tri = top right i index, or the index in the 
  !i coordinate for the top right point
  integer :: tri, trj, tli, tlj, bli, blj, bri, brj
  !Set third division points for 
  !initial high density regions.
  !tli = is + (ie - is)/6
  !tlj = je - (je - js)/6
  !tri = ie - (ie - is)/6
  !trj = je - (je - js)/6
  !bli = is + (ie - is)/6
  !blj = js + (je - js)/6
  !bri = ie - (ie - is)/6
  !brj = js + (je - js)/6  

  !Small number (1-2) cell sized zones create undesireble 
  !numerical artifacts in solution. 
  !d(tli:tli+5, tlj:tlj+5) = 50.0
  !d(tri:tri+5, trj:trj+5) = 50.0
  !d(bli:bli+5, blj:blj+5) = 50.0
  !d(bri:bri+5, blj:blj+5) = 50.0

  !The following adds quadrant based velocities around the 
  !centre of the grid. NOTE: This will not converge unless
  !CFL has been correctly implemented. This can be used as a
  !test for whether CFL has been implemented: the result of 
  !adding this will give a pinwheel like flow. 
  ! v1(is:is+(ie-is)*2/3, js:js+(je-js)/3)   =  2.0
  ! v2(is+(ie-is)*2/3:ie, js:js+(je-js)*2/3) =  2.0
  ! v1(is+(ie-is)/3:ie,   js+(je-js)*2/3:je) = -2.0
  ! v2(is:is+(ie-is)/3,   js+(je-js)/3:je)   = -2.0

end subroutine
