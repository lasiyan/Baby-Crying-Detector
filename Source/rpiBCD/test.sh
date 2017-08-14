### Baby Crying Detector Shell Script ###

PREDICTION=1
PLAYING=0
CPT=0

function clean_up {
	# Perform program exit housekeeping
	echo ""
	echo "Good Bye."
	stop_playing
	exit
}

trap clean_up SIGHUP SIGINT SIGTERM

function predict() {
	echo "Predicting..."
	echo -n "What is the prediction ?"
	python rpi_main/make_prediction.py
	PREDICTION=$(cat result/prediction.txt)
	echo "Prediction is $PREDICTION"
}

function start_playing() {
	if [[ $PLAYING == 0 ]]; then
		echo "start playing"
		PLAYING=1
	fi
}

function stop_playing(){
	if [[ $PLAYING == 1 ]]; then
		echo "stop playing"
		PLAYING=0
	fi
}


echo "Start BabyCryingDetector 2.0.1"
echo ""

#recording
predict
if [[ $PREDICTION == 0 ]]; then
	stop_playing
else
	CPT=$(expr $CPT + 1)
	start_playing
fi
echo "State of the Process PREDICTION = $PREDICTION, PLAYING=$PLAYING, COMPTEUR=$CPT"

clean_up
