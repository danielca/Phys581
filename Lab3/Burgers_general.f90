program Burgers_inviscid

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: x_min = -1.0d0
    real(dp), parameter :: x_max = +1.0d0

    real(dp), parameter :: t_min = 0.0d0
    real(dp), parameter :: t_max = 1.0d0

    integer, parameter :: max_num_t = 100000

    real(dp), parameter :: visc = 1.0d-2/pi


    real(dp), dimension(:), allocatable :: x
    real(dp), dimension(:), allocatable :: vel_last, vel_half, vel_next
    real(dp), dimension(:), allocatable :: flux_last, flux_half, flux_next

    real(dp) :: t_last, t_next

    real(dp) :: dx, dt

    integer :: num_x, num_t

    open( unit = 42, file = "./Data/Burgers_general.txt", action = "write" )

    call solve_burgers(1, 42)
    call solve_burgers(2, 42)

    close(42)


contains


subroutine solve_burgers(scheme, fid)
    integer, intent(in) :: scheme, fid

    call initialize()
    call main_loop(scheme, fid)
    call clean_up()
end subroutine


subroutine initialize()
    integer :: n, j

    num_x = 200

    allocate(x(num_x))
    allocate(vel_last(num_x))
    allocate(vel_half(num_x))
    allocate(vel_next(num_x))
    allocate(flux_last(num_x))
    allocate(flux_half(num_x))
    allocate(flux_next(num_x))

    call linspace(x, x_min, x_max)

    dx = x(2) - x(1)

    ! Set initial conditions
    do j = 1, num_x
        !vel_last(j) = 0.6*exp(-12.0*x(j)*x(j))
        vel_last(j) = -sin(pi*x(j))
        vel_next(j) = vel_last(j)
        flux_last(j) = 0.5*vel_last(j)**2
        flux_next(j) = flux_last(j)
    end do

    t_last = 0.0
    t_next = 0.0

end subroutine


subroutine main_loop(scheme, fid)
    integer, intent(in) :: scheme, fid
    integer :: n

    call write_stuff(fid)
    write(fid,*) ""
    call write_stuff(fid)
    do n = 1, max_num_t
        call step_forward(scheme)
        call write_stuff(fid)
        if (t_next > t_max) then
            exit
        end if
    end do
    write(fid,*) ""
    call write_stuff(fid)
    write(fid,*) ""
    write(*,*) "Simulation done at n = ", n

end subroutine


subroutine step_forward(scheme)
    integer, intent(in) :: scheme

    vel_last = vel_next
    flux_last = flux_next
    t_last = t_next

    dt = 0.9*dx*dx/(maxval(vel_last)*dx + 2.0*visc)
    t_next = t_last + dt

    if (scheme == 1) then
        call lax_wend_non_cons()
    else if (scheme == 2) then
        call lax_wend_cons()
    end if

end subroutine


subroutine lax_wend_non_cons()
    real(dp) :: c, s, const1, const2, const3
    integer :: j

    s = visc*dt/(dx*dx)
    do j = 2, num_x-1
        c = vel_last(j)*dt/dx
        const1 = 0.5*c + 0.5*c*c + s
        const2 = 1 - c*c - 2*s
        const3 = s + 0.5*c*c - 0.5*c
        vel_next(j) = const1*vel_last(j-1) + const2*vel_last(j) + const3*vel_last(j+1)
    end do

    vel_next(1) = vel_last(1)
    vel_next(num_x) = vel_last(num_x)

end subroutine


subroutine lax_wend_cons()
    integer :: j

    do j = 1, num_x-1
        vel_half(j) = 0.5*(vel_last(j+1) + vel_last(j)) &
                      - (0.5*dt/dx)*(flux_last(j+1) - flux_last(j))
    end do

    do j = 1, num_x-1
        flux_half(j) = 0.5*vel_half(j)**2 - (visc/dx)*(vel_last(j+1) - vel_last(j))
    end do

    do j = 2, num_x-1
        vel_next(j) = vel_last(j) - (dt/dx)*(flux_half(j) - flux_half(j-1))
    end do

    do j = 2, num_x-1
        flux_next(j) = 0.5*vel_next(j)**2 - (visc/dx)*(vel_half(j) - vel_half(j-1))
    end do

    vel_next(1) = vel_last(1)
    vel_next(num_x) = vel_last(num_x)
    flux_next(1) = flux_last(1)
    flux_next(num_x) = flux_last(num_x)

end subroutine


subroutine write_stuff(fid)
    integer, intent(in) :: fid
    integer :: j, n

    do j = 1, num_x
        write(fid, *) x(j), t_next, vel_next(j)
    end do
    write(fid, *) ""

end subroutine


subroutine clean_up()
    deallocate(x, vel_last, vel_half, vel_next, flux_last, flux_half, flux_next)
end subroutine


end program
