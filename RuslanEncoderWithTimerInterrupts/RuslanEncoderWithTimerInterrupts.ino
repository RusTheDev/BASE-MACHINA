/* Encoder Library - Basic Example
 * http://www.pjrc.com/teensy/td_libs_Encoder.html
 *
 * This example code is in the public domain.
 */
#include <Encoder.h>
#define USE_TIMER_1     true
#include "TimerInterrupt.h"


// Change these two numbers to the pins connected to your encoder.
//   Best Performance: both pins have interrupt capability
//   Good Performance: only the first pin has interrupt capability
//   Low Performance:  neither pin has interrupt capability
Encoder myEnc(6, 7);

const int buttonPin = 5;
//   avoid using pins with LEDs attached

#define TPR     80 //Full cycle
#define TIMER1_INTERVAL_MS    1000 / 60 //Frame rate of the game is 60 FPS
#define TIMER1_FREQUENCY      (float) (1000.0f / TIMER1_INTERVAL_MS)

unsigned int outputPin1 = LED_BUILTIN;
unsigned int outputPin  = A0;

long oldPosition  = -999;
long oldClamped = 0;

// --- Button Debounce Variables ---
int lastButtonState = HIGH;      
unsigned long lastDebounceTime = 0;  
unsigned long debounceDelay = 50;

// ========================================================================================
// Timer
// ========================================================================================
void TimerHandler1(unsigned int outputPin = LED_BUILTIN)
{
  //Serial.print("clamped: ");
  Serial.print(oldClamped, DEC);
  Serial.println();
}

void TimerInit1() {
  // initialize the timer
  ITimer1.init();
  // attach a callback to the timer
  if (ITimer1.attachInterruptInterval(TIMER1_INTERVAL_MS, TimerHandler1, outputPin1, 0))
  {
    Serial.println("Started Timer");
  }
  else
  {
    Serial.println(F("Can't set ITimer1. Select another freq. or timer"));
  }
}

// ========================================================================================
// Main
// ========================================================================================

void setup() {
  Serial.begin(115200);
  //Serial.println("Basic Encoder Test:");
  // initialize our timer
  pinMode(buttonPin, INPUT_PULLUP); 
  TimerInit1();
}

void loop() {
  
  //Mark's code
  long newPosition = myEnc.read();
  if (newPosition != oldPosition) {
    int clamped = newPosition % TPR;
    if (oldClamped != clamped) {
      oldClamped = clamped;
      float angle = (clamped / (float)TPR) * 360.0;
      //Serial.print(angle);
    }
  }

  int currentRead = digitalRead(buttonPin);

  // If the button JUST went from HIGH to LOW
  if (currentRead == LOW && lastButtonState == HIGH) {
    // We use a capital 'P' to make it stand out from the numbers
    Serial.println("PRESS"); 
    delay(10); // Tiny delay to prevent double-triggering
  }
  lastButtonState = currentRead;

}





