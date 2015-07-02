program Time_dependent

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: dx_0 = 5.0d-2
    real(dp), parameter :: dt_0 = 1.0d-5

    real(dp), parameter :: x_min = -15.0d0
    real(dp), parameter :: x_max = +15.0d0

    real(dp), parameter :: t_min =  0.0d0
    real(dp), parameter :: t_max = 10.0d0

    real(dp), dimension(:), allocatable :: x, t
    real(dp), dimension(:, :), allocatable :: u

    real(dp) :: dx, dt

    real(dp) :: amplitude

    integer :: num_x, num_t

    integer :: fid

    fid = 42

    open( unit = fid, file = "./Data/Time_dependent1.txt", action = "write")
    amplitude = -2.0
    call solve_time_dependent()
    close(fid)

    open( unit = fid, file = "./Data/Time_dependent2.txt", action = "write")
    amplitude = -6.0
    call solve_time_dependent()
    close(fid)


contains


subroutine solve_time_dependent()

    call initialize()
    call main_loop()
    call write_stuff()
    call clean_up()

end subroutine


subroutine initialize()
    integer :: k, n

    num_x = nint((x_max - x_min)/dx_0) + 1
    num_t = nint((t_max - t_min)/dt_0) + 1

    allocate(x(num_x))
    allocate(t(num_t))
    allocate(u(num_x, num_t))

    call linspace(x, x_min, x_max)
    call linspace(t, t_min, t_max)

    dx = x(2) - x(1)
    dt = t(2) - t(1)

    ! Set initial conditions
    u = 0.0

    do n = 1, num_t
        u(1, n) = 0.0
        u(2, n) = 0.0
        u(num_x-1, n) = 0.0
        u(num_x, n) = 0.0
    end do

    do k = 1, num_x
        u(k, 1) = amplitude/(cosh(x(k))**2)
    end do

    call init_update()

    write(*,*) ""
    write(*,*) "Starting time dependent PDE calculation"
    write(*,*) ""
    write(*,*) "Num x = ", num_x
    write(*,*) "Num t = ", num_t
    write(*,*) ""
    write(*,*) "Del x = ", dx
    write(*,*) "Del t = ", dt
    write(*,*) ""

end subroutine


subroutine main_loop()
    real(dp) :: r, s
    real(dp) :: c1, c2

    integer :: n, k

    r = dt/dx
    s = dt/(dx*dx*dx)

    c1 = 6.0*r
    c2 = s

    write(*,*) "Begin main loop"
    do n = 2, num_t-1
        do k = 3, num_x-2
            u(k,n+1) = u(k,n-1) + c1*u(k,n)*(u(k+1,n) - u(k-1,n))
            u(k,n+1) = u(k,n+1) - c2*(u(k+2,n) - 2.0*u(k+1,n) + 2.0*u(k-1,n) - u(k-2,n))
        end do
        if ((t(n+1) > 0.4) .and. (t(n) .le. 0.4)) then
            write(*,*) "t = 0.4 reached at n = ", n
        else if ((t(n+1) > 0.5) .and. (t(n) .le. 0.5)) then
            write(*,*) "t = 0.5 reached at n = ", n
        else if ((t(n+1) > 1.0) .and. (t(n) .le. 1.0)) then
            write(*,*) "t = 1.0 reached at n = ", n
        end if
    end do
    write(*,*) ""
    write(*,*) "Simulation complete."
    write(*,*) ""


end subroutine


subroutine init_update()
    integer :: k
    real(dp) :: r, s
    real(dp) :: c1, c2

    r = dt/dx
    s = dt/(dx*dx*dx)

    c1 = 3.0*r
    c2 = 0.5*s

    do k = 3, num_x-2
        u(k,2) = u(k,1) + c1*u(k,1)*(u(k+1,1) - u(k-1,1))
        u(k,2) = u(k,2) - c2*(u(k+2,1) - 2.0*u(k+1,1) + 2.0*u(k-1,1) - u(k-2,1))
    end do

end subroutine


subroutine write_stuff()
    integer :: k, n

    write(*,*) "Begin writing to file."
    do n = 1, num_t, 1000
        do k = 1, num_x
            write(fid, *) x(k), t(n), u(k, n) 
        end do
        write(fid, *) ""
        write(fid, *) ""
    end do
    write(*,*) "Writing to file complete."
    write(*,*) ""

end subroutine


subroutine clean_up()

    deallocate(x, t, u)

end subroutine


end program
