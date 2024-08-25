using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Globalization;

public class CanvasChanges : MonoBehaviour
{
    // Cubes Config
    public GameObject RedCube, GreenCube, BlueCube;
    public InputField redcube_pos_x, redcube_pos_y, redcube_pos_z, redcube_rot_x, redcube_rot_y, redcube_rot_z,
    greencube_pos_x, greencube_pos_y, greencube_pos_z, greencube_rot_x, greencube_rot_y, greencube_rot_z,
    bluecube_pos_x, bluecube_pos_y, bluecube_pos_z, bluecube_rot_x, bluecube_rot_y, bluecube_rot_z;
    
    public InputField redcube_pos_x_cam, redcube_pos_y_cam, redcube_pos_z_cam, redcube_rot_x_cam, redcube_rot_y_cam, redcube_rot_z_cam,
    greencube_pos_x_cam, greencube_pos_y_cam, greencube_pos_z_cam, greencube_rot_x_cam, greencube_rot_y_cam, greencube_rot_z_cam,
    bluecube_pos_x_cam, bluecube_pos_y_cam, bluecube_pos_z_cam, bluecube_rot_x_cam, bluecube_rot_y_cam, bluecube_rot_z_cam;

    public GameObject RedArea, GreenArea, BlueArea;
    public InputField redcube_pos_x_area, redcube_pos_y_area, redcube_pos_z_area,
    greencube_pos_x_area, greencube_pos_y_area, greencube_pos_z_area,
    bluecube_pos_x_area, bluecube_pos_y_area, bluecube_pos_z_area;

    public GameObject ChessObj;
    public InputField chess_pos_x_robot, chess_pos_y_robot, chess_pos_z_robot,
    chess_pos_x_cam, chess_pos_y_cam, chess_pos_z_cam;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        // Robot Origin
        // Red Cube
        redcube_pos_x.text = (RedCube.transform.localPosition.y).ToString();
        redcube_pos_y.text = (-RedCube.transform.localPosition.z).ToString();
        redcube_pos_z.text = (-RedCube.transform.localPosition.x).ToString();
        redcube_rot_x.text = (RedCube.transform.localEulerAngles.x).ToString();
        redcube_rot_y.text = (RedCube.transform.localEulerAngles.z).ToString();
        redcube_rot_z.text = (RedCube.transform.localEulerAngles.y).ToString();

        // Green Cube
        greencube_pos_x.text = (GreenCube.transform.localPosition.y).ToString();
        greencube_pos_y.text = (-GreenCube.transform.localPosition.z).ToString();
        greencube_pos_z.text = (-GreenCube.transform.localPosition.x).ToString();
        greencube_rot_x.text = (GreenCube.transform.localEulerAngles.x).ToString();
        greencube_rot_y.text = (GreenCube.transform.localEulerAngles.z).ToString();
        greencube_rot_z.text = (GreenCube.transform.localEulerAngles.y).ToString();

        // Blue Cube
        bluecube_pos_x.text = (BlueCube.transform.localPosition.y).ToString();
        bluecube_pos_y.text = (-BlueCube.transform.localPosition.z).ToString();
        bluecube_pos_z.text = (-BlueCube.transform.localPosition.x).ToString();
        bluecube_rot_x.text = (BlueCube.transform.localEulerAngles.x).ToString();
        bluecube_rot_y.text = (BlueCube.transform.localEulerAngles.z).ToString();
        bluecube_rot_z.text = (BlueCube.transform.localEulerAngles.y).ToString();

        // Camera Origin
        // Red Cube
        redcube_pos_x_cam.text = (RedCube.transform.localPosition.y - 283).ToString();
        redcube_pos_y_cam.text = (RedCube.transform.localPosition.z + 1777).ToString();
        redcube_pos_z_cam.text = (-RedCube.transform.localPosition.x - 1243).ToString();
        redcube_rot_x_cam.text = (RedCube.transform.localEulerAngles.x).ToString();
        redcube_rot_y_cam.text = (RedCube.transform.localEulerAngles.z).ToString();
        redcube_rot_z_cam.text = (RedCube.transform.localEulerAngles.y).ToString();

        // Green Cube
        greencube_pos_x_cam.text = (GreenCube.transform.localPosition.y - 283).ToString();
        greencube_pos_y_cam.text = (GreenCube.transform.localPosition.z + 1777).ToString();
        greencube_pos_z_cam.text = (-GreenCube.transform.localPosition.x - 1243).ToString();
        greencube_rot_x_cam.text = (GreenCube.transform.localEulerAngles.x).ToString();
        greencube_rot_y_cam.text = (GreenCube.transform.localEulerAngles.z).ToString();
        greencube_rot_z_cam.text = (GreenCube.transform.localEulerAngles.y).ToString();

        // Blue Cube
        bluecube_pos_x_cam.text = (BlueCube.transform.localPosition.y - 283).ToString();
        bluecube_pos_y_cam.text = (BlueCube.transform.localPosition.z + 1777).ToString();
        bluecube_pos_z_cam.text = (-BlueCube.transform.localPosition.x - 1243).ToString();
        bluecube_rot_x_cam.text = (BlueCube.transform.localEulerAngles.x).ToString();
        bluecube_rot_y_cam.text = (BlueCube.transform.localEulerAngles.z).ToString();
        bluecube_rot_z_cam.text = (BlueCube.transform.localEulerAngles.y).ToString();

        // Sorting Area
        // Red Cube
        redcube_pos_x_area.text = (RedArea.transform.localPosition.y).ToString();
        redcube_pos_y_area.text = (-RedArea.transform.localPosition.z).ToString();
        redcube_pos_z_area.text = (-RedArea.transform.localPosition.x).ToString();

        // Green Cube
        greencube_pos_x_area.text = (GreenArea.transform.localPosition.y).ToString();
        greencube_pos_y_area.text = (-GreenArea.transform.localPosition.z).ToString();
        greencube_pos_z_area.text = (-GreenArea.transform.localPosition.x).ToString();

        // Blue Cube
        bluecube_pos_x_area.text = (BlueArea.transform.localPosition.y).ToString();
        bluecube_pos_y_area.text = (-BlueArea.transform.localPosition.z).ToString();
        bluecube_pos_z_area.text = (-BlueArea.transform.localPosition.x).ToString();

        // Chess
        // Robot posiiton
        chess_pos_x_robot.text = (ChessObj.transform.localPosition.y).ToString();
        chess_pos_y_robot.text = (-ChessObj.transform.localPosition.z).ToString();
        chess_pos_z_robot.text = (-ChessObj.transform.localPosition.x).ToString();
        // Camera position
        chess_pos_x_cam.text = (ChessObj.transform.localPosition.y - 283).ToString();
        chess_pos_y_cam.text = (ChessObj.transform.localPosition.z + 1777).ToString();
        chess_pos_z_cam.text = (-ChessObj.transform.localPosition.x - 1243).ToString();
    }
    
    // Obstacles Config
    public void RedCubeToogle(bool newValue)
    {
        RedCube.SetActive(newValue);
    }
    public void GreenCubeToogle(bool newValue)
    {
        GreenCube.SetActive(newValue);
    }
    public void BlueCubeToogle(bool newValue)
    {
        BlueCube.SetActive(newValue);
    }

    // Chess Config
    public void ChessToogle(bool newValue)
    {
        ChessObj.SetActive(newValue);
    }
}
