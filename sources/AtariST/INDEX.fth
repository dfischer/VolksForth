\ *** Block No. 0 Hexblock 0 
\\                       *** Index ***                 26may86we
                                                                
Diese File enth�lt nur das Wort  INDEX  , das fr�her zum System-
kern geh�rt hat.  INDEX  arbeitet aber jetzt auch auf Files     
und mu�te deshalb 'nach hinten' verlegt werden.                 
                                                                
    INDEX   ( from to -- )                                      
liest die BLOCKs from bis to einschliesslich und gibt deren     
erste Zeilen aus.  INDEX  kann mit einer beliebigen Taste unter-
brochen und mit ESC oder CTRL-C abgebrochen werden.             
Die ersten Zeilen von Screens enthalten typisch Kommentare, die 
den Inhalt charakterisieren.                                    
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ index findex                                         05dec85we
                                                                
\needs capacity     ' blk/drv Alias capacity                    
                                                                
| : range  ( from to -- to+1 from )                             
     capacity 1- umin   swap   capacity 1- umin                 
     2dup > IF  swap  THEN  1+ swap ;                           
                                                                
: index ( from to --)                                           
   range DO  cr  I 4 .r   I space block  c/l type               
             stop? IF  LEAVE  THEN  LOOP ;                      
                                                                
                                                                
                                                                
                                                                
                                                                
