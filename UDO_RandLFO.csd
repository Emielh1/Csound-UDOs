opcode RandLFO, a, kk

;Pseudo-random LFO.
;varying rate and depth parameters.
       
;***************************
;           INPUTS          
;***************************
;kFL = Flutter. value should be between 2 and 20  
;kDp = Depth.   value should be between 1 and 6
      
kFl, kDp  xin             
aout      init 0                  

;****************************
;           CARRIER          
;****************************
;    Random |min| |max| |cps|  
kR1  randomh .1,   kFl,    5 
;    LFO    |amp| |cps| |sqr|
kL1  lfo     .5,   kR1,   2 
;    Port   |sig| |amt|
kP1  portk   kL1, .075
;    Upsamp |sig|
aL1  upsamp  kP1

;****************************
;          MODULATOR          
;****************************
;    Random |min| |max| |cps|
kR2  randomh  0,    1,    5
;    Port   |sig| |amt|
kP2  portk   kR2,  .05
;    Upsamp |sig|
aL2  upsamp  kP2

;combining LFOs, positive signal only, multiplied by depth-variable
aLFO =      ((aL1 + aL2) + 0.5) * kDp 
kLFO portk  k(aLFO), 0.01
aLFO upsamp kLFO

     xout   aLFO    

endop