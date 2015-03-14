module ODE_system_module
    implicit none
    private

    real(8) :: r, sigma, b
    
    public :: ODE_system, set_r, set_sigma, set_b

    contains

    subroutine ODE_system(t, funcs, derivatives)
        real(8), intent(in) :: t
        real(8), dimension(:), intent(in) :: funcs
        real(8), dimension(:), intent(out) :: derivatives

        if ((size(funcs) /= 3) .or. (size(derivatives) /= 3)) then
            write(*,*) "ERROR in ODE_system:"
            write(*,*) "    Size of input arrays should be 3."
        end if

        derivatives(1) = sigma*(funcs(2) - funcs(1))
        derivatives(2) = r*funcs(1) - funcs(2) - funcs(1)*funcs(3)
        derivatives(3) = funcs(1)*funcs(2) - b*funcs(3)
    end subroutine

    subroutine set_r(r_in)
        real(8), intent(in) :: r_in
        r = r_in    
    end subroutine
    
    subroutine set_sigma(sigma_in)
        real(8), intent(in) :: sigma_in
        sigma = sigma_in    
    end subroutine

    subroutine set_b(b_in)
        real(8), intent(in) :: b_in
        b = b_in    
    end subroutine

end module
