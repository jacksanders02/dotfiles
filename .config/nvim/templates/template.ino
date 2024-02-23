// Constants

// Global Variables

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  // Wait for serial to open and start receiving prints
  while (!Serial) {
    ;
  }
  delay(10);

  Serial.println("Connected!");
}

void loop() {
  // put your main code here, to run repeatedly:

}

// Other Subroutines
