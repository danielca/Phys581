set terminal pdfciaro
set output "./Plots/FixedPoints.pdf"

set title "Fixed Points"
set xlabel "Input Radius"
set ylabel "X"
set nokey
set xrange [0:30]
set yrange [-20:20]
plot "./Data/FixedPoints.txt" using 1:2
unset out

#------------------------------ Second Plot ------------------------------

set output "./Plots/Astro.pdf"
set multiplot layout 2,1 title "Pulsar Star"
set nokey
set xlabel ""
set ylabel ""
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
set output "./Plots/Phase1.pdf"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=1.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:5]
set yrange [0:5]
set ytics (0,5)
plot "./Data/LorenzPhase1.txt" using 1:2 with lines

set title "x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:5]
set yrange [0:5]
set ytics (0,5)
plot "./Data/LorenzPhase1.txt" using 2:3 with lines

set title "DFT of x(t)"
unset xlabel
unset ylabel
set xrange [-50:50]
set yrange [-150:100]
set ytics (-150,-25,100)
plot "./Data/LorenzPhase1.txt" using 4:5 with lines
unset multiplot
unset out

#------------------------------ Fourth Plot ------------------------------
set output "./Plots/Phase3.pdf"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=3.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [0:10]
set ytics (0,5,10)
plot "./Data/LorenzPhase3.txt" using 1:2 with lines

set title "x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [0:5]
set ytics (0,5)
plot "./Data/LorenzPhase3.txt" using 2:3 with lines

set title "DFT of x(t)"
unset xlabel
unset ylabel
set xrange [-50:50]
set yrange [-150:100]
set ytics (-150,-25,100)
plot "./Data/LorenzPhase3.txt" using 4:5 with lines
unset multiplot
unset out

#------------------------------ Fifth Plot ------------------------------
set output "./Plots/Phase13.pdf"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=13.0"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [0:10]
set ytics (0,5,10)
plot "./Data/LorenzPhase13.txt" using 1:2 with lines

set title "x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:10]
set yrange [0:10]
set ytics (0,5,10)
plot "./Data/LorenzPhase13.txt" using 2:3 with lines

set title "DFT of x(t)"
unset xlabel
unset ylabel
set xrange [-50:50]
set yrange [-150:100]
set ytics (-150,-25,100)
plot "./Data/LorenzPhase13.txt" using 4:5 with lines
unset multiplot
unset out


#------------------------------ Sixth Plot ------------------------------
set output "./Plots/Phase145.pdf"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=14.5"
set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [0:15]
set ytics (0,8,15)
plot "./Data/LorenzPhase145.txt" using 1:2 with lines

set title "x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [0:10]
set ytics (0,5,10)
plot "./Data/LorenzPhase145.txt" using 2:3 with lines

set title "DFT of x(t)"
unset xlabel
unset ylabel
set xrange [-50:50]
set yrange [-150:100]
set ytics (-150,-25,100)
plot "./Data/LorenzPhase145.txt" using 4:5 with lines
unset multiplot
unset out

#------------------------------ Seventh Plot ------------------------------

set output "./Plots/Phase26.pdf"
set multiplot layout 3,1 title "Phase Plot of the Lorenz System r=26.0"

set nokey
set title "x(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [-20:20]
set ytics (-20,0,20)
plot "./Data/LorenzPhase26.txt" using 1:2 with lines

set title "x(t) vs y(t)"
unset xlabel
unset ylabel
set xrange [0:20]
set yrange [-10:40]
set ytics (-10,15,40)
plot "./Data/LorenzPhase26.txt" using 2:3 with lines

set title "DFT of x(t)"
unset xlabel
unset ylabel
set xrange [-50:50]
set yrange [-150:100]
set ytics (-150,-25,100)
plot "./Data/LorenzPhase26.txt" using 4:5 with lines
unset multiplot
unset out

#------------------------------ Eigth Plot ------------------------------

set output "./Plots/Spectral.pdf"
set nokey
set pm3d map
set isosamples 100
set title "Spectral of the Lorenz System"
set xlabel "Radius"
set ylabel "Frequency"
set xrange [0:30]
set yrange [-20:20]
set cbrange [-150:80]
set ytics (-50,-40,-30,-20,-10,0,10,20,30,40,50)
set palette defined (0 0 0 0, 1 1 1 1 )
splot "./Data/LorenzSpec.txt" using 1:2:3 with points palette

reset
