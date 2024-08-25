using UnityEngine;
using static UnityEngine.GraphicsBuffer;
using UnityEngine.UI;
using UnityEditor;
using UnityEngine.UIElements;
using UnityEditorInternal;
using System.Globalization;

public class InverseKin : MonoBehaviour
{
    private float[] q = new float[6]; // start joints orientation

    private float[] qm = new float[6]; // trajectory

    public float q01, q02, q03, q04, q05, q06;

    private float thetha1, thetha2, thetha3, thetha4, thetha5, thetha6;

    // point to calculate ik
    public float ox = 627.86f; 
    public float oy = 1387.26f; 
    public float oz = 185.892f; 

    public bool RobotOperate;

    private float Tm= 40; // trajectory steps

    // links length
    private float L1 = 123.32f;
    private float L2 = 577.32f;
    private float L3 = 949.04f;
    private float L4 = 227.79f;
    private float L5 = 918.09f;
    private float L6 = 740.36f;

    // to calculate inverse kin manually
    public InputField NewX, NewY, NewZ;

    void Start()
    {
        q02 = 90;
        q03 = 90;
}
    void Update()
    {
        ox = float.Parse(NewX.text, CultureInfo.InvariantCulture);
        oy = float.Parse(NewY.text, CultureInfo.InvariantCulture);
        oz = float.Parse(NewZ.text, CultureInfo.InvariantCulture);
    }

    public void ChangeStateRobotOperate(bool state)
    {
        if (!state)
        {
            RobotOperate = true;
        }
        else
        {
            RobotOperate = false;
        }
    }

    public void CalculateInverseKinematics()
    {
        // Transformation matrix of the ik point
        /*
        Matrix4x4 T = new Matrix4x4(new Vector4(1, 0, 0, ox),
                                    new Vector4(0, 0, 1, oy),
                                    new Vector4(0, -1, 0, oz),
                                    new Vector4(0, 0, 0, 1));
        */

        Matrix4x4 T = new Matrix4x4(new Vector4(-1, 0,  0, ox),
                                    new Vector4( 0, 1,  0, oy),
                                    new Vector4( 0, 0, -1, oz),
                                    new Vector4( 0, 0,  0, 1));

        // Rotation matrix of the ik point
        Matrix4x4 R = new Matrix4x4(new Vector4(T[0, 0], T[1, 0], T[2, 0], 0),
                                    new Vector4(T[0, 1], T[1, 1], T[2, 1], 0),
                                    new Vector4(T[0, 2], T[1, 2], T[2, 2], 0),
                                    new Vector4(0, 0, 0, 1));

        Vector3 o = new Vector3(ox, oy, oz); // center point calculation
        float xc = o.x - L6 * R[2, 0];
        float yc = o.y - L6 * R[2, 1];
        float zc = o.z - L6 * R[2, 2];
        // calculate thetha1
        thetha1 = Mathf.Atan2(yc, xc) * Mathf.Rad2Deg;

        // calculate thetha3
        float a = Mathf.Sqrt(L4 * L4 + L5 * L5);
        float r = Mathf.Sqrt(xc * xc + yc * yc) - L1;
        float s = zc - L2;
        float b = Mathf.Sqrt(r * r + s * s);
        float D = (L3 * L3 + a * a - b * b) / (2 * L3 * a);
        float fi = Mathf.Acos(D) * Mathf.Rad2Deg;
        float beta = 180 - fi;
        float alpha = Mathf.Atan2(L4, L5) * Mathf.Rad2Deg;
        // thetha3 = beta - alpha + 90; // Config I
        thetha3 = -(beta + alpha) + 90; // Config II

        // calculate thetha2
        float fi2 = Mathf.Atan2(s, r) * Mathf.Rad2Deg;
        float D1 = (L3 * L3 + b * b - a * a) / (2 * L3 * b);
        float fi1 = Mathf.Acos(D1) * Mathf.Rad2Deg;
        // thetha2 = fi2 - fi1; // Config I
        thetha2 = fi2 + fi1; // Config II

        // calculate thetha4, thetha5, thetha6

        float alpha1 = 90, alpha2 = 0, alpha3 = 90, r1 = L1, r2 = L3, r3 = L4, d1 = L2, d2 = 0, d3 = 0;
        // matrix T1
        Matrix4x4 T1 = new Matrix4x4(new Vector4(Mathf.Cos(thetha1 * Mathf.Deg2Rad), -Mathf.Sin(thetha1 * Mathf.Deg2Rad) * Mathf.Cos(alpha1 * Mathf.Deg2Rad), Mathf.Sin(thetha1 * Mathf.Deg2Rad) * Mathf.Sin(alpha1 * Mathf.Deg2Rad), r1 * Mathf.Cos(thetha1 * Mathf.Deg2Rad)),
                                    new Vector4(Mathf.Sin(thetha1 * Mathf.Deg2Rad), Mathf.Cos(thetha1 * Mathf.Deg2Rad) * Mathf.Cos(alpha1 * Mathf.Deg2Rad), -Mathf.Cos(thetha1 * Mathf.Deg2Rad) * Mathf.Sin(alpha1 * Mathf.Deg2Rad), r1 * Mathf.Sin(thetha1 * Mathf.Deg2Rad)),
                                    new Vector4(0, Mathf.Sin(alpha1 * Mathf.Deg2Rad), Mathf.Cos(alpha1 * Mathf.Deg2Rad), d1),
                                    new Vector4(0, 0, 0, 1));

        // matrix T2
        Matrix4x4 T2 = new Matrix4x4(new Vector4(Mathf.Cos(thetha2 * Mathf.Deg2Rad), -Mathf.Sin(thetha2 * Mathf.Deg2Rad) * Mathf.Cos(alpha2 * Mathf.Deg2Rad), Mathf.Sin(thetha2 * Mathf.Deg2Rad) * Mathf.Sin(alpha2 * Mathf.Deg2Rad), r2 * Mathf.Cos(thetha2 * Mathf.Deg2Rad)),
                                    new Vector4(Mathf.Sin(thetha2 * Mathf.Deg2Rad), Mathf.Cos(thetha2 * Mathf.Deg2Rad) * Mathf.Cos(alpha2 * Mathf.Deg2Rad), -Mathf.Cos(thetha2 * Mathf.Deg2Rad) * Mathf.Sin(alpha2 * Mathf.Deg2Rad), r2 * Mathf.Sin(thetha2 * Mathf.Deg2Rad)),
                                    new Vector4(0, Mathf.Sin(alpha2 * Mathf.Deg2Rad), Mathf.Cos(alpha2 * Mathf.Deg2Rad), d2),
                                    new Vector4(0, 0, 0, 1));

        // matrix T3
        Matrix4x4 T3 = new Matrix4x4(new Vector4(Mathf.Cos(thetha3 * Mathf.Deg2Rad), -Mathf.Sin(thetha3 * Mathf.Deg2Rad) * Mathf.Cos(alpha3 * Mathf.Deg2Rad), Mathf.Sin(thetha3 * Mathf.Deg2Rad) * Mathf.Sin(alpha3 * Mathf.Deg2Rad), r3 * Mathf.Cos(thetha3 * Mathf.Deg2Rad)),
                                    new Vector4(Mathf.Sin(thetha3 * Mathf.Deg2Rad), Mathf.Cos(thetha3 * Mathf.Deg2Rad) * Mathf.Cos(alpha3 * Mathf.Deg2Rad), -Mathf.Cos(thetha3 * Mathf.Deg2Rad) * Mathf.Sin(alpha3 * Mathf.Deg2Rad), r3 * Mathf.Sin(thetha3 * Mathf.Deg2Rad)),
                                    new Vector4(0, Mathf.Sin(alpha3 * Mathf.Deg2Rad), Mathf.Cos(alpha3 * Mathf.Deg2Rad), d3),
                                    new Vector4(0, 0, 0, 1));

        // matrix T03
        Matrix4x4 T03 = T1.transpose * T2.transpose * T3.transpose;

        Matrix4x4 R03 = new Matrix4x4(T03.GetColumn(0), T03.GetColumn(1), T03.GetColumn(2), Vector4.zero);

        // matrix R03T
        Matrix4x4 R03T = R03.transpose;

        // matrix R36
        Matrix4x4 R36 = R03T * R.transpose;

        // calculate thetha4
        thetha4 = Mathf.Atan2(-R36[1, 2], -R36[0, 2]) * Mathf.Rad2Deg;

        // calculate thetha5
        thetha5 = Mathf.Acos(-R36[2, 2]) * Mathf.Rad2Deg - 180;

        // calculate thetha6
        thetha6 = Mathf.Atan2(-R36[2, 1], R36[2, 0]) * Mathf.Rad2Deg;

        thetha3 = -thetha3 + 90;
        // ModifyRobot(thetha1, thetha2, thetha3, thetha4, thetha5, thetha6);

        q[0] = thetha1;
        q[1] = thetha2;
        q[2] = thetha3;
        q[3] = thetha4;
        q[4] = thetha5;
        q[5] = thetha6;

        qm[0] = (q[0] - q01) / Tm;
        qm[1] = (q[1] - q02) / Tm;
        qm[2] = (q[2] - q03) / Tm;
        qm[3] = (q[3] - q04) / Tm;
        qm[4] = (q[4] - q05) / Tm;
        qm[5] = (q[5] - q06) / Tm;

        StartCoroutine(LoopWithDelay(q01, q02, q03, q04, q05, q06));
    }

    public void BackToInitPos() // function to move robot tot initial position
    {
        thetha1 = 0;
        thetha2 = 90;
        thetha3 = 90;
        thetha4 = 0;
        thetha5 = -90;
        thetha6 = 0;

        q[0] = thetha1;
        q[1] = thetha2;
        q[2] = thetha3;
        q[3] = thetha4;
        q[4] = thetha5;
        q[5] = thetha6;

        qm[0] = (q[0] - q01) / Tm;
        qm[1] = (q[1] - q02) / Tm;
        qm[2] = (q[2] - q03) / Tm;
        qm[3] = (q[3] - q04) / Tm;
        qm[4] = (q[4] - q05) / Tm;
        qm[5] = (q[5] - q06) / Tm;

        RobotOperate = true;
        StartCoroutine(LoopWithDelay(q01, q02, q03, q04, q05, q06));
    }

    // Cubes IK
    public void BlackCubePosition() // calculate ik for the given point
    {
        ox = 856f;
        oy = 858f;
        oz = 185.892f;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    public void GreenCubePosition() // calculate ik for the given point
    {
        ox = 1387.26f;
        oy = -1224f;
        oz = 185.892f;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    public void BlueCubePosition() // calculate ik for the given point
    {
        ox = 1387.26f;
        oy = 627.8f;
        oz = 185.892f;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    // Areas IK
    public void BlackAreaPosition() // calculate ik for the given point
    {
        ox = 1413.417f;
        oy = -204.0424f;
        oz = 0 + 200;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    public void GreenAreaPosition() // calculate ik for the given point
    {
        ox = 1413.417f;
        oy = -636.9429f;
        oz = 0 + 300;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    public void BlueAreaPosition() // calculate ik for the given point
    {
        ox = 997.6165f;
        oy = -636.9429f;
        oz = 0 + 400f;

        RobotOperate = true;
        CalculateInverseKinematics();
    }

    public void RobotStop() // stop the robot
    {
        RobotOperate = false;
    }

    System.Collections.IEnumerator LoopWithDelay(float q01, float q02, float q03, float q04, float q05, float q06)
    {
        for (int i = 1; i <= Tm; i++)
        {
            if (RobotOperate)
            {
                q01 += qm[0]; q02 += qm[1]; q03 += qm[2]; q04 += qm[3]; q05 += qm[4]; q06 += qm[5];
            }

            thetha1 = q01;
            thetha2 = q02;
            thetha3 = q03;
            thetha4 = q04;
            thetha5 = q05;
            thetha6 = q06;
            ModifyRobot(q01, q02, q03, q04, q05, q06);

            yield return new WaitForSeconds(0.05f); // how fast robot moves

            if (!RobotOperate)
            {
                yield break;
            }
        }
    }

    private void ModifyRobot(float a1, float a2, float a3, float a4, float a5, float a6)
    {
        GameObject robot = GameObject.Find("Robot1");
        RobotTest robotIns = robot.GetComponent<RobotTest>();

        robotIns.J1Angle = a1;
        robotIns.J2Angle = a2;
        robotIns.J3Angle = a3;
        robotIns.J4Angle = a4;
        robotIns.J5Angle = a5;
        robotIns.J6Angle = a6;

        q01 = thetha1;
        q02 = thetha2;
        q03 = thetha3;
        q04 = thetha4;
        q05 = thetha5;
        q06 = thetha6;
    }
}