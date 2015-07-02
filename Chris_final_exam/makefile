CC = gfortran
CFLAGS = -O3

########## HOW TO ##########
# 1. Ensure that the folder containing .f90 files is part of VPATH
# 2. Add MY_FILE which lists My_file.f90 file and all its .f90 dependencies
# 3. Add MY_FILE_OBJ = $(pathsubst %.f90, $(OBJ_DIR)%.o, $(MY_FILE))
# 4. Add the rule
# 	my_file.exe: $(MY_FILE_OBJ)
# 		$(CC) $(CFLAG) -o $@ $^
# 5. Add my_file.exe to ALL
############################

OBJ_DIR = ./Objects/
MOD_DIR = ./Modules/
PHYS581_DIR = ./phys581-final-package/
EXE_DIR = $(PHYS581_DIR)exe-dir/

VPATH = .:$(MOD_DIR):$(PHYS581_DIR)

# .f90 file dependencies for each program
USEFUL = Useful_stuff_module.f90
POISSON = $(USEFUL) Poisson.f90
TIME_DEPENDENT = $(USEFUL) Time_dependent.f90
WAVE_EQUATION = $(USEFUL) Wave_equation.f90
# final581.exe is created using all .f90 files in ./phys581-final-package/
# This searches for those and adds them automatically
FINAL581 := $(shell find $(PHYS581_DIR) -name '*.f90')

# Replace .f90 files with .o files. 
# Also put them in the ./Objects/ directory to avoid clutter
POISSON_OBJ = $(patsubst %.f90, $(OBJ_DIR)%.o, $(POISSON))
TIME_DEPENDENT_OBJ = $(patsubst %.f90, $(OBJ_DIR)%.o, $(TIME_DEPENDENT))
WAVE_EQUATION_OBJ = $(patsubst %.f90, $(OBJ_DIR)%.o, $(WAVE_EQUATION))
FINAL581_OBJ = $(patsubst $(PHYS581_DIR)%.f90, $(OBJ_DIR)%.o, $(FINAL581))

ALL = Poisson.exe Time_dependent.exe Wave_equation.exe $(EXE_DIR)final581.exe

# General rule for compiling .f90 files into .o files 
# Again, .o files are stored in the ./Objects directory to avoid clutter
$(OBJ_DIR)%.o: %.f90
	$(CC) $(CFLAGS) -c $< -o $@

all: $(ALL)

Poisson.exe: $(POISSON_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

Time_dependent.exe: $(TIME_DEPENDENT_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

Wave_equation.exe: $(WAVE_EQUATION_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

$(EXE_DIR)final581.exe: $(FINAL581_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY:
clean:
	rm $(OBJ_DIR)*.o *.mod

.PHONY:
scrub:
	rm $(OBJ_DIR)*.o *.mod *.exe
