#line 1 "C:/Users/karim/Downloads/MikroC/embedded/code/MyProject.c"
#line 12 "C:/Users/karim/Downloads/MikroC/embedded/code/MyProject.c"
char flag=0;
void autoTraffic();
void manualTraffic();
void interrupt()
{ if(intf_bit==1)
 {intf_bit=0;
 if(flag==99)
 flag=-1;
 flag++;
 }}
void main()
{  trisb.b0 =1;
gie_bit=1;
inte_bit=1;
intedg_bit=1;
 trisc =0b00000000;
 portc =0b00000000;
 trisd =0b00000000;
 portd =0b00000000;
 trisb.B2 =0;
 trisb.B3 =0;
 while(1)
 { if(flag%2==0)
 manualTraffic();
 else
 autoTraffic();
 }
}
void autoTraffic()
{
int i=0;
int num[23]={0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22};
 portb.B2 =1;
 portb.B3 =1;
 while(1)
 {

 for(i=14;i>=0;i--)
 { if(flag%2==0) return;
  portd =num[i];
 if(i>11)
  portc =0b010001;
 else
  portc =0b100001;
 delay_ms(1000);
 }
 for(i=22;i>=0;i--)
 { if(flag%2==0) return;
  portd =num[i];
 if(i>19)
  portc =0b001010;
 else
  portc =0b001100;
 delay_ms(1000);
 }
 }
 }
void manualTraffic()
{
int i=0;
int num[23]={0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22};
 trisb.b1 =1;
 portb.B2 =0;
 portb.B3 =0;
while(1)
{ for(i=2;i>=0;i--)
 { if(flag%2==1) return;
  portb.B3 =1;
  portd =num[i];
  portc =0b010001;
 delay_ms(1000);
 }  portb.B3 =0;
  portc =0b100001;
 while( portb.b1 !=1){if(flag%2==1) return;}
 for(i=2;i>=0;i--)
 { if(flag%2==1) return;
  portb.B2 =1;
  portd =num[i];
  portc =0b001010;
 delay_ms(1000);
 }  portb.B2 =0;
  portc =0b001100;
 while( portb.b1 !=1){if(flag%2==1) return;};
}
}
