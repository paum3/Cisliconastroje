

// Open Sound Control

// IP adresa pocitaca
// tu si treba najst v systeme
192.168.43.225
// PORT supercollideru
NetAddr.langPort; // 57120 alebo 57120

//// pre Mariana a tych co nemaju wifi
- pocitac je pripojeny kablom na internet
potrebujete ->  wifi (mobile) hotspot
napijit pocitac so SC na wifi siet telefonu ->
//////////////////////////////



s.boot


(
	SynthDef(\bystrica, { | freq=200  amp=0.5 attack=0.1 release=1|
		var sig = Blip.ar(freq,22);
		var env = Env.perc(attack,release).kr(2);
		sig = sig * env * amp;
		sig = Pan2.ar(sig,0);
		Out.ar(0,sig);
	}).add;


	OSCdef(\mobil, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, 100 ]);
			Synth(\bystrica, [\freq, rrand(50,200) ]);
		});
	},'/1/push1');


	OSCdef(\mobil2, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, 200 ]);
		});
	},'/1/push2');

	OSCdef(\mobil3, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, 200 ]);
		});
	},'/1/push3')


)

// OSCdef

OSCdef(\meno, {}, '/informacia_ako_sa_vola_gombik')

/// SYNTHDEF

SynthDef(\meno, {| argumenty|  } ).add

(

	SynthDef(\bystrica, { |amp=0.5 freq=200 attack=0.1 release=1 numHarm=22|
		var sig = Blip.ar(freq, numHarm);
		var env = Env.perc(attack,release).kr(2);
		sig = sig * env * amp;
		sig = sig ! 2;
		Out.ar(0,sig);
	}).add;

)

Synth(\bystrica)
Synth(\bystrica, [\freq,456  ] )
Synth(\bystrica, [\freq,60, \amp, 0.5, \numHarm, rrand(1,50)  ] )
Synth(\bystrica, [\freq, rrand(50,150) ] )


Synth(\bystrica, [\freq,100, \attack, 0.1 \release, 0.01]  )


(
{
	var sig = SinOsc.ar(20);
	var env = Env.perc.kr(2);
	var sig2 = SinOsc.ar(20 * env);
	[
		sig,
		env,
		sig * env,
		sig2

	]
}.plot(0.8)
)

{ SinOsc.ar(1000 * Env.perc(2,8).kr(2)  ) * 0.75 ! 2 }.play




(

	OSCdef(\mobil, { |m| // data v podobe Array [a,b,c,d]

		m[1].asInteger.postln;

	},'/1/push1')

)





a = [ '/1/push1', 0.0 ]
a[0]
a[1]

12.23.asInteger






(
			Synth(\bystrica, [\freq, rrand(50,200) ]);
			Synth(\bystrica, [\freq, 200 ]);
)




// MIDI to HZ

60 // c1
60.midicps
61 // C#
62 // d






var ..  // lokalne premenne
~switch // globalna premenna

~switch = 0
~f1 = [100,150];
~f1[0]
~f1[1]
~f1[~switch]

~switch

(
	SynthDef(\bystrica, { | freq=200  amp=0.5 attack=0.1 release=1|
		var sig = Blip.ar(freq,22);
		var env = Env.perc(attack,release).kr(2);
		sig = sig * env * amp;
		sig = Pan2.ar(sig,0);
		Out.ar(0,sig);
	}).add;


	OSCdef(\mobil, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, ~f1[~switch]  ]);
		});
	},'/1/push1');





	OSCdef(\mobil2, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, 59.5.midicps ]);
			Synth(\bystrica, [\freq, 63.midicps ]);
			Synth(\bystrica, [\freq, (60 + 7).midicps ]);
		});
	},'/1/push2');




	OSCdef(\mobil3, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			Synth(\bystrica, [\freq, 200 ]);
		});
	},'/1/push3');

	OSCdef(\mobil4, {|m|
		var hodnota_z_mobilu = m[1].asInteger;
		if(hodnota_z_mobilu==1,{
			~switch = ~switch.asBoolean.not.asInteger;
		});
		~switch.postln;
	},'/1/push4')


)
