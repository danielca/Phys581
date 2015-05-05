module wave_theorey
implicit none

private

public::run

contains

subroutine run(x_min, x_max, dx, y_min, y_max, dy, t, c, fid)
    real, intent(in)::x_min, x_max, dx, t, y_min, y_max, dy, c
    integer, intent(in)::fid
    integer::i,j,x_range, y_range
    real::PI
    PI = 3.14159265359
    x_range = int((x_max - x_min)/dx)
    y_range = int((y_max - y_min)/dy)

    do i=1,x_range
        do j=1,y_range
            write(fid,*) real(j)*dx - x_max, real(i)*dy - y_max,func((real(i)*dx - x_max), (real(j)*dy-y_max),t, c , PI)
        end do
        write(fid,*) ""
    end do
end subroutine

real function func(x, y, t, c, pi)
    real, intent(in)::x, y, t, c, pi

    func = 2*sin(pi*x/4.)*sin(pi*y/4.)*cos(pi*c*t/sqrt(8.))
end function


end module
