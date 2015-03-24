set terminal pdfcairo enhanced size 5, 11

set output "./Plots/cor_noiseless.pdf"
set multiplot layout 4,1 title "Noiseless Signal"

set title "Time series"
set nokey
set xrange [0:2048]
set yrange [0:15]
set xlabel "Time"
set ylabel "Signal"
set ytics (0,8,15)
plot "./Data/signal_noiseless.txt" using 1:2 with lines

set title "Power Spectrum"
set nokey
set xrange[-162:162]
set yrange [-115:80]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (-115, -17, 80)
plot "./Data/signal_noiseless.txt" using 3:4 with lines

set title "Auto Correlation Time Series"
unset key
set xrange [0:2048]
set yrange [-1.5:1.5]
set xlabel "Time"
set ylabel "Signal"
set ytics (-1.5, 0, 1.5)
plot "./Data/signal_noiseless.txt" using 1:6 with lines

set title "Auto Correlation Power Spectrum"
set nokey
set xrange [-162:162]
set yrange [-140:10]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (-140, -75, 10)
plot "./Data/signal_noiseless.txt" using 3:5 with lines

unset multiplot
unset out

#-----------------------------------------------------------------------------

set output "./Plots/cor_ac01.pdf"
set multiplot layout 4,1 title "Noisy Signal alpha 0.1"

set title "Time series"
set nokey
set xrange [0:2048]
set yrange [0:15]
set xlabel "Time"
set ylabel "Signal"
set ytics (0,8,15)
plot "./Data/signal_a01.txt" using 1:2 with lines

set title "Power Spectrum"
set nokey
set xrange[-162:162]
set yrange [-20:80]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (-20, 30, 80)
plot "./Data/signal_a01.txt" using 3:4 with lines

set title "Auto Correlation Time Series"
unset key
set xrange [0:2048]
set yrange [-1.5:1.5]
set xlabel "Time"
set ylabel "Signal"
set ytics (-1.5, 0, 1.5)
plot "./Data/signal_noiseless.txt" using 1:6 with lines

set title "Auto Correlation Power Spectrum"
set nokey
set xrange [-162:162]
set yrange [-80:40]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (-80, -30, 10)
plot "./Data/signal_a01.txt" using 3:5 with lines

unset multiplot
unset out

#-----------------------------------------------------------------------------

set output "./Plots/cor_a1.pdf"
set multiplot layout 4,1 title "Noisy signal Alpha 1"

set title "Time series"
set nokey
set xrange [0:2048]
set yrange [-5:15]
set xlabel "Time"
set ylabel "Signal"
set ytics (0,8,15)
plot "./Data/signal_a1.txt" using 1:2 with lines

set title "Power Spectrum"
set nokey
set xrange[-162:162]
set yrange [0:80]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (0, 40, 80)
plot "./Data/signal_a1.txt" using 3:4 with lines

set title "Auto Correlation Time Series"
unset key
set xrange [0:2048]
set yrange [-1.5:1.5]
set xlabel "Time"
set ylabel "Signal"
set ytics (-1.5, 0, 1.5)
plot "./Data/signal_noiseless.txt" using 1:6 with lines

set title "Auto Correlation Power Spectrum"
set nokey
set xrange [-162:162]
set yrange [-50:50]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (-50, 0, 50)
plot "./Data/signal_a1.txt" using 3:5 with lines

unset multiplot
unset out

#-----------------------------------------------------------------------------

set output "./Plots/cor_a10.pdf"
set multiplot layout 4,1 title "Noisey signal albpha 10"

set title "Time series"
set nokey
set xrange [0:2048]
set yrange [-15:15]
set xlabel "Time"
set ylabel "Signal"
set ytics (-15,0,15)
plot "./Data/signal_a10.txt" using 1:2 with lines

set title "Power Spectrum"
set nokey
set xrange[-162:162]
set yrange [20:80]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (20, 40, 80)
plot "./Data/signal_a10.txt" using 3:4 with lines

set title "Auto Correlation Time Series"
unset key
set xrange [0:2048]
set yrange [-1.5:1.5]
set xlabel "Time"
set ylabel "Signal"
set ytics (-1.5, 0, 1.5)
plot "./Data/signal_noiseless.txt" using 1:6 with lines

set title "Auto Correlation Power Spectrum"
set nokey
set xrange [-162:162]
set yrange [0:50]
set xlabel "Frequency"
set ylabel "Power (dB)"
set ytics (0, 25, 50)
plot "./Data/signal_a10.txt" using 3:5 with lines

unset multiplot
unset out

reset


