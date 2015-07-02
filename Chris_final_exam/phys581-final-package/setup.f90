

















!  =======================================================================
!  ////////////////////////  SUBROUTINE SETUP  \\\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine setup
!  
!    PURPOSE: Setups execution of a new run by initializing all variables
!    according to the flags and values in the input deck.  Calls studentsetup
!    a CPP macro) to initialize variables for the particular
!    problem to be studied, otherwise variables are set to "tiny"
!    (parameter defined to be smallest number possible on machine).
!  
!    EXTERNALS:
!       setgrid    -- initializes grid according to input deck
!       studentsetup -- macroname which is defined to be the user supplied
!                  subroutine name which initializes  variables for
!                  the problem to be studied
!       bval*   -- boundary value routines
!       cfl    -- computes initial timestep
!       checkgrid -- check grid
!       scopy
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      INCLUDE 'bndry.h'
      integer :: i,j,iiyes,ioyes
      real   ::  dtrat,dtmini2,v1zc,v2zc
!  
      external ::setgrid,bvald,bvalv1,bvalv2,scopy
      external:: cfl,studentsetup, checkgrid
      namelist /pcon/ nlim,tlim
      namelist /hycon/&
        qcon,qlin,courno,dtrat&
       ,iordd,iorde,iords1,iords2,iords3,iordb1,iordb2,iordb3,iorder&
       ,istpd,istpe,istps1,istps2,istps3,istpb1,istpb2,istpb3,istper&
       ,dfloor,efloor,v1floor,v2floor,v3floor,emffloor&
       ,b1floor,b2floor,b3floor,erfloor
      namelist /iib/ ii, niib, miib, liib, b3iib&
      ,  diim1,  eiim1, v1ii  , v2iim1, v3iim1, b3iim1, emfii&
      ,  diim2,  eiim2, v1iim1, v2iim2, v3iim2, b3iim2, emfiim1, emfiim2&
      , eriim1, eriim2
      namelist /oib/ io, noib, moib, loib, b3oib&
      ,  diop1,  eiop1, v1iop1, v2iop1, v3iop1, b3iop1, emfiop1&
      ,  diop2,  eiop2, v1iop2, v2iop2, v3iop2, b3iop2, emfiop2, emfiop3&
      , eriop1, eriop2
      namelist /ijb/     nijb, mijb, lijb, b3ijb&
      ,  djim1,  ejim1, v1jim1, v2ji  , v3jim1, b3jim1, emfji&
      ,  djim2,  ejim2, v1jim2, v2jim1, v3jim2, b3jim2, emfjim1, emfjim2&
      , erjim1, erjim2
      namelist /ojb/     nojb, mojb, lojb, b3ojb&
      ,  djop1,  ejop1, v1jop1, v2jop1, v3jop1, b3jop1, emfjop1&
      ,  djop2,  ejop2, v1jop2, v2jop2, v3jop2, b3jop2, emfjop2, emfjop3&
      , erjop1, erjop2
      namelist /gcon/ x1fac,x2fac,igcon
!  =======================================================================
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  
!  ------------------------  studentsetup CONTROL  ---------------------------
!  
!     nlim   = cycles to run
!     tlim   = physical (problem) time to stop calculation
!  
      nlim   = 1000000
      tlim   = 0.0
      nred   = 0
!  
      read (1,pcon)
      write(2,pcon)
!  
!  ------------------------  HYDRO CONTROL  ------------------------------
!  
!    qcon   = quadratic artificial viscosity (q) constant
!    qlin   = linear    artificial viscosity (q) constant
!    courno = courant number
!    dtrat  = ratio of initial dt to dtmin (used to compute dtmin below)
!    iord** = order of advection scheme to be used for variable **
!    iostp**= steepening flag for 3rd order advection.  When istp**=1,
!             use the discontinuity detection to steepen shocks during
!             interpolation for variable ** in X1INT,X1INTFC,X2INT,X2INTFC
!    **floor = smallest value desired for variable ** on grid
!  
      qcon   = 2.0
      qlin   = 0.0
      courno = 0.5
      dtrat  = 1.0e-3
      iordd  = 2
      iorde  = 2
      iords1 = 2
      iords2 = 2
      iords3 = 2
      iordb1 = 2
      iordb2 = 2
      iordb3 = 2
      iorder = 2
      istpd  = 0
      istpe  = 0
      istps1 = 0
      istps2 = 0
      istps3 = 0
      istpb1 = 0
      istpb2 = 0
      istpb3 = 0
      istper = 0
      dfloor = tiny
      v1floor = tiny
      v2floor = tiny
!  
      read (1,hycon)
      write(2,hycon)
!  
!  -------------------------  INITIALIZE GRID  ---------------------------
!    setgrid reads xgrid and ygrid 
!  
      call setgrid 
!  
!  ------------------------  BOUNDARY CONTROL ----------------------------
!  
!    The following points describe how boundaries are handled:
!  
!  *1)  We may specify any of 4 fluid boundary conditions independently at
!    every zone on the problem boundary.  The problem i boundaries may be
!    irregular to treat steps and cavities (resulting in irregular j
!    boundaries as well).
!       ii(j) is  i  index of first active zone for sweep  j
!       io(j) is  i  index of last  active zone for sweep  j
!       ji(i) is  j  index of first active zone for sweep  i # calculated
!       jo(i) is  j  index of last  active zone for sweep  i # from ii,io
!    The boundary type is specified by nflo, where
!       nflo = 1   reflecting
!            =-1   reflecting with inversion of 3-velocity
!            = 2   flow out 
!            = 3   flow in 
!            = 4   periodic
!     then,    niib(j) is nflo of inner i boundary on sweep j
!              noib(j) is nflo of outer i boundary on sweep j
!              nijb(i) is nflo of inner j boundary on sweep i
!              nojb(i) is nflo of outer j boundary on sweep i
!  
!  
!  *2) To be completely general, we allow the boundary flag for each
!    variable to be set independent of all others.  This can be done by
!    setting values for the flags in the namelists, eg:
!     diib,doib,dijb,dojb = flags on boundaries for d
!    If no values are input for each individual variable, then the flags
!    are initialized using the values for nflo above.
!  
!  *3) For flow in boundaries, boundary values of d,e,v1,v2,[v3],...
!    must be input, for example:
!        diim1(j) is inner i boundary density for sweep j at iim1(j)
!        diim2(j) is inner i boundary density for sweep j at iim2(j)
!        diop1(j) is outer i boundary density for sweep j
!        djim1(i) is inner j boundary density for sweep i
!        djop1(i) is outer j boundary density for sweep i
!  
!  *4) Since the corner zones [(ii-1,ji-1),(io+1,ji-1),etc] are set across
!    the ijb or ojb, then all i boundary values must be specified for
!    j=js,je and all j boundary values must be specified for i=is-2,ie+2
!  
      do 10 j=js,je
        ii  (j) = is
        io  (j) = ie
        niib(j) = 2
        noib(j) = 2
        miib(j) = 2
        moib(j) = 2
        liib(j) = 2
        loib(j) = 2
!  
        diim1(j) = dfloor
        diim2(j) = dfloor
        diop1(j) = dfloor
        diop2(j) = dfloor
        v1ii (j) = v1floor
        v1iim1(j) = v1floor
        v1iop1(j) = v1floor
        v1iop2(j) = v1floor
        v2iim1(j) = v2floor
        v2iim2(j) = v2floor
        v2iop1(j) = v2floor
        v2iop2(j) = v2floor
!  
10    continue
      do 20 i=is-2,ie+2
!    ji and  jo initialized to 0 since they are computed below
        ji  (i) = 0 
        jo  (i) = 0
        nijb(i) = 2
        nojb(i) = 2
        mijb(i) = 2
        mojb(i) = 2
        lijb(i) = 2
        lojb(i) = 2
!  
         b3ijb(i) = 0
         b3ojb(i) = 0
!  
        djim1(i) = dfloor
        djim2(i) = dfloor
        djop1(i) = dfloor
        djop2(i) = dfloor
        ejim1(i) = efloor
        ejim2(i) = efloor
        ejop1(i) = efloor
        ejop2(i) = efloor
        v1jim1(i) = v1floor
        v1jim2(i) = v1floor
        v1jop1(i) = v1floor
        v1jop2(i) = v1floor
        v2ji  (i) = v2floor
        v2jim1(i) = v2floor
        v2jop1(i) = v2floor
        v2jop2(i) = v2floor
!  
        v3jim1(i) = v3floor
        v3jim2(i) = v3floor
        v3jop1(i) = v3floor
        v3jop2(i) = v3floor
!  
       emfji  (i) =emffloor
       emfjim1(i) =emffloor
       emfjim2(i) =emffloor
       emfjop1(i) =emffloor
       emfjop2(i) =emffloor
       emfjop3(i) =emffloor
        b3jim1(i) = b3floor
        b3jim2(i) = b3floor
        b3jop1(i) = b3floor
        b3jop2(i) = b3floor
!  
        erjim1(i) = erfloor
        erjim2(i) = erfloor
        erjop1(i) = erfloor
        erjop2(i) = erfloor
20    continue
!  
!    set boundaries, order is iib, oib, ijb, ojb
!  
      read (1,iib)
      write(2,iib)
!  
      read (1,oib)
      write(2,oib)
!  
      read (1,ijb)
      write(2,ijb)
!  
      read (1,ojb)
      write(2,ojb)
!  
!    Load boundary flags from nflo and mflo if not set when reading
!    namelists (in which case the flags are zero)
!  
      do 30 j=js,je
        if ( b3iib(j) .eq. 0)  b3iib(j) = miib(j)
        if ( b3oib(j) .eq. 0)  b3oib(j) = moib(j)
30    continue
      do 40 i=is-2,ie+2
        if ( b3ijb(i) .eq. 0)  b3ijb(i) = mijb(i)
        if ( b3ojb(i) .eq. 0)  b3ojb(i) = mojb(i)
40    continue
!  
!    Reset grid indices based on input starting and ending indices.
!  
      ii(js-1) = ii(js)
      ii(js-2) = ii(js)
      ii(je+1) = ii(je)
      ii(je+2) = ii(je)
      io(js-1) = io(js)
      io(js-2) = io(js)
      io(je+1) = io(je)
      io(je+2) = io(je)
      do 50 j=js-2,je+2
        iim2(j) = ii(j) - 2
        iim1(j) = ii(j) - 1
        iip1(j) = ii(j) + 1
        iip2(j) = ii(j) + 2
        iom2(j) = io(j) - 2
        iom1(j) = io(j) - 1
        iop1(j) = io(j) + 1
        iop2(j) = io(j) + 2
        iop3(j) = io(j) + 3
50    continue
!  
!    Compute starting and ending j indices from starting and ending i
!    indices (since they are NOT independent).  Note corner values must be
!    included, i.e. values for i=is-2,ie+2 are needed.
!  
      iiyes = 0
      ioyes = 0
      do 70 j=js,je
        do 60 i=ii(j),io(j)
          if (ji(i) .eq. 0) ji(i) = j
60      continue
        if (ii(j) .eq. is) iiyes = 1
        if (io(j) .eq. ie) ioyes = 1
        if (iiyes .eq. 1 .and. ioyes .eq. 1) goto 71
70    continue
71    continue
!  
      iiyes = 0
      ioyes = 0
      do 90 j=je,js,-1
        do 80 i=ii(j),io(j)
          if (jo(i) .eq. 0) jo(i) = j
80      continue
        if (ii(j) .eq. is) iiyes = 1
        if (io(j) .eq. ie) ioyes = 1
        if (iiyes .eq. 1 .and. ioyes .eq. 1) goto 91
90    continue
91    continue
!  
      ji(is-1) = ji(is)
      ji(is-2) = ji(is)
      ji(ie+1) = ji(ie)
      ji(ie+2) = ji(ie)
      jo(is-1) = jo(is)
      jo(is-2) = jo(is)
      jo(ie+1) = jo(ie)
      jo(ie+2) = jo(ie)
!  
      do 100 i=is-2,ie+2
        jim2(i) = ji(i) - 2
        jim1(i) = ji(i) - 1
        jip1(i) = ji(i) + 1
        jip2(i) = ji(i) + 2
        jom2(i) = jo(i) - 2
        jom1(i) = jo(i) - 1
        jop1(i) = jo(i) + 1
        jop2(i) = jo(i) + 2
        jop3(i) = jo(i) + 3
100   continue
!    Compute maximum number of active zones in x1 [x2], and number of
!    active zones for each j [i] sweep
      nx1z = ie - is + 1
      nx2z = je - js + 1
      do 110 j=js,je
        nx1(j) = io(j) - ii(j) + 1
110   continue
      do 120 i=is-2,ie+2
        nx2(i) = jo(i) - ji(i) + 1
120   continue
!  
!  -------------------------  studentsetup GENERATOR  -------------------------
!  
!    studentsetup is a subroutine supplied by the 581 student where he/she 
!    intializes all variables for the particular problem to
!    be studied.  studentsetup should initialize all arrays for active zones
!    only (boundary values set in BVAL** routines).
!  
!    Begin by initializing all variables to default values.
!  
      do 160 j=js,je
        do 150 i=ii(j),io(j)
          d(i,j) = dfloor
150     continue
160   continue
      do 180 j=js,je
        do 170 i=iip1(j),io(j)
          v1(i,j) = v1floor
170     continue
180   continue
      do 200 i=is,ie
        do 190 j=jip1(i),jo(i)
          v2(i,j) = v2floor
190     continue
200   continue
      call studentsetup
!  
!    Set boundary zones
!  
      call bvald
      call bvalv1
      call bvalv2
!  
!    Set initial gravitational potential
!  
!  
!  -------------------------  GRID MOTION CONTROL  -----------------------
!  
!          igcon = 1 and x1fac < 0 gives "lagrangian" tracking in x1 lines
!          igcon = 1 and x2fac < 0 gives "lagrangian" tracking in x2 lines
!          igcon = 2 for input grid boundary speeds
!                  vg1(io) = x1fac * central soundspeed
!                  vg2(jo) = x2fac * central soundspeed
!          igcon = 3 for constant motion at x1[2]fac
!  
      x1fac = 0.0
      x2fac = 0.0
      igcon = 0
!  
      read (1,gcon)
      write(2,gcon)
      do 300 i=is-2,ie+2
        vg1(i) = 0.0
300   continue
      do 310 j=js-2,je+2
        vg2(j) = 0.0
310   continue
      
!  ----------------------Set gamma -------------------------
!  
      gamma=1.67
!  
!  
!  ----------------------  INITIAL TIMESTEP  -----------------------------
!    dtmin is initially an order of magnitude estimate of the initial
!    timestep.  NUDT is then called to refine that estimate.  This avoids
!    getting warnings from NUDT the first time it is called.  Note grid
!    must be assumed to be stationary initially (cannot compute grid v's)
!  
      if ((gamma-1.0) .eq. 0.0) then
        dtmini2 = ciso**2/(amin1(dx1a(is),g2b(is)*dx2a(ji(is))))**2
      else
        dtmini2 = e(is,ji(is))/&
                (d(is,ji(is))*(amin1(dx1a(is),g2b(is)*dx2a(ji(is))))**2)
      endif
      v1zc = 0.5*(v1(is,ji(is)) + v1(is+1,ji  (is)))
      v2zc = 0.5*(v2(is,ji(is)) + v2(is  ,jip1(is)))
      dtmini2 = dtmini2 + (v1zc         *dx1ai(is    ) )**2
      dtmini2 = dtmini2 + (v2zc/(g2b(is)*dx2a (ji(is))))**2
      dt    = courno/sqrt(dtmini2)
      dtmin = dtrat*dt
      call cfl 
      dtmin = dtrat*dt
!  
!    Reset initial timestep if checkgrid is necessary 
!  
      if (x1fac .ne. 0.0 .or. x2fac .ne. 0.0) dt = 5.0*dtmin
!  
!  -----------------------  CHECK GRID  -------------------------
!  
      call scopy(in, x1a ,1, x1an ,1)
      call scopy(in, x1b ,1, x1bn ,1)
      call scopy(in,dx1a ,1,dx1an ,1)
      call scopy(in,dx1b ,1,dx1bn ,1)
      call scopy(in, g2a ,1, g2ah ,1)
      call scopy(in, g2a ,1, g2an ,1)
      call scopy(in, g2b ,1, g2bh ,1)
      call scopy(in, g2b ,1, g2bn ,1)
      call scopy(in, g31a,1, g31ah,1)
      call scopy(in, g31a,1, g31an,1)
      call scopy(in, g31b,1, g31bh,1)
      call scopy(in, g31b,1, g31bn,1)
      call scopy(in,dvl1a,1,dvl1an,1)
      call scopy(in,dvl1b,1,dvl1bn,1)
!  
      call scopy(jn, x2a ,1, x2an ,1)
      call scopy(jn, x2b ,1, x2bn ,1)
      call scopy(jn,dx2a ,1,dx2an ,1)
      call scopy(jn,dx2b ,1,dx2bn ,1)
      call scopy(jn, g32a,1, g32ah,1)
      call scopy(jn, g32a,1, g32an,1)
      call scopy(jn, g32b,1, g32bh,1)
      call scopy(jn, g32b,1, g32bn,1)
      call scopy(jn, g4a,1, g4ah,1)
      call scopy(jn, g4a,1, g4an,1)
      call scopy(jn, g4b,1, g4bh,1)
      call scopy(jn, g4b,1, g4bn,1)
      call scopy(jn,dvl2a,1,dvl2ah,1)
      call scopy(jn,dvl2a,1,dvl2an,1)
      call scopy(jn,dvl2b,1,dvl2bh,1)
      call scopy(jn,dvl2b,1,dvl2bn,1)
!  
      call checkgrid
!  
!  ------------------------  Initialize everything else  -----------------
!  
      ix1x2 = 1
!  
      return
      end
