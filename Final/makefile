CC = gfortran
CFLAGS = -fcheck=all -O3

MOD_DIR = ../Modules/
NR_DIR = ../Numerical_recipes/
EXE_DIR = ./exe-dir/

VPATH = $(MOD_DIR) $(NR_DIR)

#Add <taget_name> to variables with its dependencies 
#as the string to be dereferenced.
#
#general form of recipe:
#<target_name>: $(<depencies_name>)
#	$(CC) $(CFLAGS) -o $@ $^
#
#Then add <target_name> to ALL variable

NO_TIME = No_Time.o
GOT_TIME = I_Got_Time.o
WAVE = wave_theorey.o Wave.o
CFL = cfl.o checkgrid.o datadump.o dataoutput.o eos.o findno.o fluxes.o ghosts.o intchk.o linpck.o maxmin.o momx1.o momx2.o newvg.o newx1.o newx2.o setgrid.o setobjects.o setup.o startrun.o strtoi.o studentsetup.o stv1.o stv2.o tranx1.o tranx2.o updatev.o vtos.o x1intfc.o x1intzc.o x2intfc.o x2intzc.o final581.o

ALL = No_Time.exe I_Got_Time.exe Wave.exe CFL.exe

%.o: %.f90
	$(CC) $(CFLAGS) -c $<

all: $(ALL)

No_Time.exe: $(NO_TIME)
	$(CC) $(CFLAGS) -o $(EXE_DIR)$@ $^

CLF.exe: $(CFL)
	$(CC) $(CFLAGS) -o $(EXE_DIR)$@ $^

I_Got_Time.exe: $(GOT_TIME)
	$(CC) $(CFLAGS) -o $(EXE_DIR)$@ $^

Wave.exe: $(WAVE)
	$(CC) $(CFLAGS) -o $(EXE_DIR)$@ $^

.PHONY:
clean:
	rm *.o *.mod

.PHONY:
scrub:
	rm *.o *.mod $(EXE_DIR)*.exe
