reset
set terminal pdfcairo

set output "./Plots/LCMAutoCorrilation.pdf"

set multiplot layout 2,1 title "LCM Auto Corrilation"

#First plot
set title "Random Numbers"
unset key
set origin 0,0
set size 1,0.4
set xrange[0:100]
set yrange[0:1.1]
plot "./Data/AutoCorrelationLCMTest.txt" using 1:3 with lines

set title "Auto Correlation"
unset key
set origin 0,0.5
set size 1,0.4
set xrange[0:100]
set yrange[0:1]
plot "./Data/AutoCorrelationLCMTest.txt" using 1:2 with lines

unset multiplot
#Second Plot
set output "./Plots/GfortranAutoCorrilation.pdf"

set multiplot layout 2,1 title "Gfortran Auto Corrilation"
unset key

set title "Random Numbers"
unset key
set origin 0,0
set size 1,0.4
set xrange[0:100]
set yrange[0:1.1]
plot "./Data/AutoCorrelationGfortranTest.txt" using 1:3 with lines

set title "Auto Correlation"
unset key
set origin 0,0.5
set size 1,0.4
set xrange[0:100]
set yrange[0:1]
plot "./Data/AutoCorrelationGfortranTest.txt" using 1:2 with lines

unset multiplot
unset out
reset