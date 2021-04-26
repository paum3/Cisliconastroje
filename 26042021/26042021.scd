





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
    env = EnvGen.kr( Env.asr(atk,1,rel), gate, doneAction:2);
    mod = SinOsc.ar(freq * mRatio , mul:freq * mRatio.lag(10) * index);
    car = (PinkNoise.ar(0.2) + SinOsc.ar(freq * cRatio + mod)) * env * amp;
    car = Pan2.ar(car, pan);
    Out.ar(0, car);
}).add;
)

Synth(\fm_sustained) // ctrl + .  , hard stop
a = Synth(\fm_sustained)
// a.set(\gate,1)

a.set(\freq,500.rand)
a.set(\mRatio,2)
a.set(\rel,10, \cRatio, 5)
a.set(\gate,0)


////////////////////////
a = 8
a + 10
b = [3,4,56,6,7]
c = Synth\dkfkjjglkdfjfgl


(

	fork{
		~dron = Synth(\fm_sustained, [\atk, 10, \rel, 10]);
		5.wait;
			20.do({
				~dron.set(\pan, 1.0.rand2 ); // -1.0 ~ +1.0
				~dron.set(\freq, 500.rand);
				0.5.wait;
			});

		3.wait;
		~dron.set(\gate,0);
	}
)





a = Synth(\fm_sustained, [\freq, 500.rand, \atk, 10.0.rand, \rel,20.0.rand])
b = Synth(\fm_sustained, [\freq, 500.rand, \atk, 10.0.rand, \rel,20.0.rand])
c = Synth(\fm_sustained, [\freq, 500.rand, \atk, 10.0.rand, \rel,20.0.rand])
d = Synth(\fm_sustained, [\freq, 500.rand, \atk, 10.0.rand, \rel,20.0.rand])

a.set(\gate,0)
b.set(\gate,0)
c.set(\gate,0)
d.set(\gate,0)




// MIDI
