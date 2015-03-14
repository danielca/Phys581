set terminal pdfcairo enhanced size 4, 4

set output "./Plots/White_noise_uniform.pdf"

set multiplot

set title "Uniform white noise autocorrelation"

set size 1.0, 0.5
set origin 0.0, 0.5
set xrange[-100:8192]
set xlabel "k"
set ylabel "AC[k]"
set logscale y
unset key

plot "./Data/White_noise.txt" index 0 with lines

set title "Uniform white noise spectral density"

set origin 0.0, 0.0
set xrange[-3.14:3.14]
set xlabel "ω"
set ylabel "S(ω) (dB)"
unset logscale y
plot "./Data/White_noise.txt" index 1 with lines

unset multiplot

set output "./Plots/White_noise_gaussian.pdf"

set multiplot

set title "Gaussian white noise autocorrelation"

set size 1.0, 0.5
set origin 0.0, 0.5
set xrange[-100:8192]
set xlabel "k"
set ylabel "AC[k]"
set logscale y
unset key

plot "./Data/White_noise.txt" index 2 with lines

set title "Gaussian white noise spectral density"

set origin 0.0, 0.0
set xrange[-3.14:3.14]
set xlabel "ω"
set ylabel "S(ω) (dB)"
unset logscale y
plot "./Data/White_noise.txt" index 3 with lines

unset multiplot

set output "./Plots/Noise_reduction.pdf"

set multiplot

set origin 0.0, 0.5
set title "Time domain signals"
set xrange[0:12]
set yrange[-2:4]
set xlabel "Time (ms)"
set ylabel ""
set key

plot \
    "./Data/Noise_reduction.txt" index 0 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Noise_reduction.txt" index 0 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Noise_reduction.txt" index 0 using 1:4 title "Cleaned" with lines lc 2

set origin 0.0, 0.0
set title "Frequency domain signals"
set xrange[-22.5:22.5]
set yrange[-50:80]
set xlabel "Frequency (kHz)"
set ylabel "Power (dB)"
plot \
    "./Data/Noise_reduction.txt" index 1 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Noise_reduction.txt" index 1 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Noise_reduction.txt" index 1 using 1:4 title "Cleaned" with lines lc 2

unset multiplot

set output "./Plots/Signal_with_trend.pdf"

set multiplot

set origin 0.0, 0.5
set title "Time domain signals"
set xrange[0:512]
set yrange[-10:40]
set xlabel "Time"
set ylabel ""

plot \
    "./Data/Signal_with_trend.txt" index 0 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Signal_with_trend.txt" index 0 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Signal_with_trend.txt" index 0 using 1:4 title "Cleaned" with lines lc 2

set origin 0.0, 0.0
set title "Frequency domain signals"
set xrange[-0.5:0.5]
set yrange[0:100]
set xlabel "Frequency"
set ylabel "Power (dB)"

plot \
    "./Data/Signal_with_trend.txt" index 1 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Signal_with_trend.txt" index 1 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Signal_with_trend.txt" index 1 using 1:5 title "Critical power" with lines lc 0

unset multiplot

set output "./Plots/Signal_with_trend2.pdf"

set multiplot

set origin 0.0, 0.5
set title "Time domain signals"
set xrange[0:512]
set yrange[-10:40]
set xlabel "Time"
set ylabel ""

plot \
    "./Data/Signal_with_trend.txt" index 2 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Signal_with_trend.txt" index 2 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Signal_with_trend.txt" index 2 using 1:4 title "Cleaned" with lines lc 2

set origin 0.0, 0.0
set title "Frequency domain signals (minus trend)"
set xrange[-0.5:0.5]
set yrange[0:100]
set xlabel "Frequency"
set ylabel "Power (dB)"

plot \
    "./Data/Signal_with_trend.txt" index 3 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Signal_with_trend.txt" index 3 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Signal_with_trend.txt" index 3 using 1:5 title "Critical power" with lines lc 0

unset multiplot

set terminal pdfcairo enhanced size 6, 4

set output "./Plots/Stocks.pdf"

set multiplot

set size 0.4, 0.5
set origin 0.0, 0.5
set title "Stock prices"
set xrange[1:64]
set yrange[0.1:10000]
set xlabel "Month"
set ylabel "Stock price"
unset key
set logscale y

plot \
    "./Data/Stocks_out.txt" index 0 using 1:2 with lines title "SANDP", \
    "./Data/Stocks_out.txt" index 0 using 1:3 with lines title "FORD", \
    "./Data/Stocks_out.txt" index 0 using 1:4 with lines title "GM", \
    "./Data/Stocks_out.txt" index 0 using 1:5 with lines title "MICROSOFT", \
    "./Data/Stocks_out.txt" index 0 using 1:6 with lines title "SUN", \
    "./Data/Stocks_out.txt" index 0 using 1:7 with lines title "USTB3M"

set size 0.6, 0.5
set origin 0.4, 0.5
set title "Compounded returns"
set xrange[1:64]
set yrange[-1:1]
set xlabel "Month"
set ylabel "R"
set key outside
unset logscale y

plot \
    "./Data/Stocks_out.txt" index 1 using 1:2 with lines title "SANDP", \
    "./Data/Stocks_out.txt" index 1 using 1:3 with lines title "FORD", \
    "./Data/Stocks_out.txt" index 1 using 1:4 with lines title "GM", \
    "./Data/Stocks_out.txt" index 1 using 1:5 with lines title "MICROSOFT", \
    "./Data/Stocks_out.txt" index 1 using 1:6 with lines title "SUN", \
    "./Data/Stocks_out.txt" index 1 using 1:7 with lines title "USTB3M"

set size 0.4, 0.5
set origin 0.0, 0.0
set title "Auto-correlation"
set xrange[1:64]
set yrange[0.001:2]
set xlabel "Month"
set ylabel "AC"
unset key
set logscale y

plot \
    "./Data/Stocks_out.txt" index 2 using 1:2 with lines title "SANDP", \
    "./Data/Stocks_out.txt" index 2 using 1:3 with lines title "FORD", \
    "./Data/Stocks_out.txt" index 2 using 1:4 with lines title "GM", \
    "./Data/Stocks_out.txt" index 2 using 1:5 with lines title "MICROSOFT", \
    "./Data/Stocks_out.txt" index 2 using 1:6 with lines title "SUN", \
    "./Data/Stocks_out.txt" index 2 using 1:7 with lines title "USTB3M"

set size 0.6, 0.5
set origin 0.4, 0.0
set title "Spectrum"
set xrange[-0.5:0.5]
set yrange[-25:35]
set xlabel "Frequency (1/month)"
set ylabel "S(k) (dB)"
set key outside
unset logscale y

plot \
    "./Data/Stocks_out.txt" index 3 using 1:2 with lines title "SANDP", \
    "./Data/Stocks_out.txt" index 3 using 1:3 with lines title "FORD", \
    "./Data/Stocks_out.txt" index 3 using 1:4 with lines title "GM", \
    "./Data/Stocks_out.txt" index 3 using 1:5 with lines title "MICROSOFT", \
    "./Data/Stocks_out.txt" index 3 using 1:6 with lines title "SUN", \
    "./Data/Stocks_out.txt" index 3 using 1:7 with lines title "USTB3M"


reset
