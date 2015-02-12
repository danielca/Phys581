program Pseudo_RNGs
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module
    
    implicit none
    integer(16), dimension(3) :: a, c, m, seed
    integer :: i, simple_test_file

    simple_test_file = new_file_unit()
    open( unit = simple_test_file, file = "./Data/Simple_LCM_test.txt", action = 'write' )

    call set_lcm_seed(seed_val = 3_16)
    call set_lcm_params(a_val = 7_16, c_val = 0_16, m_val = 10_16)

    do i = 1, 50
        write(simple_test_file,*) lcm_random_number()
    end do

    close(simple_test_file)
    
    a(1) = 106
    c(1) = 1283
    m(1) = 6075
    seed(1) = 1

    a(2) = 107
    c(2) = 1283
    m(2) = 6075 
    seed(2) = 1

    a(3) = 1103515245
    c(3) = 12345
    m(3) = 32768
    seed(3) = 1

    do i = 1, 3
        call lcm_test(a = a(i), c = c(i), m = m(i), seed = seed(i), test_num = i)
    end do
    
    call lcm_chi2_test(a = a(3), c = c(3), m = m(3), seed = seed(3))

    call auto_correlation_calc(a = a(3), c = c(3), m = m(3), seed = seed(3), num = 110)

contains

    subroutine lcm_test(a, c, m, seed, test_num)
        integer(16), intent(in) :: a, c, m, seed
        integer, intent(in) :: test_num
        character(len = 1024) :: filename
        integer :: lcm_file, i, j
        real :: last_num, new_num

        write(filename, "(a16,i1.1,a4)") "./Data/LCM_test_", test_num, ".txt"
        lcm_file = new_file_unit()
        open( unit = lcm_file , file = filename, action = 'write')

        call set_lcm_params(a_val = a, c_val = c, m_val = m)
        call set_lcm_seed(seed_val = seed)

        last_num = seed/real(m, kind = 8)
        do i = 1, 10000
            new_num = lcm_random_number()
            write(lcm_file, *) last_num, new_num
            last_num = new_num
        end do

        close(lcm_file)

    end subroutine

    subroutine lcm_chi2_test(a, c, m, seed)
        integer(16), intent(in) :: a, c, m, seed
        real(8), dimension(10) :: lcm_obs, lcm_exp
        real(8), dimension(10) :: gfort_obs, gfort_exp
        real(8) :: lcm_rand, gfort_rand 
        real(8) :: lcm_chi2, gfort_chi2, AC
        character(len = 1024) :: format_str
        integer :: chi2_file, AC_LCM_file, AC_gfort_file
        integer :: num_tests
        integer :: i, j

        chi2_file = new_file_unit()
        open(unit = chi2_file, file = "./Data/LCM_chi2_test.txt", action = 'write')

        call set_lcm_params(a_val = a, c_val = c, m_val = m)
        call set_lcm_seed(seed_val = seed)

        call init_random_seed()
        lcm_obs = 0.0
        gfort_obs = 0.0
        num_tests = 100
        do i = 1, num_tests
            lcm_rand = lcm_random_number()
            call random_number(gfort_rand)
            do j = 1, 10
                if ((lcm_rand >= (j-1)*0.1) .and. (lcm_rand < j*0.1)) then
                    lcm_obs(j) = lcm_obs(j) + 1.0
                end if
                if ((gfort_rand >= (j-1)*0.1) .and. (gfort_rand < j*0.1)) then
                    gfort_obs(j) = gfort_obs(j) + 1.0
                end if
            end do
        end do
        lcm_exp(:) = num_tests/10.0
        gfort_exp(:) = num_tests/10.0

        format_str = '(i2.1,a3,i2.1,a3,i2.1,a3)'
        do i = 1, 10
            write(chi2_file, format_str) nint(lcm_obs(i)), ' & ', nint(gfort_obs(i)), ' & ', nint(lcm_exp(i)), ' \\'
        end do


        lcm_chi2 = 0.0
        gfort_chi2 = 0.0
        do i = 1, 10
            lcm_chi2 = lcm_chi2 + ((lcm_obs(i) - lcm_exp(i))**2)/lcm_exp(i)
            gfort_chi2 = gfort_chi2 + ((gfort_obs(i) - gfort_exp(i))**2)/gfort_exp(i)
        end do

        write(*,*) "-----------"
        write(*,*) "LCM chi squared = ", lcm_chi2
        write(*,*) "Gfortran chi squared = ", gfort_chi2
        write(*,*) "-----------"

        close(chi2_file)

    end subroutine
    
    subroutine auto_correlation_calc(a, c, m, seed, num)
      integer(16), intent(in) :: a, c, m, seed
      integer, intent(in) :: num
      real(8), dimension(num):: gfortran_rand, lcm_rand
      integer :: i
      real(8) :: AC_LCM, AC_Gfort
      integer :: AC_LCM_file, AC_Gfort_file
      
      call set_lcm_params(a_val = a, c_val = c, m_val = m)
      call set_lcm_seed(seed_val = seed)

      do i = 1, num
         lcm_rand(i) = lcm_random_number()
         call random_number(gfortran_rand(i))
      end do

      AC_LCM_file = new_file_unit()
      open(unit = AC_LCM_file, file = "./Data/Auto_correlation_LCM_test.txt", action = 'write')

      AC_Gfort_file = new_file_unit()
      open(unit = AC_Gfort_file, file = "./Data/Auto_correlation_gfortran_test.txt", action = 'write')

      do i = 1, num
          call AutoCorrelation(lcm_rand, i, AC_LCM)
          write(AC_LCM_file,*) i, abs(AC_LCM), lcm_rand(i)

          call AutoCorrelation(gfortran_rand, i, AC_Gfort)
          write(AC_Gfort_file,*) i, abs(AC_Gfort), gfortran_rand(i)
      end do

      close(AC_LCM_file)
      close(AC_Gfort_file)
      
    end subroutine 
    
end program
