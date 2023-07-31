sbit DIS1 at PORTD.B6;
sbit DIS2 at PORTD.B7;
#define red1 portB.b2
#define red2 portB.b5
#define yellow1 portB.b3
#define yellow2 portB.b6
#define green1  portB.b4
#define green2  portB.b7
#define ma portB.b1

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
          yellow1 = 1;
          for (i = 1; i <= 3; i++)
          {
               PORTC = i;
               delay_ms(1000);
          }
          DIS2 = 0;
          yellow1 = 0;
          green1 = 1;
          red2 = 1;
          for(; ma == 0;){
             if (flag % 2 ==0)
             {
                return;
             }
          }
          all_off();
          yellow2 = 1;
          DIS2 = 1;
          for (i = 1; i <= 3; i++)
          {
               PORTC = i;
               delay_ms(1000);
          }
          DIS2 = 0;
          yellow2 = 0;
          green2 = 1;
          red1 = 1;
          for(; ma == 1;){
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
     
     if (red1){
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
         
         green1 = 1;
         red2 = 1;
         timer(19, 23);
         green1 = 0;
         yellow1 = 1;
         timer(3, 3);
         yellow1 = 0;
         red1 = 1;
         red2 = 0;
         green2 = 1;
         timer(11, 15);
         yellow2 = 1;
         green2 = 0;
         timer(3, 3);
         yellow2 = 0;
         red1 = 0;
     }
}

void all_off(){
 red1 = 0;
 red2 = 0;
 yellow1 = 0;
 yellow2 = 0;
 green1 = 0;
 green2 = 0;
}