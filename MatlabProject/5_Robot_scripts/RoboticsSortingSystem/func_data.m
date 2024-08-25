function func_data(ClientHandle, Q)
writeTCP(ClientHandle,sprintf("ModRobot:%f,%f,%f,%f,%f,%f",Q(1)*180/pi,(Q(2))*180/pi,90-(Q(3)*180/pi),Q(4)*180/pi,Q(5)*180/pi,Q(6)*180/pi));
pause(0.1);