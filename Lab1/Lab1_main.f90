program Lab1_main
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module
    
    implicit none

    call lcm_test(a = 106, c = 1283, m = 6075, seed = 1, test_num = 1)
    call lcm_test(a = 107, c = 1283, m = 6075, seed = 1, test_num = 2)
    call lcm_test(a = 1103515245, c = 12345, m = 32768, seed = 1, test_num = 3)

    call lcm_chi2_test(a = 106, c = 1283, m = 6075, seed = 1)

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

    subroutine lcm_chi2_test(a, c, m, seed)
        integer, intent(in) :: a, c, m, seed
        real(8), dimension(2,10) :: lcm_table
        real(8), dimension(2,10) :: gfort_table
        real(8) :: lcm_rand, gfort_rand
        real(8) :: lcm_chi2, gfort_chi2
        character(len = 1024) :: format_str
        integer :: file_id, i, j
        integer :: num_tests

        open(unit = new_file_unit(file_id), file = "./Data/LCM_chi2_test.txt", action = 'write')

        call set_lcm_params(a_val = a, c_val = c, m_val = m)
        call set_lcm_seed(seed_val = seed)

        call init_random_seed()
        lcm_table = 0.0
        gfort_table = 0.0
        num_tests = 100
        do i = 1, num_tests
            lcm_rand = lcm_random_number()
            call random_number(gfort_rand)
            do j = 1, 10
                if ((lcm_rand >= (j-1)*0.1) .and. (lcm_rand < j*0.1)) then
                    lcm_table(1,j) = lcm_table(1,j) + 1.0
                end if
                if ((gfort_rand >= (j-1)*0.1) .and. (gfort_rand < j*0.1)) then
                    gfort_table(1,j) = gfort_table(1,j) + 1.0
                end if
            end do
        end do
        lcm_table(2,:) = num_tests/10.0
        gfort_table(2,:) = num_tests/10.0

        format_str = '(i2.1,a3,i2.1,a3,i2.1,a3)'
        do i = 1, 10
            write(file_id,format_str) nint(lcm_table(1,i)), ' & ', nint(gfort_table(1,i)), ' & ', nint(lcm_table(2,i)), ' \\'
        end do


        lcm_chi2 = 0.0
        gfort_chi2 = 0.0
        do i = 1, 10
            lcm_chi2 = lcm_chi2 + ((lcm_table(1,i) - lcm_table(2,i))**2)/lcm_table(2,i)
            gfort_chi2 = gfort_chi2 + ((gfort_table(1,i) - gfort_table(2,i))**2)/gfort_table(2,i)
        end do
        write(*,*) lcm_chi2, gfort_chi2

        !lcm_chi2 = calculate_chi2(real(lcm_table, kind = 8))
        !gfort_chi2 = calculate_chi2(real(gfort_table, kind = 8))

        !write(*,*) lcm_chi2, gfort_chi2

        close(file_id)
        
    end subroutine
    
end program
