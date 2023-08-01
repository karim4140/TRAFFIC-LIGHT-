#line 1 "C:/Users/karim/Downloads/MikroC/Project/code/MyProject.c"
#line 14 "C:/Users/karim/Downloads/MikroC/Project/code/MyProject.c"
short int counter = 1;
int i,j;
int arr[25] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22};
void automatic();
void manual();
void interrupt(){
 if(intf_bit == 1){
 intf_bit = 0;
 if(counter == 2){counter = 0;}
 counter++;}}
void main() {
 gie_bit = 1;
 inte_bit = 1;
 intedg_bit = 1;
 trisd = 0;trisb.b0 = trisb.b1 = 1;trisc = 0;
 portd = 0b00000000; portc = 0;
while(1){
 if(!(counter == 2)){
 automatic();
 }else{
 manual();}}
}
void automatic(){
portd = 0;
 portd.B3  =  portd.B7  = 1;
while(1){
 for(i=0;i<20;i++){
 if(counter == 2) return;
 portc = arr[i];
  portd.B0  =  portd.B6  = 1;
 delay_ms(1000);
 }
 portc = 0;
 for(i=1;i<4;i++){
 if(counter == 2) return;
  portd.B0  = 0; portd.B1  = 1;
 delay_ms(1000);
 portc = arr[i];
 }
 portc = 0;
 for(i=0;i<12;i++){
 if(counter == 2) return;
  portd.B6  =  portd.B1  = 0; portd.B2  =  portd.B4  = 1;
 portc = arr[i];
 delay_ms(1000);
 }
 portc = 0;
  portd.B5  = 1; portd.B4  = 0;
 for(i=1;i<4;i++){
 if(counter == 2) return;
 delay_ms(1000);
 portc = arr[i];
 }
  portd.B5  =  portd.B2  = 0;
}}
void manual(){
portd = 0;
 while(1)
{
 for(i=0;i<3;i++)
 { if(counter == 1) return;
  portd.B3  = 1;
 portc = arr[i];
  portd.B0  =  portd.B6  = 0; portd.B1  =  portd.B4  = 1;
 delay_ms(1000);
 }  portd.B3  = 0;
  portd.B1  = 0; portd.B2  =1;
 while( portb.B1  == 0){if(counter == 1) return;};
 for(i=0;i<3;i++)
 { if(counter == 1) return;
  portd.B7  = 1;
 portc = arr[i];
  portd.B4  =  portd.B2  = 0; portd.B5  =  portd.B0  = 1;
 delay_ms(1000);
 }  portd.B7  = 0;
  portd.B5  = 0; portd.B6  = 1;
 while( portb.B1  == 0){if(counter == 1) return;};
}
}
