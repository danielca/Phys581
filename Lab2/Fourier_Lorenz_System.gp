set terminal png
set output "./Plots/FixedPoints.png"

set title "Fixed Points"
set xlabel "Input Radius"
set ylabel "X"
set nokey
set xrange [0:30]
set yrange [-20:20]
plot "./Data/FixedPoints.txt" using 1:2
unset out

#------------------------------ Second Plot ------------------------------

set output "./Plots/Astro.png"
set multiplot layout 2,1 title "Pulsar Star"
set nokey
set title "Time series of the pulsar"
set xrange[0:3551]
set yrange[0:7000]
plot "./Data/Astro.txt" using 1:2 with lines


set title "DFT of the Pulsar Star"
set xrange [-2:2]
set yrange [40:160]
plot "./Data/Astro.txt" using 3:4 with lines
unset multiplot
unset out


#------------------------------ Third Plot ------------------------------
set output "./Plots/Phase1.png"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=1.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase1.txt" using 1:2 with lines
set title "y(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase1.txt" using 1:3 with lines
set title "Phase x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:8]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase1.txt" using 2:3 with lines
unset multiplot
unset out

#------------------------------ Fourth Plot ------------------------------
set output "./Plots/Phase3.png"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=3.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase3.txt" using 1:2 with lines
set title "y(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase3.txt" using 1:3 with lines
set title "Phase x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:8]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase3.txt" using 2:3 with lines
unset multiplot
unset out

#------------------------------ Fifth Plot ------------------------------
set output "./Plots/Phase13.png"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=13.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase13.txt" using 1:2 with lines
set title "y(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase13.txt" using 1:3 with lines
set title "Phase x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:8]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase13.txt" using 2:3 with lines
unset multiplot
unset out

#------------------------------ Sixth Plot ------------------------------
set output "./Plots/Phase145.png"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=14.5"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase145.txt" using 1:2 with lines
set title "y(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase145.txt" using 1:3 with lines
set title "Phase x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:8]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase145.txt" using 2:3 with lines
unset multiplot
unset out

#------------------------------ Seventh Plot ------------------------------

set output "./Plots/Phase26.png"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=26.0"

set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase26.txt" using 1:2 with lines

set title "y(t)"
unset xlabel
unset ylabel
set xrange [0:100]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase26.txt" using 1:3 with lines

set title "Phase x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:8]
set yrange [0:8]
set ytics (0,4,8)
plot "./Data/LorenzPhase26.txt" using 2:3 with lines

unset multiplot
unset out


#------------------------------ Eigth Plot ------------------------------
set output "./Plots/Spectral.png"
set nokey
set pm3d map
set isosamples 100
set title "Spectral of the Lorenz System"
set xrange [0:30]
set yrange [0:50]
set ytics (0,10,20,30,40,50)
splot "./Data/LorenzSpec.txt" using 1:2:3 with pm3d

reset
