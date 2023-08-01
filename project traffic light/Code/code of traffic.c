char x,indicator = 1 , i = 0 ,
terms[] = {0x23,0x22,0x21,0x20,0x19,0x18,0x17,0x16,0x15,0x14,0x13,0x12,0x11,0x10,9,8,7,6,5,4,3,2,1};// for 7 seg. display
void intone() // to use for manual mode in first
{
  portc.B5 = 1;  // green 1 on
  portc.b0 = 1; // red 1 on
}
void intsec() // to use for manual mode in sec
{
  portc.B4 = 1; // yellow 2 on
  portc.b5 = 0; // grren 2  off
  delay_ms(3000); // delay by 3 sec
  portc.b4 = 0;  // yellow 2 off
  portc.B3 = 1;  // red 2  on
  portc.b0 = 0; // red 1 off
  portc.b2 = 1; // green 1 on
}
void actint()
{
 porta = 0; // 7 seg. dispaly off
 while(!portb.b1)  intone();
  indicator = 1;
while(portb.b0)
     {
      while(portb.b1 && portb.b0)
     if( indicator == 1)
             {
             intsec();
             indicator = 2;
             }
      while(!portb.b1 && portb.b0)
     if( indicator == 2 )
     {
      portc.b2 = 0;portc.b1 = 1;
      delay_ms(3000);
      portc.b1 = 0;
      portc.b3 = 0;
      intone();
      indicator = 1;
     }
      }
     portc = 0;
     porta = 15 ;
}
void checkandint()
{
     for(i = 0 ; i < 5 ; i++)
               {
               delay_ms(200);
               if(portb.b0 == 1)
                           {
                           actint();
                           return;
                           }
               }
}
void one()
{
   for(x = 0; x < 23 ; x++)
         { portd = terms[x];
          if(x < 19)
          {
           portc.B5 = 1;
           portc.b0 = 1;
          }
          if(x >= 19)
          {
           portc.B5 = 0;
           portc.b4 = 1;
          }
          checkandint();
         }
}
void second ()
{
     for(x = 0 ; x <15 ; x++ )
     {  portd = terms[x  + 8];
        if(x < 3)
        {
        portc.B1 = 1;
        portc.b3 = 1;
        }
        if(x >= 3)
        {
        portc.B1 = 0;
        portc.b2 = 1;
        }
        checkandint();
     }
}
void operation()
{
      one();
      portc.b0 = 0;
      portc.b4 = 0;
      portc.b5 = 0;
      second();
      portc.b3 = 0;
      portc.b2 = 0;
      portc.b1 = 0;
}
void main() {
        
        ADCON0 = 1;
        trisc = 0;
        portc = 0;
        trisd = 0;
        portd = 0;
        trisa = 0;
        porta = 15;
        trisb = 2;
     while(1)
     {
     operation();
     }
}