program tube
use nr
implicit none
real, dimension(5000)::x, density, energy, pressure, velocity
real::gam, left_density, right_density, left_pressure, right_pressure
real::xdistance, t, left_boundry, right_boundry, p4, z, c5, beta2, beta3
real::ea, alpha, u4, density_4, w, p3, u3, c_left ,c3, xsh, xcd, xft, xhd, dx
real::density_3, right_velocity, left_velocity
integer::i
    common/globals/left_pressure,right_pressure, right_density, left_density, gam

gam = 7./5.             !adobatic constant
left_density = 10**5     !initial left density
right_density = 1.25*10**4  !initial right density
left_pressure = 1    !initial left pressure
right_pressure = 0.1     !initial right pressure
right_velocity = 0.0
left_velocity = 0.0

xdistance = 0. !center point of the tube
t = 5000.      !Final Time

left_boundry = -60. !left boundry
right_boundry = 60. !right boundry


p4 = rtsec(shock,0.,1.,0.000001)

z = (p4/left_pressure-1.)
c5 = sqrt(gam * right_pressure/right_density)


beta2 = (gam-1.)/(2.*gam)
beta3 = (gam+1.)/(2.*gam)
ea = 0.5*(gam+1.)/gam
alpha = sqrt(1. + ea + z)
u4 = c5 * z/(gam*alpha)
density_4 = right_density*(1. + ea *z)/(1. + beta3 * z)

w = c5 * alpha !shock speed

p3 = p4
u3 = u4
density_3 = right_density * (p3/left_density)**(1./gam)

c_left = sqrt(gam*left_pressure/left_density)
c3 = sqrt(gam*p3/density_3)

xsh = xdistance + w * t
xft = xdistance + u3 * t
xhd = xdistance - c_left * t

dx = (right_boundry - left_boundry)/(size(x) -1)
do i=1, size(x)
    x(i) = left_boundry + dx *(i-1)
end do

do i=1, size(x)
    if (x(i) .lt. xhd) then 
        density(i) = right_density
        pressure(i) = left_density
        velocity(i) = c_left
        energy(i) = left_pressure/((gam-1.)*density(i))
    else if (x(i) .lt. xft) then
        velocity(i) = (2. / (gam + 1.))* (c_left + (x(i) - xdistance)/t)
        alpha = 1. - (0.5*(gam+1.)*velocity(i)/c_left)
        density(i) = right_density * alpha **(2./(gam - 1.))
        pressure(i) = left_pressure * alpha ** (2.*gam/(gam-1.))
        energy(i) = pressure(i)/((gam - 1.)*density(i))
    else if (x(i) .lt. xcd) then
        density(i) = density_3
        pressure(i) = p3
        velocity(i) = u3
        energy(i) = pressure(i)/((gam -1.)*density(i))
    else if (x(i) .lt. xsh) then 
        density(i) = density_4
        pressure(i) = p4
        velocity(i) = u4
        energy(i) = pressure(i)/((gam -1.)*density(i))
    else 
        density(i) = right_density
        pressure(i) = right_pressure
        velocity(i) = right_velocity
        energy(i) = pressure(i)/((gam - 1.)*density(i))
    end if
end do

open(unit=42, file = "./Data/tube_dat.txt", action = "write")
do i = 1, size(x)
    write(42,*) real(i)/50, x(i), pressure(i), density(i), energy(i), velocity(i)
end do
close(42)


contains



real function shock(p4)
    implicit none
    real,intent(in)::p4
    real::right_pressure, left_pressure, left_density, right_density, gam
    real::z, c1, c5, gam2, beta2, beta3, alpha
       common/globals/left_pressure,right_pressure, right_density, left_density, gam 

    z = (p4/right_pressure - 1.)
    c1 = sqrt(gam * left_pressure / left_density)
    c5 = sqrt(gam * right_pressure / right_density)
    gam2 = (gam-1.)/(gam+1.)
    beta2 = (gam-1.)/(2.*gam)
    beta3 = (gam + 1.)/(2.*gam)

    alpha = beta2 * (c5/c1)*z/sqrt(1. + beta3 * z)
    alpha = (1. - alpha)**(1/beta2)

    shock = left_pressure*alpha-p4

    
end function








end program
