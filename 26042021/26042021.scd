





57.midicps // male a

57.midicps / 58.midicps // pomer frekvencii

~pomery = Scale.chromatic.ratios


[1,2,3,4] ++ 5 // [1,2,3,4,5]

~pomery = Scale.chromatic.ratios ++ 2
~pomery // Array

~pomery[0]
~pomery[1]

Array.help

///////////////////////////////
// dva Array

~freq = [200,300,400,500,600,700]
~pauzy = [ 1,2, 3, 4, 5, 0 ] // nula sa nepouzije

~freq.do({ | hodnota index| index.postln      })
~freq.do({ | hodnota index| hodnota.postln    })

~freq.do({ | hodnota|          })

(
	fork{

		~freq.do({
			| frekvencia index|
			  ("Hram "++frekvencia).postln;
			  ("Cakam "++ ~pauzy[index]    ).postln;
				"-----------".postln
		})


	}
)


"Ja sa volam "++" Jozef" // spajanie retzacov





///////////////////////////////////////
//

s.boot



(
SynthDef(\fm, {
    arg freq=500, mRatio=1, cRatio=1, index=1,
    amp=0.2, atk=0.01, rel=3, pan=0;
    var car, mod, env;
    env = EnvGen.kr(Env.perc(atk,rel),doneAction:2);
    mod = SinOsc.ar(freq * mRatio , mul:freq * mRatio * index);
    car = (PinkNoise.ar(0.2) + SinOsc.ar(freq * cRatio + mod)) * env * amp;
    car = Pan2.ar(car, pan);
    Out.ar(0, car);
}).add;
)

Env.perc(0.1 ,2).plot


Synth(\fm)
Synth(\fm, [\rel, 10])


(
SynthDef(\fm_sustained, {
    arg freq=500, mRatio=1, cRatio=1, index=1,
    amp=0.2, atk=0.01, rel=3, pan=0, gate=1;
    var car, mod, env;
    // env = EnvGen.kr(Env.perc(atk,rel),doneAction:2);
    env = EnvGen.kr(Env.asr(atk,1,rel),gate, doneAction:2);
    mod = SinOsc.ar(freq * mRatio , mul:freq * mRatio * index);
    car = (PinkNoise.ar(0.2) + SinOsc.ar(freq * cRatio + mod)) * env * amp;
    car = Pan2.ar(car, pan);
    Out.ar(0, car);
}).add;
)

Synth(\fm_sustained) // ctrl + .


a = Synth(\fm_sustained) // ctrl + .

a.set(\freq,500.rand)
a.set(\mRatio,40.rand)
a.set(\rel,10)
a.set(\gate,0)
