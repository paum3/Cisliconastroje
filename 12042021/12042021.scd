
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
    mod = SinOsc.ar(freq * mRatio , mul:freq * mRatio * index);
    car = (PinkNoise.ar(0.2) + SinOsc.ar(freq * cRatio + mod)) * env * amp;
    car = Pan2.ar(car, pan);
    Out.ar(0, car);
}).add;
)

		Synth(\fm,  [ \freq, 60.midicps, \atk, 5, \rel, 4.5 ]);
		Synth(\fm,  [ \freq, 60.midicps, \pan, 1.0.rand2 ]);
		// pan < -1, 1 >

		Synth(\fm,  [ \freq, 60.midicps, \pan, 1.0.rand2, \mRatio, 3, \cRatio, 10, \index, 10.rand ]);










				Synth(\fm,  [ freq: 60.midicps, atk: 0.01, rel: 0.1, mRatio: 3.12.rand ]);
				Synth(\fm,  [ \freq, 60.midicps,\atk, 0.01, \rel, 0.1, \mRatio, 3.12.rand ]);

~c = 60.midicps;

~d = Scale.major
~d.degrees
~d.ratios
~pomery = [ 1.0, 1.1224620483089, 1.2599210498937, 1.3348398541685, 1.4983070768743, 1.6817928305039, 1.8877486253586,2, 1.1224620483089*2 ]

~pomery[8]


~pii = [3,1,4,5,9,2,6,5,3,5,8,9,8]
~pii.class

3*60+14  / ~pii.size

~pii.size



~pii.do({ arg i; ~pomery[i-1].postln    })

(
	fork{
		[3,1,4,5,9,2,6,5,3,5,8,9,8].do({ arg i;
				Synth(\fm,  [ \freq, ~pomery[i-1] * 60.midicps,\atk, 0.01, \rel, 5, \mRatio, 3.12.rand ]);
				(3*60+12/~pii.size).wait;
		});
	}
)




(

	fork{


		[3,1,4,5,9,2,6,5,3,5,8,9,8].do({ arg i, index;
				Synth(\fm,  [ \freq, ~pomery[i-1] * 60.midicps,\atk, 0.01, \rel, 0.1, \mRatio, 3.12.rand ]);
				index.postln;
				0.25.wait;
		});

		fork{
			4.do({
				Synth(\fm,  [ \freq, ~c,\atk, 0.01, \rel, 0.1, \mRatio, 3.12.rand ]);
				(0.25 + 0.1.rand  ).wait;
			});
		};

	    // 0.5.wait;

		Synth(\fm, [\freq, 62.midicps]);

		2.wait;
		Synth(\fm, [\freq, 64.midicps, \atk, 4.0.rand]);
		Synth(\fm, [\freq, 66.midicps, \atk, 5.0.rand]);

	}

)




5.rand // 0, 1 ,2, 3, 4
5.0.rand // 0 - 4.999999999999999999999





[1,2,3,4,5]
(1..500).do({   \ahoj.postln;     })
(500..1000).do({ arg i, index;  index.post;": ".post; i.postln;       })


~pii.do({ arg i; ~pomery[i-1].postln;    })













true
false

true.if({ \pravda.postln })
false.if({ \pravda.postln }, { \nepravda.postln;})

~pomery = [ 1.0, 1.1224620483089, 1.2599210498937, 1.3348398541685, 1.4983070768743, 1.6817928305039, 1.8877486253586,2, 1.1224620483089*2 ]
~harmonia = ~pomery.scramble

(

	~hraj = true;
	fork{


		[3,1,4,5,9,2,6,5,3,5,8,9,8].do({ arg i, index;
				Synth(\fm,  [ \freq, ~pomery[i-1] * 60.midicps,\atk, 0.1, \rel, 1.2, \mRatio, 4]);
				Synth(\fm,  [ \freq, (~harmonia[i-1] * 60.midicps) / 2,\atk, 0.1, \rel, 1.2, \mRatio, 1]);

				// ~hraj.if({
				// 	Synth(\fm,  [ \freq, 60.midicps,\atk, 0.1, \rel, 1.2, \mRatio, 2]); // kazdy druhy krat
				// 	~hraj = false;
				// },{
				// 	Synth(\fm,  [ \freq, 67.midicps,\atk, 0.1, \rel, 1.2, \mRatio, 2]); // kazdy druhy krat
				// 	~hraj = true;
				// });
				index.postln;
				0.5.wait;
		});


	}

)
