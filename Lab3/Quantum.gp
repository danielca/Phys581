#set terminal png
set terminal pdfcairo enhanced size 8, 5

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Direct.pdf"

set multiplot layout 1, 2

set title "Quantum mechanics, direct method, alpha = 1"
set xlabel "x"
set xlabel "y"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
set palette color
unset key
set xrange[1:50]
set yrange[1:50]
set cbrange[0.95:1]
set zrange[0.9:1]

splot "./Data/Direct1.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out


set title "Quantum mechanics, direct method, alpha = 1000"
#set output "./Plots/Direct1000.pdf"

set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange [0:1]

splot "./Data/Direct100.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out
unset multiplot

set terminal pdfcairo enhanced size 8, 8

#Second set, same as the first (Who are we, henery the 8th?)

set output "./Plots/Weighted_Lax1_01.pdf"
set multiplot layout 3, 2
set title "Weight Jacobi w=0.01 alpha=1"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set zrange[0.9:1]
set cbrange[0.9:1]

splot "./Data/weight_lax_1_01.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1_25.png"
set title "Weight Jacobi w=0.25 alpha=1"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0.95:1]
set zrange [0.9:1]

splot "./Data/weight_lax_1_25.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1_50.png"
set title "Weight Jacobi w=0.5 alpha=1"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0.95:1]
set zrange [0.9:1]

splot "./Data/weight_lax_1_50.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1_75.png"
set title "Weight Jacobi w=0.75 alpha=1"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0.95:1]
set zrange [0.9:1]

splot "./Data/weight_lax_1_75.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1_90.png"
set title "Weight Jacobi w=0.9 alpha=1"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0.95:1]
set zrange [0.9:1]

splot "./Data/weight_lax_1_90.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out
unset multiplot

#Second set, same as the first (Who are we, henery the 8th?)

set output "./Plots/Weighted_Lax1000_01.pdf"
set multiplot layout 3, 2
set title "Weight Jacobi w=0.01 alpha=1000"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange[0:1]

splot "./Data/weight_lax_1000_01.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1000_25.png"
set title "Weight Jacobi w=0.25 alpha=1000"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange[0:1]

splot "./Data/weight_lax_1000_25.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1000_50.png"
set title "Weight Jacobi w=0.5 alpha=1000"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange[0:1]

splot "./Data/weight_lax_1000_50.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1000_75.png"
set title "Weight Jacobi w=0.75 alpha=1000"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange[0:1]

splot "./Data/weight_lax_1000_75.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

#set output "./Plots/Weighted_Lax1000_90.png"
set title "Weight Jacobi w=0.9 alpha=1000"
set surface
set samples 50,50
set isosamples 50,50
set ticslevel 0
set contour both
unset key
set palette color
set xrange[1:50]
set yrange[1:50]
set cbrange[0:1]
set zrange[0:1]

splot "./Data/weight_lax_1000_90.txt" using 1:2:3 with pm3d t "weaves"
unset pm3d
#unset out

reset
