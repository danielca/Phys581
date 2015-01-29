set terminal gif animate
set termoption dashed
set output "third.gif"

do for [i=1:251000:10]{

set pm3d map
set multiplot
set xrange [-50:50]
set yrange [-50:50]
#set title "Exp(-(x^2 + y^2))"
#set cbrange [0:1]
set size 1,1
set origin 0,0
#unset legend
unset colorbox
set isosamples 1000
set ytics
set xtics
unset key
splot (1-x)*(1-x) + 100*(y-x*x)*(y-x*x)
unset pm3d
#unset title
set size 0.76,0.695
set origin 0.125,0.175
set xrange [-50:50]
set yrange [-50:50]
unset ytics
unset xtics
unset key
#plot "data2.txt" using 1:2
plot "data3.txt" every ::i::i using 1:2
pause 1
unset multiplot
}
reset