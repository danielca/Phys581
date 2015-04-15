program tube
	use nr
	implicit none
	real:: rhol,pl,ul,rhor,pr,ur,gamma,xdis,t,xr,xl,p4,z,c5,BigG 
	real:: fact,u4,rho4, w,p3,rho3,u3,Beta2,Beta3,cl,xsh,xcd,xft,xhd
	real:: c3,dx,p5,ea,c2
	integer:: i
	real,dimension(5000)::x,rho,u,p,enr
	common/ihatemylife/ pr,pl,rhol,rhor,gamma !this is so I can use NR.
	

	!This stupid thing solves the exact stupid tube thing with root finding and all that junk. These equations are
	!all available on Wikipedia, feel free to look at them. Alternatively, if you don't care, feel free to compile
	!this and toss it in your lab all willy-nilly and act like you did it. That's cool. I won't be hurt. 
	!also see http://cococubed.asu.edu/codes/riemann/exact_riemann.f for a similar F77 code if you care
	!this is essentially the same, because I was using it as guidance (cheesing). However I call nr and cut out 
	!a lot of the error checking because I'm a rule breaker. Also, besides "r" and "l", everything else
	!is indexed by region. 

	!IN THE STATE THIS IS IN, YOU CANNOT USE IT TO SOLVE DISCRETE REINMANN PROBLEMS!!!!

	!first we define the inital conditions of this stupid tube
	rhol = 10.**5 !density
	pl = 1.0   !pressure
	ul = 0.0       !velocit, note "l" is for "left", and then "r" is for what you would expect.

	rhor = 1.25 * 10.0**4
	pr = .10
	ur = 0.0

	!define gamma. Read the lab to find out what it is. I'm not telling you.

	gamma = 7./5.

	 !print*, gamma, rhor,rhol,pl,pr



	!Now we need a location of the discontinuity (pressure difference) at t ==0, so here's a nice location
	!as well as a time for the solution that we care about

	xdis = 0.
	t = 5000.

	!horizontal size of this stupid tube. I mean I love the tube. (I don't)

	xl = -60.
	xr = 60.

	!Now, we use good ol' secant to find our solution. Why? Because I can. That's why. (also something something fast convergence.)
	!but also, because I didn't want to calculate a derivative. (This is the real reason)

	!Note, this is why everything is single precision as well.
	
	p4 = rtsec(shocker,0.,1.,0.000001) !This is finicky. I don't reccomend changing where to look. Secant. You so silly.
	!print*,p4, shocker(p4)
	!Cool, so we have a new P. That's great. Good job team. Now what? Should we calculate other stuff too? Well
	!This wouldn't be Derek Zoolander's school for kids who can't read good and want to learn to do other stuff
	!Good too if we didn't!

	!So we'll compute post-shock junk now that we know P4! Hooray!

	z = (p4 / pr -1.)
	c5 = sqrt(gamma * pr/rhor) !medium velocity

	Beta3 = (gamma - 1)/(2. * gamma)  !Some factors, they make it nicer to look at 
	Beta2 = (gamma + 1)/(2. * gamma)
	ea = 0.5 * (gamma + 1.) / gamma
	
	fact = sqrt(1. + ea *z )
	u4 = c5 * z /(gamma * fact) !speed 4


	rho4 = rhor * ( 1. + ea * z)/(1. + Beta3 * z) 

	!shock speed 
	w = c5 * fact

	!now this stuff

	p3 = p4
	u3 = u4
	rho3 = rhol * (p3/pl)**(1./gamma)

	!But wait! There's more! Waves! lkasjdf;laksjdfa;lksdjfa;sdf
	!Note this assumes the conditions I've given above if pr>pl, this will do stuff, but the wrong stuff
        
        print*, "Test",rho3 ,rhol, p3, gamma

	cl = sqrt(gamma*pl/rhol)
	c3 = sqrt(gamma*p3/rho3)
	

	 xsh = xdis + w * t 
     xcd = xdis + u3  * t 
     xft = xdis + (u3 - c3) * t 
     xhd = xdis - cl * t 
     
     !print*, "TEST"
     !print*, xhd, xft, xcd, xsh
     !print*, xhd, xft,cl, xdis,t
     !Alright. So I bet you're like "Wow Alex! This has to be almost finished!"
     !Well honestly, you're entriely wrong. We have to do this crap again a bunch of times. It sucks
     !So here is a whole bunch o stuff that does that. Essentially the above acts as boundary conditions.

     dx = (xr - xl)/(size(x) - 1)
     do i = 1,size(x)
    	x(i) = xl + dx * (i - 1)
   
     end do
     !essentially though, this applies the formulae on Wikipedea or the other refferences to the appropriate location. NBD.
     
     do i = 1, size(x) !Just change it above if you want more points. 
     	if(x(i) .lt. xhd) then
     		rho(i) = rhol
     		p(i) = pl
     		u(i) = ul
     		enr(i) = pl/((gamma - 1.)* rhol)
     	elseif(x(i) .lt. xft) then 
     		u(i) = (2. / (gamma + 1.)) * (cl + (x(i) - xdis)/t)
     		fact = 1. - (0.5 * (gamma - 1.) * u(i) / cl)
     		rho(i) = rhol * fact ** (2./(gamma - 1.))
     		p(i) = pl * fact ** (2. * gamma/(gamma - 1))
     		enr(i) = p(i)/((gamma -1)* rho(i))
     	elseif(x(i) .lt. xcd) then
     		rho(i) = rho3
     		p(i) = p3
     		u(i) = u3
     		enr(i) = p(i)/((gamma - 1.)* rho(i))
     	elseif (x(i) .lt. xsh) then
     		rho(i) = rho4
     		p(i) = p4
     		u(i) = u4
     		enr(i) = p(i)/((gamma - 1.)*rho(i))
     	else
     		rho(i) = rhor
     		p(i) = pr
     		u(i) = ur
     		enr(i) = p(i)/((gamma - 1.)* rho(i))
     	end if
   end do

   open(12,file="./Data/tubular.txt",action = 'write')
   do i = 1, size(x)
   	write(12,*) x(i), rho(i), p(i), (enr(i)*rho(i)) + (rho(i)*u(i)**2)/2.
   end do


contains
	!this is the shock tube equation. IT is an equation. That has to do with tubes, that are shocked. No one reads this
	!I'm tired. If you read this please bring me coffee.

	real function shocker(p4)
      implicit none
      real,intent(in)::p4
      real:: pr,pl,rhol,rhor,gamma !everyting is indexed by location.
      real:: z,c1,c5,BigG,beeta,fact,other      !c is speed
 	 common/ihatemylife/ pr,pl,rhol,rhor,gamma
 	 

      z = (p4 / pr - 1.)
      c1 = sqrt(gamma * pl / rhol)
      c5 = sqrt(gamma * pr / rhor)

      BigG = (gamma - 1.)/(gamma + 1.)
      Beeta = (gamma - 1.)/(2. * gamma)
      other = (gamma +1)/(2* gamma)

      fact = Beeta * (c5 / c1) * z / sqrt (1. + other * z)
      fact = (1. - fact) ** (1/Beeta)

      shocker = pl * fact - p4

      
     end function


end program tube


