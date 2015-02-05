program Metropolis
implicit none
integer::max_iterations, i, j
real(kind=8), dimension(3)::sigma
real(kind=8)::xn, x_star, temp
real(kind=8), allocatable,dimension(:,:)::x
!NOTE TO SELF: STANDARD DEVATION IS RETURNING 0

max_iterations = 10
allocate(x(3,max_iterations))
sigma(1) = 0.025
sigma(2) = 1.0
sigma(3) = 50.0
xn = -1.0

j=1 !temp assignment of j, will loop soon
do i=1,max_iterations
  temp = normal_dist(sigma(j),xn)
  !write(*,*) temp
  x_star = xn + temp !+ normal_dist(sigma(j),xn)
  !write(*,*) x_star, xn, i
  xn = select_new_point(x_star,xn)
  x(j,i) = xn
  
end do
   



contains 

real(kind=8) function prob_distribution(x)
 !The desired probability distribution
 real(kind=8),intent(in)::x
 real(kind=8)::PI,constant,hard_part, temp
 PI=3.14159265359
 constant = 1/(2.0*sqrt(PI))
 hard_part = (sin(5.0*x) + sin(2.0*x) + 2)*exp(-1.*(x**2))
 temp = constant * hard_part
 write(*,*) constant, hard_part, temp
 prob_distribution = temp
 return
end function prob_distribution

real(kind=8) function normal_dist(sigma,xn)
 !Normal distrubution to sample new trial points.
 !Centered around the current point xn with deviation sigma
 real(kind=8), intent(in)::sigma,xn
 real(kind=8)::constant, hard_part,PI
 PI=3.14159265359
 constant = 1./(sigma*sqrt(2.*PI))
 hard_part=exp((-(xn)**2)/(2.*(sigma**2)))
 normal_dist = constant*hard_part
end function normal_dist

real(kind=8) function select_new_point(x_star,xn)
 !This function determines if the new point is accepted or rejected
 !bassed on the acceptance probability. x_star is the new point, xn is the
 !current point
 real(kind=8), intent(in)::x_star,xn
 real(kind=8)::a, rand_number

 a = prob_distribution(x_star)/prob_distribution(xn)
 call random_number(rand_number)
 !write(*,*) a, rand_number, x_star, xn
 if (a .ge. 1) then
    select_new_point = x_star
 else if (a .lt. rand_number) then
    select_new_point = x_star
 else
    select_new_point = xn
 end if

end function select_new_point


end program
