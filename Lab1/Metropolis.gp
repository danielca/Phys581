#set terminal x11
set terminal pdfcairo
set output "./Plots/Metropolis_sigma-0.025-1000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm sigma of 0.025 with 1000 iterations "

unset key
set xrange [-3:3]
set yrange [0:10]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-0.025_1000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-0.025_1000.txt" using 1:3 with lines

unset multiplot
unset out
reset

#second plot
set output "./Plots/Metropolis_sigma-1-1000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm sigma of 1 with 1000 iterations  "

unset key
set xrange [-3:3]
set yrange [0:10]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-1_1000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-1_1000.txt" using 1:3 with lines

unset multiplot
unset out
reset

#third plot
set output "./Plots/Metropolis_sigma-50-1000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorthm sigma of 50 with 1000 iterations "

unset key
set xrange [-3:3]
set yrange [0:10]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-50_1000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-50_1000.txt" using 1:3 with lines

unset multiplot
unset out
reset

#4th plot
set output "./Plots/Metropolis_sigma-0.025-50000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm sigma of 0.025 with 50000 iterations"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-0.025_50000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:50000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-0.025_50000.txt" using 1:3 with lines

unset multiplot
unset out
reset

#5th plot
set output "./Plots/Metropolis_sigma-1-50000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm sigma of 1 with 50000 iterations"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-1_50000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:50000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-1_50000.txt" using 1:3 with lines

unset multiplot
unset out
reset

#6th plot
set output "./Plots/Metropolis_sigma-50-50000.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm sigma of 50 with 50000 iterations"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_sigma-50_50000.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:50000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_sigma-50_50000.txt" using 1:3 with lines

unset multiplot
unset out
reset


#********************************************************************************************************************
#7 plot
set output "./Plots/Metropolis_burn1-1.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm No burn in, sample 1"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn1-1.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn1_1.txt" using 1:3 with lines

unset multiplot
unset out
reset

#8th plot
set output "./Plots/Metropolis_burn1-2.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm No burn in, sample 2"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn1-2.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn1_2.txt" using 1:3 with lines

unset multiplot
unset out
reset

#9th plot
set output "./Plots/Metropolis_burn1-3.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm No burn in, sample 3"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn1-3.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:1000]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn1_3.txt" using 1:3 with lines

unset multiplot
unset out
reset

#10th plot
set output "./Plots/Metropolis_burn2-1.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm Burn-in of 200 Points, sample 1"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn2-1.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:800]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn2_1.txt" using 1:3 with lines

unset multiplot
unset out
reset

#11 plot
set output "./Plots/Metropolis_burn2-2.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm Burn-in of 200 Points, sample 2"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn2-2.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:800]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn2_2.txt" using 1:3 with lines

unset multiplot
unset out
reset

#12th plot
set output "./Plots/Metropolis_burn2-3.pdf"

set multiplot layout 2,1 title "Metrpolois Hastings Algorithm Burn-in of 200 Points, sample 3"

unset key
set xrange [-3:3]
set yrange [0:20]
set ylabel " "
set style fill solid 2.0
set title "Probability distribution and histogram of selected the Markov chain"
plot (1/1.5449)*(sin(5*x)+sin(2*x)+2)*exp(-1*(x**2)), "./Data/hist_data_burn2-3.txt" using 1:2 linestyle 3 with steps

set xrange [-3:3]
set yrange [0:800]
set title "Markov Chain"
set ylabel "Number of iterations"
plot "./Data/Metropolis_Burn2_3.txt" using 1:3 with lines

unset multiplot
unset out
reset