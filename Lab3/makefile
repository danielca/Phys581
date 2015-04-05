CC = gfortran
CFLAGS = -fcheck=all -O3

MOD_DIR = ../Modules/

VPATH = .:$(MOD_DIR)

#Add <taget_name> to variables with its dependencies 
#as the string to be dereferenced.
#
#general form of recipe:
#<target_name>: $(<depencies_name>)
#	$(CC) $(CFLAGS) -o $@ $^
#
#Then add <target_name> to ALL variable

ADVECTION = Linear_systems_module.o Advection.o
DIFFUSION = Useful_stuff_module.o Diffusion.o

ALL = Advection Diffusion

%.o: %.f90
	$(CC) $(CFLAGS) -c $<

all: $(ALL)

Advection.exe: $(ADVECTION)
	$(CC) $(CFLAGS) -o $@ $^

Diffusion.exe: $(DIFFUSION)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY:
clean:
	rm *.o *.mod

.PHONY:
scrub:
	rm *.o *.mod *.exe
