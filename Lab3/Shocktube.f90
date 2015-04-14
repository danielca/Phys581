program tube
use nr
implicit none
real, dimension(5000)::x, density, energy, pressure, velocity
real::gam, left_density, right_density, left_pressure, right_pressure
real::xdistance, t, left_boundry, right_boundry, pressure4, z, c5, beta2, beta3
real::ea, alpha, velocity_4, density_4, w, pressure_3, velocity_3, c_left ,c3, xsh, xcd, xft, xhd, dx
real::denisty_3, right_velocity, left_velocity, pressure_4
integer::i
    common/globals/left_pressure,right_pressure, right_density, left_density, gam

gam = 7./5.             !adobatic constant
left_density = 10.**5     !initial left density
right_density = 1.25*10**4  !initial right density
left_pressure = 1.    !initial left pressure
right_pressure = 0.1     !initial right pressure
right_velocity = 0.0    !initial velocity
left_velocity = 0.0     !initial veloctiy

xdistance = 0. !center point of the tube
t = 5000.      !Final Time

left_boundry = -60. !left boundry
right_boundry = 60. !right boundry

!print*, gam, right_density,left_density,left_pressure,right_pressure


pressure_4 = rtsec(shock,0.,1.,0.000001)

!print*, pressure_4, shock(pressure_4)


z = (pressure_4/right_pressure-1.)
c5 = sqrt(gam * right_pressure/right_density)


beta2 = (gam+1.)/(2.*gam)
beta3 = (gam-1.)/(2.*gam)
ea = 0.5*(gam+1.)/gam
alpha = sqrt(1. + ea * z)


velocity_4 = c5 * z/(gam*alpha)
density_4 = right_density*(1. + ea *z)/(1. + beta3 * z)

w = c5 * alpha !shock speed

pressure_3 = pressure_4
velocity_3 = velocity_4
denisty_3 = left_density * (pressure_3/left_density)**(1./gam)
!rhol * (p3/pl)**(1./gamma)

print*, "Test", denisty_3, left_density, pressure_3, gam
c_left = sqrt(gam*left_pressure/left_density)
c3 = sqrt(gam*pressure_3/denisty_3)

xsh = xdistance + w * t
xft = xdistance + (velocity_3 - c3) * t
xhd = xdistance - c_left * t
xcd = xdistance + velocity_3 * t
!write(*,*) xhd, xft, xcd, xsh

dx = (right_boundry - left_boundry)/(size(x) -1)
do i=1, size(x)
    x(i) = left_boundry + dx *(i-1)
end do

do i=1, size(x)
    if (x(i) .lt. xhd) then 
        density(i) = left_density
        pressure(i) = left_pressure
        velocity(i) = c_left
        energy(i) = left_pressure/((gam-1.)*left_density)
    else if (x(i) .lt. xft) then
        velocity(i) = (2. / (gam + 1.))* (c_left + (x(i) - xdistance)/t)
        alpha = 1. - (0.5*(gam+1.)*velocity(i)/c_left)
        density(i) = left_density * alpha **(2./(gam - 1.))
        pressure(i) = left_pressure * alpha ** (2.*gam/(gam-1.))
        energy(i) = pressure(i)/((gam - 1.)*density(i))
    else if (x(i) .lt. xcd) then
        density(i) = denisty_3
        pressure(i) = pressure_3
        velocity(i) = velocity_3
        energy(i) =pressure(i)/((gam - 1.)*density(i)) 
    else if (x(i) .lt. xsh) then 
        density(i) = density_4
        pressure(i) = pressure_4
        velocity(i) = velocity_4
        energy(i) =pressure(i)/((gam - 1.)*density(i)) 
    else 
        density(i) = right_density
        pressure(i) = right_pressure
        velocity(i) = right_velocity
        energy(i) =pressure(i)/((gam - 1.)*density(i)) 
    end if
end do

open(unit=42, file = "./Data/tube_dat.txt", action = "write")
do i = 1, size(x)
    write(42,*) x(i), density(i), pressure(i), energy(i) 
end do
close(42)


contains



real function shock(p4)
    implicit none
    real,intent(in)::p4
    real::right_pressure, left_pressure, left_density, right_density, gam
    real::z, c1, c5, BigG, beeta, other, fact
       common/globals/left_pressure,right_pressure, right_density, left_density, gam 

    z = (p4 / right_pressure - 1.)
    c1 = sqrt(gam * left_pressure / left_density)
    c5 = sqrt(gam * right_pressure / right_density)

    BigG = (gam - 1.)/(gam + 1.)
    Beeta = (gam - 1.)/(2. * gam)
    other = (gam +1)/(2* gam)

    fact = Beeta * (c5 / c1) * z / sqrt (1. + other * z)
    fact = (1. - fact) ** (1/Beeta)

    shock = left_pressure * fact - p4

    
end function








end program

