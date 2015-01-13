program Lab1_main
    use Useful_stuff_module
    use Random_numbers_module
    
    implicit none

    call lcm_test(a = 106, c = 1283, m = 6075, seed = 1, test_num = 1)
    call lcm_test(a = 107, c = 1283, m = 6075, seed = 1, test_num = 2)
    call lcm_test(a = 1103515245, c = 12345, m = 32768, seed = 1, test_num = 3)

contains

    subroutine lcm_test(a, c, m, seed, test_num)
        integer, intent(in) :: a, c, m, seed, test_num
        character(len = 1024) :: filename
        integer :: file_id, i
        real :: last_num, new_num

        write(filename, "(a16,i1.1,a4)") "./Data/LCM_test_", test_num, ".txt"
        open( unit = new_file_unit(file_id) , file = filename, action = 'write')

        call set_lcm_params(a_val = a, c_val = c, m_val = m)
        call set_lcm_seed(seed_val = seed)

        last_num = seed/real(m, kind = 8)
        do i = 1, 10000
            new_num = lcm_random_number()
            write(file_id, *) last_num, new_num
            last_num = new_num
        end do

        close(file_id)

    end subroutine
    
end program
