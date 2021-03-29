(


  /*
Retrieved from: http://sccode.org/1-522
FM Rhodes Synthesizer
by Nathan Ho (snappizz)
Native SuperCollider port of STK's Rhodey. This should be preferred over the StkInst version because:
- It uses much less CPU.
- It is easier to modify.
- It doesn't require sc3-plugins or a correct setting of StkGlobals.
- It's beginner-friendly because it uses only basic UGens: SinOsc, EnvGen, Mix, Pan2, Out.
Modified by Josh Mitchell and Bruno Ruviaro in July 2019.
*/

SynthDef(\FMRhodes1, {
    arg
    // standard meanings
    out = 0, freq = 440, gate = 1, pan = 0, amp = 0.1, att = 0.001, rel = 1, lfoSpeed = 4.8, inputLevel = 0.2,
    // all of these range from 0 to 1
    modIndex = 0.2, mix = 0.2, lfoDepth = 0.1;

    var env1, env2, env3, env4;
    var osc1, osc2, osc3, osc4, snd;

    env1 = Env.perc(att, rel * 1.25, inputLevel, curve: \lin).kr;
    env2 = Env.perc(att, rel, inputLevel, curve: \lin).kr;
    env3 = Env.perc(att, rel * 1.5, inputLevel, curve: \lin).kr;
    env4 = Env.perc(att, rel * 1.5, inputLevel, curve: \lin).kr;

    osc4 = SinOsc.ar(freq) * 6.7341546494171 * modIndex * env4;
    osc3 = SinOsc.ar(freq * 2, osc4) * env3;
    osc2 = SinOsc.ar(freq * 30) * 0.683729941 * env2;
    osc1 = SinOsc.ar(freq * 2, osc2) * env1;
    snd = Mix((osc3 * (1 - mix)) + (osc1 * mix));
  	snd = snd * (SinOsc.ar(lfoSpeed).range((1 - lfoDepth), 1));

    snd = snd * Env.asr(0, 1, 0.1).kr(gate: gate, doneAction: 2);
    snd = Pan2.ar(snd, pan, amp);

    Out.ar(out, snd);
},
metadata: (
	credit: "Nathan Ho",
	category: \keyboards,
	tags: [\pitched, \piano, \fm]
)
).add;

SynthDef("harpsichord1", { arg out = 0, freq = 440, amp = 0.1, pan = 0;
    var env, snd;
	env = Env.perc(level: amp).kr(doneAction: 2);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "unknown",
	category: \keyboards,
	tags: [\pitched, \harpsichord]
)
).add;



/* Retrieved from
http://sccode.org/1-5aD
Additive tonewheel organ with low CPU usage.
Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("organTonewheel0", {

	arg
    // Standard Values
	out = 0, freq = 440, amp = 0.7, att = 0.001, rel = 0.01, pan = 0, crv = -4, gate = 1,
	//organ voices (drawbars) amplitudes
	bass = 1, quint = 1, fundamental = 1, oct = 1, nazard = 1, blockFlute = 1, tierce = 1,
	larigot = 1, sifflute = 1,
	 //vibrato arguments
    vrate = 3, vdepth = 0.008;

	var snd, env, vibrato;

	vibrato = SinOsc.kr(vrate).range((1 / (1 + vdepth)), (1 + vdepth));

	env = Env.asr(
		attackTime: att,
		sustainLevel: amp,
		releaseTime: rel,
		curve: crv).ar(gate: gate);

	vibrato = DynKlang.ar(
		specificationsArrayRef: Ref.new([
			[1/12,  1/7, 1, 12, 19, 24, 28, 31, 36].midiratio,
			[bass, quint, fundamental, oct, nazard, blockFlute, tierce, larigot, sifflute].normalizeSum
		      ]),
		freqscale: vibrato * freq);

	// Output Stuff
	snd = vibrato * env;
	snd = Mix.ar(snd);
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Zé Craum",
	category: \organ,
	tags: [\pitched]
	)
).add;



/* Retrieved from
http://sccode.org/1-5aD
Glockenspiel, xylophone, and tubularBell are all based on a very similar structure.
By nicolaariutti and edited by Zé Craum
http://sccode.org/1-5ay#c835
Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\tubularBell, {
	arg freq = 440, amp = 0.1, pan = 0, out = 0, att = 0.005, rel = 9, exciterRel = 0.05;

	var env, snd, exciter;

	env = Env.perc(att, exciterRel, 0.05).kr;

	exciter = GrayNoise.ar(env);

	snd = DynKlank.ar(
		specificationsArrayRef:
	        	Ref.new([
	        		[1.013, 1.512, 2.113, 2.525, 3.35, 4.57, 6.48],   // harmonics
			        [1, 0.78, 0.89, 0.63, 0.31, 0.56, 0.25], // amplitudes
		        	[1, 0.9, 0.8, 0.65, 0.45, 0.3, 0.1]     // ring times
		        ]),
		input: exciter,
		freqscale: freq,
		decayscale: rel
	);

	snd = LPF.ar(snd, freq * 9.5);

	DetectSilence.ar(
		        in: snd,
		        amp: 0.001,
		        time: 0.5,
		        doneAction: 2
		    );

	Out.ar(out, Pan2.ar(snd, pan, amp));
},
metadata: (
	credit: "nicolaariutti, Zé Craum, Josh Mitchell",
	category: \bells,
	tags: [\pitched, \tubular, \bell]
	)
).add;

/* Retrieved from
http://sccode.org/1-5aD
Original by Zé Craum
Crude simulation of old sinusoidal generators - with random vibrato and a high noise floor.
50hz mains hum emulation and slightly distorted sine (a clipped triangle wave) added by Josh Mitchell.
Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\vintageSine, {
	arg
	//Standard Definitions
	amp = 0.2, freq = 440, pan = 0, att = 0.001, sus = 1, rel = 0.5, gate = 1, out = 0,
	//Noise Arguments (mainsDepth is 0 to 1)
	noiseAmp = 0.06, mainsDepth = 0.1, mainsHz = 50,
	//Sine Arguments
	vrate = 2, vdepth = 0.005, sineClip = 0.825;

	var noise, env, snd, vibrato;

	env = Env.asr(att, amp, rel, curve: \lin).kr(gate: gate, doneAction: 2);

	noise = PinkNoise.ar(noiseAmp * LFPar.ar(mainsHz * 2).range((1 - mainsDepth), 1));
	noise = noise + LFPar.ar(freq: mainsHz, mul: noiseAmp/8);

	vibrato = freq * LFNoise2.ar(vrate).range(1/(1 + vdepth), (1 + vdepth));

	snd = Clip.ar(LFTri.ar(vibrato), -1 * sineClip, sineClip).softclip;
	snd = ((snd * amp) + noise) * env;
	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Zé Craum; Josh Mitchell",
	category: \misc,
	tags: [\vintage, \pitched]
	)
).add;


SynthDef("blip1", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0;
	var snd, env;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = Blip.ar(
		freq: freq * [1, 1.01],
		numharm: numharm,
		mul: env
	);
	snd = LeakDC.ar(snd);
	snd = Mix.ar(snd);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
},

metadata: (
	credit: "unknown",
	category: \pads,
	tags: [\pitched]
)
).add;

/*
A SynthDef by Bruno Ruviaro built around beats, an acoustic phenomenon created when
two oscillators at slightly different frequencies are combined. We hear the beating
frequency as the difference between these two frequencies.
For example, 455hz - 440hz = 15 beats per second.
Slightly modified by Josh Mitchell 8/19.
*/

SynthDef("beating", {
	arg freq = 440, amp = 0.1, out = 0, pan = 0, att = 0.01, dec = 1, curve = -4, beatFreq = 15;

	var env, snd, oscillator1, oscillator2;

	env = Env.perc(att, dec, amp, curve).kr(doneAction: 2);

	oscillator1 = SinOsc.ar(freq); //Try other waveforms for the oscillators! Mix and match, collect them all!
	oscillator2 = SinOsc.ar(Line.kr(freq + beatFreq, freq, dec));

	snd = Mix([oscillator1, oscillator2]);
	snd = snd * env;

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Bruno Ruviaro",
	category: \misc,
	tags: [\pitched]
	)
).add
)



a = Synth(\FMRhodes1, [\freq, 200])
a.free

(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \FMRhodes1,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) / 2,
		\degree, Pseq([0,1,2,3,4,5,6,7],inf) ,
		\scale, Pfunc({ ~a })
	).play
)

	Pbindef(\test).stop
(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \harpsichord1,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) / 2,
		\degree, Pseq([0,1,2,3,4,5,6,7],inf) ,
		\scale, Pfunc({ ~a })
	).play
)

	Pbindef(\test).stop

(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \organTonewheel0,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) / 2,
		\degree, Prand([2,5,7],inf),
		\scale, Pfunc({ ~a })
	).play
)


	Pbindef(\test).stop


(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \tubularBell,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) * 2,
		\degree, Pseq([0,1,2,3,4,5,6,7],inf) ,
		\scale, Pfunc({ ~a })
	).play
)


(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \vintageSine,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) * 2,
		\degree, Pseq([0,1,2,3,4,5,6,7],inf) ,
		\scale, Pfunc({ ~a })
	).play
)

(
	~a = Scale.minor;
	Pbindef(\test,
		\instrument, \blip1,
		\dur, Pseq([Pn(0.5,8), Pn(0.25,8)], inf) / 4,
		\degree, Pseq([0,1,2,3,4,5,6,7],inf)  ,
		\scale, Pfunc({ ~a })
	).play
)


s.defaultGroup.release
