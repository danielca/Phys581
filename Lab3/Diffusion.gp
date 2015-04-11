set terminal pdfcairo enhanced size 8, 4

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Diffusion.pdf"

set multiplot layout 1, 2

set xlabel "x"
set ylabel "t"
set xrange [0:1]
set yrange [0:0.0535]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Diffusion equation finite-difference solution"
splot "./Data/Diffusion.txt" index 0 using 1:2:3 palette title "stuff"

set title "Diffusion equation analytical solution"
splot "./Data/Diffusion.txt" index 0 using 1:2:4 palette title "stuff"

unset multiplot

#load 'set2.pal'
#load 'my_config.cfg'

set terminal pdfcairo enhanced size 8, 4

set output "./Plots/Diffusion2.pdf"

set multiplot layout 1, 2

set xlabel "x"
set ylabel "u"
set xrange [0:1]
set yrange [0:1]
set grid
unset key
unset pm3d

set pointsize 0.6

set title "Diffusion equation initial solution"
plot \
    "./Data/Diffusion.txt" index 1 using 1:3 lt 12 with lines title "Analytical", \
    "./Data/Diffusion.txt" index 1 using 1:2 lt 11 with points title "FD"

set key inside

set title "Diffusion equation final solution"
plot \
    "./Data/Diffusion.txt" index 1 using 1:5 lt 12 with lines title "Analytical", \
    "./Data/Diffusion.txt" index 1 using 1:4 lt 11 with points title "FD"

reset

