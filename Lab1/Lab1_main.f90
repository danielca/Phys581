program Lab1_main
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module
    
    implicit none
    integer(16)::a1,c1,m1,seed1,testNum1
    integer(16)::a3,c3,m3,seed3,testNum3
    integer(16)::a2,c2,m2,seed2,testNum2
    
    a1 = 106
    c1 = 1283
    m1 = 6075
    seed1 = 1
    testNum1 = 1

    a2 = 107
    c2 = 1283
    m2 = 6075 
    seed2 = 2
    testNum2 = 2

    a3 = 1103515245
    c3 = 12345
    m3 = 32768
    seed3 = 1
    testNum3 = 3

    call lcm_test(a1, c1, m1, seed1,testNum1)
    call lcm_test(a2,c2,m2, seed1,testNum2)
    call lcm_test(a3, c3, m3, seed3,testNum3)
    
    call lcm_chi2_test(a3,c3,m3,seed3)

contains

    subroutine lcm_test(a, c, m, seed, test_num)
        integer(16), intent(in) :: a, c, m, seed, test_num
        character(len = 1024) :: filename
        integer :: file_id, i, j
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
        integer(16), intent(in) :: a, c, m, seed
        real(8), dimension(2,10) :: lcm_table
        real(8), dimension(2,10) :: gfort_table
        real(8), dimension(100) :: lcm_rand, gfort_rand 
        real(8) :: lcm_chi2, gfort_chi2, AC
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
            lcm_rand(i) = lcm_random_number()
            call random_number(gfort_rand(i))
            do j = 1, 10
                if ((lcm_rand(i) >= (j-1)*0.1) .and. (lcm_rand(i) < j*0.1)) then
                    lcm_table(1,j) = lcm_table(1,j) + 1.0
                end if
                if ((gfort_rand(i) >= (j-1)*0.1) .and. (gfort_rand(i) < j*0.1)) then
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

        !Calculate the Auto Correlation for k ranging from 1 to 100 for both our RNG and the gfortran RNG
        !Saves data to file for gnuplot
        open(unit = 42, file = "./Data/AutoCorrelationLCMTest.txt", action = 'write')
        do j = 0,100
           call AutoCorrelation(lcm_rand, j, AC)
           write(42,*) j, AC, lcm_rand(j)
        enddo
        close(42)

        open(unit = 43, file = "./Data/AutoCorrelationGfortranTest.txt", action = 'write')
        do j = 0,100
           call AutoCorrelation(gfort_rand, j, AC)
           write(42,*) j, AC, gfort_rand(j)
        enddo
        close(43)
        
    end subroutine
    
end program
