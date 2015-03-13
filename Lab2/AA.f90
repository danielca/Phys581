program AA
use Fourier_analysis_module

implicit none

!call Transform()
call windowing()





contains

real(kind=8) function sinFunc(f,PI,dt,n,theta)
    real(kind=8), intent(in)::f, PI, dt, n, theta   
    sinFunc = sin((2*PI*f*n*dt) + theta)
end function

subroutine windowing()
    real(kind=8)::PI, f, dt, theta
    real(kind=8), dimension(64)::vec_no_window,vec_window, freq_no_window, & 
        magnitude_no_window, freq_window, magnitude_window, &
        vec_offset, freq_offset, magnitude_offset
    complex(kind=8), dimension(64) :: fft_no_window, fft_window, fft_offset
    integer::n, i

    PI = 3.14159265359
    f = 10.
    n = 64
    PI = 3.14159265359
    dt = 1./64.
    theta = 0.

    do i=1,n 
        vec_no_window(i) = sinFunc(f, PI, dt, dble(i-1), theta)
        vec_offset(i) = sinFunc(f*1.35, PI, dt, dble(i-1), dble(4))
    end do

    !Create the Window
    call window_hanning(vec_offset, vec_window)
    !calculate the FFTs
    call fft(vec_no_window, dt, freq_no_window, fft_no_window)
    call fft(vec_window, dt, freq_window, fft_window)
    call fft(vec_offset, dt, freq_offset, fft_offset)
    call calc_power(fft_no_window,magnitude_no_window)
    call calc_power(fft_window,magnitude_window)
    call calc_power(fft_offset, magnitude_offset)

    open(unit=44, file="./Data/Window1.txt")
    do i=1,N
        write(44,*) i, vec_no_window(i), vec_offset(i), vec_window(i), &
            freq_no_window(i), magnitude_no_window(i), &
            freq_offset(i), magnitude_offset(i), &
            freq_window(i), magnitude_window(i)
    end do
    close(44)

    !Second Window
    call window_blackmann(vec_offset, vec_window)

    call fft(vec_window, dt, freq_window, fft_window)
    call calc_power(fft_window,magnitude_window)

    open(unit=45, file= "./Data/Window2.txt")
    do i=1,N
        write(45,*) i, vec_no_window(i), vec_offset(i), vec_window(i), &
            freq_no_window(i), magnitude_no_window(i), &
            freq_offset(i), magnitude_offset(i), &
            freq_window(i), magnitude_window(i)
    end do
    close(45)


end subroutine

real(kind=8) function cosFunc(f,PI,dt,n,theta)
    real(kind=8), intent(in):: f,PI,dt,n,theta
    cosFunc = cos((2.*PI*f*n*dt) + theta)
end function

subroutine power(dat, pwr)
    complex(kind=8), dimension(:), intent(in)::dat
    real(kind=8), dimension(:), intent(out)::pwr
    integer::i
    do i =1, size(dat)
        pwr(i) = abs(dat(i))
    end do
end subroutine

subroutine Transform()
    real(kind=8)::f,PI,dt,theta
    integer::N, i
    real(kind=8),dimension(64)::vec1, freq1, magnitude1, magnitude_db1
    real(kind=8),dimension(64)::vec2, freq2, magnitude2, magnitude_db2
    complex(kind=8), dimension(64)::fft1, fft2
    !set constants
    PI = 3.14159265359
    f = 0.25
    theta=0.
    dt = 1.
    N=64

    !assign the first vector
    do i=1,N
        vec1(i) = cosFunc(f,PI,dt,real(i-1,8),theta)
    end do

    call fft(vec1, dt, freq1, fft1)
    call power(fft1,magnitude1)
    call calc_power(fft1,magnitude_db1)

    open (unit=42, file="./Data/AA1.txt")
    do i=1,N
        write(42,*) i, vec1(i), freq1(i), magnitude1(i), magnitude_db1(i)
    end do
    close(42)

    !now for the second set with ... PHASE... *GASP*
    !assign the first vector
    f = f + PI/8.
    do i=1,N
        vec2(i) = cosFunc(f,PI,dt,real(i-1,8),theta)
    end do

    call fft(vec2, dt, freq2, fft2)
    call power(fft2,magnitude2)
    call calc_power(fft2,magnitude_db2)

    open (unit=43, file="./Data/AA2.txt")
    do i=1,N
        write(43,*) i, vec2(i), freq2(i), magnitude2(i), magnitude_db2(i)
    end do

    close(43)


end subroutine

end program
