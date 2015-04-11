program AD_combined

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: x_min = 0.0d0
    real(dp), parameter :: x_max = 60.0d0

    real(dp), parameter :: t_min = 0.0d0
    real(dp), parameter :: t_max = 57.d0

    real(dp), parameter :: beta = 0.1d0
    real(dp), parameter :: spd = 0.5d0

    real(dp), parameter :: std_dev = 3.0d0
    real(dp), parameter :: mean = 12.0d0

    real(dp), dimension(:), allocatable :: x, t
    real(dp), dimension(:, :), allocatable :: vel

    real(dp) :: dx, dt

    integer :: num_x, num_t

    call initialize()
    call main_loop()
    call calc_mean_shift()
    call write_stuff()
    call clean_up()

contains

subroutine initialize()
    integer :: n, j
    real(dp) :: norm_factor

    num_x = 101

    allocate(x(num_x))

    call linspace(x, x_min, x_max)

    dx = x(2) - x(1)

    dt = 0.9*(dx**2)/(spd*dx + 2.0*beta)

    num_t = int((t_max - t_min)/dt) + 1

    write(*,*) "Num. time steps = ", num_t

    allocate(t(num_t))

    do n = 1, num_t
        t(n) = t_min + (n-1)*dt
    end do

    allocate(vel(num_x, num_t))

    ! Set initial conditions

    norm_factor = 1.0/(sqrt(2.0)*std_dev)
    do j = 1, num_x
        vel(j, 1) = exp(-0.5*((x(j) - mean)/std_dev)**2)
    end do

    ! Set boundary conditions
    do n = 2, num_t
        vel(1, n) = vel(1, 1)
        vel(num_x, n) = vel(num_x, 1)
    end do

end subroutine


subroutine main_loop()
    integer :: n, j
    real(dp) :: r, s
    real(dp) :: c1, c2, c3

    r = spd*dt/dx
    s = beta*dt/(dx*dx)
    
    c1 = s
    c2 = 1.0 - r - 2.0*s
    c3 = r + s

    do n = 1, num_t-1
        do j = 2, num_x-1
            vel(j, n+1) = c1*vel(j+1, n) + c2*vel(j, n) + c3*vel(j-1, n)
        end do
    end do

end subroutine


subroutine calc_mean_shift()
    real(dp) :: mean_i, mean_f
    real(dp) :: std_dev_i, std_dev_f
    real(dp) :: norm_i, norm_f
    integer :: j

    norm_i = 0.0
    norm_f = 0.0
    do j = 1, num_x
        norm_i = norm_i + vel(j, 1)
        norm_f = norm_f + vel(j, num_t)
    end do

    mean_i = 0.0
    mean_f = 0.0

    do j = 1, num_x
        mean_i = mean_i + x(j)*vel(j, 1)
        mean_f = mean_f + x(j)*vel(j, num_t)
    end do

    mean_i = mean_i/norm_i
    mean_f = mean_f/norm_f

    std_dev_i = 0.0
    std_dev_f = 0.0

    do j = 1, num_x
        std_dev_i = std_dev_i + ((x(j) - mean_i)**2)*vel(j, 1)
        std_dev_f = std_dev_f + ((x(j) - mean_f)**2)*vel(j, num_t)
    end do

    std_dev_i = sqrt(std_dev_i/norm_i)
    std_dev_f = sqrt(std_dev_f/norm_f)

    write(*,*) ""
    write(*,*) "Initial mean = ", mean_i
    write(*,*) "Final mean   = ", mean_f
    write(*,*) ""
    write(*,*) "Initial std. dev = ", std_dev_i
    write(*,*) "Final std. dev   = ", std_dev_f
    write(*,*) ""

end subroutine


subroutine write_stuff()
    integer :: j, n, fid

    fid = 42

    open(unit = fid, file = "./Data/AD_combined.txt", action = "write")

    do j = 1, num_x
        do n = 1, num_t
            write(fid, *) x(j), t(n), vel(j, n)
        end do
        write(fid, *) ""
    end do

    write(fid, *) ""
    write(fid, *) ""

    do j = 1, num_x
        write(fid, *) x(j), vel(j, 1), vel(j, num_t)
    end do

    close(fid)

end subroutine


subroutine clean_up()

    deallocate(x, t, vel)

end subroutine


end program
