reset
set terminal pdfcairo

set output "./Plots/LCM_test_1.pdf"

set title "Linear congruential method test 1"
set xlabel "Last random number"
set ylabel "Current random number"
unset key

plot "./Data/LCM_test_1.txt" with points pt 0 lc 0

set output "./Plots/LCM_test_2.pdf"

set title "Linear congruential method test 2"
set xlabel "Last random number"
set ylabel "Current random number"
unset key

plot "./Data/LCM_test_2.txt" with points pt 0 lc 0

set output "./Plots/LCM_test_3.pdf"

set title "Linear congruential method test 3"
set xlabel "Last random number"
set ylabel "Current random number"
unset key

plot "./Data/LCM_test_3.txt" with points pt 0 lc 0

set output "./Plots/LCM_auto_correlation.pdf"

set multiplot layout 2,1 title "LCM Auto Correlation"

#First plot
set title "Random Numbers"
unset key
set origin 0,0
set size 1,0.4
set xrange[0:100]
set yrange[0:1.1]
plot "./Data/Auto_correlation_LCM_test.txt" using 1:3 with lines

set title "Auto Correlation"
unset key
set origin 0,0.5
set size 1,0.4
set xrange[0:100]
set yrange[0:1]
plot "./Data/Auto_correlation_LCM_test.txt" using 1:2 with lines

unset multiplot
#Second Plot
set output "./Plots/Gfortran_auto_correlation.pdf"

set multiplot layout 2,1 title "Gfortran Auto Correlation"
unset key

set title "Random Numbers"
unset key
set origin 0,0
set size 1,0.4
set xrange[0:100]
set yrange[0:1.1]
plot "./Data/Auto_correlation_gfortran_test.txt" using 1:3 with lines

set title "Auto Correlation"
unset key
set origin 0,0.5
set size 1,0.4
set xrange[0:100]
set yrange[0:1]
plot "./Data/Auto_correlation_gfortran_test.txt" using 1:2 with lines

unset multiplot
unset out

reset
