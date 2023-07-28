source /opt/intel/openvino_2021/bin/setupvars.sh
cd Modules/object_detection_yolov5openvino
# python3 yolo_openvino.py -m weights/yolov5s.xml -i cam -at yolov5
# sudo python3 yolo_openvino.py -m weights/yolov5s.xml -i cam -at yolov5
# python3 yolo_openvino.py -m weights/best.xml -i /home/fast/Downloads/FIRE-SMOKE-DATASET/Test/Fire/image_0.jpg -at yolov5
# python3 yolo_openvino.py -m weights/yolov5s.xml -i /home/fast/Downloads/Prometheus/Modules/object_detection/dataset/stereo_images/left/1661.680000.jpg -at yolov5
# python3 yolo_openvino.py -m weights/best.xml -i /home/fast/Downloads/input.mp4 -at yolov5
# python3 yolo_openvino.py -m weights/yolov5s.xml -i /home/fast/Downloads/FIRE-SMOKE-DATASET/Test/Fire/image_0.jpg -at yolov5
python3 yolo_openvino.py -m weights/best.xml -i cam -at yolov5