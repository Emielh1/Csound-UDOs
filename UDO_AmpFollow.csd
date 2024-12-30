opcode AmpFollow, a, akk
;Amplitude-tracking envelope.
;variable amount and threshold.

;***************************
;           INPUTS          
;***************************
;aSg = Incoming audio signal
;kAm = Envelope strength. value between 1 and 5
;kTr = Threshold. Envelope cutoff. range: 0.1 - 0.9
aSg, kAm, kTr    xin 
aOut             init 0 

;      follow    |sig| |time|
aSg    follow     aSg,  .001
;      downsamp  |sig|
kSg    downsamp   aSg
;      portk     |sig| |time|
kSg    portk      kSg,  .001
;      scaling   |amt|
kSg    *=         kAm

;***************************
;        CONDITIONS          
;***************************

if     kSg >= 1   then
       kSg =  1
endif

if     kSg <= kTr then
       kSg =  0
endif

;***************************
;         STAGING          
;***************************
;   portk  |sig| |amt|
kSg portk   kSg,  .05
;   upsamp |sig|
aSg upsamp  kSg

    xout aSg


endop