set terminal pdfcairo enhanced size 5, 8

set output "./Plots/Power_sine_wave.pdf"

set multiplot layout 3, 1

set title "Power spectrum of sine wave"
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
set xrange[-125:125]
set yrange[-200:0]
set key inside

plot \
    "./Data/Correlation.txt" index 0 using 1:2 with lines title "f = 60.000 Hz", \
    "./Data/Correlation.txt" index 1 using 1:2 with lines title "f = 59.673 Hz"



#set terminal pdfcairo enhanced size 5, 10

#set output "./Plots/Power_hann.pdf"

set title "Power spectrum of Hann-windowed sine wave"
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
set xrange[-125:125]
set yrange[-200:0]
set key inside

plot \
    "./Data/Correlation.txt" index 3 using 1:2 with lines title "f = 60.000 Hz", \
    "./Data/Correlation.txt" index 4 using 1:2 with lines title "f = 59.673 Hz"


#set output "./Plots/Power_blackhar.pdf"

set title "Power spectrum of Blackmann-Harris windowed sine wave"
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
set xrange[-125:125]
set yrange[-200:0]
set key inside

plot \
    "./Data/Correlation.txt" index 5 using 1:2 with lines title "f = 60.000 Hz", \
    "./Data/Correlation.txt" index 6 using 1:2 with lines title "f = 59.673 Hz"

unset multiplot

set terminal pdfcairo enhanced size 4, 4

set output "./Plots/Hann_window.pdf"

set multiplot layout 2, 1

set title "Hann window time domain"
set xlabel "Time (s)"
set ylabel "Hann window"
set xrange [0:1]
set yrange [0:1.5]
unset key

plot "./Data/Correlation.txt" index 2 using 1:2 with lines

set title "Hann window frequency domain"
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
set xrange [-125:125]
set yrange [-150:100]
unset key

plot "./Data/Correlation.txt" index 2 using 3:4 with lines

unset multiplot
reset
