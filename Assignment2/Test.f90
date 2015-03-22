program test
    use fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 3.14159265
    integer, parameter :: num = 100

    real(dp), dimension(num) :: x, freq, time
    complex(dp), dimension(num) :: dft
    real(dp) :: pow
    integer :: n

    do n = 0, num-1
        time(n+1) = n/1000.0
        x(n+1) = sin(2*pi*100*time(n+1))
    end do

    call calc_dft(x, dft)

    pow = 0.0
    do n = 1, num
        pow = pow + abs(dft(n))**2
        !write(*,"(f10.3)") abs(dft(n))
    end do
    pow = pow/dble(num**2)

    write(*,*) pow
    
end program
