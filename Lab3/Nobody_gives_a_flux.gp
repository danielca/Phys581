set terminal png

set output "./Plots/Euler.png"

set multiplot layout 3,1 title "Exact vs Forward Euler"

set xlabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:3 with lines ls 2 title "Euler"

set xlabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:4 with lines ls 2 title "Euler"

set xlabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 0 using 1:5 with lines ls 2 title "Euler"


unset multiplot 
unset out 
#########_____________________________#######################

set output "./Plots/Lax.png"

set multiplot layout 3,1 title "Exact vs Lax Wendroff"

set xlabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:3 with lines ls 2 title "Lax Wendroff"

set xlabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:4 with lines ls 2 title "Lax Wendroff"

set xlabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 1 using 1:5 with lines ls 2 title "Lax Wendroff"


unset multiplot 
unset out


#########_____________________________#######################

set output "./Plots/Flux.png"

set multiplot layout 3,1 title "Exact vs Van Leer Flux Splitting"

set xlabel "Density"
set xrange[-60:60]
set ytics(0,50000,100000)
set yrange [-100:101000]
plot "./Data/tubular.txt" using 1:2 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:3 with lines ls 2 title "Flux Splitting"

set xlabel "Pressure"
set xrange[-60:60]
set ytics (0,0.6,1.2)
set yrange [0:1.2]
plot "./Data/tubular.txt" using 1:3 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:4 with lines ls 2 title "Flux Splitting"

set xlabel "Energy"
set xrange[-60:60]
set ytics (0,1,2,3)
set yrange [0:3]
plot "./Data/tubular.txt" using 1:4 with lines ls 1 title "Exact", \
     "./Data/Nobody_likes_CFD.txt" index 2 using 1:5 with lines ls 2 title "Flux splitting"


unset multiplot 
unset out
