
NetAddr.langPort;
s.boot


(
	SynthDef(\bystrica, { | freq=200  amp=0.5 gate=1 attack=0.1 release=1|
		var sig = Blip.ar(freq,22);
		var env = Env.perc(attack,release).kr(2);
		sig = sig * env;
		sig = Pan2.ar(sig,0);
		Out.ar(0,sig);
	}).add;




	OSCdef(\mobil, {|m|
		var v = m[1].asInteger;
		if(v==1,{
			~a = Synth(\bystrica);
			~a.set(\freq, rrand(50,200))
		});
	},'/1/push1')
)
