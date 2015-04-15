set terminal pdfcairo enhanced size 6, 8

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/shocktube.pdf"

set multiplot layout 3,1

set xrange [-60:60]
set nokey
set xlabel "x"

#Second Image
set yrange[-5000:105000]
set ylabel "Density"
set title "Density vs Position"
plot "./Data/tubular.txt" using 1:2 with lines ls 11

#first image
set yrange[-0.10:1.2]
set ylabel "Pressure"
set title "Pressure vs Position"
plot "./Data/tubular.txt" using 1:3 with lines ls 11


#third image
#set yrange[1e-5:3e-5]
set yrange[*:*]
set title "Energy vs Position"
set ylabel "Energy"
plot "./Data/tubular.txt" using 1:4 with lines ls 11

