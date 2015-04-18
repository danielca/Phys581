program I_Got_Time
implicit none




open(unit=42, file="../Data/got_time1.txt")
call grid1(42,1)
close(42)

open(unit=43, file="../Data/got_time2.txt")
call grid1(43,2)
close(43)


contains

subroutine grid1(fid, arrayno)
    integer, intent(in)::fid, arrayno
    real(kind=8)::dt, dx, x_max, x_min, time_max, time 
    real(kind=8), dimension(:,:), allocatable::grid
    integer::i,j, x_size, t_size
    
    dt = 10e-3
    dx = 0.05
    x_min = -15.0
    x_max = 15.0
    x_size = int((x_max - x_min)/dx)
    time_max = 10.0
    time = 0.0
    t_size = int(time_max/dt)

    allocate(grid(int(x_size/dx),int(t_size/dt))) 
    if (arrayno .eq. 1) then 
        call init_array1(grid, x_size, t_size, dx, dt)
    else if (arrayno .eq. 2) then 
        call init_array2(grid, x_size, t_size, dx, dt)
    end if

    
    do i=3, t_size
        do j=1, x_size
            if ((j.le.2) .or. (j.ge.(x_size-1))) then
                grid(i,j) = grid(i-1, j)
            else
                grid(j,i) = time_step(grid, j, i-1, dx, dt)
            end if
            if ((grid(j,i).gt.10000) .or. (grid(j,i).lt. -10000)) then
                grid(j,i) = 100000
            end if
        end do
    end do


    call write_array(grid, x_size, t_size, dx, dt, fid)

    
end subroutine

subroutine init_array1(grid, x_size, t_size, dx, dt)
    real(kind=8), dimension(:,:), intent(inout)::grid
    real(kind=8), intent(in)::dx, dt
    integer, intent(in)::x_size, t_size
    integer::i,j
    
    do i=1, x_size
        if ((i.eq.1) .or. (i.eq.2) .or. (i.eq.x_size) .or. (i.eq.x_size-1))then
            grid(i,1) = cosh1(dble(i-1)*dx-15., dble(0.0))!0.0
        else 
            grid(i,1) = cosh1(dble(i-1)*dx-15., dble(0.0))
        end if
    end do

    do i=1,x_size
        if ((i.eq.1) .or. (i.eq.2) .or. (i.eq.x_size) .or. (i.eq.x_size-1))then
            grid(i,2) = 0.0
        else 
            grid(i,2) = step(grid,i,dx,dt)
        end if    
    end do

    do j=3,t_size
        do i=1,x_size
            grid(i,j) = 0.0
        end do
    end do

end subroutine

subroutine init_array2(grid, x_size, t_size, dx, dt)
    real(kind=8), dimension(:,:), intent(inout)::grid
    real(kind=8), intent(in)::dx, dt
    integer, intent(in)::x_size, t_size
    integer::i,j
    
    do i=1, x_size
        if ((i.eq.1) .or. (i.eq.2) .or. (i.eq.x_size) .or. (i.eq.x_size-1))then
            grid(i,1) = cosh2(dble(i-1)*dx-15., dble(0.0))!0.0
        else 
            grid(i,1) = cosh2(dble(i-1)*dx-15., dble(0.0))
        end if
    end do

    do i=1,x_size
        if ((i.eq.1) .or. (i.eq.2) .or. (i.eq.x_size) .or. (i.eq.x_size-1))then
            grid(i,2) = 0.0
        else 
            grid(i,2) = step(grid,i,dx,dt)
        end if    
    end do

    do j=3,t_size
        do i=1,x_size
            grid(i,j) = 0.0
        end do
    end do

end subroutine

real(kind=8) function step(grid, l, dx, dt)
    real(kind=8), dimension(:,:), intent(in)::grid
    integer, intent(in)::l
    real(kind=8), intent(in)::dx, dt
    integer::n
    real::u2, u3, u4

    n=1
    u2 = grid(l,n)
    u3 = grid(n,l) * (grid(l+1,n) - grid(l-1,n))
    u4 = grid(l+2,n) - 2.*grid(l+1,n) + 2.*grid(l-1,n) - grid(l-2,n)

    step = -u2 + (dt*(6.*(dx**2)*u3 - u4)/(dx**3))
    
end function

real(kind=8) function time_step(grid, l, n, dx, dt)
    real(kind=8), dimension(:,:),intent(in):: grid
    integer, intent(in)::n,l
    real(kind=8), intent(in)::dx, dt
    real(kind=8):: u2, u3, u4
    
    u2 = grid(n-1,l)
    u3 = grid(n,l) * (grid(l+1,n) - grid(l-1,n))
    u4 = grid(l+2,n) - 2.*grid(l+1,n) + 2.*grid(l-1,n) - grid(l-2,n)

    time_step = u2 + (3.*dt*u3/dx) - (dt*u4)/(2.*(dx**3))
    
end function

real(kind=8) function cosh1(x,t)
    real(kind=8), intent(in):: x,t

    cosh1 = 1./cosh(x - 4.0*t)
end function

real(kind=8) function cosh2(x,t)
    real(kind=8), intent(in):: x,t

    cosh2 = -6./cosh(x - 4.0*t)
end function

subroutine write_array(array, x_size, t_size, dx, dt, fid)
    real(kind=8), dimension(:,:), intent(in)::array
    real(kind=8), intent(in):: dx, dt
    integer, intent(in)::fid, x_size, t_size
    integer::i,j

    do j=1,t_size
        do i=1,x_size
           write(fid,*) real(j)*dt, real(i)*dx-15.0,  array(i,j)
        end do
        write(fid,*) ""
    end do
end subroutine

end program
