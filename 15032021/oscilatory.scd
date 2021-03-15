

s.boot


// zakladne zvukove vlny
(
	{
		[
			SinOsc.ar(20),
			LFSaw.ar(20),
			LFTri.ar(20),
			LFPulse.ar(20),
			WhiteNoise.ar
		]
	}.plot(0.8)
)

SinOsc.openHelpFile // precitajte si help, studujte
LFSaw.openHelpFile
LFTri.openHelpFile
LFPulse.openHelpFile
WhiteNoise.openHelpFile


// vplyv zmeny amplitudy na SinOsc
(
	{
		[
			SinOsc.ar(20) * 3 ,
			SinOsc.ar(20) * 1 ,
			SinOsc.ar(20) * 0.8 ,
			SinOsc.ar(20) * 0.5 ,
			SinOsc.ar(20) * 0.1 ,
			SinOsc.ar(20) * 0
		]
	}.plot(0.8)
)

s.scope
// ak je mys prilis vpravo, ide do hodnot vyssych ako 1, co zapricini skereslenie
{SinOsc.ar(800) * MouseX.kr(0,2)}.play


// modulacia frekvencie
{SinOsc.ar( 440 + (LFSaw.kr(0.5) * 20 ) )  * 0.5  ! 2 }.play // mala zmena
// ctrl + .

{SinOsc.ar( 440 + (LFSaw.kr(0.5) * 200) ) * 0.5  ! 2 }.play
// ctrl + .

{SinOsc.ar( 440 + (LFSaw.kr(Line.kr(0.5,4, 4)) * 200) ) * 0.5  ! 2 }.play
// ctrl + .

Line.openHelpFile

{SinOsc.ar( 440 + (LFSaw.kr( SinOsc.kr(0.5).range(0.1,18) ) * 200  )  * 0.5  ! 2) }.play
// ctrl + .

{SinOsc.ar( 440 + (LFTri.kr(0.5) * 400) )  * 0.5  ! 2 }.play
// ctrl + .

// to iste, ale prepisane prehladnejsie
(

		{
			var freq = 440; // slovo 'var' oznacuje ze sa jedna o premmennu
			// premenna (angl. variable) je kusok pamate pocitaca, do ktoreho mozeme nieco ulozit
			// vyhodou je ze si ten kusok pamate mozeme lubovolne pomenovat
			// POZNAMKA: meno premennej sa musi zacinat malym pismenom
			var amp = 0.5;
			var mod = (LFTri.kr(0.5) * 400);
			var sig = SinOsc.ar(440 + mod ) * amp;
			sig ! 2
		}.play
)


// biely sum
{ WhiteNoise.ar * 0.25 ! 2 }.play


//
{SinOsc.ar( LFNoise0.kr(5).range(100,450) )  * 0.5  ! 2 }.play
// skuste zistit co sa tam deje..



// Obalky / Envelopes

Env.openHelpFile

(
	{
		var sig = SinOsc.ar(20);
		var env = Env.perc.kr(2);
		var sig2 = SinOsc.ar(20 * env);
		[
			sig, // sinus
			env, // obalka
			sig * env, // sinus * obalka
			sig2 // obalka aplikovana na frekvenciu

		]
	}.plot(0.8)
)

{ SinOsc.ar(1000 * Env.perc(2,8).kr(2)  ) * 0.75 ! 2 }.play

