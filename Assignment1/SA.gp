set terminal png
set output "./Plots/SA1.png"

set multiplot layout 1,2
unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
plot "./Data/SA_Temp1.txt" using 1:2 with lines, (x**4) - (x**2) + (0.1*x)

unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
plot "./Data/SA_Hist_T1.txt" using 1:2 linestyle 3 with steps, (x**4) - (x**2) + (0.1*x)

unset multiplot
reset