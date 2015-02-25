set terminal gif animate delay 3
set output "Traveling.gif"
do for [i=0:5] {
unset key
set xrange[0:10]
set yrange[0:10]
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
set style line 3 lc rgb '#FF0000' lt 1 lw 1
plot "Traveling_Salesman_Brute.txt" every::0::i using 1:2 with line ls 1, \
	 "Traveling_Salesman_SA.txt" every::0::i using 1:2 with line ls 2, \
	 "Traveling_Salesman_Brute.txt" using 1:2 with points
}
reset