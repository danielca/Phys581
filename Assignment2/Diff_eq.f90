program Diff_eq

    use Fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    real(dp), parameter :: sig = 0.03
    real(dp), parameter :: x0  = 2.0/3.0

    open(unit = 42, file = "./Data/Diff_eq.txt", action = "write")

    call analytical_solution(42)

    write(42,*) ""
    write(42,*) ""

    call fft_solution(42)

    close(42)

contains

subroutine analytical_solution(fid)
    
    integer, intent(in) :: fid

    integer, parameter :: num_x = 10000
    integer, parameter :: num_n = 50

    real(dp), dimension(num_x) :: x, xpp
    real(dp), dimension(num_x) :: temp, temp_grad, diff, q
    complex(dp), dimension(num_x) :: q_theor
    complex(dp), dimension(2*num_n+1) :: q_coef
    real(dp) :: a, b, dx
    real(dp), dimension(num_n) :: bn
    integer :: i, n

    dx = 1.0/dble(num_x-1)
    do i = 1, num_x
        x(i) = (i-1)*dx
    end do

    a = 1.0/(2.0*pi*pi)
    b = exp(-2.0d0*sig*sig*pi*pi)

    do n = 1, num_n
        bn(n) = b**(n*n)
    end do

    temp = 0.0d0
    do i = 1, num_x
        do n = 1, num_n
            temp(i) = temp(i) + a*bn(n)*cos(2.0*pi*(x(i) - x0)*n)/dble(n*n)
        end do
        !temp(i) = temp(i) - x(i)*x(i)/2.0
        !q(i) = q_prime(x(i)) + q_prime(x(i) - 1.0d0) + q_prime(x(i) + 1.0d0) - 1.0
        q(i) = q_prime(x(i)) - 1.0
    end do

    q_theor = 0.0
    do n = -num_n, num_n
        do i = 1, num_x
            q_theor(i) = q_theor(i) + (b**(n*n))*exp(cmplx(0.0, 2.0*pi*n*(x(i) - x0), kind = dp))
        end do
    end do

    temp_grad = 0.0
    do i = 2, num_x-1
        temp_grad(i) = (temp(i+1) - 2.0*temp(i) + temp(i-1))/(dx*dx)
    end do
    temp_grad(1) = temp_grad(2)
    temp_grad(num_x) = temp_grad(num_x-1)

    do i = 1, num_x
        diff(i) = abs(temp_grad(i) + q(i))
        write(fid,*) x(i), temp(i), temp_grad(i), -q(i), 20*log10(diff(i))
    end do

end subroutine

subroutine fft_solution(fid)
    integer, intent(in) :: fid
    integer, parameter :: num = 64
    complex(dp), dimension(num) :: temp, temp_dft, q, q_dft
    real(dp), dimension(num) :: x, freq, x2
    real(dp) :: dx, period
    integer :: n, k

    period = 1.0
    dx = period/dble(num)

    do n = 0, num-1
        x(n+1) = n*dx
        q(n+1) = q_prime(x(n+1))
    end do

    call fft(q, dx, freq, q_dft)

    do k = 1, num-1
        if (abs(freq(k)) < 1.0d-12) then
            temp_dft(k) = 0.0d0
        else
            temp_dft(k) = q_dft(k)/((2.0*pi*freq(k))**2)
        end if
    end do

    call ifft(temp_dft, freq(2) - freq(1), x2, temp)

    do n = 1, num
        write(fid, *) x2(n), real(q(n)), real(temp(n)), aimag(temp(n))
        !write(fid, *) x2(n), real(q(n)), freq(n), real(temp_dft(n)), aimag(temp_dft(n))
    end do

end subroutine

real(dp) function q_prime(x)
    real(dp), intent(in) :: x
    q_prime = exp(-((x - x0)**2)/(2*sig*sig))/sqrt(2.0d0*pi*sig*sig)
end function

end program
