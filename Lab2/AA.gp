set terminal pdfcairo
set output "./Plots/AA1.pdf"

set nokey

set multiplot layout 3,1 title "FFT Cos(ft)"
set title "Time Serries" 
set xrange [0:64]
set yrange [-1:1]
set ytics(-1,0,1)
plot "./Data/AA1.txt" using 1:2 with lines

set title "Magnitude of the FFT"
set xrange [-0.5:0.5]
set yrange [0:40]
set ytics 40/4
plot "./Data/AA1.txt" using 3:4 with lines

set title "Power in dB"
set xrange [-0.5:0.5]
set yrange [-120:40]
set ytics (-120, -60, 0, 40)
plot "./Data/AA1.txt" using 3:5 with lines

unset multiplot
unset out

#--------------Second Plot-----------------------
set output "./Plots/AA2.pdf"
set multiplot layout 3,1 title "FFT Cos(ft) with modified frequency"
set title "Time Serries" 
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
plot "./Data/AA2.txt" using 1:2 with lines

set title "Magnitude of the FFT"
set xrange [-0.5:0.5]
set yrange [0:40]
set ytics 40/4
plot "./Data/AA2.txt" using 3:4 with lines

set title "Power in dB"
set xrange [-0.5:0.5]
set yrange [-120:40]
set ytics (-120, -60, 0, 40)
plot "./Data/AA2.txt" using 3:5 with lines

unset multiplot
unset out

#-----------------Third Plot-----------------------
set output "./Plots/Window1.pdf"
set multiplot layout 2,3 title "Effects of Hanning Window"

set title "Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window1.txt" using 1:2 with lines

set title "Modified Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window1.txt" using 1:3 with lines

set title "Windowed Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window1.txt" using 1:4 with lines

set title " "
set xrange [-31:31]
set yrange [-125:32]
set ytics (-120, -90,-60, -30, 0, 30)
set xtics (-30, -15, 0, 15, 30)
set xtics (-30,-15,0,15,30)
plot "./Data/Window1.txt" using 5:6 with lines

set title "Power Measured in dB"
set xrange [-31:31]
set yrange [-15:30]
set ytics (-15, 0 , 15, 30)
set xtics (-30, -15, 0, 15, 30)
plot "./Data/Window1.txt" using 7:8 with lines

#set title "Power of Windowed Sine Wave in dB"
set title " "
set xrange [-31:31]
set yrange [-75:25]
set ytics (-75, -50, -25, 0, 15, 25)
set xtics (-30, -15, 0, 15, 30)
plot "./Data/Window1.txt" using 9:10 with lines

unset multiplot
unset out


#-----------------Fourth Plot-----------------------
set output "./Plots/Window2.pdf"
set multiplot layout 2,3 title "Effects of Blackman Window"

set title "Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window2.txt" using 1:2 with lines

set title "Modified Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window2.txt" using 1:3 with lines

set title "Windowed Sine Wave"
set xrange [0:64]
set yrange [-1:1]
set ytics (-1,0,1)
set xtics (0,20,40,60)
plot "./Data/Window2.txt" using 1:4 with lines

set title " "
set xrange [-31:31]
set yrange [-125:32]
set ytics (-120, -90,-60, -30, 0, 30)
set xtics (-30, -15, 0, 15, 30)
plot "./Data/Window2.txt" using 5:6 with lines

set title "Power Measured in dB"
set xrange [-31:31]
set yrange [-15:30]
set ytics (-15, 0 , 15, 30)
set xtics (-30, -15, 0, 15, 30)
plot "./Data/Window2.txt" using 7:8 with lines

#set title "Power of Windowed Sine Wave in dB"
set title " "
set xrange [-31:31]
set yrange [-35:25]
set ytics (-35, -15, 0, 15, 25)
set xtics (-30, -15, 0, 15, 30)
plot "./Data/Window2.txt" using 9:10 with lines

unset multiplot
unset out

reset
