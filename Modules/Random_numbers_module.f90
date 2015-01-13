module random_numbers_module
    implicit none
    
    private
    
    integer :: lcm_seed, lcm_a, lcm_c, lcm_m
    
    public :: set_lcm_seed, set_lcm_params, lcm_random_number

contains

    subroutine set_lcm_seed(seed_val)
        integer, intent(in) :: seed_val
        lcm_seed = seed_val
    end subroutine

    subroutine set_lcm_params(a_val, c_val, m_val)
        integer, intent(in) :: a_val, c_val, m_val
        lcm_a = a_val
        lcm_c = c_val
        lcm_m = m_val
    end subroutine
    
    real(8) function lcm_random_number()
        lcm_seed = mod(lcm_a*lcm_seed + lcm_c, lcm_m)
        lcm_random_number = lcm_seed/real(lcm_m, kind = 8)
    end function
end module

