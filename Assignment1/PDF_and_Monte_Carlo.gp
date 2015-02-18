reset
set terminal png enhanced 

set output "./Plots/Beta_fundamental_princ.png"
set title "Beta sequence using fundamnetal principle"
set yrange[0:1]
set xlabel "i"
set ylabel "X[i]"
unset key

plot "./Data/Beta_fundamental_princ.txt" with points pt 0

set output "./Plots/Beta_accept_reject.png"
set title "Beta sequence using accept/reject"
set yrange[0:1]
set xlabel "i"
set ylabel "X[i]"
unset key

plot "./Data/Beta_accept_reject.txt" with points pt 0

set terminal pdfcairo enhanced

set output "./Plots/Gauss_accept_reject.pdf"
set title "Gaussian sequence using accept/reject"
set yrange[0:0.5]
set xlabel "x"
set ylabel "PDF"
set key

plot \
    "./Data/Gauss_generation.txt" using 1:2 with boxes title "Pseudo random", \
    0.31915382432*exp(-((x - 5)**2)/(2*1.25*1.25)) with lines lc 3 title "Theoretical"

set output "./Plots/Gauss_central_limit.pdf"
set title "Gaussian sequence using central limit theorem"
set yrange[0:0.5]
set xrange[0:10]
set xlabel "x"
set ylabel "PDF"
set key

plot \
    "./Data/Gauss_generation.txt" using 3:4 with boxes title "Pseudo random", \
    0.31915382432*exp(-((x - 5)**2)/(2*1.25*1.25)) with lines lc 3 title "Theoretical"


reset
