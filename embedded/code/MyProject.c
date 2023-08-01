#define  traffic portc
#define  trafficDir trisc
#define  switchA_MDir trisb.b0
#define  switchManualMode portb.b1
#define  switchManualModeDir trisb.b1
#define  power portb.B2
#define  powerDir trisb.B2
#define  power1 portb.B3
#define  power1Dir trisb.B3
#define  ssd   portd
#define  ssdDir trisd
char flag=0;
void autoTraffic();
void manualTraffic();
void interrupt()
{     if(intf_bit==1)
      {intf_bit=0;
      if(flag==99)
         flag=-1;
      flag++;
      }}
void main() 
{       switchA_MDir=1;
gie_bit=1;
inte_bit=1;
intedg_bit=1;
trafficDir=0b00000000;
traffic=0b00000000;
ssdDir=0b00000000;
ssd=0b00000000;
powerDir=0;
power1Dir=0;
      while(1)
      {    if(flag%2==0)
              manualTraffic();
           else
              autoTraffic();
      }
}
void autoTraffic()
{
int i=0;
int num[23]={0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22};
power=1;
power1=1;
 while(1)
 {

     for(i=14;i>=0;i--)
     {    if(flag%2==0) return;
      ssd=num[i];
      if(i>11)
           traffic=0b010001;
      else
           traffic=0b100001;
           delay_ms(1000);
     }
      for(i=22;i>=0;i--)
     {     if(flag%2==0) return;
          ssd=num[i];
       if(i>19)
           traffic=0b001010;
       else
           traffic=0b001100;
           delay_ms(1000);
     }
     }
     }
void manualTraffic()
{
int i=0;
int num[23]={0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22};
switchManualModeDir=1;
power=0;
power1=0;
while(1)
{        for(i=2;i>=0;i--)
     {      if(flag%2==1) return;
           power1=1;
           ssd=num[i];
          traffic=0b010001;
           delay_ms(1000);
     }    power1=0;
          traffic=0b100001;
     while(switchManualMode!=1){if(flag%2==1) return;}
      for(i=2;i>=0;i--)
     {    if(flag%2==1) return;
          power=1;
          ssd=num[i];
          traffic=0b001010;
          delay_ms(1000);
     }    power=0;
          traffic=0b001100;
      while(switchManualMode!=1){if(flag%2==1) return;};
}
}