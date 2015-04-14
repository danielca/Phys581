set terminal png

set output "./Plots/Stock1.png"
set nokey
set multiplot layout 3,1
set xrange[2:20]
set yrange[0:15]
set ytics(0,5,10,15)

set title "Stock at t=100"
plot "./Data/stock_100.txt" using 1:2 with lines

set title "Stock at t=85"
set yrange [0:15]
plot "./Data/stock_85.txt" using 1:2 with lines

set title "Stock at t=75"
set yrange [0:15]
plot "./Data/stock_75.txt" using 1:2 with lines

unset multiplot
unset out

set output "./Plots/Stock2.png"
set multiplot layout 2,1
set nokey
set xrange [2:20]
set yrange [0:15]

set title "Stock at t=50"
plot "./Data/stock_50.txt" using 1:2 with lines

set title "Stock at t=0.0"
set yrange [0:15]
plot "./Data/stock_00.txt" using 1:2 with lines

