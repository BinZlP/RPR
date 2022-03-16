if [ -z "$1" ]
then
	echo "simrun_rpr.sh: no arguments are given"
	exit
fi

mkdir ~/rpr_log/run_radix
for ((run_count=3; run_count<13; run_count++));
do
time ./simrun_rl_l.sh radix $1 0 &
wait
mv ~/rpr_log/radix*.log ~/rpr_log/run_radix/
done
