#line 1 "C:/Users/Name/Documents/College/Summer Training/Embedded Project/Code/TrafficLight.c"
sbit DIS1 at PORTD.B6;
sbit DIS2 at PORTD.B7;








int flag = 5;

void timer(int time1, int time2);
void display(int tens, int units, int tens2, int units2);
void switch_ma();
void automaticTraffic();
void manualTraffic();
void all_off();

void interrupt()
{
 if(intf_bit==1)
 {intf_bit=0;
 if(flag==99)
 flag=-1;
 flag++;
 }}

void manualTraffic(){

 int i = 0;
 while(1){

 if (flag % 2 ==0)
 {
 return;
 }
 DIS2 = 1;
 all_off();
  portB.b3  = 1;
 for (i = 1; i <= 3; i++)
 {
 PORTC = i;
 delay_ms(1000);
 }
 DIS2 = 0;
  portB.b3  = 0;
  portB.b4  = 1;
  portB.b5  = 1;
 for(;  portB.b1  == 0;){
 if (flag % 2 ==0)
 {
 return;
 }
 }
 all_off();
  portB.b6  = 1;
 DIS2 = 1;
 for (i = 1; i <= 3; i++)
 {
 PORTC = i;
 delay_ms(1000);
 }
 DIS2 = 0;
  portB.b6  = 0;
  portB.b7  = 1;
  portB.b2  = 1;
 for(;  portB.b1  == 1;){
 if (flag % 2 ==0)
 {
 return;
 }
 }
 }
}

void main()
{
 gie_bit = 1;
 inte_bit = 1;
 intedg_bit = 1;

 TRISB = 0B00000011;
 TRISC = 0;
 TRISD = 0;
 DIS1 = 0;
 DIS2 = 0;
 PORTB = 0;
 PORTC = 0;
 PORTD = 0;

 while (1)
 {
 if (flag % 2 == 0){
 automaticTraffic();
 }else{
 manualTraffic();
 }
 }
}

void timer(int time1, int time2){
 int i, j, k;

 if (flag % 2 == 1)
 {
 return;
 }

 if ( portB.b2 ){
 i = time2;
 j = time1;
 k = j;
 }
 else{
 i = time1;
 j = time2;
 k = i;
 }

 for (; k >= 0; i--, j--, k--){

 if (flag % 2 == 1)
 {
 return;
 }

 display(i/10, i%10, j/10, j%10);
 }
}

void display(int tens, int units, int tens2, int units2){
 int i;
 for (i = 0; i < 10; i++){

 if (flag % 2 == 1)
 {
 return;
 }

 DIS1 = 1;
 PORTC = tens + (tens2 << 4);
 delay_ms(50);
 DIS1 = 0;

 DIS2 = 1;
 PORTC = units + (units2 << 4);
 delay_ms(50);
 DIS2 = 0;
 }
}


void automaticTraffic(){
 while (1){
 if (flag % 2 == 1)
 {
 return;
 }

  portB.b4  = 1;
  portB.b5  = 1;
 timer(19, 23);
  portB.b4  = 0;
  portB.b3  = 1;
 timer(3, 3);
  portB.b3  = 0;
  portB.b2  = 1;
  portB.b5  = 0;
  portB.b7  = 1;
 timer(11, 15);
  portB.b6  = 1;
  portB.b7  = 0;
 timer(3, 3);
  portB.b6  = 0;
  portB.b2  = 0;
 }
}

void all_off(){
  portB.b2  = 0;
  portB.b5  = 0;
  portB.b3  = 0;
  portB.b6  = 0;
  portB.b4  = 0;
  portB.b7  = 0;
}
