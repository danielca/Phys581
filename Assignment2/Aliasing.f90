program Aliasing

    use fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    integer, parameter :: num1a = 200
    integer, parameter :: num1b = 2000
    integer, parameter :: num1c = 20000
    integer, parameter :: num2  = 10000

    real(dp), parameter :: dt1 = 0.005
    real(dp), parameter :: dt2 = 0.010

    open(unit = 42, file = "./Data/Aliasing.txt", action = "write")

    call simple_test(num1a, dt1, 42)
    write(*,*) "Done test 1a"
    call simple_test(num1b, dt1, 42)
    write(*,*) "Done test 1b"
!    call simple_test(num1c, dt1, 42)
!    write(*,*) "Done test 1c"
    call simple_test(num2,  dt2, 42)
    write(*,*) "Done test 2"
    call simple_test2(42)

    close(42)



contains



subroutine simple_test(num, dt, fid)
    integer, intent(in) :: num
    real(dp), intent(in) :: dt
    integer, intent(in) :: fid
    real(dp), dimension(num) :: sig, time, freq, power
    complex(dp), dimension(num) :: dft
    integer :: i

    do i = 0, num-1
        time(i+1) = i*dt
        sig(i+1) = signal(time(i+1))
        freq(i+1) = i/(dt*num)
        if (freq(i+1) >= 0.5/dt) then
            freq(i+1) = freq(i+1) - 1.0/dt
        end if
    end do

    call calc_dft(sig, dft)

    call reorder2_cmplx(dft)
    call reorder2_real(freq)

    call calc_power(dft, power)

    do i = 1, num
        !write(fid, *) freq(i), abs(dft(i))**2
        write(fid, *) freq(i), power(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

end subroutine


subroutine reorder2_real(arr)
    real(dp), dimension(:), intent(inout) :: arr
    real(dp) :: temp
    integer :: num, i

    num = size(arr)

    do i = 1, num/2
        temp = arr(num/2 + i)
        arr(num/2 + i) = arr(i)
        arr(i) = temp
    end do

end subroutine


subroutine reorder2_cmplx(arr)
    complex(dp), dimension(:), intent(inout) :: arr
    complex(dp) :: temp
    integer :: num, i

    num = size(arr)

    do i = 1, num/2
        temp = arr(num/2 + i)
        arr(num/2 + i) = arr(i)
        arr(i) = temp
    end do

end subroutine


subroutine simple_test2(fid)
    integer, intent(in) :: fid
    integer, parameter :: num1 = 20000
    integer, parameter :: num2 = 10000
    complex(dp), dimension(num1) :: sig1, dft1
    real(dp), dimension(num1) :: freq1, time1, power1
    real(dp) :: dt1, df1
    complex(dp), dimension(num2) :: sig2, dft2
    real(dp), dimension(num2) :: freq2, power2
    real(dp) :: dt2
    integer :: i

    dt1 = 0.005
    dt2 = 0.010

    do i = 0, num1-1
        sig1(i+1) = signal(i*dt1)
        freq1(i+1) = i/(dt1*num1)
        if (freq1(i+1) >= 0.5/dt1) then
            freq1(i+1) = freq1(i+1) - 1.0/dt1
        end if
    end do

    call calc_dft(sig1, dft1)

    call reorder2_cmplx(dft1)
    call reorder2_real(freq1)

    write(*,*) "Done first dft"

    call calc_power(dft1, power1)

    do i = 1, num1
        write(fid, *) freq1(i), power1(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num1
        if (abs(freq1(i)) >= 50.0) then
            dft1(i) = cmplx(0.0, 0.0)
        end if
    end do

    call calc_power(dft1, power1)

    do i = 1, num1
        write(fid, *) freq1(i), power1(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

    !df1 = freq1(2) - freq1(1)

    call reorder2_cmplx(dft1)
    call calc_idft(dft1, sig1)

    write(*,*) "Done idft"
    do i = 0, num2-1
        sig2(i+1) = sig1(2*i+1)
        freq2(i+1) = i/(dt2*num2)
        if (freq2(i+1) >= 0.5/dt2) then
            freq2(i+1) = freq2(i+1) - 1.0/dt2
        end if
    end do

    call calc_dft(sig2, dft2)

    call reorder2_cmplx(dft2)
    call reorder2_real(freq2)

    write(*,*) "Done second dft"
    call calc_power(dft2, power2)

    do i = 1, num2
        write(fid, *) freq2(i), power2(i)
    end do

end subroutine


real(dp) function signal(t)
    real(dp), intent(in) :: t

    signal = sin(20.0*pi*t) + 3.0*sin(140.0*pi*t) + cos(160.0*pi*t)
end function

end program
