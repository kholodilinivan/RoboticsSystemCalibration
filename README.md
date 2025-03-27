# RoboticsSystemCalibration

This repository explain the calibration and operation process of the Robotics System consisting of the Fisheye camera with the Laser emitter and the 6DOF Robot arm Parol 6 

If these files were useful, consider citation: 
`Kholodilin, I., Zhang, Z., Guo, Q. et al. Calibration of the omnidirectional vision system for robotics sorting system. Sci Rep 15, 10256 (2025). doi: 10.1038/s41598-025-94723-6.` 
* **Paper File** - [Link](https://www.researchgate.net/publication/390178127_Calibration_of_the_omnidirectional_vision_system_for_robotics_sorting_system)

<img width="990" alt="image" src="https://github.com/user-attachments/assets/a3015ff2-7769-4a3f-8400-25a8a42cd57a"> 

## How to open this project with Unity
The simulation environment was built with Unity 2020.3.15f2 (Game screen resolution 1280x720), for importing project to another Unity version consider [this import asset](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/unitypackage.unitypackage) 

Unity Project: UnityProject/Assets/Scenes/Main 

In order to make the laser work you need to change setting of the Unity project in the following way: File -> Build Settings -> Player Settings -> Player -> Other Settings -> Rendering -> Auto Graphics API for Windows (disable it) -> add OpenGLCore and move it up 

See videos below how to import project and change settings for the similar project: [Link](https://youtu.be/8Lbmiy_5Bqg ) 

## Project Motivation and Main Theory 
Text explanations in English - [Omnidirectional Vision System.pdf](https://github.com/kholodilinivan/CVSystem/files/10878212/Omnidirectional.Vision.System.pdf) \
Video explanations in English - https://youtu.be/eyiFRb6uCYg 

## Project PDF Tutorials
* **How To Use** - [How To Use.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/1_How_To_Use.pdf) \
Unity Project: UnityProject/Assets/Scenes/Main 
* **Intrinsic Calibration** - [Intrinsic Calibration.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/2_Intrinsic_Camera_Calibration.pdf) \
Unity Project: UnityProject/Assets/Scenes/Main \
Matlab Project: MatlabProject/0_Tutorial_Intrinsic_Calibration 

* **Extrinsic Calibrations** 
1. Chess Calibration (Method2) - [Chess Calibration.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/3_Extrinsic_System_Calibration_Chess.pdf) \
Unity Project: UnityProject/Assets/Scenes/Main \
Matlab Project: MatlabProject/4_Tutorial_Advance_Chess_Calibration_Method2/TutorialAdvanceChess 
2. 3 Sides Calibration (Method1) - [3 Sides Calibration.pdf](https://www.researchgate.net/publication/356899119_Calibration_and_three-dimensional_reconstruction_with_a_photorealistic_simulator_based_on_the_omnidirectional_vision_system) \
Unity Project: UnityProject/Assets/Scenes/Main \
Matlab Project: MatlabProject/4_Tutorial_Advance_3Sides_Calibration_Method1/TutorialAdvance3Sides 
3. 2 Sides Calibration (Proposed) - [2 Sides Calibration.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/3_Extrinsic_System_Calibration_Proposed.pdf) \
Unity Project: UnityProject/Assets/Scenes/Main \
Matlab Project: MatlabProject/4_Tutorial_Advance_2Sides_Calibration_Proposed/TutorialAdvance2Sides 
* **Robotics System Calibration** - [Paper File.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/Paper%20File.pdf) \
Unity Project: UnityProject/Assets/Scenes/Main \
Matlab Project: MatlabProject/5_Robot_scripts/RoboticsSortingSystem/RoboticsSortingSystem 

* **Robot Files** 
1. Kinematic Diagram - [Parol6_Kinematic_Diagram.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/I_Parol6_Kinematic_Diagram.pdf)
2. Forward Kinematics - [Forward Kinematics.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/II_Forward%20Kinematics.pdf)
3. Inverse Kinematics - [Inverse Kinematics.pdf](https://github.com/kholodilinivan/RoboticsSystemCalibration/blob/main/Documents/III_Inverse%20Kinematics.pdf)
