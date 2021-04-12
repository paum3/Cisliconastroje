
/*

	12. april 2021

*/

s.boot;

s.meter

(
SynthDef(\fm, {
    arg freq=500, mRatio=1, cRatio=1, index=1,
    amp=0.2, atk=0.01, rel=3, pan=0;
    var car, mod, env;
    env = EnvGen.kr(Env.perc(atk,rel),doneAction:2);
    mod = SinOsc.ar(freq * mRatio, mul:freq * mRatio * index);
    car = SinOsc.ar(freq * cRatio + mod) * env * amp;
    car = Pan2.ar(car, pan);
    Out.ar(0, car);
}).add;
)

		Synth(\fm,  [ \freq, 60.midicps, \atk, 5, \rel, 4.5 ]);
		Synth(\fm,  [ \freq, 60.midicps, \pan, 1.0.rand2 ]);
		// pan < -1, 1 >


(

	fork{

		Synth(\fm,  [ \freq, 60.midicps ]);
		1.wait;

		Synth(\fm, [\freq, 62.midicps]);

		2.wait;
		Synth(\fm, [\freq, 64.midicps]);
		Synth(\fm, [\freq, 66.midicps]);

	}

)
