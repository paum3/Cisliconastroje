




s.boot // server


~b = Buffer.read(s, "/home/paum/Projekty/Akademia_umeni_BB/Cisliconastroje/29032021/sample/alina.wav");

~b.plot

~b.class
~b.numFrames
~b.numChannels
~b.duration
~b.query













(
SynthDef.new(\sp_mono,{

      arg buf, out = 0, loop = 0, start = 0, len = 1, rate = 1, amp = 1, pan = 0, atk = 0.01, rel = 0.01 ;
      var sig, env;
      start = start * BufFrames.kr(buf);

      len = len * BufFrames.kr(buf) / 44100;
      env = EnvGen.kr( Env( [0,1,1,0], [atk, len ,rel], [3,0,-3] ) , doneAction:2);
      sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate,startPos:start, loop:loop, doneAction:2);

	    sig = sig * env * amp;
	    Out.ar(out, Pan2.ar(sig, pan) );
	}).add;
)



Synth(\sp_mono, [ \buf, ~b ])
Synth(\sp_mono, [ \buf, ~b, \start, 0.5 ])

Synth(\sp_mono, [ \buf, ~b, \start, 0.5, \len, 0.1 ])









/// Phase player

~cas = 0.25;
~pos = 0;
~len = 0.01;
(
	Tdef(\phase, {
		~pos = 0;
		loop{

			Synth(\sp_mono, [ \buf, ~b, \start, ~pos, \len, ~len ]);
			~pos = ~pos + 0.005;
			~cas.wait;
		}
	}).play

)

	Tdef(\phase).stop;
