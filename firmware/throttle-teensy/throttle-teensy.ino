/* Throttle unit USB adapter for Teensy LC

  The Throttle unit has keyboard diode matrix for buttons, hats and mode switches.
*/
//#define BOUNCE_WITH_PROMPT_DETECTION
#include <FastLED.h>
//#include <Bounce2.h>
#include <Keypad.h>

boolean gDebugToSerial = false;

class Axis
{
public:
  int rawValue;
  int value;
  int deadZone;
  int maxValue;
  int minValue;
  int centerValue;
  char name;

  Axis(char name = 'A')
  {
    this->name = name;
    this->value = 0;
    this->rawValue = 0;
    this->deadZone = 4;
    this->maxValue = 1020;
    this->minValue = 3;
    this->centerValue = 511;
  }

  void calcValue(int rawValue)
  {
    if (rawValue != this->rawValue)
    {
      this->rawValue = rawValue;
      int value = this->valueToPosition(rawValue);
      if (gDebugToSerial && value != this->value)
      {
        Serial.print("Axis ");
        Serial.print(this->name);
        Serial.print(": ");
        Serial.print(value);
        Serial.print(" (");
        Serial.print(rawValue);
        Serial.println(")");
      }
      this->value = value;
    }
  }

  int valueToPosition(int rawValue)
  {
   // Min/max
   if (rawValue >= this->maxValue)
    return 1023;
   if (rawValue <= this->minValue)
    return 0;
    
   int pos = rawValue - this->centerValue;
   
   // Dead-zone
   if (pos > -this->deadZone && pos < this->deadZone)
    return 511;

  // Curves
  if (pos > 0)
   {
    // Top-side curve
    pos = rawValue - this->centerValue - this->deadZone;
    unsigned long l = this->maxValue - this->centerValue - this->deadZone;
    return (((unsigned long) pos) * (unsigned long) 512) / l + 511;
   }
   else
   {
    // Bottom-side curve
    pos = rawValue - this->minValue;
    unsigned long l = this->centerValue - this->minValue - this->deadZone;
    return (((unsigned long) pos) * (unsigned long) 512) / l + 0;
   }
  }
};

// Modes
const byte MODE_STARTUP = 0;
const byte MODE_NORMAL = 1;
const byte MODE_LOCKED = 2;
const byte MODE_ALT = 4;

byte mode = MODE_NORMAL;
byte throttleCentered = 0;
Axis axisThrottle('T');
Axis axisHor('X');
Axis axisVer('Y');

byte previousMode = MODE_STARTUP;
byte previousThrottleCentered = 0;

// Led drives

#define NUM_LEDS    1
CRGB leds[NUM_LEDS];
const byte pinLed = 13;

// Mapping pins to buttons and axis

const int ROW_NUM = 3;
const int COLUMN_NUM = 8;

byte pin_rows[ROW_NUM] = { 8, 6, 0 };
byte pin_column[COLUMN_NUM] = { 10, 4, 9, 1, 12, 5, 7, 11 };

const byte pinHatButton = 'H';
const byte pinHatA = 'a';
const byte pinHatB = 'b';
const byte pinHatC = 'c';
const byte pinHatD = 'd';
const byte pinHatE = 'e';
const byte pinHatF = 'f';
const byte pinHatG = 'g';
const byte pinHatH = 'h';

const byte pinUp = 'U';
const byte pinDown = 'D';
const byte pinForward = 'F';
const byte pinBack = 'B';
const byte pinExtraForward = '>';
const byte pinExtraBack= '<';
const byte pinTrigger = 'T';
const byte pinModeSwitch = 'M';

const byte pinNC = '-';

const byte analogPinThrottle = 20;
const byte analogPinHor = 21;
const byte analogPinVer = 22;
const byte analogPinSlider = 19;

char keys[ROW_NUM][COLUMN_NUM] = {
  {pinHatD, pinHatC, pinHatB, pinHatA, pinHatH, pinHatG, pinHatF, pinHatE},
  {pinBack, pinNC, pinDown, pinNC, pinForward, pinUp, pinTrigger, pinHatButton},
  {pinNC, pinExtraBack, pinNC, pinExtraForward, pinModeSwitch, pinNC, pinNC, pinNC},
};

Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );

const int max_buttons = ROW_NUM * COLUMN_NUM;
byte buttonPressed[max_buttons];

const byte debounce_interval_ms = 5;

void checkKeys()
{
  // Determine changes to button states
  keypad.getKeys();
  for (int i=0; i<LIST_MAX; i++)   // Scan the list of active keys
  {
    char key = keypad.key[i].kchar;
    if ( keypad.key[i].stateChanged )
    {
      keypad.key[i].stateChanged = false;
      switch (keypad.key[i].kstate)
      {
          case PRESSED:
            buttonPressed[keypad.key[i].kcode] = 1;
            if (gDebugToSerial)
            {
              Serial.print("down: ");
              Serial.println(key);
            }
            break;
          case HOLD:
            break;
          case RELEASED:
            buttonPressed[keypad.key[i].kcode] = 0;
            if (gDebugToSerial)
            {
              Serial.print("up:   ");
              Serial.println(key);
            }
            break;
          case IDLE:
            break;
      }
    }
  }

  // Determine the outcome of pressed buttons to joystick controls
  int hatDir = -1;
  for (int r = 0; r < ROW_NUM; r++)
  {
    for (int c = 0; c < COLUMN_NUM; c++)
    {
      char buttonId = keys[r][c];
      byte value = buttonPressed[r*COLUMN_NUM + c];
      
      // POV Hat position
      if (value)
      {
        switch (buttonId)
        {
        case pinHatA:
          hatDir = 45;
          break;
        case pinHatB:
          hatDir = 0;
          break;
        case pinHatC:
          hatDir = 315;
          break;
        case pinHatD:
          hatDir = 270;
          break;
        case pinHatE:
          hatDir = 225;
          break;
        case pinHatF:
          hatDir = 180;
          break;
        case pinHatG:
          hatDir = 135;
          break;
        case pinHatH:
          hatDir = 90;
          break;
        default:
          break;
        }
      }

      // Buttons
      switch (buttonId)
      {
        case pinUp:
          Joystick.button(1, value);
          break;
        case pinDown:
          Joystick.button(2, value);
          break;
        case pinForward:
          Joystick.button(3, value);
          break;
        case pinBack:
          Joystick.button(4, value);
          break;
        case pinExtraBack:
          Joystick.button(5, value);
          break;
        case pinExtraForward:
          Joystick.button(6, value);
          break;
        case pinTrigger:
          Joystick.button(10, value);
          break;
        case pinModeSwitch:
          Joystick.button(11, value);
          break;
        case pinHatButton:
          Joystick.button(20, value);
          break;
        default:
          break;
      }
    }
    Joystick.hat(hatDir);
  }
}

void
checkAxis()
{
  // read 4 analog inputs and use them for the joystick axis
  //if (mode != MODE_LOCKED)
  {
    axisThrottle.calcValue(analogRead(analogPinThrottle));
    axisHor.calcValue(analogRead(analogPinHor));
    axisVer.calcValue(analogRead(analogPinVer));
    
    Joystick.X(axisHor.value);
    Joystick.Y(axisVer.value);
    Joystick.Z(axisThrottle.value);
    //Joystick.Zrotate(analogRead(analogPinSlider));
  }  
}

void setup()
{
  Serial.begin(9600);
  Joystick.useManualSend(true);
  Joystick.hat(-1);
 
  FastLED.addLeds<WS2812, pinLed, GRB>(leds, NUM_LEDS);

  // Precalibration of axis
  
  axisThrottle.centerValue = 526;
  axisThrottle.maxValue = 1021;
  axisThrottle.minValue = 3;
  axisThrottle.deadZone = 20;
  
  axisHor.centerValue = 504;
  axisHor.maxValue = 1023;
  axisHor.minValue = 2;
  axisHor.deadZone = 25;
  
  axisVer.centerValue = 513;
  axisVer.maxValue = 1023;
  axisVer.minValue = 2;
  axisVer.deadZone = 25;
}

void setLeds()
{
  // Center detection for led color changes
  if (axisThrottle.value > 506 and axisThrottle.value < 516)
    throttleCentered = 1;
  else if (axisThrottle.value > 471 and axisThrottle.value < 551)
    throttleCentered = 2;
  else
    throttleCentered = 0;
  
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

void loop()
{
  checkAxis();
  checkKeys();

  Joystick.send_now();
/*
  if (buttonPressed[pinModeSwitch])
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
  */
  //setLeds();

  delay(1);
}
