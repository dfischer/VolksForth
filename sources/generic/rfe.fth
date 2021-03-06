
\ *** Block No. 0, Hexblock 0

\ Retro Forth Editor

a simple forth-style editor

use filename.fb                       :: open forth block file
block# list                           :: list block
v                                     :: view current block
x                                     :: clear/zero block
line# i text                          :: insert text at line
line# d                               :: delete line
n                                    :: load next block
p                                    :: load previous block
block# s                             :: load block
e                                    :: evaluate/load block



\ *** Block No. 1, Hexblock 1

\ RetroForth Editor for VolksForth 1/2                19july2020

16 constant l/b

: (block) scr @ block ;  : (line) c/l * (block) + ;
: row dup c/l -trailing type c/l + cr ;
: .rows l/s 0 do i 2 u.r space row loop ;
: .block ." BLOCK: " scr @ . space ;
: +--- ." +---" ;  : :--- ." :---" ;
: x--- +--- :--- +--- :--- ;
: --- space space space x--- x--- x--- x--- cr ;
: vb --- scr @ block .rows drop --- ;
: .stack ." Stack: " .s ;
: status .block .stack ;
: v cr vb status ;
-->

\ *** Block No. 2, Hexblock 2

\ RetroForth Editor for VolksForth 2/2

: v* update v ;
: s dup scr ! block drop v ;
: ia (line) + >r 10 parse r> swap move v* ;
: i 0 swap ia ;
: d (line) c/l bl fill v* ;
: x (block) l/b c/l * bl fill v* ;
: p -1 scr +! v ;
: n 1 scr +! v ;
: e scr @ load ;



.( Retro Forth Editor loaded )


\ *** Block No. 3, Hexblock 3

         : x (block) l/b c/l * bl fill v* ;
         : p -1 scr +! v ;
         : n 1 scr +! v ;
         : e scr @ load ;

         .( RetroForth Editor loaded )




