program Radiative_transfer
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module

    implicit none

    type photon
        real(8) :: phi, theta
        real(8) :: x, y, z
        integer :: state, life_time
    end type

    real(8), parameter :: pi = 4.0d0*atan(1.0d0)
    integer, parameter :: ALIVE = 0
    integer, parameter :: ABSORBED = 1
    integer, parameter :: REFLECTED = 2
    integer, parameter :: TRANSMITTED = 3

    character(len=1024) :: filename

    call generate_histograms()

    write(filename, "(a34)") "./Data/Scattering_experiment_1.txt"
    call scattering_experiment( tau_max = 10.0d0,             &
                                z_max = 1.0d0,                &
                                prob_abs = -0.1d0,            &
                                num_photons = 1000000,        &
                                output_file = filename,       &
                                num_bins = 20 )

    write(filename, "(a34)") "./Data/Scattering_experiment_2.txt"
    call scattering_experiment( tau_max = 10.0d0,             &
                                z_max = 1.0d0,                &
                                prob_abs = 0.5d0,             &
                                num_photons = 100000000,      &
                                output_file = filename,       &
                                num_bins = 20 )

    write(filename, "(a35)") "./Data/Single_photon_experiment.txt"
    call single_photon_experiment( tau_max = 10.0d0,             &
                                   z_max = 1.0d0,                &
                                   prob_abs = -0.1d0,             &
                                   output_file = filename )


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
        random_mu = 1.0 - 2.0*uni_rand
    end function

    real(8) function random_theta()
        random_theta = acos(random_mu())
    end function

    real(8) function random_phi()
        real(8) :: uni_rand
        !uni_rand = lcm_random_number()
        call random_number(uni_rand)
        random_phi = 2.0*pi*uni_rand
    end function

    subroutine init_photons(photons)
        type (photon), dimension(:), intent(inout) :: photons
        real(8) :: mu
        integer :: i

        do i = 1, size(photons)
            mu = random_mu()
            do while (mu < 0.0)
                mu = random_mu()    ! Ensure mu is positive initially
            end do

            photons(i)%theta = acos(mu)
            photons(i)%phi = random_phi()
            photons(i)%x = 0.0
            photons(i)%y = 0.0
            photons(i)%z = 0.0
            photons(i)%state = ALIVE
            photons(i)%life_time = 1
        end do
    end subroutine

    integer function num_in_state(photons, state)
        type (photon), dimension(:), intent(in) :: photons
        integer, intent(in) :: state
        integer :: i

        num_in_state = 0
        do i = 1, size(photons)
            if (photons(i)%state == state) then
                num_in_state = num_in_state + 1
            end if
        end do
    end function

    subroutine step_forward(tau_max, z_max, prob_abs, photons)
        real(8), intent(in) :: tau_max, z_max, prob_abs
        type (photon), dimension(:), intent(inout) :: photons
        integer :: num_photons, i
        real(8) :: tau, dist, uni_rand

        num_photons = size(photons)

        do i = 1, num_photons
            if (photons(i)%state == ALIVE) then
                dist = random_tau()*z_max/tau_max
                photons(i)%x = photons(i)%x + dist*sin(photons(i)%theta)*cos(photons(i)%phi)
                photons(i)%y = photons(i)%y + dist*sin(photons(i)%theta)*sin(photons(i)%phi)
                photons(i)%z = photons(i)%z + dist*cos(photons(i)%theta)

                photons(i)%life_time = photons(i)%life_time + 1

                call random_number(uni_rand)
                if (photons(i)%z > z_max) then
                    photons(i)%state = TRANSMITTED
                else if (photons(i)%z < 0.0) then
                    photons(i)%state = REFLECTED
                else if (uni_rand < prob_abs) then
                    photons(i)%state = ABSORBED
                else
                    photons(i)%theta = random_theta()
                    photons(i)%phi = random_phi()
                end if
            end if
        end do

    end subroutine

    subroutine generate_histograms()
        real(8), dimension(1000000) :: tau, mu, phi, theta
        real(8), dimension(100) :: tau_bins, mu_bins, phi_bins, theta_bins
        integer, dimension(100) :: tau_hist, mu_hist, phi_hist, theta_hist
        real(8), dimension(100) :: tau_pdf, mu_pdf, phi_pdf, theta_pdf
        integer :: tau_id, mu_id, phi_id, theta_id
        integer :: num_exp, num_bins
        real(8) :: norm_factor
        integer :: i

        open(unit = new_file_unit(tau_id), file = "./Data/Tau_histogram.txt", action = 'write')
        open(unit = new_file_unit(mu_id), file = "./Data/Mu_histogram.txt", action = 'write')
        open(unit = new_file_unit(phi_id), file = "./Data/Phi_histogram.txt", action = 'write')
        open(unit = new_file_unit(theta_id), file = "./Data/Theta_histogram.txt", action = 'write')
        
        !call set_up_lcm_generator()
        call init_random_seed()

        ! Run histogram tests

        num_exp = size(tau)
        do i = 1, num_exp
            tau(i) = random_tau()
            mu(i) = random_mu()
            phi(i) = random_phi()
            theta(i) = acos(mu(i))
        end do

        call histogram(tau, tau_bins, tau_hist)
        call histogram(mu, mu_bins, mu_hist)
        call histogram(phi, phi_bins, phi_hist)
        call histogram(theta, theta_bins, theta_hist)

        ! Calculate probability distribution functions

        tau_pdf   =   tau_hist / (real(num_exp)*(  tau_bins(2) -   tau_bins(1)))
        mu_pdf    =    mu_hist / (real(num_exp)*(   mu_bins(2) -    mu_bins(1)))
        phi_pdf   =   phi_hist / (real(num_exp)*(  phi_bins(2) -   phi_bins(1)))
        theta_pdf = theta_hist / (real(num_exp)*(theta_bins(2) - theta_bins(1)))

        num_bins = size(tau_hist)
        do i = 1, num_bins
            write(tau_id, *) tau_bins(i), tau_pdf(i)
            write(mu_id, *) mu_bins(i), mu_pdf(i)
            write(phi_id, *) phi_bins(i), phi_pdf(i)
            write(theta_id, *) theta_bins(i), theta_pdf(i)
        end do

        close(tau_id)
        close(mu_id)
        close(phi_id)
        close(theta_id)

    end subroutine

    subroutine scattering_experiment(tau_max, z_max, prob_abs, num_photons, num_bins, output_file)
        real(8), intent(in) :: tau_max, z_max, prob_abs
        character(len = 1024), intent(in) :: output_file
        integer, intent(in) :: num_photons, num_bins
        type (photon), dimension(num_photons) :: photons
        real(8), dimension(num_bins) :: mu_bin_centres, theta_bin_centres, intensity, theor_intensity
        integer, dimension(num_bins) :: mu_hist
        real(8), dimension(:), allocatable :: transmitted_mus
        real(8) :: mu_spacing
        integer :: num_iter, max_num_iter, num_transmitted
        integer :: file_id, i, j

        open( unit = new_file_unit(file_id), file = output_file, action = 'write' )

        max_num_iter = 100000

        call init_photons(photons)

        num_iter = 0
        do while (num_in_state(photons, ALIVE) > 0)
            call step_forward(tau_max, z_max, prob_abs, photons)
            num_iter = num_iter + 1
            if (num_iter > max_num_iter) then
                write(*,*) "WARNING in scattering_experiment: too many iterations!"
                exit
            end if
        end do

        num_transmitted = num_in_state(photons, TRANSMITTED)
        allocate(transmitted_mus(num_transmitted))

        j = 1
        do i = 1, num_photons
            if (photons(i)%state == TRANSMITTED) then
                transmitted_mus(j) = cos(photons(i)%theta)
                j = j + 1
            end if
        end do

        mu_hist = 0.0
        mu_spacing = 1.0/num_bins
        do i = 1, num_bins
            mu_bin_centres(i) = (i - 0.5)*mu_spacing
            theta_bin_centres(i) = acos(mu_bin_centres(i))*180.0/3.14159265
            do j = 1, num_transmitted
                if (abs(transmitted_mus(j) - mu_bin_centres(i)) < 0.5*mu_spacing) then
                    mu_hist(i) = mu_hist(i) + 1
                end if
            end do
            intensity(i) = mu_hist(i)*num_bins/(2.0*num_transmitted*mu_bin_centres(i))
            theor_intensity(i) = 0.0244*(51.6 - 0.0043*(theta_bin_centres(i))**2)
            write(file_id,*) theta_bin_centres(i), mu_hist(i), intensity(i), theor_intensity(i)
        end do

        !call histogram(transmitted_mus, mu_bin_centres, mu_hist)


        !do i = 1, num_bins
        !    write(file_id,*) acos(mu_bin_centres(i)), mu_hist(i)
        !end do

        !do i = 1, num_photons
        !    write(file_id, *) photons(i)%x, photons(i)%y, photons(i)%z,     &
        !                      photons(i)%theta, photons(i)%phi,             &
        !                      photons(i)%state, photons(i)%life_time
        !end do

        write(*,*) "================================"
        write(*,*) "Scattering experiment:"
        write(*,*) ""
        write(*,*) "tau_max          = ", tau_max
        write(*,*) "z_max            = ", z_max
        write(*,*) "prob_abs         = ", prob_abs
        write(*,*) "num_photons      = ", num_photons
        write(*,*) "num_absorbed     = ", num_in_state(photons, ABSORBED)
        write(*,*) "num_transmitted  = ", num_in_state(photons, TRANSMITTED)
        write(*,*) "num_reflected    = ", num_in_state(photons, REFLECTED)
        write(*,*) "num_iterations   = ", num_iter
        write(*,*) ""
        write(*,*) "Output file    = ", trim(output_file)
        write(*,*) "================================"

        close(file_id)
        deallocate(transmitted_mus)

    end subroutine

    subroutine single_photon_experiment(tau_max, z_max, prob_abs, output_file)
        real(8), intent(in) :: tau_max, z_max, prob_abs
        character(len = 1024), intent(in) :: output_file
        type (photon), dimension(1) :: photons
        real(8), dimension(100000) :: x, y, z
        integer :: file_id, num_iter, max_num_iter, i

        open( unit = new_file_unit(file_id), file = output_file, action = 'write' )

        max_num_iter = 100000

        call init_photons(photons)
        do while (photons(1)%life_time < 100)

            call init_photons(photons)

            do while (num_in_state(photons, ALIVE) > 0)
                x(photons(1)%life_time) = photons(1)%x
                y(photons(1)%life_time) = photons(1)%y
                z(photons(1)%life_time) = photons(1)%z

                call step_forward(tau_max, z_max, prob_abs, photons)
                if (photons(1)%life_time > max_num_iter) then
                    write(*,*) "WARNING in scattering_experiment: too many iterations!"
                    exit
                end if

            end do

            x(photons(1)%life_time) = photons(1)%x
            y(photons(1)%life_time) = photons(1)%y
            z(photons(1)%life_time) = photons(1)%z

        end do

        do i = 1, photons(1)%life_time 
            write(file_id, *) x(i), y(i), z(i), i
        end do

        write(*,*) "================================"
        write(*,*) "Single photon experiment:"
        write(*,*) ""
        write(*,*) "tau_max        = ", tau_max
        write(*,*) "z_max          = ", z_max
        write(*,*) "prob_abs       = ", prob_abs
        write(*,*) ""
        write(*,*) "Output file    = ", trim(output_file)
        write(*,*) ""
        write(*,*) "Photon life    = ", photons(1)%life_time
        write(*,*) "Photon state   = ", photons(1)%state
        write(*,*) ""
        write(*,*) "================================"

        close(file_id)

    end subroutine

end program
