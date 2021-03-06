\ *** Block No. 0 Hexblock 0 
\\ documentation for dargon demo                    tcas20130106
start the dragon with : <pos int> DRAG                          
              or with : <1 or -1> <pos int> DRAGON              
                                                                
DRAG clears the screen, defines the starting point and executes 
DRAGON.                                                         
The variable STEPSIZE defines the size of steps between 1 and 3 
(larger values will produce grabage)                            
                                                                
odd numbers as input values do not work                         
                                                                
DDEMO is a loop executing the DRAGON demo which can be stopped  
with a keypress once the 2nd dragon is fully painted (it is     
recommended to press a key a little in advance)                 
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ dragon-loadscreen                                  cas20130106
                                                                
Onlyforth                                                       
                                                                
\needs Graphics    include line_a.fb                            
                                                                
Onlyforth    GEM also    Graphics also                          
                                                                
decimal                                                         
                                                                
1 5 +thru                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ dragon s.2                                           03oct86we
                                                                
Variable angle                                                  
Variable stepsize      1 stepsize !                             
Variable color         1 color !                                
Variable xcood         Variable ycood                           
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\ set_pixel                                            03oct86we
                                                                
Label ?step                                                     
   stepsize pcrel) D2 move  D1 tst  0<> IF  D2 neg  THEN  rts   
                                                                
Code set_pixel                                                  
   xcood pcrel) D3 move   ycood pcrel) D4 move                  
   angle pcrel) D0 move   1 # D0 asr   D0 D1 move   1 D0 andi   
   1 # D1 asr   1 D1 andi                                       
   D0 tst  0=  IF ?step bsr  D2 D3 add   D3 xcood R#) move THEN 
   D0 tst  0<> IF ?step bsr  D2 D4 add   D4 ycood R#) move THEN 
   D3 SP -) move   D4 SP -) move   color pcrel) SP -) move      
   ;c: put_pixel ;                                              
                                                                
                                                                
                                                                
\ *** Block No. 4 Hexblock 4 
\ dragon s.3                                           03oct86we
                                                                
Code turn   ( n -- )                                            
   angle pcrel) D0 move   SP )+ D0 add   D0 angle R#) move      
   Next end-code                                                
                                                                
: dragon  recursive   ( stepw rec_tiefe -- )                    
   dup 0= IF    2drop   set_pixel                               
          ELSE                                                  
           over  turn                                           
            1  over 1-   dragon                                 
           over  2* negate  turn                                
           -1  over 1-   dragon                                 
           drop  turn                                           
         THEN ;                                                 
                                                                
\ *** Block No. 5 Hexblock 5 
\ dragon s.4                                           03oct86we
                                                                
: drachen                                                       
   2 stepsize !                                                 
   100 xcood !  200 ycood !  1 14 dragon                        
   101 xcood !  200 ycood !  1 14 dragon                        
   100 xcood !  201 ycood !  1 14 dragon                        
   101 xcood !  201 ycood !  1 14 dragon                        
   1 stepsize ! ;                                               
                                                                
: schubs                                                        
     100 0 DO   I  112 over -  400 272  2over >r 1+ r> 1-       
                scr>scr   LOOP ;                                
                                                                
                                                                
                                                                
\ *** Block No. 6 Hexblock 6 
\ dragon s.5                                           03oct86we
                                                                
: drag   ( n -- )          page                                 
   angle off  100 xcood !  200 ycood !                          
   1 swap dragon ;                                              
                                                                
: ddemo                                                         
    16 drag   schubs                                            
    0 color !  199 xcood !  100 ycood !  1 16 dragon            
    1 color !  drachen  ;                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 7 Hexblock 7 
\                                                      03oct86we
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
