module Useful_stuff_module
    implicit none
    private

    public :: new_file_unit, calculate_chi2

contains

real(8) function calculate_chi2(obs_freq)
    real(8), dimension(:,:), intent(in) :: obs_freq
    real(8), dimension(:,:), allocatable :: exp_freq
    integer, dimension(2) :: dims
    integer :: n, m
    real(8), dimension(:,:), allocatable :: row_marg_tot
    real(8), dimension(:,:), allocatable :: col_marg_tot
    real(8) :: chi2
    real(8) :: grand_total
    integer :: i, j 

    dims = shape(obs_freq)
    n = dims(1)
    m = dims(2)
    allocate(exp_freq(n,m))
    allocate(row_marg_tot(n,1), col_marg_tot(1,m))

    do i = 1, n
        row_marg_tot(i,1) = 0.0
        do j = 1,m
            row_marg_tot(i,1) = row_marg_tot(i,1) + obs_freq(i,j)
        enddo
    enddo

    do i = 1, m
        col_marg_tot(1,i) = 0.0
        do j = 1,n
            col_marg_tot(1,i) = col_marg_tot(1,i) + obs_freq(j,i)
        enddo
    enddo

    grand_total = 0.0

    do i = 1, n
        do j = 1, m
            grand_total = grand_total + obs_freq(i,j)
        enddo
    enddo

    exp_freq = matmul(row_marg_tot, col_marg_tot)/grand_total

    chi2 = 0.0
    do i = 1, n
        do j = 1, m
            chi2 = chi2 + ((obs_freq(i,j) - exp_freq(i,j))**(2.0))/exp_freq(i,j)
        enddo
    enddo

    calculate_chi2 = chi2

end function

integer function new_file_unit(unit) result(n)
    integer, intent(out), optional :: unit
    logical inuse
    integer, parameter :: n_min = 10
    integer, parameter :: n_max = 999

    do n = n_min, n_max
        inquire(unit = n, opened = inuse)
        if (.not. inuse) then
            if (present(unit)) unit = n
            return
        end if
    end do
    write(*,*) "new_unit ERROR: available unit not found."
end function

end module
