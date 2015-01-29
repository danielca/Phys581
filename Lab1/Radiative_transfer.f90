program Lab1_main
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module
    
    implicit none

    real(8), parameter :: pi = 4.0d0*atan(1.0d0)

    real(8), dimension(1000000) :: tau, mu, phi, theta
    real(8), dimension(100) :: tau_bins, mu_bins, phi_bins, theta_bins
    integer, dimension(100) :: tau_hist, mu_hist, phi_hist, theta_hist
    integer :: tau_id, mu_id, phi_id, theta_id
    integer :: i

    open(unit = new_file_unit(tau_id), file = "./Data/Tau_histogram.txt", action = 'write')
    open(unit = new_file_unit(mu_id), file = "./Data/Mu_histogram.txt", action = 'write')
    open(unit = new_file_unit(phi_id), file = "./Data/Phi_histogram.txt", action = 'write')
    open(unit = new_file_unit(theta_id), file = "./Data/Theta_histogram.txt", action = 'write')
    
    !call set_up_lcm_generator()
    call init_random_seed()

    ! Run histogram tests

    do i = 1, size(tau)
        tau(i) = random_tau()
        mu(i) = random_mu()
        phi(i) = random_phi()
        theta(i) = acos(mu(i))
    end do

    call histogram(tau, tau_bins, tau_hist)
    call histogram(mu, mu_bins, mu_hist)
    call histogram(phi, phi_bins, phi_hist)
    call histogram(theta, theta_bins, theta_hist)

    do i = 1, size(tau_hist)
        write(tau_id, *) tau_bins(i), tau_hist(i)
        write(mu_id, *) mu_bins(i), mu_hist(i)
        write(phi_id, *) phi_bins(i), phi_hist(i)
        write(theta_id, *) theta_bins(i), theta_hist(i)
    end do

    close(tau_id)
    close(mu_id)
    close(phi_id)
    close(theta_id)

contains

    subroutine set_up_lcm_generator()
        integer(16) :: a, c, m, seed

        a = 1103515245
        c = 12345
        m = 32768
        seed = 1

        call set_lcm_params(a_val = a, c_val = c, m_val = m)
        call set_lcm_seed(seed_val = seed)
    end subroutine

    real(8) function random_tau()
        real(8) :: uni_rand
        !uni_rand = lcm_random_number()
        call random_number(uni_rand)
        random_tau = -log(1.0-uni_rand)
    end function

    real(8) function random_mu()
        real(8) :: uni_rand
        !uni_rand = lcm_random_number()
        call random_number(uni_rand)
        random_mu = 1 - 2*uni_rand
    end function

    real(8) function random_phi()
        real(8) :: uni_rand
        !uni_rand = lcm_random_number()
        call random_number(uni_rand)
        random_phi = 2*pi*uni_rand
    end function

end program
