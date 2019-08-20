#line 1 "E:/Waleed/live_person/Nawaf_Ozzy/Final_Year_Project/Final_Year_Project/Implementation/Final_Code/final_code.c"
double ADC(unsigned char);
void Apply_Brakes(void);
void Lift_Brakes(void);
void PORTB_INT_ISR(void);



unsigned int DATA=0;
double STEP_SIZE = 4.88;

char Driver=0;
char Baby=0;
char Belt=0;
char Brake=0;
char B=1;
char Rc;
unsigned char Tx[16]={'1','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'};
#line 40 "E:/Waleed/live_person/Nawaf_Ozzy/Final_Year_Project/Final_Year_Project/Implementation/Final_Code/final_code.c"
void interrupt(void)
{
 if(INTCON.RBIF==1)
 {
 PORTB_INT_ISR();
 INTCON.RBIF=0;
 }
 if(PIR1.RCIF==1)
 {
 Rc=RCREG;
 }
}

void main()
{
 char i=0;
 double V0=0,V1=0,V2=0;

 TRISB.RB0=0;
 TRISB.RB1=0;
 TRISB.RB2=0;
 TRISB.RB3=0;
 TRISB.RB4=1;
 TRISB.RB5=1;
 TRISB.RB6=1;
 TRISB.RB7=1;

 TRISC.RA0=1;
 TRISC.RA1=1;
 TRISC.RA2=1;

 TRISC.RC0=1;
 TRISC.RC1=1;
 TRISC.RC2=0;
 TRISC.RC3=0;
 TRISC.RC4=0;
 TRISC.RC6=0;
 TRISC.RC7=1;

 TRISD.RD0=0;
 TRISD.RD1=0;
 TRISD.RD2=0;
 TRISD.RD3=0;
 TRISD.RD4=1;
 TRISD.RD5=1;

 ADCON1=0xC0;
 ADCON0=0x81;


 TXSTA=0x24;
 RCSTA=0x90;
 SPBRG=5;
 TXSTA.TXEN=1;
 RCSTA.SPEN=1;



 INTCON.RBIF=0;
 INTCON.RBIE=1;
 PIE1.RCIE=1;
 INTCON.PEIE=1;
 INTCON.GIE=1;

  PORTC.RC2 =0;
  PORTB.RB0 =0;
  PORTB.RB1 =0;
  PORTB.RB2 =0;
  PORTB.RB3 =0;
 Driver=PORTB.RB4 | PORTB.RB5;
 Belt=PORTB.RB6;
 Delay_ms(10);
 ADCON0.GO=1;
 Delay_ms(1000);

while(1)
 {
  PORTC.RC2 =~ PORTC.RC2 ;
 V0=ADC(0);
 Delay_ms(20);
 V1=ADC(1);
 Delay_ms(20);
 V2=ADC(2);
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

 Delay_ms(200);
 TXREG=Tx[i];
 while(PIR1.TXIF==0);
 Delay_ms(200);
}
}


void PORTB_INT_ISR()
{
if(PORTB.RB6==0 )
{

 Belt=0;
}
else
{

 Belt=1;
}

if(PORTB.RB4==0 && PORTB.RB5==0 )
{

 Driver=0;
 B=1;
}
else
{

 Driver=1;
 B=1;
}
}


double ADC(unsigned char N)
{
 unsigned char DATAH,DATAL;
 double V0;
 if(N==0)
 {
 ADCON0=0x81;

 }
 else if(N==1)
 {
 ADCON0=0x89;

 }
 else if(N==2)
 {
 ADCON0=0x91;

 }

 Delay_ms(25);
 ADCON0.GO=1;
 while(ADCON0.GO==1);

 DATAH=ADRESH;
 DATAL=ADRESL;

 DATA=DATAH;
 DATA=DATA<<8;
 DATA = DATA | DATAL;

 V0 = DATA*STEP_SIZE;
 V0 = V0/1000;
 return V0;
 }


 void Apply_Brakes(void)
{
B=0;
if( PORTC.RC0 ==1 &&  PORTC.RC1 ==1)
{
 PORTB.RB0 =1;
 PORTB.RB1 =0;
 PORTB.RB2 =1;
 PORTB.RB3 =0;
Brake=1;
}

if(( PORTC.RC0 ==0 ||  PORTC.RC1 ==0) && Driver==0)
{
 PORTD.RD2 =1;
Delay_ms(5);
 PORTC.RC3 =1;
Delay_ms(5);

 PORTD.RD1 =0;
 PORTD.RD0 =1;

 PORTD.RD3 =1;
 PORTC.RC4 =0;

while( PORTC.RC0 ==0 &&  PORTC.RC1 ==0 && Driver==0);
while( PORTC.RC0 ==1 ||  PORTC.RC1 ==1 || Driver==1)
{
if(Driver==1)
{
 PORTD.RD1 = PORTD.RD0 ;
 PORTD.RD3 = PORTC.RC4 ;
break;
}

if( PORTC.RC0 ==1)
{ PORTD.RD1 = PORTD.RD0 ;
  PORTB.RB0 =1;
  PORTB.RB1 =0;
}


if( PORTC.RC1 ==1)
{
 PORTD.RD3 = PORTC.RC4 ;
  PORTB.RB2 =1;
  PORTB.RB3 =0;
}
if( PORTC.RC0 ==1 &&  PORTC.RC1 ==1)
{
Brake=1;
break;
}
Delay_ms(20);
}

 PORTD.RD2 =0;
Delay_ms(5);
 PORTC.RC3 =0;
Delay_ms(5);
 PORTD.RD1 =0;
 PORTD.RD0 =0;
 PORTD.RD3 =0;
 PORTC.RC4 =0;
Delay_ms(100);
}
}


void Lift_Brakes(void)
{
B=0;
if( PORTD.RD4 ==1 &&  PORTD.RD5 ==1)
{
 PORTB.RB0 =0;
 PORTB.RB1 =1;
 PORTB.RB2 =0;
 PORTB.RB3 =1;
Brake=0;
}
if(( PORTD.RD4 ==0 ||  PORTD.RD5 ==0) && Driver==1)
{
 PORTD.RD2 =1;
Delay_ms(5);
 PORTC.RC3 =1;
Delay_ms(5);

 PORTD.RD1 =1;
 PORTD.RD0 =0;

 PORTD.RD3 =0;
 PORTC.RC4 =1;
while( PORTD.RD4 ==0 &&  PORTD.RD5 ==0 && Driver==1);
while( PORTD.RD4 ==1 ||  PORTD.RD5 ==1 || Driver==0)
{
if(Driver==0)
{
 PORTD.RD1 = PORTD.RD0 ;
 PORTD.RD3 = PORTC.RC4 ;
break;
}

if( PORTD.RD4 ==1)
{  PORTD.RD1 = PORTD.RD0 ;
  PORTB.RB1 =1;
  PORTB.RB0 =0;
}

if( PORTD.RD5 ==1)
{  PORTD.RD3 = PORTC.RC4 ;
  PORTB.RB3 =1;
  PORTB.RB2 =0;
}


if( PORTD.RD4 ==1 &&  PORTD.RD5 ==1)
{
Brake=0;
break;
}
Delay_ms(20);
}

 PORTD.RD2 =0;
Delay_ms(5);
 PORTC.RC3 =0;
Delay_ms(5);
 PORTD.RD1 =0;
 PORTD.RD0 =0;
 PORTD.RD3 =0;
 PORTC.RC4 =0;
Delay_ms(100);
}
}
