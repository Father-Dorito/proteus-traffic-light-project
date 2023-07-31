sbit red1 at PORTB.B1;
sbit yellow1 at PORTB.B2;
sbit green1 at PORTB.B3;
sbit red2 at PORTB.B4;
sbit yellow2 at PORTB.B5;
sbit green2 at PORTB.B6;



void main3(){

     TRISB = 0;
     portb = 0;

     while (1){
           green1 = 1;
           red2 = 1;
           delay_ms(20000);
           green1 = 0;
           yellow1 = 1;
           delay_ms(3000);
           yellow1 = 0;
           red1 = 1;
           red2 = 0;
           green2 = 1;
           delay_ms(12000);
           yellow2 = 1;
           green2 = 0;
           delay_ms(3000);
           yellow2 = 0;
           red1 = 0;
     }
}