/* Throttle unit USB adapter for Teensy LC

  The Throttle unit has keyboard diode matrix for buttons, hats and mode switches.
*/
#define BOUNCE_WITH_PROMPT_DETECTION
#include <FastLED.h>
#include <Bounce2.h>

// Modes
const byte MODE_STARTUP = 0;
const byte MODE_NORMAL = 1;
const byte MODE_LOCKED = 2;
const byte MODE_ALT = 4;

byte mode = MODE_NORMAL;
byte throttleCentered = 0;
int axisThrottle = 0;
int axisHor = 0;
int axisVer = 0;

// Led drives

#define NUM_LEDS    1
CRGB leds[NUM_LEDS];
const byte pinLed = 24;

// Mapping pins to buttons and axis

const byte pinHatButton = 18;
const byte pinHatA = 8;
const byte pinHatB = 7;
const byte pinHatC = 6;
const byte pinHatD = 5;
const byte pinHatE = 12;
const byte pinHatF = 11;
const byte pinHatG = 10;
const byte pinHatH = 9;

const byte pinUp = 1;
const byte pinDown = 3;
const byte pinForward = 0;
const byte pinBack = 2;
const byte pinExtra = 4;
const byte pinLock = 19;
const byte pinB1 = 20;
const byte pinB2 = 21;

const byte analogPinThrottle = 2;
const byte analogPinHor = 1;
const byte analogPinVer = 0;
const byte analogPinSlider = 3;

const byte numButtons = 17;
const byte pins[numButtons] = { pinUp, pinDown, pinForward, pinBack, pinExtra, pinLock, pinB1, pinB2, pinHatButton, pinHatA, pinHatB, pinHatC, pinHatD, pinHatE, pinHatF, pinHatG, pinHatH };

byte buttonPressed[32];
Bounce buttons[numButtons];

const byte debounce_interval_ms = 5;

void setup()
{
  Serial.begin(9600);
  Joystick.useManualSend(true);
  
  for (int i=0; i<numButtons; i++)
  {
    const byte pin = pins[i];
    pinMode(pin, INPUT_PULLUP);
    buttons[i] = Bounce();
    buttons[i].attach(pin);
    buttons[i].interval(debounce_interval_ms);
  }

  FastLED.addLeds<WS2812, pinLed, GRB>(leds, NUM_LEDS);
}

byte previousMode = MODE_STARTUP;
byte previousThrottleCentered = 0;

void setLeds()
{
  if (mode != previousMode || throttleCentered != previousThrottleCentered)
  {
    if (mode == MODE_LOCKED)
      leds[0] = CRGB (255, 0, 0); // red
    else if (mode == MODE_ALT)
      leds[0] = CRGB (0, 0, 255); // blue
    else
    {
      if (throttleCentered == 1)
        leds[0] = CRGB (0, 255, 0); // green
      else if (throttleCentered == 2)
        leds[0] = CRGB (255, 255, 0); // yellow
      else
        leds[0] = CRGB (255, 102, 0); // orange
    }
    
    previousMode = mode;
    previousThrottleCentered = throttleCentered;
    FastLED.show();
  }
}

const long printCountMax = 1000;
long printCount = 0;

void doModeAlt()
{
  if (printCount <= 0)
  {
    Serial.print("T = ");
    Serial.print(axisThrottle);
    Serial.print(" | H = ");
    Serial.print(axisHor);
    Serial.print(" | V = ");
    Serial.print(axisVer);
    for (int i=0; i<numButtons; i++)
    {
      int b = buttonPressed[i];
      if (b)
      {
        Serial.print(" | PIN ");
        Serial.print(i);
      }
    }
    Serial.println();
    printCount = printCountMax;
  }
  else
    printCount--;
}

void loop()
{
  // read 4 analog inputs and use them for the joystick axis
  if (mode != MODE_LOCKED)
  {
    axisThrottle = analogRead(analogPinThrottle);
    axisHor = analogRead(analogPinHor);
    axisVer = analogRead(analogPinVer);
    Joystick.X(analogRead(analogPinHor));
    Joystick.Y(analogRead(analogPinVer));
    Joystick.Z(axisThrottle);
    //Joystick.Zrotate(analogRead(analogPinSlider));
  }

  for (int i=0; i<numButtons; i++)
  {
    const byte pin = pins[i];
    buttons[i].update();
    if (buttons[i].fell() == true)
      buttonPressed[pin] = 1;
    if (buttons[i].rose() == true)
      buttonPressed[pin] = 0;
  }

  if (buttonPressed[pinHatA])
    Joystick.hat(0);
  else if (buttonPressed[pinHatB])
    Joystick.hat(315);
  else if (buttonPressed[pinHatC])
    Joystick.hat(270);
  else if (buttonPressed[pinHatD])
    Joystick.hat(225);
  else if (buttonPressed[pinHatE])
    Joystick.hat(180);
  else if (buttonPressed[pinHatF])
    Joystick.hat(135);
  else if (buttonPressed[pinHatG])
    Joystick.hat(90);
  else if (buttonPressed[pinHatH])
    Joystick.hat(45);
  else
    Joystick.hat(-1);

  Joystick.button(1, buttonPressed[pinUp]);
  Joystick.button(2, buttonPressed[pinDown]);
  Joystick.button(3, buttonPressed[pinForward]);
  Joystick.button(4, buttonPressed[pinBack]);
  Joystick.button(5, buttonPressed[pinExtra]);
  Joystick.button(10, buttonPressed[pinLock]);
  Joystick.button(11, buttonPressed[pinB1]);
  Joystick.button(12, buttonPressed[pinB2]);
  Joystick.button(20, buttonPressed[pinHatButton]);

  Joystick.send_now();

  if (buttonPressed[pinLock])
  {
    if (Serial)
      mode = MODE_ALT;
    else
      mode = MODE_LOCKED;
  }
  else
  {
    mode = MODE_NORMAL;
    if (axisThrottle > 506 and axisThrottle < 516)
      throttleCentered = 1;
    else if (axisThrottle > 471 and axisThrottle < 551)
      throttleCentered = 2;
    else
      throttleCentered = 0;
  }
  
  setLeds();

  if (mode == MODE_ALT)
    doModeAlt();
  
  delay(1);
}
