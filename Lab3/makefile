CC = gfortran
CFLAGS = -fcheck=all -O3

MOD_DIR = ../Modules/
NR_DIR = ../Numerical_recipes/

VPATH = .:$(MOD_DIR):$(NR_DIR)

#Add <taget_name> to variables with its dependencies 
#as the string to be dereferenced.
#
#general form of recipe:
#<target_name>: $(<depencies_name>)
#	$(CC) $(CFLAGS) -o $@ $^
#
#Then add <target_name> to ALL variable

LAPLACE = Useful_stuff_module.o Laplace.o
ADVECTION = Linear_systems_module.o Advection.o
DIFFUSION = Useful_stuff_module.o Diffusion.o
AD_COMBINED = Useful_stuff_module.o AD_combined.o

ALL = Advection.exe Diffusion.exe Laplace.exe

%.o: %.f90
	$(CC) $(CFLAGS) -c $<

all: $(ALL)

Advection.exe: $(ADVECTION)
	$(CC) $(CFLAGS) -o $@ $^

Diffusion.exe: $(DIFFUSION)
	$(CC) $(CFLAGS) -o $@ $^

Laplace.exe: $(LAPLACE)
	$(CC) $(CFLAGS) -o $@ $^

AD_combined.exe: $(AD_COMBINED)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY:
clean:
	rm *.o *.mod

.PHONY:
scrub:
	rm *.o *.mod *.exe
