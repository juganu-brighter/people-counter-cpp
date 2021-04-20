#!/bin/bash
#export MQTT_SERVER=localhost:1884
export MQTT_SERVER=192.168.63.95:11883
export MQTT_CLIENT_ID=cvservice

sudo lsof -i:8090
cd /home/juganu/people-counter-cpp
sudo ls
sudo ffserver -f ./ffmpeg/server.conf&
sleep 10


source /opt/intel/openvino/bin/setupvars.sh
cd ieservice/bin/intel64/Release

./obj_recognition -i ../Pedestrain_Detect_2_1_1.mp4 -m /opt/intel/openvino/deployment_tools/tools/model_downloader/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml -d CPU -thresh 0.65 | ffmpeg -v warning -f rawvideo -pixel_format bgr24 -video_size 768x432 -i - http://localhost:8090/fac.ffm


