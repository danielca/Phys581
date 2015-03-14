program Image_analysis
    use Fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)

    real(dp), dimension(3, 4) :: x
    complex(dp), dimension(3, 4) :: x1, x2t
    complex(dp), dimension(4, 3) :: x1t, x2
    character(len=1024) :: wstr
    integer :: i, j

    x = reshape((/ 1, 8, 9, 2, 5, 8, 3, 1, 7, 9, 2, 2 /), shape(x))

    do i = 1, 3
        call calc_dft(x(i, :), x1(i, :))
    end do

    x1t = transpose(x1)

    do i = 1, 4
        call calc_dft(x1t(i, :), x2(i, :))
    end do

    x2t = transpose(x2)

    wstr = "(f8.4, a, f8.4, a)"

    write(*,*) "----- x1: -----"
    do i = 1, 3
        do j = 1, 4
            if (aimag(x1(i,j)) >= 0) then
                write(*,wstr) real(x1(i, j)), " + i", aimag(x1(i, j)), " &"
            else
                write(*,wstr) real(x1(i, j)), " - i", -aimag(x1(i, j)), " &"
            end if
        end do
        write(*,*) "\\"
    end do

    write(*,*) "----- x2: -----"
    do i = 1, 3
        do j = 1, 4
            if (aimag(x2t(i,j)) >= 0) then
                write(*,wstr) real(x2t(i, j)), " + i", aimag(x2t(i, j)), " &"
            else
                write(*,wstr) real(x2t(i, j)), " - i", -aimag(x2t(i, j)), " &"
            end if
        end do
        write(*,*) "\\"
    end do


end program
