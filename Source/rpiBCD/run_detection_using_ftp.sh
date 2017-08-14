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

function get_model_file {
	SERVER="210.102.181.110"
	PORT="21"
	
	USER="pi"
	PASS="1234qwer"
	
	LOCAL_DIR="/home/pi/bcdRpi/result/model/"
	TARGET_FILE="model.pkl"
	
	# Move to downloading Dir in Rpi
	cd $LOCAL_DIR
	# Connect FTP and Start file downloading
	ftp -n $SERVER $PORT << End-Of-Session
	user $USER $PASS
	bin
	get $TARGET_FILE
	quit	

End-Of-Session
}

trap clean_up SIGHUP SIGINT SIGTERM

function recording(){
	echo "Start Recording..."
	arecord -D plughw:1,0 -d 9 -f S16_LE -c1 -r44100 -t wav /opt/baby_cry_rpi/recording/signal_9s.wav
}


function predict() {
	echo "Predicting..."
	echo -n "What is the prediction ?"
	python ~/bcdRpi/rpi_main/make_prediction.py
	PREDICTION=$(cat ~/bcdRpi/result/prediction.txt)
	echo "Prediction is $PREDICTION"
}

function start_playing() {
	if [[ $PLAYING == 0 ]]; then
		echo "start playing"
        #        aplay -D plughw:0,0 ../bcdRpi/lullaby_classic.wav
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

get_model_file

#recording
predict
if [[ $PREDICTION == 0 ]]; then
	stop_playing
else
	CPT=$(expr $CPT + 1)
	start_playing
fi
echo "State of the Process PREDICTION = $PREDICTION, PLAYING=$PLAYING, COMPTEUR=$CPT"

#
#while true; do
#	recording
#	predict
#	if [[ $PREDICTION == 0 ]]; then
#		stop_playing
#	else
#		CPT=$(expr $CPT + 1)
#		start_playing
#	fi
#echo "State of the Process PREDICTION = $PREDICTION, PLAYING=$PLAYING, COMPTEUR=$CPT"
#done
#

clean_up
