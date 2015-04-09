set terminal pdfcairo enhanced

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Diffusion.pdf"

set title "Diffusion equation solution"
set xlabel "x"
set ylabel "t"
set xrange [0:1]
set yrange [0:0.0535]
set colorbox border 101
set pm3d map
unset key
unset grid

splot "./Data/Diffusion.txt" using 1:2:3 palette title "stuff"

#plot 0.05*sin(x), 0.05*sin(2*x), 0.05*sin(3*x), 0.05*sin(4*x)

reset
