program Image_analysis
    use Fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)

    real(dp), dimension(3, 4) :: x
    complex(dp), dimension(3, 4) :: x1, x2
    complex(dp), dimension(4, 3) :: x2_tran
    integer :: i, j

    x = reshape((/ 1, 8, 9, 2, 5, 8, 3, 1, 7, 9, 2, 2 /), shape(x))

    call dft_2d(x, x1)
    call dft_2d(transpose(x), x2_tran)
    x2 = transpose(x2_tran)

    write(*,*) "----- x1: -----"
    do i = 1, 3
        do j = 1, 4
            write(*,*) x1(i, j)
        end do
        write(*,*) "\\"
    end do

    write(*,*) "----- x2: -----"
    do i = 1, 3
        do j = 1, 4
            write(*,*) x2(i, j)
        end do
        write(*,*) "\\"
    end do


end program
