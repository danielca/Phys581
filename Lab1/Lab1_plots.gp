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

reset
