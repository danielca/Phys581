program Poisson

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    integer, parameter :: max_num_t = 1000000

    real(dp), dimension(:), allocatable :: x, y
    real(dp), dimension(:, :), allocatable :: u0, u1

    real(dp) :: x_min, x_max, y_min, y_max
    real(dp) :: del
    real(dp) :: src
    real(dp) :: eps

    integer :: num_x, num_y

    integer :: scheme, bound_conds

    integer :: fid

    integer :: i

    fid = 42

    open( unit = fid, file = "./Data/Poisson.txt", action = "write")

    ! Jacobi runs

    x_min = 0.0d0
    x_max = 20.0d0
    y_min = 0.0d0
    y_max = 10.0d0

    del = 0.5d0
    src = 0.0
    eps = 1.0d-3

    scheme      = 1
    bound_conds = 1

    do i = 1, 5
        del = 5.0*(0.5)**i
        call solve_poisson()
    end do

    ! Gauss-Seidel run

    x_min = 0.0d0
    x_max = 1.0d0
    y_min = 0.0d0
    y_max = 1.0d0

    del = 1.0/49.0
    src = 10.0
    eps = 1.0d-3

    scheme      = 2
    bound_conds = 2

    call solve_poisson()

    close(fid)

contains


subroutine solve_poisson()

    call initialize()
    call main_loop()
    call write_stuff()
    call clean_up()

end subroutine


subroutine initialize()
    integer :: k, l

    num_x = (x_max - x_min)/del + 1.0
    num_y = (y_max - y_min)/del + 1.0

    allocate(x(num_x))
    allocate(y(num_y))
    allocate(u0(num_x, num_y))
    allocate(u1(num_x, num_y))

    call linspace(x, x_min, x_max)
    call linspace(y, y_min, y_max)

    del = x(2) - x(1)

    ! Set initial conditions
    u0 = 0.0
    u1 = 0.0

    call apply_bound_conds()

end subroutine


subroutine apply_bound_conds()

    integer :: k, l
    real(dp) :: x_l, x_r, y_l, y_r

    if (bound_conds == 1) then
        x_l = 0.0
        x_r = 100.0
        y_l = 0.0
        y_r = 0.0
    else if (bound_conds == 2) then
        x_l = 0.0
        x_r = 0.0
        y_l = 0.0
        y_r = 0.0
    end if

    do k = 1, num_x
        u0(k, 1) = y_l
        u0(k, num_y) = y_r

        u1(k, 1) = y_l
        u1(k, num_y) = y_r
    end do

    do l = 1, num_y
        u0(1, l) = x_l
        u0(num_x, l) = x_r

        u1(1, l) = x_l
        u1(num_x, l) = x_r
    end do

end subroutine


subroutine main_loop()

    real(dp) :: u_diff

    integer :: n

    do n = 1, max_num_t
        if (scheme == 1) call jacobi_update()
        if (scheme == 2) call gauss_seigel_update()

        !u_diff = maxval(abs(u1 - u0))
        u_diff = calc_error()
        if (u_diff < eps) exit

        u0 = u1
    end do

    if (scheme == 1) write(*,*) "Jacobi method      : ", n, " iterations."
    if (scheme == 2) write(*,*) "Gauss-Seigel method: ", n, " iterations."

end subroutine


subroutine jacobi_update()
    integer :: k, l
    real(dp) :: const

    const = 0.25*del*del*src

    do k = 2, num_x-1
        do l = 2, num_y-1
            u1(k,l) = 0.25*(u0(k+1,l) + u0(k-1,l) + u0(k,l+1) + u0(k,l-1)) - const
        end do
    end do

end subroutine


subroutine gauss_seigel_update()
    integer :: k, l
    real(dp) :: const

    const = 0.25*del*del*src

    do k = 2, num_x-1
        do l = 2, num_y-1
            u1(k,l) = 0.25*(u1(k+1,l) + u1(k-1,l) + u1(k,l+1) + u1(k,l-1)) - const
        end do
    end do

end subroutine


real(dp) function calc_error()
    integer :: k, l
    real(dp) :: const, diff, max_diff

    const = del*del*src

    max_diff = 0.0

    do k = 2, num_x-1
        do l = 2, num_y-1
            diff = u1(k+1,l) + u1(k-1,l) + u1(k,l+1) + u1(k,l-1) - 4.0*u1(k,l) - const
            if (abs(diff) > max_diff) then
                max_diff = abs(diff)
            end if
        end do
    end do

    calc_error = max_diff

end function


subroutine write_stuff()
    integer :: k, l

    do k = 1, num_x
        do l = 1, num_y
            write(fid, *) x(k), y(l), u1(k, l) 
        end do
        write(fid, *) ""
    end do
    write(fid, *) ""

end subroutine


subroutine clean_up()

    deallocate(x, y, u0, u1)

end subroutine


end program
