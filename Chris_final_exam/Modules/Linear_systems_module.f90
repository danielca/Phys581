module Linear_systems_module

    implicit none

    private

    integer, parameter :: dp = kind(1.0d0)

    public :: tridiagonal

contains

subroutine tridiagonal(a, b, c, d, x)
    ! Solves the tridiagonal matrix equation
    ! Size of a, b, c, d, and x should all be the same.
    ! This subroutine is too lazy to check your inputs for you.

    real(dp), dimension(:), intent(in)  :: a, b, c, d
    real(dp), dimension(:), intent(out) :: x
    real(dp), dimension(size(a)) :: cpr, dpr
    real(dp) :: factor
    integer :: num, i

    num = size(a)

    cpr(1) = c(1)/b(1)

    dpr(1) = d(1)/b(1)

    do i = 2, num-1
        factor = 1.0d0/(b(i) - a(i)*cpr(i-1))
        cpr(i) = c(i)*factor
        dpr(i) = (d(i) - a(i)*dpr(i-1))*factor
    end do
    dpr(num) = (d(num) - a(num)*dpr(num-1))/(b(num) - a(num)*cpr(num-1))

    x(num) = dpr(num)
    do i = num-1, 1, -1
        x(i) = dpr(i) - cpr(i)*x(i+1)
    end do

end subroutine

end module
