program Advection

    use Linear_systems_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)

    real(dp), parameter :: x_min = -2.0d0
    real(dp), parameter :: x_max =  2.0d0
    real(dp), parameter :: t_min =  0.0d0
    real(dp), parameter :: t_max =  2.0d0

    real(dp), dimension(:), allocatable :: x, t
    real(dp), dimension(:, :), allocatable :: vel

    real(dp) :: energy_init, energy_fin, del_energy_rel

    ! Coefficients
    real(dp), dimension(:), allocatable :: a, b, c, d
    real(dp) :: d1, d2, d3

    integer :: num_x, num_t

    integer :: scheme, init_type, trial, ind_num
    real(dp), dimension(7) :: spd, dx, dt

    spd = (/ 5.00d-1, 5.00d-1, 5.00d-1, 5.00d-1, 5.00d-1, 5.00d-1, 5.00d-1 /)
    dx  = (/ 4.00d-2, 2.00d-2, 1.37d-2, 1.01d-2, 9.90d-3, 2.00d-2, 2.00d-2 /)
    dt  = (/ 2.00d-2, 2.00d-2, 2.00d-2, 2.00d-2, 2.00d-2, 1.00d-2, 4.00d-2 /)

    open( unit = 42, file = "./Data/Advection.txt", action = "write" )
    open( unit = 43, file = "./Advection.gp", action = "write" )

    call gnuplot_header(43)

    ind_num = 0
    do init_type = 1, 4
        do trial = 1, 7
            do scheme = 1, 4
                call solve_advection(spd(trial), dx(trial), dt(trial), &
                                     scheme, init_type, trial, 42, 43, ind_num)
                ind_num = ind_num + 1
            end do
        end do
    end do

    call gnuplot_footer(43)

    close(42)
    close(43)


contains


subroutine gnuplot_header(fid2)
    integer, intent(in) :: fid2

    write(fid2, *) "set terminal pdfcairo enhanced size 5, 5"
    write(fid2, *) ""
    write(fid2, *) "set output ""./Plots/Advection.pdf"""
    write(fid2, *) ""
    write(fid2, *) "set size 1, 0.9"
    write(fid2, *) "set origin 0, 0.1"
    write(fid2, *) ""
    write(fid2, *) "set xlabel ""x"""
    write(fid2, *) "set ylabel ""t"""
    write(fid2, *) "set pm3d map"
    !write(fid2, *) "set palette gray"
    write(fid2, *) "set palette defined (0 0 0 0, 1 1 1 1)"
    write(fid2, *) "set xrange [-2:2]"
    write(fid2, *) "set yrange [0:2]"
    write(fid2, *) "unset key"
    write(fid2, *) "unset grid"
    write(fid2, *) ""
    write(fid2, *) ""

end subroutine


subroutine gnuplot_footer(fid2)
    integer, intent(in) :: fid2

    write(fid2, *) "reset"
    write(fid2, *) ""

end subroutine


subroutine solve_advection(spd, dx, dt, scheme, init_type, trial, fid, fid2, index_num)
    real(dp), intent(in) :: spd, dx, dt
    integer, intent(in) :: scheme, init_type, trial, fid, fid2, index_num

    integer :: n

    call initialize(spd, dx, dt, scheme)
    call calc_coefs(scheme, spd*dt/(2.0*dx))
    call set_init_conds(init_type)
    call main_loop()
    call calc_energy()
    call write_out(spd, dx, dt, scheme, init_type, trial, fid, fid2, index_num)
    call clean_up()

end subroutine


subroutine initialize(spd, dx, dt, scheme)
    real(dp), intent(in) :: spd, dx, dt
    integer, intent(in) :: scheme

    integer :: n, j

    num_x = int(floor((x_max - x_min)/dx)) + 1
    num_t = int(floor((t_max - t_min)/dt)) + 1

    allocate(x(num_x))
    allocate(t(num_t))
    allocate(vel(num_x, num_t))

    allocate(a(num_x), b(num_x), c(num_x), d(num_x))

    do j = 1, num_x
        x(j) = x_min + (j-1)*dx
    end do

    do n = 1, num_t
        t(n) = t_min + (n-1)*dt
    end do

end subroutine


subroutine calc_coefs(scheme, cour)
    integer, intent(in) :: scheme
    real(dp), intent(in) :: cour
    real(dp) :: alpha

    if ((scheme == 1) .or. (scheme == 2)) then
        alpha = 0.0
    else if (scheme == 3) then
        alpha = 1.0
    else if (scheme == 4) then
        alpha = 0.5
    end if

    a = -alpha*cour
    b = 1.0d0
    c = alpha*cour

    a(1) = 0.0
    a(num_x) = 0.0

    c(1) = 0.0
    c(num_x) = 0.0

    d1 = (1.0 - alpha)*cour
    d2 = 1.0
    d3 = (alpha - 1.0)*cour

    if (scheme == 2) then
        d1 = 2.0*cour*cour + cour
        d2 = 1.0 - 4.0*cour*cour
        d3 = 2.0*cour*cour - cour
    end if

end subroutine


subroutine set_init_conds(init_type)
    integer, intent(in) :: init_type

    integer :: j

    do j = 1, num_x
        if (init_type == 1) then
            vel(j, 1) = sin(2.0*x(j))
        else if (init_type == 2) then
            if (x(j) < 0.0) then
                vel(j, 1) = 0.0 
            else
                vel(j, 1) = 1.0
            end if
        else if (init_type == 4) then
            vel(j, 1) = exp(-4.0*(x(j)**2))
        end if
    end do

    if (init_type == 3) then
        vel = 0.0
        vel(nint(num_x/2.0), 1) = 1.0/(x(2) - x(1))
    end if

end subroutine


subroutine main_loop()
    integer :: n, j

    do n = 1, num_t-1
        d(1) = vel(1, 1)
        d(num_x) = vel(num_x, 1)

        do j = 2, num_x - 1
            d(j) = d1*vel(j-1, n) + d2*vel(j, n) + d3*vel(j+1, n)
        end do

        call tridiagonal(a, b, c, d, vel(:, n+1))

    end do

end subroutine


subroutine calc_energy()
    integer :: j

    energy_init = 0.0
    energy_fin  = 0.0
    do j = 1, num_x
        if ((x(j) > -2.0) .and. (x(j) < 2.0)) then
            energy_init = energy_init + vel(j, 1)**2
            energy_fin  = energy_fin  + vel(j, num_t)**2
        end if
    end do

    del_energy_rel = (energy_fin - energy_init)/(energy_init)

end subroutine


subroutine write_out(spd, dx, dt, scheme, init_type, trial, fid, fid2, index_num)
    real(dp), intent(in) :: spd, dx, dt
    integer, intent(in) :: scheme, init_type, trial, fid, fid2, index_num

    character(len=1024) :: scheme_str, fmt_str, title_str, cbrange
    real(dp) :: min_vel, max_vel
    integer :: n, j

    if (scheme == 1) then
        scheme_str = "Forward Euler"
    else if (scheme == 2) then
        scheme_str = "Lax-Wendroff"
    else if (scheme == 3) then
        scheme_str = "Backward Euler"
    else if (scheme == 4) then
        scheme_str = "Crank-Nicolson"
    end if

    if (init_type == 1) then
        min_vel = -1.2
        max_vel = 1.2
    else if ((init_type == 2) .or. (init_type == 4)) then
        min_vel = -0.2
        max_vel = 1.2
    else if (init_type == 3) then
        min_vel = -0.2
        max_vel = maxval(vel(:, 1))
    end if

    write(fid2, *) ""
    fmt_str = "(a, a, a, i1, a, i1, a)"
    write(fid2, fmt_str)   " set title ""Advection: ", trim(scheme_str), &
                                ", Initial Condition ", init_type, & 
                                ", Trial ", trial, """"
    write(fid2, *) "set cbrange [", min_vel, ":", max_vel, "]"
    fmt_str = "(a, e15.3, a)"
    write(fid2, fmt_str) " set label ""dE_{rel} = ", del_energy_rel, """ at -2.2, -0.5"
    write(fid2, *) ""
    fmt_str = "(a, i3, a)"
    write(fid2, fmt_str) " splot ""./Data/Advection.txt"" index ", index_num, " using 1:2:3 palette"
    write(fid2, *) ""
    write(fid2, *) "unset label"
    write(fid2, *) ""

    do j = 1, num_x
        if ((x(j) > -2.0) .and. (x(j) < 2.0)) then
            do n = 1, num_t
                write(fid, *) x(j), t(n), vel(j, n)
            end do
        write(fid, *) ""
        end if
    end do

    write(fid, *) ""
    write(fid, *) ""


end subroutine


subroutine clean_up()

    deallocate(x)
    deallocate(t)
    deallocate(vel)
    deallocate(a)
    deallocate(b)
    deallocate(c)
    deallocate(d)

end subroutine


end program
