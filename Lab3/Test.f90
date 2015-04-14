program Test
    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), dimension(100, 100) :: u
    real(dp), dimension(100) :: x, y
    real(dp) :: coef, alpha, temp1, temp2
    integer :: n, m, max_num, i, j, num_x

    num_x = size(x)

    alpha = -1000.0
    max_num = 100

    do i = 1, num_x
        x(i) = (i-1)/(num_x - 1.0)
        y(i) = (i-1)/(num_x - 1.0)
    end do

    do n = 1, max_num
        do m = 1, max_num
            coef = 1 - cos(pi*n)
            coef = coef*(1 - cos(pi*m))
            coef = coef*4.0/(pi*pi*n*m)
            coef = coef/(pi*pi*(n*n + m*m) - alpha)
            coef = coef*(pi*pi*(n*n + m*m))
            do i = 1, num_x
                do j = 1, num_x
                    u(i, j) = u(i, j) + coef*sin(n*pi*x(i))*sin(m*pi*y(j))
                end do
            end do
        end do
    end do

    write(*,*) coef

    open( unit = 42, file = "Test.txt" )

    do i = 1, num_x
        do j = 1, num_x
            write(42, *) x(i), y(j), u(i, j)
        end do
        write(42, *) ""
    end do

    !write(42, *) ""
    !write(42, *) ""

    !do i = 2, num_x - 1
    !    do j = 2, num_x - 1
    !        temp1 =  u(i-1, j) + u(i+1, j) + u(i, j-1) + u(i, j+1) - (4.0 + alpha*(x(2) - x(1))**2)*u(i, j)
    !        temp1 = log10(abs(temp1))
    !        write(42,*) temp1
    !    end do
    !    write(42, *) ""
    !end do

    close(42)

end program
