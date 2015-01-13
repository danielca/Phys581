program lab1_main
    use random_numbers_module
    
    implicit none

    integer :: i 
    real::last_num, new_num
    open(unit = 42, file = "lcm_test.txt", action = "write")
    
    !First set of constants
    call set_lcm_params(a_val = 106, c_val = 1283, m_val = 6075)
    call set_lcm_seed(seed_val = 1)
    last_num = 1.0/6075
    do i = 1,10000
       new_num = lcm_random_number()
       write(42,*) last_num, new_num
       last_num = new_num
    end do

    write(42,*) ""
    write(42,*) ""

    !Second set of constatns
    call set_lcm_params(a_val=107, c_val=1283, m_val=6075)
    call set_lcm_seed(seed_val=1)
    last_num = 1.0/6075
    do i = 1, 10000
       new_num = lcm_random_number()
       write(42,*) last_num, new_num
       last_num = new_num
    end do

    write(42,*) ""
    write(42,*) ""

    !Yet another set of constants
    call set_lcm_params(a_val=1103515245, c_val=12345, m_val=32768)
    call set_lcm_seed(seed_val=1)
    last_num = 1.0/6075
    do i = 1, 10000
       new_num = lcm_random_number()
       write(42,*) last_num, new_num
       last_num = new_num
    end do
    
    close(42)
    
end program
