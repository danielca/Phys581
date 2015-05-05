program Laplace

    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)
    real(dp), parameter :: two_pi = 2.0d0*pi

    real(dp), parameter :: x_min = 0.0d0
    real(dp), parameter :: x_max = 1.0d0

    real(dp), parameter :: y_min = 0.0d0
    real(dp), parameter :: y_max = 1.0d0

    real(dp), parameter :: eps = 1.0d-8

    real(dp), dimension(:), allocatable :: x, y
    real(dp), dimension(:, :), allocatable :: u0, u1

    real(dp) :: del

    integer :: num_x, num_y

    open( unit = 42, file = "./Data/Laplace.txt", action = "write")

    call solve_laplace(1, 42)
    write(42, *) ""
    write(42, *) ""
    call solve_laplace(2, 42)

    close(42)

contains


subroutine solve_laplace(method, fid)
    integer, intent(in) :: method, fid

    call initialize()
    call main_loop(method)
    call write_stuff(fid)
    !call compare_to_theoretical()
    call clean_up()

end subroutine


subroutine initialize()
    integer :: j, l

    num_x = 64
    num_y = 64

    allocate(x(num_x))
    allocate(y(num_y))
    allocate(u0(num_x, num_y))
    allocate(u1(num_x, num_y))

    call linspace(x, x_min, x_max)
    call linspace(y, y_min, y_max)

    del = x(2) - x(1)
    if (abs(del - y(2) + y(1))/abs(del) > 1.0d-6) then
        write(*,*) "WARNING: delta x is not equal to delta y"
    end if

    ! Set initial conditions
    u0 = 0.0
    u1 = 0.0

    call apply_bound_conds()

end subroutine


subroutine apply_bound_conds()

    integer :: j, l

    do j = 1, num_x
        u0(j, 1) = 100.0*sin(two_pi*x(j))
        u0(j, num_y) = -100.0*sin(two_pi*x(j))

        u1(j, 1) = u0(j, 1)
        u1(j, num_y) = u0(j, num_y)
    end do

    do l = 1, num_y
        u0(1, l) = 0.0
        u0(num_x, l) = 0.0
        
        u1(1, l) = 0.0
        u1(num_x, l) = 0.0
    end do

end subroutine


subroutine main_loop(method)
    integer, intent(in) :: method

    real(dp) :: u_diff

    integer :: n, j, l

    do n = 1, 1000000
        if (method == 1) call jacobi_update()
        if (method == 2) call gauss_seigel_update()

        u_diff = maxval(abs(u1 - u0))
        if (u_diff < eps) exit

        u0 = u1
        call apply_bound_conds()
    end do

    if (method == 1) write(*,*) "Jacobi method      : ", n, " iterations."
    if (method == 2) write(*,*) "Gauss-Seigel method: ", n, " iterations."

end subroutine


subroutine jacobi_update()
    integer :: j, l

    do j = 2, num_x-1
        do l = 2, num_y-1
            u1(j,l) = 0.25*(u0(j+1,l) + u0(j-1,l) + u0(j,l+1) + u0(j,l-1))
        end do
    end do

end subroutine


subroutine gauss_seigel_update()
    integer :: j, l

    do j = 2, num_x-1
        do l = 2, num_y-1
            u1(j,l) = 0.25*(u1(j+1,l) + u1(j-1,l) + u1(j,l+1) + u1(j,l-1))
        end do
    end do

end subroutine


subroutine compare_to_theoretical()
    real(dp), dimension(:,:), allocatable :: ut
    real(dp), dimension(:), allocatable :: x_part, y_part
    real(dp) :: coef1, coef2, diff
    integer :: j, l

    allocate(ut(num_x, num_y))
    allocate(x_part(num_x))
    allocate(y_part(num_y))

    do j = 1, num_x
        x_part(j) = sin(2.0*pi*x(j))
    end do

    coef1 = 100.0/(1.0 - exp(2.0*pi))
    coef2 = 100.0/(1.0 - exp(-2.0*pi))
    do l = 1, num_y
        y_part(l) = coef1*exp(2.0*pi*y(l)) + coef2*exp(-2.0*pi*y(l))
    end do

    do j = 1, num_x
        do l = 1, num_y
            ut(j,l) = x_part(j)*y_part(l)
        end do
    end do

    diff = maxval(abs(u1 - ut))

    write(*, *) "Max error = ", diff

    deallocate(ut, x_part, y_part)

end subroutine


subroutine write_stuff(fid)
    integer, intent(in) :: fid
    integer :: j, l

    do j = 1, num_x
        do l = 1, num_y
            write(fid, *) x(j), y(l), u1(j, l) 
        end do
        write(fid, *) ""
    end do

end subroutine


subroutine clean_up()

    deallocate(x, y, u0, u1)

end subroutine


end program
