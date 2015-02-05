program Metropolis
implicit none





contains 

real function prob_distribution(x)
real,intent(in)::x
real::PI,constant,hard_part
PI=3.14159265359
constant = 1/(2.0*sqrt(PI))
hard_part = (sin(5.0*x) + sin(2.0*x) + 2)*exp(-1.*(x**2))
prob_distribution = constant*hard_part
end function prob_distribution



end program
