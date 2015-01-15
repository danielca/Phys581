module random_numbers_module
    implicit none
    
    private
    
    integer(16) :: lcm_seed, lcm_a, lcm_c, lcm_m
    
    public :: set_lcm_seed
    public :: set_lcm_params
    public :: lcm_random_number
    public :: AutoCorrelation

contains

    subroutine set_lcm_seed(seed_val)
        integer(16), intent(in) :: seed_val
        lcm_seed = seed_val
    end subroutine

    subroutine set_lcm_params(a_val, c_val, m_val)
        integer(16), intent(in) :: a_val, c_val, m_val
        lcm_a = a_val
        lcm_c = c_val
        lcm_m = m_val
    end subroutine
    
    real(8) function lcm_random_number()
        lcm_seed = mod(lcm_a*lcm_seed + lcm_c, lcm_m)
        lcm_random_number = lcm_seed/real(lcm_m, kind = 8)
    end function

    subroutine AutoCorrelation(x, k, AC)
      real(8),dimension(:),intent(in)::x
      integer,intent(in)::k
      real(8),intent(out)::AC
      real(8)::xbar, denom, numerator
      integer::i, limit
      
      denom = 0
      numerator = 0
      limit = size(x)-k

      xbar = sum(x)/size(x)
      
      do i=1,limit
         denom = denom + (x(i)-xbar)**2
      enddo

      do i=1,limit
         numerator = numerator + (x(i)-xbar)*(x(i+k)-xbar)
      enddo

      AC = numerator/denom

    end subroutine

end module

