program Fluid_mechanics

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    integer, parameter :: num_disp = 1000
    integer, parameter :: num_t = 1000

    real(dp), parameter :: visc = 1.0d-2/pi

    real(dp), dimension(:, :), allocatable :: vel
    real(dp), dimension(:), allocatable    :: time
    real(dp), dimension(:), allocatable    :: disp

    call initialize()
    call cleanup()



contains



subroutine initialize()
end subroutine

subroutine cleanup()
end subroutine

end program
