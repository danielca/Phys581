program wave
use wave_theorey
implicit none
real::dx,dt,c, dy

dx = 0.1
dy = 0.1
dt = 0.1
c = 0.7

open(unit = 42, file = "../Data/wave1.txt", action = "write")
open(unit = 45, file = "../Data/wavet1.txt", action = "write")
call wave_eqn(dx,dt,c,dy,42, 45)
close(42)
close(45)

open(unit=43, file = "../Data/wave2.txt", action = "write")
open(unit=46, file = "../Data/wavet2.txt", action = "write")

dx = 0.2
dy = 0.2
dt = 0.1
c = 0.7
call wave_eqn(dx,dt,c,dy,43, 46)
close(43)
close(46)

dx = 0.1
dy = 0.1
dt = 0.1
c = 0.71
open(unit=47, file = "../Data/wavet3.txt", action = "write")
open(unit=44, file = "../Data/wave3.txt", action = "write")
call wave_eqn(dx,dt,c,dy,44, 47)
close(44)
close(47)



contains


subroutine wave_eqn(dx,dt,c,dy,fid, fid2)
    real, intent(in)::dx,dt,c,dy
    integer, intent(in)::fid, fid2
    real, dimension(:,:,:), allocatable::array
    real::x_max, x_min, y_max, y_min, t_max
    real::gamx, gamy, gam
    integer::i,j,k
    integer::x_size, y_size, t_size

    

    x_min = -2.0
    x_max = 2.0
    x_size = int((x_max - x_min)/dx)
    y_min = -2.0
    y_max = 2.0
    y_size = int((y_max - y_min)/dx)
    t_max = 10.0
    t_size = int(t_max/dt)
    gamx = c*dt/dx
    gamy = c*dt/dy
    gam = 2*(1-gamx**2 - gamy**2)
    allocate(array(t_size,x_size,y_size))

    call init_array(array, dx, dy, x_min, y_min, x_size, y_size, t_size,gamx, &
                    gamy, gam)

    call write_array(array(1,:,:),x_size, y_size, y_max, x_max, dx, dy,fid)
    call run(x_min, x_max, dx, y_min, y_max, dy, 0.0, c, fid2)
    write(fid,*) ""
    write(fid,*) ""
    write(fid2,*) ""
    write(fid2,*) ""
    do k=3, t_size-1
        do i=1,x_size
            do j=1,y_size
                if ((i.eq.1) .and. (j.eq.1)) then
                    array(k,i,j) = x1y1(array, k-1, gamx, gamy, gam)
                else if ((i.eq.1) .and. (j.eq.y_size) ) then
                    array(k,i,j) = x1ym(array, y_size, k-1, gamx, gamy, gam)
                else if ((i.eq.x_size) .and. (j.eq.1)) then
                    array(k,i,j) = xny1(array, x_size, k-1, gamx, gamy, gam)
                else if ((i.eq.x_size) .and. (j.eq.x_size)) then
                    array(k,i,j)=xnym(array,x_size,y_size,k-1,gamx,gamy,gam)
                else if (i.eq.1 .and. (j.ne.1) .and. (j.ne.x_size) ) then
                    array(k,i,j) = x1(array, j, k-1, gamx, gamy, gam)
                else if (j.eq.1 .and. (i.ne.1) .and. (i.ne.x_size) ) then
                    array(k,i,j) = y1(array, i, k-1, gamx, gamy, gam)
                else if ((i.eq.x_size) .and. (j.ne.1) .and. (j.ne.y_size)) then
                    array(k,i,j) = xn(array, x_size, j, k-1, gamx, gamy, gam)
                else if ((j.eq.y_size) .and. (i.ne.1) .and. (i.ne.x_size)) then
                    array(k,i,j) = ym(array, i, y_size, k-1, gamx, gamy, gam)
                else 
                    array(k,i,j) = internal(array, i, j, k-1, gamx, gamy, gam)
                end if
            end do
        end do
        if ((k.eq.10).or.(k.eq.40).or.(k.eq.60).or.(k.eq.80).or.(k.eq.99)) then
            call write_array(array(k,:,:),x_size, y_size, y_max, x_max, dx, dy,fid)
            call run(x_min, x_max, dx, y_min, y_max, dy, real(k)/dt, c, fid2)
            write(fid,*) ""
            write(fid,*) ""
            write(fid2,*) ""
            write(fid2,*) ""
        end if
    end do

    deallocate(array)
end subroutine

subroutine init_array(array, dx, dy, x_min, y_min, x_size, y_size, t_size, &
                      gamx, gamy, gam)
    real, intent(inout), dimension(:,:,:)::array
    real, intent(in)::x_min, y_min, dx, dy, gamx,gamy,gam
    integer, intent(in):: x_size,y_size,t_size
    integer::i,j,k
    
    do i=1, x_size
        do j=1, y_size
            array(1,i,j) = init_conditions(i,j,dx,dy, x_min, y_min)
        end do
    end do

    do i=1, x_size
        do j=1, x_size
            if ((i.eq.1) .or. (j.eq.1) .or. (i.eq.x_size).or.(j.eq.y_size))then
                array(2,i,j) = 0.0
            else 
                array(2,i,j) = t1(array,i,j,dx,dy, x_min, y_min, gamx,gamy,gam)
            end if
        end do
    end do

end subroutine

real function init_conditions(i,j,dx,dy, x_min, y_min)
    integer, intent(in)::i,j
    real, intent(in)::dx,dy, x_min, y_min
    real::PI
    real::fac1, fac2
    PI = 3.14159265359
    fac1 = 2*sin((pi/4.)*(real(i)*dx - x_min))
    fac2 = sin((pi/4.)*(real(j)*dx - y_min))

    init_conditions = fac1*fac2
end function

real function t1(array,i,j,dx,dy, x_min, y_min, gamx, gamy, gam)
    real, intent(in), dimension(:,:,:)::array
    integer, intent(in)::i,j
    real, intent(in)::dx,dy, x_min, y_min, gamx, gamy, gam
    real::PI
    
    PI = 3.14159265359

    t1 = (gam/2.)*array(1,i, j) + (gamx**2)*(array(1,i+1, j) + &
          array(1, i-1, j))/2. + (gamy**2)*(array(1,i, j+1)+array(1,i, j-1))/2.
end function

real function internal(array,i,j,k,gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::i,j,k
    real, intent(in)::gamx, gamy, gam
    

    internal = gam*array(k,i,j) + &
              (gamx**2)*(array(k,i+1,j)+array(k,i-1,j)) + &
              (gamy**2)*(array(k,i,j+1)+array(k,i,j-1)) - array(k-1,i,j)
end function

real function x1(array, j,k,gamx,gamy,gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::j,k
    real, intent(in)::gamx, gamy, gam

    x1 = gam*array(k,1,j) + &
         (gamx**2)*array(k,2,j) + &
         (gamy**2)*(array(k,1,j+1)+array(k,1,j-1)) - array(k-1,1,j)
end function

real function xn(array, n, j, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::j,k, n
    real, intent(in)::gamx, gamy, gam

    xn = gam*array(k,n,j) + &
         (gamx**2)*array(k,n-1,j) + &
         (gamy**2)*(array(k,1,j+1)+array(k,n,j-1)) - array(k-1,n,j)
end function

real function y1(array, i, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::i,k
    real, intent(in)::gamx, gamy, gam

    y1 = gam*array(k,i,1) + &
         (gamx**2)*(array(k,i+1,1) + &
         array(k,i-1,1)) + (gamy**2)*(array(k,i,2)) - array(k-1,i,1)

end function

real function ym(array, i, m, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::i,k, m
    real, intent(in)::gamx, gamy, gam

    ym = gam*array(k,i,m) + &
         (gamx**2)*(array(k,i+1,m) + array(k,i-1,m)) + &
         (gamy**2)*(array(k,i,m-1)) - array(k-1,i,m)

end function

real function x1y1(array, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::k
    real, intent(in)::gamx, gamy, gam

    x1y1 = gam*array(k,1,1) + (gamx**2)*(array(k,2,1)) + &
           (gamy**2)*array(k,1,2) - array(k-1,1,1)
end function

real function xny1(array, n, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::n,k
    real, intent(in)::gamx, gamy, gam

    xny1 = gam*array(k,n,1) + (gamx**2)*array(k,n-1,1) + &
           (gamy**2)*array(k,n,2) - array(k-1,n,1)
end function

real function x1ym(array, m, k, gamx, gamy, gam)
    real, dimension(:,:,:), intent(in)::array
    integer, intent(in)::m,k
    real, intent(in)::gamx, gamy, gam

    x1ym = gam*array(k,1,m) + (gamx**2)*array(k,2,m) + &
           (gamy**2)*array(k,1,m-1) - array(k-1,1,m)
end function

real function xnym(array, n, m, k, gamx, gamy, gam)
    real, dimension(:,:,:)::array
    integer, intent(in)::n,m,k
    real, intent(in)::gamx, gamy, gam

    xnym = gam*array(k,n,m) + (gamx**2)*array(k,n-1,m) + &
           (gamy**2)*array(k,n,m-1) - array(k-1,n,m)
    
end function

subroutine write_array(array,x_size, y_size, y_max, x_max, dx, dy,fid)
    real, dimension(:,:), intent(in)::array
    integer, intent(in)::fid, x_size, y_size
    real, intent(in):: dx, dy, x_max, y_max
    integer::i,j

    do j=1,x_size
        do i=1,y_size
            write(fid,*) real(j)*dx - x_max, real(i)*dy - y_max, array(j,i)
        end do
        write(fid,*) ""
    end do
end subroutine










end program
