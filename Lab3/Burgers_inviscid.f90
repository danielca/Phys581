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


    real(dp), dimension(:), allocatable :: x
    real(dp), dimension(:), allocatable :: vel_last, vel_next
    real(dp), dimension(:), allocatable :: flux_last, flux_next

    real(dp) :: t_last, t_next

    real(dp) :: dx, dt

    integer :: num_x, num_t

    open( unit = 42, file = "./Data/Burgers_inviscid.txt", action = "write" )

    call solve_burgers(1, 42)
    call solve_burgers(2, 42)
    call solve_burgers(3, 42)
    call solve_burgers(4, 42)

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
    allocate(vel_next(num_x))
    allocate(flux_last(num_x))
    allocate(flux_next(num_x))

    call linspace(x, x_min, x_max)

    dx = x(2) - x(1)

    ! Set initial conditions
    do j = 1, num_x
        vel_last(j) = 0.6*exp(-12.0*x(j)*x(j))
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

    dt = 0.7*dx/maxval(vel_last)
    t_next = t_last + dt

    if (scheme == 1) then
        call upwind_non_cons()
    else if (scheme == 2) then
        call upwind_cons()
    else if (scheme == 3) then
        call lax_wend_non_cons()
    else if (scheme == 4) then
        call lax_wend_cons()
    end if

end subroutine


subroutine upwind_non_cons()
    integer :: j

    do j = 2, num_x-1
        if (vel_last(j) > 0.0) then
            vel_next(j) = vel_last(j) - (dt/dx)*vel_last(j)*(vel_last(j) - vel_last(j-1))
        else
            vel_next(j) = vel_last(j) - (dt/dx)*vel_last(j)*(vel_last(j+1) - vel_last(j))
        end if
    end do

    vel_next(1) = vel_last(1)
    vel_next(num_x) = vel_last(num_x)

end subroutine


subroutine upwind_cons()
    integer :: j

    do j = 2, num_x-1
        if (vel_last(j) > 0.0) then
            vel_next(j) = vel_last(j) - 0.5*(dt/dx)*(vel_last(j)*vel_last(j) - vel_last(j-1)*vel_last(j-1))
        else
            vel_next(j) = vel_last(j) - 0.5*(dt/dx)*(vel_last(j+1)*vel_last(j+1) - vel_last(j)*vel_last(j))
        end if
    end do

    vel_next(1) = vel_last(1)
    vel_next(num_x) = vel_last(num_x)

end subroutine


subroutine lax_wend_non_cons()
    integer :: j

    do j = 2, num_x-1
        vel_next(j) = vel_last(j) &
                      - (0.5*dt/dx)*vel_last(j)*(vel_last(j+1) - vel_last(j-1)) &
                      + 0.5*((dt*vel_last(j)/dx)**2)*(vel_last(j+1) - 2.0*vel_last(j) + vel_last(j-1))
    end do

    vel_next(1) = vel_last(1)
    vel_next(num_x) = vel_last(num_x)

end subroutine


subroutine lax_wend_cons()
    integer :: j

    do j = 1, num_x-1
        vel_next(j) = 0.5*(vel_last(j+1) + vel_last(j)) &
                      - (0.5*dt/dx)*(flux_last(j+1) - flux_last(j))
    end do

    do j = 1, num_x-1
        flux_next(j) = 0.5*vel_next(j)**2
    end do

    do j = 2, num_x-1
        vel_next(j) = vel_last(j) - (dt/dx)*(flux_next(j) - flux_next(j-1))
    end do

    do j = 2, num_x-1
        flux_next(j) = 0.5*vel_next(j)**2
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
    deallocate(x, vel_last, vel_next, flux_last, flux_next)
end subroutine


end program
