set terminal pdfcairo enhanced size 8, 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Euler.pdf"

set multiplot layout 3,1 title "Exact vs Forward Euler"

set xlabel "x"

unset title
set ylabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:3 with lines ls 12 title "Euler"

set ylabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:4 with lines ls 12 title "Euler"

set ylabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:5 with lines ls 12 title "Euler"


unset multiplot 
unset out 
#########_____________________________#######################

set output "./Plots/Lax.pdf"

set multiplot layout 3,1 title "Exact vs Lax Wendroff"

set ylabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:3 with lines ls 12 title "Lax Wendroff"

set ylabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:4 with lines ls 12 title "Lax Wendroff"

set ylabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:5 with lines ls 12 title "Lax Wendroff"


unset multiplot 
unset out


#########_____________________________#######################

set output "./Plots/Flux.pdf"

set multiplot layout 3,1 title "Exact vs Van Leer Flux Splitting"

set ylabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:3 with lines ls 12 title "Flux Splitting"

set ylabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:4 with lines ls 12 title "Flux Splitting"

set ylabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 11 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:5 with lines ls 12 title "Flux splitting"


unset multiplot 
unset out
