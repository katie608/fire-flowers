// This is the code for our Principles of Engineering project

// wire is the library that allows communication with the accelerometer using I2C
#include <Wire.h>

// needed for communicating with this particular accelerometer
#include "SparkFun_MMA8452Q.h"

// create instance of the MMA8452 class for accelerometer
MMA8452Q accel;

void setup() { // this code runs once
  // initialize serial
  Serial.begin(9600);
  Serial.println("Setup");

  // initialize wire library
  Wire.begin();

  // check if accelerometer is connected
  if (accel.begin() == false) {
    Serial.println("Not Connected. Please check connections and read the hookup guide.");
    while (1);
  }

}


void loop() {
  // accelerometer code
  if (accel.available()) {  // Wait for new data from accelerometer
    // Acceleration of x, y, and z directions in g units (between 0 and 1)
    float ax = (accel.getCalculatedX());
    float ay = (accel.getCalculatedY());
    float az = (accel.getCalculatedZ());

    // prints accelerometer values if accelerometer is not flat (in z direction)
    Serial.print(millis());
    Serial.print(" ");
    Serial.print(ax);
    Serial.print(" ");
    Serial.print(ay);
    Serial.print(" ");
    Serial.println(az);
  }
}
