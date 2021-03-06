\ *** Block No. 0 Hexblock 0 
\\                    *** Multitasker ***             bp 12oct86
                                                                
Dieses File enth�lt die Worte f�r das Multitasking.             
                                                                
Mit  TASK  werden Tasks eingerichtet. Jede Task hat ihren eige- 
 nen Daten- und Returnstack, deren Gr��e beim Einrichten der    
 Task angegeben werden mu�.                                     
                                                                
Mit  MULTITASK  wird der Tasker eingeschaltet, mit  SINGLETASK  
 abgeschaltet. Mit  TASKS  kann man die Tasks im System und     
 ihren Zustand anzeigen.                                        
                                                                
N�heres zur Funktionsweise des Taskers findet man im Handbuch,  
 ebenso wie ein ausf�hrliches Glossar !                         
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Multitasker Loadscreen                               22nov86bp
                                                                
Onlyforth                                                       
                                                                
\needs Code        2 loadfrom assemble.scr                      
\needs multitask   1 +load                                      
                                                                
02 05 +thru    \ Tasker                                         
   06 +load    \ Spooler                                        
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ stop singletask multitask                            14sep86we
                                                                
Code stop                                                       
  .l FP IP suba   .w IP SP -) move                              
  .l FP RP suba   .w RP SP -) move                              
     UP R#) D6 move   D6 reg) A0 lea                            
  .l FP SP suba   .w SP 8 A0 D) move                            
     2 A0 D) D6 move  D6 reg) jmp  end-code                     
                                                                
Label taskpause                                                 
    UP R#) D6 move   D6 reg) A0 lea   $4E43 # A0 ) move         
    Forth ' stop @ Assembler bra  end-code                      
                                                                
: singletask   [ ' pause @ ] Literal  ['] pause ! ;             
                                                                
: multitask    taskpause  ['] pause ! ;                         
\ *** Block No. 3 Hexblock 3 
\ pass activate                                       bp 12oct86
                                                                
| : (pass   ( n0 ... nm-1 Taskaddr m -- )                       
   rdrop  swap            \ delete IP of ACTIVATE or PASS       
   $4E43 over !           \ awake Task                          
   r> -rot                \ get the IP;  Stack: IP m Taskaddr   
   &10 + >r               \ push s0 of Task                     
   r@ 2+ @ swap           \ Stack-Top:  IP r0 m                 
   2+ 2*                  \ bytes on Taskstack incl. r0 & IP    
   r@ @ over -            \ new SP                              
   dup r> 2- !            \ into Ssave                          
   swap bounds  ?DO  I !  2 +LOOP  ;                            
                                                                
: activate   ( Taddr -- )               0 (pass ;  restrict     
                                                                
: pass       ( n0 ... nm-1 Taskaddr m )   (pass ;  restrict     
\ *** Block No. 4 Hexblock 4 
\ sleep wake taskerror                                bp 12oct86
                                                                
: sleep   ( Taddr -- )    $3C3C swap ! ; \ # D6 move opcode     
: wake    ( Taddr -- )    $4E43 swap ! ; \ Trap 3 opcode        
                                                                
| : taskerror   ( string -- )                                   
     standardi/o  singletask  bell                              
     at?  &24 0 at  ." Task error : "  rot count type   at      
     multitask stop ;                                           
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\ Task                                                 14sep86we
                                                                
: Task   ( rlen slen -- )                                       
   2 arguments                                                  
   0 Constant  here >r               \ Task-dp                  
   even dup  r@ +  r@ 2- !  allot  even  \ 68000 align          
   up@ here 100 cmove               \ init user area            
   here   $3C3C , up@ 2+ @ ,        \ JMP opcode to sleep task  
   $4EF3 , $6800 ,                                              
   dup  up@ 2+ !                    \ link task                 
   dup  6 -   dup , ,               \ ssave and s0              
   2dup + ,                         \ here + rlen = r0          
   r@ ,                             \ dp                        
   under  + here - allot  0 ,                                   
   ['] taskerror  swap  [ ' errorhandler >body c@ ] Literal + ! 
   r> 2- 2- , ;                                                 
\ *** Block No. 6 Hexblock 6 
\ rendezvous 's tasks                                  22nov86bp
                                                                
: rendezvous   ( semaphoraddr -- )                              
   dup unlock  pause  lock ;                                    
                                                                
| : statesmart       state @ IF  [compile] Literal  THEN ;      
                                                                
: 's   ( Taddr -- adr )     \ adr is adress of the foll. uservar
   ' >body c@ +  statesmart ;  immediate                        
                                                                
: tasks   ( -- )                                                
   cr  ." Main "    up@ dup 2+ @                                
   BEGIN  2dup -  WHILE cr dup  [ ' r0 >body c@ ] Literal  +  @ 
                        2+ @ >name .name                        
                        dup @  $3C3C = IF  ." sleeping"  THEN   
           2+  @  REPEAT  2drop ;                               
\ *** Block No. 7 Hexblock 7 
\ Printerspool                                         21oct86we
                                                                
$100 $200 Task spooler                                          
                                                                
: spool'  ( -- )   \ reads word                                 
   '  isfile@  offset @  base @   spooler  depth 1-  6 min  pass
   base !  offset !  isfile !  execute                          
   true abort" SPOOL' ready for next job!" stop ;               
                                                                
\\ syntax:                                                      
spool' listing                                                  
spool' printall                                                 
from to spool' pthru                                            
from to spool' document                                         
                                                                
                                                                
