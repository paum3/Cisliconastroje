

// Open Sound Control
// komunikacny protokol, lepsie MIDI

// pre fungovanie potrebujeme vediet dve veci:
// 1. IP adresa pocitaca
// tu si treba najst v nastaveniach vasho operacneho systemu pocitaca
// mohla by vyzerat nejako takto: 192.168.43.225

// 2. PORT SuperCollideru
// ten zistime jednoducho, spustenim nasledovneho prikazu:
NetAddr.langPort; // 57120 alebo 57120
// pri kazdom starte SC sa moze port lisit.

//////////////////////////////
// pre tych co nemaju wifi a pocitac mate pripojeny kablom na internet
// treba si na mobile zapnut MOBILE HOTSPOT a pripojit pocitac na wifi siet mobilu.
// navodov na to ako sa to robi najdete na internete vela.
// vase PC bude teda zapojene na kabel (ethernet), ktorym ste pripijeny k internetu a zaroven na wifi vasho telefonu
//////////////////////////////



s.boot // shift + enter, start audio servera


(
	// definicia synthu
	SynthDef(\bystrica, { | freq=200  amp=0.5 attack=0.1 release=1| // argunemty
		var sig = Blip.ar(freq,22);
		var env = Env.perc(attack,release).kr(2);
		sig = sig * env * amp;
		sig = Pan2.ar(sig,0);
		Out.ar(0,sig);
	}).add;


	OSCdef(\mobil, {|m|
		if(m[1]==1.0,{
			Synth(\bystrica, [\freq, 100 ]);
			Synth(\bystrica, [\freq, rrand(50,200) ]);
		});
	},'/1/push1');

)

// ANALYZA:


/// SYNTHDEF je definiciou zvuku, teda zvukovej syntezy.
// argumenty su typom premennych, ktore sa daju menit 'zvonku'

// SynthDef(\meno, {| argumenty|  } ).add

(

	SynthDef(\bystrica, {
		|amp=0.3 freq=100 attack=0.1 release=1 numHarm=5| // arg s vychodzymi nastaveniami
		var sig = Blip.ar(freq, numHarm);
		var env = Env.perc(attack,release).kr(2); // obalka
		sig = sig * env * amp;
		sig = sig ! 2; // stereo
		Out.ar(0,sig); // UGEN Out sa postara o to aby siel signal von.
	}).add; // 'add' je dolezite, pridava sa tym konkretny SynthDef do zoznamu pre audio server

)
// SynthDef je len definicia. Pouzie nastava prostrednicvom triedy Synth
Synth(\bystrica)
Synth(\bystrica, [\freq,456] )
Synth(\bystrica, [\freq,60, \amp, 0.5, \numHarm, rrand(1,50)  ] ) // spusti viac krat po sebe
Synth(\bystrica, [\freq, rrand(50,150) ] )
Synth(\bystrica, [\freq,100, \attack, 3 ,\release, 2]  )
Synth(\bystrica, [\freq,100, \attack, 0.05 ,\release, 0.01]  )


// blok, zahra dva tony naraz
(
	Synth(\bystrica, [\freq,100, \attack, 1 ,\release, 2]  );
	Synth(\bystrica, [\freq,200, \attack, 1 ,\release, 2]  );
)

//MIDI 60 je c1
60.midicps// 261.625 ... frekvencia tonu c1, prevedie MIDI hodnotu na frekbvenciu, cycles per second (to iste ako Hz)
61.midicps// c#1
60.5.midicps // quartertone

// male c ( 60 - 12 ).midicps
Synth(\bystrica, [\freq, 48.midicps, \numHarm, 8, \release,3] )


// c dur
(
	Synth(\bystrica, [\freq, 48.midicps, \numHarm, 8, \release,3] );
	Synth(\bystrica, [\freq, 52.midicps, \numHarm, 8, \release,3] );
	Synth(\bystrica, [\freq, 55.midicps, \numHarm, 8, \release,3] );
)

//Array
// hranate zatvorky oznacuju zoznam (pole) prvkov. Array
Array.openHelpFile

a = [1,2,3,4,5,6,7,8,9]
a
a[0] // prvy prvok, 1
a[3] // stvrty prvok, 4

a.scramble // pozri post window
a.mirror
a.reverse
a.choose // vyberie nahodny prvok


~d_dorian = [50,52,53,55,57,59,60,62] // rad tonov, d dorian
~e_dorian = [50,52,53,55,57,59,60,62] + 2

// spusti viac krat
(
	var stupnica = [~d_dorian, ~e_dorian].choose;
	Synth(\bystrica, [\freq, stupnica.midicps.choose, \numHarm, 8,\attack, 4.0.rand + 2, \release,3.0.rand + 3, \amp, 0.1] );
	Synth(\bystrica, [\freq, stupnica.midicps.choose, \numHarm, 8,\attack, 4.0.rand + 2, \release,3.0.rand + 3, \amp, 0.1] );
	Synth(\bystrica, [\freq, stupnica.midicps.choose, \numHarm, 8,\attack, 4.0.rand + 2, \release,3.0.rand + 3, \amp, 0.1] );
)


// to iste jednoduchsie
(
	3.do({
		Synth(\bystrica, [\freq, ~tony.midicps.choose, \numHarm, 8,\attack, 4.0.rand + 2, \release,3.0.rand + 2, \amp, 0.1] );
	})
)


SynthDef.openHelpFile
Synth.openHelpFile





// OSCdef
// -- definicia prijimaca  OSC sprav (messages)
// strukturu
OSCdef(\meno, {
	/*tu je hlavna funckia, ktorej argumetom su prijimane data vo formate Array*/
}, '/path') // 'path' je cesta, pod ktorou sa posielaju data
// v LittleOSC to bolo na kazdy button : '/1/pushX'


// PODMIENKY

ak nieco tak toto
if(true, {\pravda.postln})
if(false, {\pravda.postln},{\NEpravda.postln})

// ak chceme porovnat ci sa nieco rovna niecomu inemu, tak pouzivame DVE ==

if( 1 == 1, { "jedna sa rovna jedna".postln } )

if( 1 == 2, { "jedna sa rovna jedna".postln } ) // nil

/*
LittleOSC apikacia posiela informaciu o tom ci sme button stlacili alebo uvolnili v podobe desatinneho (Float) cisla
1.0 stlacene
0.0 uvolnene

preto v kode nizsie porovnavame ci sa argument == 1.0, lebo chcee vediet ci sa button stlacil

*/


(

	OSCdef(\mobil, { |m| // data v podobe Array [a,b,c,d, ..]
		//m.postln; // mozete si dat vypisat ake data sa sem posielaju cez OSC
		if(m[1]==1.0,{ // ak druhy prvok sa rovna 1.0
			\mam.postln; // tak sprav toto
		})

	},'/1/push1')

)




//LittleOSC
// aktivne vsetky 4 buttony
// stvrty je 'switch'

~switch = 0 // globalna premenna
~f1 = [100,150];

(
	OSCdef(\mobil, {|m|
		if(m[1]==1.0,{
			Synth(\bystrica, [\freq, ~f1[~switch]  ]);
			"Hram prvy".postln;
		});
	},'/1/push1');



	OSCdef(\mobil2, {|m|
		if(m[1]==1.0,{
			Synth(\bystrica, [\freq, 59.5.midicps,\attack, 2, \release, 3]);
			Synth(\bystrica, [\freq, 63.midicps,\attack, 2, \release, 3]);
			Synth(\bystrica, [\freq, (60+7).midicps,\attack, 2, \release, 3]);
			"Hram druhy".postln;
		});
	},'/1/push2');



	OSCdef(\mobil3, {|m|
		if(m[1]==1.0,{
			Synth(\bystrica, [\freq, 200, \numHarm,5 ]);
			"Hram treti".postln;
		});
	},'/1/push3');

	OSCdef(\mobil4, {|m|
		if(m[1]==1.0,{
			~switch = ~switch.asBoolean.not.asInteger; // skuste to desifrovat
		    ("Switch je prepnuty na "++~switch).postln;
		});
	},'/1/push4')


)
