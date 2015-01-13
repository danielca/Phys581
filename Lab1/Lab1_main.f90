program lab1_main
    use random_numbers_module
    
    implicit none

    integer :: i
    
    call set_lcm_params(a_val = 27, c_val = 11, m_val = 54)
    call set_lcm_seed(seed_val = 2)
    
    do i = 1, 30
       write(*,*) lcm_random_number()
    end do
    
end program
