set terminal pdfcairo enhanced size 4, 6

set output "./Plots/Aliasing200.pdf"

set multiplot layout 3, 1

set xrange[-100:100]
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
unset key

set title "1 second sample duration"
plot "./Data/Aliasing.txt" index 0 using 1:2 with lines
set title "10 second sample duration"
plot "./Data/Aliasing.txt" index 1 using 1:2 with lines
set title "100 second sample duration"
plot "./Data/Aliasing.txt" index 3 using 1:2 with lines

unset multiplot

set terminal pdfcairo enhanced size 4, 4

set output "./Plots/Aliasing100.pdf"

set multiplot layout 2, 1

set xrange[-50:50]
set xlabel "Frequency (Hz)"
set ylabel "Power (dB)"
unset key

set title "Without filtering"
plot "./Data/Aliasing.txt" index 2 using 1:2 with lines
set title "With filtering"
plot "./Data/Aliasing.txt" index 4 using 1:2 with lines

reset
