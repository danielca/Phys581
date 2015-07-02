program Wave_equation

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: x_min = -2.0d0
    real(dp), parameter :: x_max = +2.0d0

    real(dp), parameter :: y_min = -2.0d0
    real(dp), parameter :: y_max = +2.0d0

    real(dp), parameter :: t_min =  0.0d0
    real(dp), parameter :: t_max = 10.0d0

    real(dp), dimension(:), allocatable :: x, y, t
    real(dp), dimension(:, :, :), allocatable :: u, ua, ud

    real(dp) :: dx_0, dy_0, dt_0

    real(dp) :: dx, dy, dt

    real(dp) :: spd

    integer :: num_x, num_y, num_t

    integer :: fid

    fid = 42

    open( unit = fid, file = "./Data/Wave_equation1.txt", action = "write")
    spd = 0.7
    dx_0 = 0.1
    dy_0 = 0.1
    dt_0 = 0.1
    call solve_wave_equation()
    close(fid)

    open( unit = fid, file = "./Data/Wave_equation2.txt", action = "write")
    spd = 0.7
    dx_0 = 0.2
    dy_0 = 0.2
    dt_0 = 0.1
    call solve_wave_equation()
    close(fid)

    open( unit = fid, file = "./Data/Wave_equation3.txt", action = "write")
    spd = 0.71
    dx_0 = 0.1
    dy_0 = 0.1
    dt_0 = 0.1
    call solve_wave_equation()
    close(fid)


contains


subroutine solve_wave_equation()

    call initialize()
    call calc_analytical()
    call main_loop()
    call calc_diff()
    call write_stuff()
    call clean_up()

end subroutine


subroutine initialize()

    num_x = nint((x_max - x_min)/dx_0) + 1
    num_y = nint((y_max - y_min)/dy_0) + 1
    num_t = nint((t_max - t_min)/dt_0) + 1

    allocate(x(num_x))
    allocate(y(num_y))
    allocate(t(num_t))
    allocate(u(num_x, num_y, num_t))
    allocate(ua(num_x, num_y, num_t))
    allocate(ud(num_x, num_y, num_t))

    call linspace(x, x_min, x_max)
    call linspace(y, y_min, y_max)
    call linspace(t, t_min, t_max)

    dx = x(2) - x(1)
    dy = y(2) - y(1)
    dt = t(2) - t(1)

    call set_init_bound_conds()

    write(*,*) ""
    write(*,*) "Starting wave equation calculation"
    write(*,*) ""
    write(*,*) "Num x = ", num_x
    write(*,*) "Num y = ", num_y
    write(*,*) "Num t = ", num_t
    write(*,*) ""
    write(*,*) "Del x = ", dx
    write(*,*) "Del y = ", dy
    write(*,*) "Del t = ", dt
    write(*,*) ""

end subroutine


subroutine set_init_bound_conds()
    integer :: k, l

    do k = 1, num_x
        do l = 1, num_y
            u(k,l,1) = 2.0*sin(pi*x(k)/4.0)*sin(pi*y(l)/4.0)
            u(k,l,2) = u(k,l,1)
        end do
    end do

end subroutine


subroutine calc_analytical()
    integer :: k, l, n

    do n = 1, num_t
        do k = 1, num_x
            do l = 1, num_y
                ua(k,l,n) = 2.0*sin(pi*x(k)/4.0)*sin(pi*y(l)/4.0)*cos(pi*spd*t(n)/sqrt(8.0))
            end do
        end do
    end do

end subroutine


subroutine main_loop()
    real(dp) :: rx, ry, rx2, ry2

    integer :: n, k, l

    rx = spd*dt/dx
    ry = spd*dt/dy

    rx2 = rx**2
    ry2 = ry**2

    write(*,*) "Begin main loop"
    do n = 2, num_t-1
        do k = 2, num_x-1
            do l = 2, num_y-1
                ! Update equation
                u(k,l,n+1) = 2.0*u(k,l,n) - u(k,l,n-1) &
                            + rx2*(u(k+1,l,n) - 2.0*u(k,l,n) + u(k-1,l,n)) &
                            + ry2*(u(k,l+1,n) - 2.0*u(k,l,n) + u(k,l-1,n))
            end do
        end do
        ! Apply BC's: derivatives set to zero
        u(1,:,n+1) = u(2,:,n+1)
        u(num_x,:,n+1) = u(num_x-1,:,n+1)
        u(:,1,n+1) = u(:,2,n+1)
        u(:,num_y,n+1) = u(:,num_y-1,n+1)
    end do

    write(*,*) ""
    write(*,*) "Main loop complete."
    write(*,*) ""

end subroutine


subroutine calc_diff()
    integer :: k, l, n

    do n = 1, num_t
        do k = 1, num_x
            do l = 1, num_y
                ud(k,l,n) = abs(u(k,l,n) - ua(k,l,n))
            end do
        end do
    end do

    write(*,*) "Max. error = ", maxval(ud)
    write(*,*) ""

end subroutine


subroutine write_stuff()
    integer :: k, l, n

    write(*,*) "Begin writing to file."
    do n = 1, num_t
        do k = 1, num_x
            do l = 1, num_y
                write(fid, *) x(k), y(l), t(n), &
                              u(k,l,n), ua(k,l,n), ud(k,l,n)
            end do
            write(fid, *) ""
        end do
        write(fid, *) ""
        write(fid, *) ""
    end do


    write(*,*) "Writing to file complete."
    write(*,*) ""

end subroutine


subroutine clean_up()

    deallocate(x, y, t, u, ua, ud)

end subroutine


end program
