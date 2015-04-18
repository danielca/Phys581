

















!  =======================================================================
!  ///////////////////////////  SUBROUTINE NEWVG  \\\\\\\\\\\\\\\\\\\\\\\c
      subroutine newvg
!  
!    PURPOSE: Computes grid velocities at current timestep to be used in
!    updating the grid variables.  Velocoties are claculated over the
!    range i=is-2,ie+2 and j=js-2,je+2.  The method used to compute the
!    grid velocities depends on the flag igcon and the sign of x1fac,x2fac
!          igcon = 1 gives "lagrangian" tracking in x1 [x2] lines
!          igcon = 2 for input grid boundary speeds
!                  vg1(io) = x1fac * central soundspeed
!                  vg2(jo) = x2fac * central soundspeed
!          igcon = 3 for uniform translation
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'bndry.h'
!  
      integer:: i,j
      real  ::  qa,qb
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////
!  =======================================================================
!  
!    igcon = 0: "Lagrangian" tracking of grid lines
!  
      if (igcon .eq. 1) then
      if (nx1z .gt. 1 .and. x1fac .lt. 0.0) then
        do 100 i=is+1,ie
          vg1(i) = v1(i,js)
100     continue
        vg1(is  ) = 0.0
        vg1(is-1) = -vg1(is+1)
        vg1(is-2) = -vg1(is+2)
        vg1(ie+1) = 0.0
        vg1(ie+2) = -vg1(ie  )
      endif
!  
      if (nx2z .gt. 1 .and. x2fac .lt. 0.0) then
        do 110 j=js+1,je
          vg2(j) = v2(is,j)
110     continue
        vg2(js  ) = 0.0
        vg2(js-1) = -vg2(js+1)
        vg2(js-2) = -vg2(js+2)
        vg2(je+1) = 0.0
        vg2(je+2) = -vg2(je  )
      endif
      return
      endif
!  
!    igcon=2:  qa=central sound speed; vg is computed as a
!    linear function of x from x=0 to x(outer boundary).
!  
      if (igcon .eq. 2) then
      qa = sqrt(gamma*(gamma-1.0)*e(is,js)/d(is,js))
      if (x1fac .ne. 0.0) then
        qb = x1fac*qa/x1a(ie)
        do 200 i=is+1,ie
          vg1(i)=-qb*x1a(i)
200     continue
        vg1(is  ) = 0.0
        vg1(is-1) = -vg1(is+1)
        vg1(is-2) = -vg1(is+2)
        vg1(ie+1) = 0.0
        vg1(ie+2) = -vg1(ie  )
      end if
!  
      if (x2fac .ne. 0.0) then
        qb = x2fac*qa/x2a(je)
        do 210 j=js+1,je
          vg2(j)=-qb*x2a(j)
210     continue
        vg2(js  ) = 0.0
        vg2(js-1) = -vg2(js+1)
        vg2(js-2) = -vg2(js+2)
        vg2(je+1) = 0.0
        vg2(je+2) = -vg2(je  )
      end if
      return
      endif
!  
!    igcon = 3.  Uniform translation of the grid at a velocity x1[2]fac.
!  
      if (igcon .eq. 3) then
      do 300 i = is-2, ie+2
        vg1(i) = x1fac
300   continue
      do 310 j = js-2, je+2
        vg2(j) = x2fac
310   continue
      return
      endif
!  
      return
      end
