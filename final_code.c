double ADC(unsigned char);      // Declaration of ADC function
void Apply_Brakes(void);
void Lift_Brakes(void);
void PORTB_INT_ISR(void);

//unsigned char txt0[15],txt1[15],txt2[15]; // Store decimal to string converted
                                          // results of Three Sensors
unsigned int DATA=0;        // The 10 bit output value of ADC is stored in it
double STEP_SIZE = 4.88; // It is a step size of Analoge to Digital Converter
                        //Its value is being calculated for 5V Input
char Driver=0;          // This Variable will store the status of the Driver
char Baby=0;            // This Variable will store the status of the Baby
char Belt=0;            // This Variable will store the status of the Belt
char Brake=0;           // This Variable will store the status of the Brake
char B=1;           // This Variable will store the status of the Brake
char Rc;
unsigned char Tx[16]={'1','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'};

#define LED PORTC.RC2
#define RED_LED1 PORTB.RB0
#define GREEN_LED1 PORTB.RB1
#define RED_LED2 PORTB.RB2
#define GREEN_LED2 PORTB.RB3

#define M1_1 PORTD.RD1
#define M1_2 PORTD.RD0
#define M1_Enable PORTD.RD2

#define M2_1 PORTD.RD3
#define M2_2 PORTC.RC4
#define M2_Enable PORTC.RC3

#define Lock1 PORTC.RC0
#define UnLock1 PORTD.RD4

#define Lock2 PORTC.RC1
#define UnLock2 PORTD.RD5


void interrupt(void)  // Interrupt function
{
   if(INTCON.RBIF==1) // To verify that what type of interrupt is being generated
   {
   PORTB_INT_ISR();   // Go to the Service Routine of PORTB change Interrupt
   INTCON.RBIF=0;     // Clear the Interrupt flag to indicate that appropriate
   }                 // action has been taken against the generated Interrupt
   if(PIR1.RCIF==1)
   {
   Rc=RCREG;
   }
}

void main()
{
   char i=0;
   double V0=0,V1=0,V2=0; // To store the calculated decimal results of sensors

   TRISB.RB0=0;      // Configure the Output Pin
   TRISB.RB1=0;      // Configure the Output Pin
   TRISB.RB2=0;      // Configure the Output Pin
   TRISB.RB3=0;      // Configure the Output Pin
   TRISB.RB4=1;      // Configure the Input Pin
   TRISB.RB5=1;      // Configure the Input Pin
   TRISB.RB6=1;      // Configure the Input Pin
   TRISB.RB7=1;      // Configure the Input Pin

   TRISC.RA0=1;          // Configure the PIN RA0 as Input for Sensor 1
   TRISC.RA1=1;          // Configure the PIN RA1 as Input for Sensor 2
   TRISC.RA2=1;          // Configure the PIN RA2 as Input for Sensor 3

   TRISC.RC0=1;      // Configure the Input Pin
   TRISC.RC1=1;      // Configure the Input Pin
   TRISC.RC2=0;      // Configure the Output Pin
   TRISC.RC3=0;      // Configure the Output Pin
   TRISC.RC4=0;      // Configure the Output Pin
   TRISC.RC6=0;          // Configure the Output Tx pin of Serial PORT
   TRISC.RC7=1;          // Configure the Input Rx pin of Serial PORT

   TRISD.RD0=0;      // Configure the Output Pin
   TRISD.RD1=0;      // Configure the Output Pin
   TRISD.RD2=0;      // Configure the Output Pin
   TRISD.RD3=0;      // Configure the Output Pin
   TRISD.RD4=1;      // Configure the Input Pin
   TRISD.RD5=1;      // Configure the Input Pin

   ADCON1=0xC0;          //Configure the ADC Module Register
   ADCON0=0x81;          //Configure the ADC Module Register

////////////// Configure Serial PORT(USART) //////////////////////////////////
   TXSTA=0x24;           //Configure the Tx Register Serial PORT(USART)
   RCSTA=0x90;           //Configure the Rx Register Serial PORT(USART)
   SPBRG=5;              //Set the Baud Rate
   TXSTA.TXEN=1;
   RCSTA.SPEN=1;
//////////////////////////////////////////////////////////////////////////////

/////////////////////// Configure the PORTB Change Interrupt /////////////////
   INTCON.RBIF=0;
   INTCON.RBIE=1;
   PIE1.RCIE=1;
   INTCON.PEIE=1;
   INTCON.GIE=1;
///////////////////////////////////////////////////////////////////////////////
   LED=0;
   RED_LED1=0;
   GREEN_LED1=0;
   RED_LED2=0;
   GREEN_LED2=0;
   Driver=PORTB.RB4 | PORTB.RB5; // Check the Initial Status of Driver
   Belt=PORTB.RB6;
   Delay_ms(10);
   ADCON0.GO=1;          // Start Analoge to Digital Conversion
   Delay_ms(1000);

while(1)
   {
   LED=~LED;
   V0=ADC(0);            // Read Data of First Sensor
   Delay_ms(20);
   V1=ADC(1);            // Read Data of Second Sensor
   Delay_ms(20);
   V2=ADC(2);            // Read Data of Third Sensor
   Delay_ms(20);

   if(V0>3.5 || V1>3.5 || V2>3.5)
   {Baby=1;}
   else
   {Baby=0;}

   if(Driver==0 && B==1)
   {
    Delay_ms(10);
    Apply_Brakes();
    }
   if(Driver==1 && B==1)
   {
    Delay_ms(10);
    Lift_Brakes();
    }
/////////////////////////// Coding the Data ////////////////////////////////////
   if(Driver==0 && Baby==0 && Belt==0 && Brake==0)
   i=0;
       else if(Driver==1 && Baby==0 && Belt==0 && Brake==0)
   i=1;
       else if(Driver==0 && Baby==1 && Belt==0 && Brake==0)
   i=2;
      else if(Driver==1 && Baby==1 && Belt==0 && Brake==0)
   i=3;
      else if(Driver==0 && Baby==0 && Belt==1 && Brake==0)
   i=4;
      else if(Driver==1 && Baby==0 && Belt==1 && Brake==0)
   i=5;
      else if(Driver==0 && Baby==1 && Belt==1 && Brake==0)
   i=6;
      else if(Driver==1 && Baby==1 && Belt==1 && Brake==0)
   i=7;
      else if(Driver==0 && Baby==0 && Belt==0 && Brake==1)
   i=8;
      else if(Driver==1 && Baby==0 && Belt==0 && Brake==1)
   i=9;
      else if(Driver==0 && Baby==1 && Belt==0 && Brake==1)
   i=10;
      else if(Driver==1 && Baby==1 && Belt==0 && Brake==1)
   i=11;
      else if(Driver==0 && Baby==0 && Belt==1 && Brake==1)
   i=12;
      else if(Driver==1 && Baby==0 && Belt==1 && Brake==1)
   i=13;
      else if(Driver==0 && Baby==1 && Belt==1 && Brake==1)
   i=14;
      else if(Driver==1 && Baby==1 && Belt==1 && Brake==1)
   i=15;
////////////////////////////////////////////////////////////////////////////////
   Delay_ms(200);
   TXREG=Tx[i];       // Transmit the Coded Data
   while(PIR1.TXIF==0);
   Delay_ms(200);
}
}


void PORTB_INT_ISR()
{
if(PORTB.RB6==0 )
{
// When the Seat Belt is Open
   Belt=0;
}
else
{
// When the Seat Belt is locked
   Belt=1;
}

if(PORTB.RB4==0 && PORTB.RB5==0 )
{
// When the Driver is not present
   Driver=0;
   B=1;
}
else
{
// When the Driver is present
   Driver=1;
   B=1;
}
}

// Function to Read the analoge value from the sensor
double ADC(unsigned char N)
{               // Variable N indicates the Sensor whose value needs to be read
   unsigned char DATAH,DATAL;
   double V0;
   if(N==0)
   {
   ADCON0=0x81;  // Adjust the value of ADC register to read
                 // the Input from pin RA0 of ADC
   }
   else if(N==1)
   {
   ADCON0=0x89;  // Adjust the value of ADC register to read
                 // the Input from pin RA1 of ADC
   }
   else if(N==2)
   {
   ADCON0=0x91; // Adjust the value of ADC register to read
                // the Input from pin RA2 of ADC
   }

   Delay_ms(25);
   ADCON0.GO=1;         // Start Conversion
   while(ADCON0.GO==1); // Wait till conversion Completes

   DATAH=ADRESH;        // Read Data
   DATAL=ADRESL;

   DATA=DATAH;          // Rearrange Data
   DATA=DATA<<8;
   DATA = DATA | DATAL;// DATA variable contains combined value of ADC

   V0 = DATA*STEP_SIZE;// Calculate actual value that is being read by the ADC
   V0 = V0/1000;
   return V0;          // Return the Intput value to main Program
 }
 
 
 void Apply_Brakes(void)
{
B=0;
if(Lock1==1 && Lock2==1)
{
RED_LED1=1;
GREEN_LED1=0;
RED_LED2=1;
GREEN_LED2=0;
Brake=1;
}

if((Lock1==0 || Lock2==0) && Driver==0)
{
M1_Enable=1;
Delay_ms(5);
M2_Enable=1;
Delay_ms(5);

M1_1=0;
M1_2=1;

M2_1=1;
M2_2=0;

while(Lock1==0 && Lock2==0 && Driver==0);
while(Lock1==1 || Lock2==1 || Driver==1)
{
if(Driver==1)
{
M1_1=M1_2;        // Instant Braking of motors
M2_1=M2_2;
break;
}

if(Lock1==1)
{M1_1=M1_2;       // Instant Braking of motors
 RED_LED1=1;
   GREEN_LED1=0;
}


if(Lock2==1)
{
M2_1=M2_2;        // Instant Braking of motors
   RED_LED2=1;
   GREEN_LED2=0;
}
if(Lock1==1 && Lock2==1)
{
Brake=1;
break;
}
Delay_ms(20);
}

M1_Enable=0;
Delay_ms(5);
M2_Enable=0;
Delay_ms(5);
M1_1=0;
M1_2=0;
M2_1=0;
M2_2=0;
Delay_ms(100);
}
}


void Lift_Brakes(void)
{
B=0;
if(UnLock1==1 && UnLock2==1)
{
RED_LED1=0;
GREEN_LED1=1;
RED_LED2=0;
GREEN_LED2=1;
Brake=0;
}
if((UnLock1==0 || UnLock2==0) && Driver==1)
{
M1_Enable=1;
Delay_ms(5);
M2_Enable=1;
Delay_ms(5);

M1_1=1;
M1_2=0;

M2_1=0;
M2_2=1;
while(UnLock1==0 && UnLock2==0 && Driver==1);
while(UnLock1==1 || UnLock2==1 || Driver==0)
{
if(Driver==0)
{
M1_1=M1_2;        // Instant Braking of motors
M2_1=M2_2;
break;
}

if(UnLock1==1)
{  M1_1=M1_2;
   GREEN_LED1=1;
   RED_LED1=0;
}

if(UnLock2==1)
{  M2_1=M2_2;
   GREEN_LED2=1;
   RED_LED2=0;
}


if(UnLock1==1 && UnLock2==1)
{
Brake=0;
break;
}
Delay_ms(20);
}

M1_Enable=0;
Delay_ms(5);
M2_Enable=0;
Delay_ms(5);
M1_1=0;
M1_2=0;
M2_1=0;
M2_2=0;
Delay_ms(100);
}
}
