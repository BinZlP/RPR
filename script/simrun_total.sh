#TARGET=("cholesky" "fft" "lu_cb" "lu_ncb" "ocean_cp" "ocean_ncp" "radiosity" "radix" "raytrace" "volrend" "water_nsquared" "water_spatial")
TARGET=("ocean_cp" "ocean_ncp" "radiosity" "radix" "raytrace" "volrend" "water_nsquared" "water_spatial")

for wl in ${TARGET[*]};
do
	./simrun_rl.sh $wl
done
