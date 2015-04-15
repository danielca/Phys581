program EconoPhys

implicit none

integer, parameter :: nx = 100

real(kind=8), dimension(nx, 100000)::V
real(kind=8), dimension(nx) :: S
real(kind=8)::dt, ds, t, sigma, r
integer::i,j,k, left, right
    common/global/dt,ds,sigma,r

t = 100.0d0
ds = 20.0/(nx - 1.0)
dt = 0.9*ds/20.0
sigma = 0.1d0
r = 0.05d0
left = 1
right = 20

!ASk about boundry conditions for something like this

call initial_conditions(V)

open(unit=42, file="./Data/stock_100.txt", action="write")
open(unit=43, file="./Data/stock_85.txt", action="write")
open(unit=44, file="./Data/stock_75.txt", action="write")
open(unit=45, file="./Data/stock_50.txt", action="write")
open(unit=46, file="./Data/stock_00.txt", action="write")

do i=2,100000
    !Each time step
    do j = 2,nx-1
        V(j,i) = point(V,i,j)
        if ((t.ge.100.0).and.(t-dt.lt.100.0)) then
            write(42,*) s(j), v(j,i-1)
        else if ((t.ge.85.0).and.(t-dt.lt.85.0)) then
            write(43,*) s(j), v(j,i-1)
        else if ((t.ge.75.0).and.(t-dt.lt.75.0)) then 
            write(44,*) s(j), v(j,i-1)
        else if ((t.ge.50.0).and.(t-dt.lt.50.0)) then
            write(45,*) s(j), V(j,i-1)
        else if ((t.ge.0.0).and.(t-dt.lt.0.0)) then
            write(46,*) s(j), V(j,i-1)
        end if
    end do
    
    V(1,i) = 0.0
    !V(21,i) = V(20,i) + ds
    V(nx, i) = 10.0
    t = t - dt

    if (t < 0.0) then
        exit
    end if
end do




contains

subroutine initial_conditions(V)
real(kind=8), dimension(:,:), intent(inout)::V
integer:: i

do i = 1,nx 
    S(i) = (i-1.0)*ds
end do

do i = 1, nx-1
    if (S(i).lt.10.0) then
        V(i,1) = 0.0d0
    else
        V(i,1) = s(i) - 10.0d0
    end if
end do
!do i=2,10000
!    V(1,i) = 0
!    V(21,i) = 20.0 - 10.0
!end do

end subroutine

real(kind=8) function point(V,n,j)
    real(kind=8), dimension(:,:), intent(in)::V
    integer, intent(in)::n,j
    real(kind=8)::alpha, beta, gam, fac1, fac2, fac3
    real(kind=8):: dt, ds, sigma, r
        common/global/dt,ds,sigma,r
    !alpha = r*dt
    !beta = dt*(sigma**2)/2.0d0
    !fac1 = V(j,n-1)
    !fac2 = V(j+1,n-1) -2*V(j,n-1)+V(j-1,n-1)
    !fac3 = V(j+1,n-1)-V(j-1,n-1)

    !point = fac1 + beta*fac2 + alpha*fac3

    point = V(j,n-1) + dt*0.5*sigma*sigma*(j-1)*(j-1)*(V(j+1,n-1) - 2.0*V(j,n-1) + V(j-1,n)) +&
            dt*0.5*r*(j-1)*(V(j+1,n-1) - V(j-1,n-1)) -&
            dt*r*V(j,n-1)
end function







end program
