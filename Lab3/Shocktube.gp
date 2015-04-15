set terminal png
set output "./Plots/shocktube.png"

set multiplot layout 3,1

set xrange [-60:60]
set nokey

#first image
set yrange[-0.10:1.2]
set title "Pressure vs Position"
plot "./Data/tubular.txt" using 1:3 with lines

#Second Image
set yrange[-5000:105000]
set title ""
plot "./Data/tubular.txt" using 1:2 with lines

#third image
set yrange[1e-5:3e-5]
plot "./Data/tubular.txt" using 1:4 with lines

