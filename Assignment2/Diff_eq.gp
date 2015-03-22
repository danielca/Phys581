set terminal pdfcairo enhanced

set output "./Plots/Diff_eq_solution.pdf"

set title "Heat equation solution"
set xlabel "x"
set ylabel "T(x)"
unset key

plot "./Data/Diff_eq.txt" index 0 using 1:2 with lines, "./Data/Diff_eq.txt" index 1 using 1:3 every 2 with points

set output "./Plots/Diff_eq_deriv.pdf"

set title "Error in the second derivative"
set xlabel "x"
set ylabel "Error (dB)"
unset key

plot "./Data/Diff_eq.txt" index 0 using 1:5 with lines

reset
