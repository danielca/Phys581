program Burgers_inviscid

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: x_min = -60.0d0
    real(dp), parameter :: x_max = +60.0d0

    real(dp), parameter :: t_min = 0.0d0
    real(dp), parameter :: t_max = 5000.0d0

    integer, parameter :: num_x = 500

    integer, parameter :: max_num_t = 100000

    real(dp), parameter :: rho_l = 1.0d5
    real(dp), parameter :: rho_r = 1.25d4

    real(dp), parameter :: pre_l = 1.0d0
    real(dp), parameter :: pre_r = 0.1d0

    real(dp), parameter :: vel_l = 0.0d0
    real(dp), parameter :: vel_r = 0.0d0

    real(dp), parameter :: gam = 7.0/5.0

    real(dp), dimension(num_x)    :: x
    real(dp), dimension(num_x, 2) :: u1, u2, u3
    real(dp), dimension(num_x, 2) :: f1, f2, f3

    real(dp) :: t_last, t_next

    real(dp) :: dx, dt

    open( unit = 42, file = "./Data/Nobody_likes_CFD.txt", action = "write" )
    call solve_CFD(1, 42)
    close(42)

    open(unit=43, file="./Data/Nobody_likes_flux.txt", action= "write")
    call solve_CFD(2,43)
    close(43)

contains


subroutine solve_CFD(scheme, fid)
    integer, intent(in) :: scheme, fid

    call initialize()
    call main_loop(scheme, fid)
    
end subroutine


subroutine initialize()
    real(dp) :: enr_l, enr_r
    integer :: n, j

    call linspace(x, x_min, x_max)

    dx = x(2) - x(1)

    ! Set initial conditions

    enr_l = pre_l/(gam - 1.0)
    enr_r = pre_r/(gam - 1.0)

    do j = 1, num_x
        if (x(j) .le. 0.0) then
            u1(j, :) = rho_l
            u2(j, :) = rho_l*vel_l
            u3(j, :) = enr_l
        else
            u1(j, :) = rho_r
            u2(j, :) = rho_r*vel_r
            u3(j, :) = enr_r
        end if
    end do

end subroutine


subroutine main_loop(scheme, fid)
    integer, intent(in) :: scheme, fid
    integer :: n

    call write_stuff(fid)
    do n = 1, max_num_t
        call step_forward(scheme)
        if (t_next > t_max) then
            exit
        end if
    end do
    call write_stuff(fid)
    write(*,*) "Simulation done at n = ", n

end subroutine


subroutine step_forward(scheme)
    integer, intent(in) :: scheme

    u1(:,1) = u1(:,2)
    u2(:,1) = u2(:,2)
    u3(:,1) = u3(:,2)

    f1(:,1) = f1(:,2)
    f2(:,1) = f2(:,2)
    f3(:,1) = f3(:,2)

    t_last = t_next

    call apply_cfl()
    t_next = t_last + dt

    if (scheme == 1) then
        call euler()
    else if (scheme == 2) then
        call FLV()
    !else if (scheme == 3) then
    !    call van_leer()
    end if

end subroutine


subroutine apply_cfl()
    real(dp) :: sound_spd, max_spd, vel
    integer :: j

    !max_spd = sqrt(7.0*100000.0/(5.0*1.0))

    max_spd = 0.0

    do j = 1, num_x
        sound_spd = sqrt(gam*abs(calc_pre(u1(j,1), u2(j,1), u3(j,1))/u1(j,1)))
        vel = u2(j,1)/u1(j,1)
        if (abs( vel - sound_spd ) > max_spd) then
            max_spd = abs(vel - sound_spd)
        else if (abs( vel + sound_spd ) > max_spd) then
            max_spd = abs(vel + sound_spd)
        else if (abs(vel) > max_spd) then
            max_spd = abs(vel)
        end if
    end do

    dt = 0.5*dx/max_spd

end subroutine


subroutine euler()
    real(dp), dimension(num_x) :: u1h, u2h, u3h, M, a
    integer :: j
    
    
    do j = 1, num_x-1
        
        u1h(j) = 0.5*(u1(j,1) + u1(j+1,1))
        u2h(j) = 0.5*(u2(j,1) + u2(j+1,1))
        u3h(j) = 0.5*(u3(j,1) + u3(j+1,1))

        !f1(j, 1) = calc_f1(u1h(j), u2h(j), u3h(j))
        !f2(j, 1) = calc_f2(u1h(j), u2h(j), u3h(j))
        !f3(j, 1) = calc_f3(u1h(j), u2h(j), u3h(j))

        f1(j, 1) = calc_f1(u1(j, 1), u2(j, 1), u3(j, 1))
        f2(j, 1) = calc_f2(u1(j, 1), u2(j, 1), u3(j, 1))
        f3(j, 1) = calc_f3(u1(j, 1), u2(j, 1), u3(j, 1))

    end do

    do j = 1, num_x -1
        u1h(j) = u1h(j) - 0.5*(dt/dx)*(f1(j+1,1) - f1(j,1))
        u2h(j) = u2h(j) - 0.5*(dt/dx)*(f2(j+1,1) - f2(j,1))
        u3h(j) = u3h(j) - 0.5*(dt/dx)*(f3(j+1,1) - f3(j,1))

        f1(j, 2) = calc_f1(u1h(j), u2h(j), u3h(j))
        f2(j, 2) = calc_f2(u1h(j), u2h(j), u3h(j))
        f3(j, 2) = calc_f3(u1h(j), u2h(j), u3h(j))

    end do

    do j = 2, num_x-1
        !u1(j,2) = u1(j,1) - (dt/dx)*(f1(j,1) - f1(j-1,1))
        !u2(j,2) = u2(j,1) - (dt/dx)*(f2(j,1) - f2(j-1,1))
        !u3(j,2) = u3(j,1) - (dt/dx)*(f3(j,1) - f3(j-1,1))

        u1(j, 2) = u1(j, 1) - (dt/dx)*(f1(j,2) - f1(j-1,2))
        u2(j, 2) = u2(j, 1) - (dt/dx)*(f2(j,2) - f2(j-1,2))
        u3(j, 2) = u3(j, 1) - (dt/dx)*(f3(j,2) - f3(j-1,2))
    end do

end subroutine

real(dp) function calc_speed(u1_in, u2_in, u3_in)
    real(dp), intent(in) :: u1_in, u2_in, u3_in
    real(dp)::M
    calc_speed = sqrt(gam*abs(calc_pre(u1_in, u2_in, u3_in)/u1_in))

end function

subroutine FVL()
    real(dp), dimension(num_x) :: u1h, u2h, u3h
    integer :: j
    real(dp)::M,a,s

    do j = 1, num_x-1
        u1h(j) = 0.5*(u1(j,1) + u1(j+1,1))
        u2h(j) = 0.5*(u2(j,1) + u2(j+1,1))
        u3h(j) = 0.5*(u3(j,1) + u3(j+1,1))

        s = u2(j,1)/(u1(j,1))
        a = (calc_speed(u1(j,1), u2(j,1), u3(j,1)))
        M = s/a
        
        if (M.lt.0) then
            f1(j, 1) = calc_f1(u1h(j), u2h(j), u3h(j))
            f2(j, 1) = calc_f2(u1h(j), u2h(j), u3h(j))
            f3(j, 1) = calc_f3(u1h(j), u2h(j), u3h(j))
        else if ((m.gt.0) .and. (m.lt.1)) then 
            f1(j, 1) = 0.25*(u2(j,1)*a*(M+1)**2) -&
                       0.25*(u2(j,1)*(M-1)**2)
            f2(j, 1) = 0.25*(u2(j,1)*a*(M+1)**2)*((gam-1.)*s+2*a)/gam - &
                       0.25*(u2(j,1)*a*(M-1)**2)*((gam-1.)*s-2*a)/gam 
            f3(j, 1) = 0.25*(u2(j,1)*a*(M+1)**2) * ((((gam-1.)*s+ 2*a)**2)/(2*(gam-1.)*(gam+1))) - &
                       0.25*(u2(j,1)*(M-1)**2) * ((((gam-1.)*s- 2*a)**2)/(2*(gam-1.)*(gam+1)))
        else
            f1(j, 1) = calc_f1(u1h(j), u2h(j), u3h(j))
            f2(j, 1) = calc_f2(u1h(j), u2h(j), u3h(j))
            f3(j, 1) = calc_f3(u1h(j), u2h(j), u3h(j)) 
        end if
    end do

    do j = 2, num_x-1
        
            u1(j,2) = u1(j,1) - (dt/dx)*(f1(j,1) - f1(j-1,1))
            u2(j,2) = u2(j,1) - (dt/dx)*(f2(j,1) - f2(j-1,1))
            u3(j,2) = u3(j,1) - (dt/dx)*(f3(j,1) - f3(j-1,1))
        
    end do

end subroutine

subroutine write_stuff(fid)
    integer, intent(in) :: fid
    integer :: j, n

    do j = 1, num_x
        write(fid, *) x(j), t_next, u1(j,2), calc_pre(u1(j,2), u2(j,2), u3(j,2)), u3(j,2)
    end do
    write(fid, *) ""
    write(fid, *) ""

end subroutine


real(dp) function calc_f1(u1_in, u2_in, u3_in)
    real(dp), intent(in) :: u1_in, u2_in, u3_in
    calc_f1 = u2_in
end function


real(dp) function calc_f2(u1_in, u2_in, u3_in)
    real(dp), intent(in) :: u1_in, u2_in, u3_in
    calc_f2 = 0.5*(3.0 - gam)*(u2_in**2)/u1_in + (gam - 1.0)*u3_in
end function


real(dp) function calc_f3(u1_in, u2_in, u3_in)
    real(dp), intent(in) :: u1_in, u2_in, u3_in
    calc_f3 = gam*u2_in*u3_in/u1_in - 0.5*(gam - 1.0)*(u2_in**3)/(u1_in**2)
end function


real(dp) function calc_pre(u1_in, u2_in, u3_in)
    real(dp), intent(in) :: u1_in, u2_in, u3_in
    calc_pre = (gam - 1.0)*(u3_in - 0.5*(u2_in**2)/u1_in)
end function

end program
