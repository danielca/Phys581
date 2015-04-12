program Burgers_general

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: x_min = 0.0d0
    real(dp), parameter :: x_max = 1.0d0

    real(dp), parameter :: t_min = 0.0d0

    real(dp), parameter :: beta = 1.0d0

    real(dp), dimension(:), allocatable :: x, t
    real(dp), dimension(:, :), allocatable :: vel, vel_theor

    real(dp) :: dx, dt

    integer :: num_x, num_t

    call initialize()
    call main_loop()
    call write_stuff()

contains

subroutine initialize()
    integer :: n, j

    num_x = 51
    num_t = 300

    allocate(x(num_x))
    allocate(t(num_t))
    allocate(vel(num_x, num_t))
    allocate(vel_theor(num_x, num_t))

    call linspace(x, x_min, x_max)

    dx = x(2) - x(1)

    dt = 0.9*(dx**2)/(2.0*beta)

    do n = 1, num_t
        t(n) = t_min + (n-1)*dt
    end do

    ! Set initial conditions
    do j = 1, num_x
        vel(j, 1) = sin(pi*x(j))
    end do

    ! Set boundary conditions
    do n = 1, num_t
        vel(1, n) = 0.0
        vel(num_x, n) = 0.0
    end do

end subroutine


subroutine main_loop()
    integer :: n, j
    real(dp) :: c1, c2

    c1 = 1.0 - 2.0*beta*dt/(dx**2)
    c2 = beta*dt/(dx**2)

    do n = 1, num_t-1
        do j = 2, num_x-1
            vel(j, n+1) = c1*vel(j, n) + c2*(vel(j+1, n) + vel(j-1, n))
        end do
    end do

    do n = 1, num_t
        do j = 1, num_x
            vel_theor(j, n) = exp(-beta*pi*pi*t(n))*sin(pi*x(j))
        end do
    end do

end subroutine


subroutine write_stuff()
    integer :: j, n, fid

    fid = 42

    open(unit = fid, file = "./Data/Diffusion.txt", action = "write")

    do j = 1, num_x
        do n = 1, num_t
            write(fid, *) x(j), t(n), vel(j, n), vel_theor(j, n)
        end do
        write(fid, *) ""
    end do

    write(fid, *) ""
    write(fid, *) ""

    do j = 1, num_x
        write(fid, *) x(j), vel(j, 1), vel_theor(j, 1), vel(j, num_t), vel_theor(j, num_t)
    end do

    close(fid)

end subroutine


end program
