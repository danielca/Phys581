

















!   =======================================================================
!   /////////////////////////  SUBROUTINE setobjects   \\\\\\\\\\\\\\\\\\\\
!     Use this subroutine to add tasks to the main loop of the main code.  
!   
!   This file contains a default setup and various subroutines for 
!   adding geometries to the active region of the simulations:
!        drawPixel, drawRect, drawCircle, drawTriangle
!   See below for more description of the subroutines and their arguments.
!
!   DO NOT modify these subroutines. They work correctly as is. 
!   The DO NOT check for clipping with the boundaries of the grid area. 
!
!   For best results specify geometry in relative co-ordinates as is 
!   done in the default example below. 
!   This will allow for good testing at lower grid resolutions as specified 
!   in the file "final581input". If this is not done, down-sizing may cause 
!   memory indexing errors (segmentation faults). 
!

subroutine setobjects
  !implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'

  call finalDefault
  !Write other subroutines for further tasks in the exam 
  !and call here for other geometries and boundary 
  !conditions (like walls)

end subroutine


!Default setup for geometries. This is designed to be stable 
!for at least tlim=10 without using a real CLF condition 
!with a time step, dt=1E-3. In other words this will work 
!before your CFL.f90 routine is implemented correctly with 
!the CFL.f90 default. 
subroutine finalDefault
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'
  !High pressure points:
  !tri = top right i index, or the index in the 
  !i coordinate for the top right point
  integer :: tri, trj, tli, tlj, bli, blj, bri, brj
  !Wall coordinates: a is lower left point and c is upper right point
  integer :: ai, aj, bi, bj, ci, cj
  integer :: i,j 

  !ai = is + (ie-is)/3
  !aj = js + (je-js)/3

  !ci = is + (ie-is)*2/3
  !cj = js + (je-js)*2/3

  bi = is + (ie-is)*2/3
  bj = js + (je-js)/3

  !call drawCircle(ai, aj, 5)
  !call drawTriangle(ai, aj, bi, bj, ci, cj)

  call activate_inlet(20, 10.0, 10.0)
  !call inlet_test()
  !call golf_ball_test()
  !call airplane_test()

end subroutine


subroutine inlet_test()
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'

  integer :: ai, aj, bi, bj, ci, cj
  integer :: i,j 

  ai = is + (ie-is)/2
  aj = js + (je-js)/2 - 15

  ci = is + (ie-is)/2 + 10
  cj = js + (je-js)/2 + 15

  call drawRect(ai, aj, ci, cj)

  call activate_inlet(20, 10.0, 10.0)

end subroutine


subroutine golf_ball_test()
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'

  integer :: ai, aj, bi, bj, ci, cj, r
  integer :: i,j 
  real :: v_inlet, d_inlet

  v_inlet = 10.0
  d_inlet = 3.0

  do j = js, je
    v1(iip1(j), j) = v_inlet
    v2(ii(j), j) = 0.0
    d(ii(j), j) = d_inlet
  end do

  ai = is + (ie-is)/2
  aj = js + (je-js)/2
  r = 10

  call drawCircle(ai, aj, r)

end subroutine


subroutine airplane_test()
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'

  integer, dimension(11) :: ai, aj
  integer :: ci, cj
  integer :: wb, ww, lw1, lw2, lw3, ln, lb
  integer :: gf
  integer :: j

  real :: v_inlet, d_inlet

  real :: snd_spd

  d_inlet = 5.0

  snd_spd = sqrt(gamma*(d_inlet**(gamma-1.0)))

  v_inlet = 7.5*snd_spd

  do j = js, je
    v1(iip1(j), j) = v_inlet
    v2(ii(j), j) = 0.0
    d(ii(j), j) = d_inlet
  end do

  gf = 1

  ci = is + (ie-is)/2 - 20*gf
  cj = js + (je-js)/2

  wb = 6*gf
  ww = 25*gf
  !ww = 15*gf
  ln = 10*gf
  lb = 40*gf
  lw1 = 10*gf
  lw2 = 20*gf
  lw3 = 20*gf
  !lw3 = 30*gf


  call drawTriangle(ci-ln, cj, ci, cj-wb, ci, cj+wb)

  call drawRect(ci, cj-wb, ci+lb, cj+wb)

  call drawTriangle(ci+lw1, cj+wb, ci+lw2, cj+wb, ci+lw3, cj+ww)

  call drawTriangle(ci+lw1, cj-wb, ci+lw3, cj-ww, ci+lw2, cj-wb)
  
end subroutine


subroutine activate_inlet(n_inlet, v_inlet, d_inlet)
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'

  real :: v_inlet, d_inlet
  integer, intent(in) :: n_inlet
  integer :: j, nw

  nw = ((je - js) - n_inlet)/2

  do j = js, js+nw
    v1(iip1(j), j) = 0.0
    v2(ii(j), j) = 0.0
    d(ii(j), j) = 1.0
  end do

  do j = js+nw+1, je-nw-1
    v1(iip1(j), j) = v_inlet
    v2(ii(j), j) = 0.0
    d(ii(j), j) = d_inlet
  end do

  do j = je-nw+1, je
    v1(iip1(j), j) = 0.0
    v2(ii(j), j) = 0.0
    d(ii(j), j) = 1.0
  end do

end subroutine

!This sets the density and velocities to zero at and around the pixel location.
!This can be used to create walls inside the grid with the so-called no-slip 
!boundary condition.
subroutine drawPixel(i, j)
  INCLUDE 'param.h'
  INCLUDE 'variables.h'
  integer :: ci, cj, rad, i, j, r, x0, y0, x, y, rErr

  d(i,j)       = tiny
  v1(i,j)       = 0.0
  v1(i+1, j+1)  = 0.0
  v2(i,j)       = 0.0
  v2(i+1, j+1)  = 0.0

end subroutine

!Draws a rectangle with a lower left corner of (ai,aj) and 
!upper right corner of (ci, cj).
subroutine drawRect(ai, aj, ci,cj)
  implicit none
  integer :: ai, aj, ci, cj
  integer :: i, j

  do i = ai,ci
    do j = aj, cj
      call drawPixel(i,j) 
    end do 
  end do 
end subroutine

!Draws the outer borders of radius 3 centered at (ci, cj) 
!in the grid. 
subroutine drawCircle(ci, cj, r) 
  implicit none 
  INCLUDE 'param.h'
  INCLUDE 'gridparam.h'
  INCLUDE 'variables.h'
  INCLUDE 'bndry.h'
  INCLUDE 'root.h'
  integer:: ci, cj, rad, i, j, r, x0, y0, x, y, rErr
  !The following draws a circle using the midpoint circle algorithm
  x0 = ci
  y0 = cj
  x = r
  y = 0
  rErr = 1-x

  do while ( x .ge. y)

    call drawPixel(x+x0, y+y0)
    call drawPixel(y+x0, x+y0)
    call drawPixel(-x+x0, y+y0)
    call drawPixel(-y+x0, x+y0)
    call drawPixel(-x+x0, -y+y0)
    call drawPixel(-y+x0, -x+y0)
    call drawPixel(x+x0, -y+y0)
    call drawPixel(y+x0, -x+y0)

    y=y+1
    if (rErr .lt. 0) then 
      rErr = rErr  + 2*y + 1
    else 
      x = x-1
      rErr = rErr + 2 * ( y-x) + 1 
    end if 
  end do 

  return
end subroutine


!Draws a triangle with vertices (ax, ay), (bx, by), and (cx, cy)
!The vertices MUST be specified in counter-clockwise direction
subroutine drawTriangle(ax, ay, bx, by, cx, cy)
  implicit none 
  integer,intent(in) :: ax, ay, bx, by, cx, cy  
  integer :: w0, w1, w2, j, i 
  integer :: orient2d

  do j=min(ay,by,cy), max(ay,by,cy) 
    do i=min(ax, bx, cx), max(ax,bx,cx) 
      !Calculate barycentric coordinates 
      w0 = orient2d(bx, by, cx, cy, i,j)
      w1 = orient2d(cx, cy, ax, ay, i,j)
      w2 = orient2d(ax, ay, bx, by, i,j) 

      !Check if inside triangle 
      if ( (w0 .ge. 0) .and. (w1 .ge. 0) .and. (w2 .ge. 0) ) then 
        call drawPixel(i, j)
      end if 
    end do 
  end do 
end subroutine

!Used to compute barycentric coordinates for a triangle
!Used in the triangle drawing subroutine. 
integer function orient2d(ax, ay, bx, by, cx, cy) 
  implicit none 
  integer, intent(IN) :: ax, ay, bx, by, cx, cy 

  orient2d = (bx-ax)*(cy-ay) - (by-ay)*(cx - ax)

end function orient2d
