TARGET1=("radix" "fft" "lu_cb" "water_nsquared")
TARGET2=("volrend" "ocean_cp" "ocean_ncp" "cholesky")

#TARGET=("cholesky" "fft" "lu_cb" "ocean_cp" "ocean_ncp" "radix" "volrend")

#TARGET1=("radix" "volrend" "ocean_ncp" "water_nsquared" "water_nsquared" "cholesky")
#TARGET2=("radix" "radix" "ocean_cp" "fft" "water_nsquared" "radix")

#echo "${TARGET1[1]}"

if [ -z "$1" ]
then
	echo "simrun_rpr.sh: no arguments are given"
	exit
fi


for ((run_count=0; run_count<1; run_count++));
do

#mkdir ~/rpr_log/run${run_count}

for ((i=0; i<4; i++));
do
	time ./simrun_rl_l.sh ${TARGET1[$i]} $1 0 &
	time ./simrun_rl_l.sh ${TARGET2[$i]} $1 16 &
#	time ./simrun_rl_l.sh ${TARGET[$i]} $1 0 &
	wait
done
#mv ~/rpr_log/*.log ~/rpr_log/run${run_count}/

done
