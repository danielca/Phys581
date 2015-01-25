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

set output "./Plots/Tau_histogram.pdf"

set title "Tau histogram"
set xlabel "tau"
set ylabel ""
unset key

plot "./Data/Tau_histogram.txt" with boxes

set output "./Plots/Mu_histogram.pdf"

set title "Mu histogram"
set xlabel "mu"
set ylabel ""
set yrange[0:12000]
unset key

plot "./Data/Mu_histogram.txt" with boxes

set output "./Plots/Phi_histogram.pdf"

set title "Phi histogram"
set xlabel "phi"
set ylabel ""
set yrange[0:12000]
unset key

plot "./Data/Phi_histogram.txt" with boxes

reset
