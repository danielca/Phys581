reset

set terminal pdfcairo enhanced size 4, 6

set output "./Plots/MH_hist.pdf"
set multiplot

set size 1.0, 0.33
set origin 0, 0.66
set title "Gaussian target distribution, Gaussian proposal distribution"
set xlabel "x"
set ylabel "PDF"

plot \
    "./Data/MH_hist_1.txt" with boxes title "Metropolis-Hastings", \
    exp(-((x-5)**2)/(2.0*1.0*1.0))/(1.0*sqrt(2.0*3.14159265)) lc 3 title "Actual"

set origin 0, 0.33
set title "Gaussian target distribution, Gaussian proposal distribution"
set xrange [-25:25]
set xlabel "x"
set ylabel "PDF"

plot \
    "./Data/MH_hist_2.txt" with boxes title "Metropolis-Hastings", \
    exp(-((x-0)**2)/(2.0*5.0*5.0))/(5.0*sqrt(2.0*3.14159265)) lc 3 title "Actual"

set origin 0,0
set title "Student's t target distribution, Gaussian proposal distribution"
set xrange [-25:25]
set xlabel "x"
set ylabel "PDF"

plot \
    "./Data/MH_hist_3.txt" with boxes title "Metropolis-Hastings", \
    ((1.0 + x**2/1.0)**(-(1.0+1.0)/2.0))*gamma(1)/(gamma(1)*sqrt(3.14159265)) lc 3 title "Actual"

unset multiplot

reset

set terminal pdfcairo enhanced size 5, 3

set output "./Plots/MH_mixing_normal.pdf"

set size 1, 1
set title "Complicated target distribution, Gaussian proposal distribution"
set xrange [0:500]
set xlabel "x"
set ylabel "Walk"
unset key
set label "3.4% acceptance rate" at 50, 90

plot "./Data/MH_mixing_normal.txt" with lines

set output "./Plots/MH_mixing_chi2.pdf"

set title "Complicated target distribution, chi^2 proposal distribution"
set xrange [0:500]
set xlabel "x"
set ylabel "Walk"
unset key
unset label
set label "82% acceptance rate" at 50, 500

plot "./Data/MH_mixing_chi2.txt" with lines

set output "./Plots/Student_t.pdf"

set title "Student's t distribution"
set xlabel "x"
set ylabel "PDF"
set xrange[-5:5]
set key
unset label

plot \
    gamma((1+1)/2.0)*((1+x*x/1.0)**(-(1+1)/2.0))/(gamma(1/2.0)*sqrt(1*3.14159265)) title "nu = 1", \
    gamma((2+1)/2.0)*((1+x*x/2.0)**(-(2+1)/2.0))/(gamma(2/2.0)*sqrt(2*3.14159265)) title "nu = 2", \
    gamma((5+1)/2.0)*((1+x*x/5.0)**(-(5+1)/2.0))/(gamma(5/2.0)*sqrt(5*3.14159265)) title "nu = 5", \
    gamma((100+1)/2.0)*((1+x*x/100.0)**(-(100+1)/2.0))/(gamma(100/2.0)*sqrt(100*3.14159265)) title "nu = 100", \
    exp(-x*x/2.0)/sqrt(2.0*3.14159265) title "Gaussian"

reset
