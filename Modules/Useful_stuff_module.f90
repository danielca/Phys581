module Useful_stuff_module
    implicit none
    private

    public :: new_file_unit

contains
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
