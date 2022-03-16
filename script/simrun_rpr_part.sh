#TARGET1=("radix" "fft" "lu_cb" "water_nsquared")
#TARGET2=("volrend" "ocean_cp" "ocean_ncp" "cholesky")

#TARGET=("cholesky" "fft" "lu_cb" "ocean_cp" "ocean_ncp" "radix" "volrend")

#TARGET1=("radix" "volrend" "ocean_ncp" "water_nsquared" "water_nsquared" "cholesky")
#TARGET2=("radix" "radix" "ocean_cp" "fft" "water_nsquared" "radix")

#echo "${TARGET1[1]}"

<< '###'
if [ -z "$1" ]
then
	echo "simrun_rpr.sh: no arguments are given"
	exit
fi
###

for ((run_count=0; run_count<20; run_count++));
do

<< '###'
#mkdir ~/rpr_log/run${run_count}

for ((i=0; i<6; i++));
do
	time ./simrun_rl_l.sh ${TARGET1[$i]} $1 0 &
	time ./simrun_rl_l.sh ${TARGET2[$i]} $1 16 &
#	time ./simrun_rl_l.sh ${TARGET[$i]} $1 0 &
	wait
done
#mv ~/rpr_log/*.log ~/rpr_log/run${run_count}/
###

./simrun_rl_temp.sh fft alifo 0 &
./simrun_rl_temp.sh volrend alifo 1 &
./simrun_rl_temp.sh radix alifo 3 &
./simrun_rl_temp.sh water_nsquared alifo 7 &
./simrun_rl_temp.sh ocean_ncp alifo 13 &

./simrun_rl_temp.sh fft alifo 16 &
./simrun_rl_temp.sh volrend alifo 17 &
./simrun_rl_temp.sh radix alifo 19 &
./simrun_rl_temp.sh water_nsquared alifo 23 &
./simrun_rl_temp.sh ocean_ncp alifo 29 &
wait

done
