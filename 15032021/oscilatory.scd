

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
{SinOsc.ar( 440 + (LFSaw.kr(0.5) * 20  )  * 0.5  ! 2) }.play // mala zmena
// ctrl + .
{SinOsc.ar( 440 + (LFSaw.kr(0.5) * 200  )  * 0.5  ! 2) }.play
// ctrl + .
{SinOsc.ar( 440 + (LFSaw.kr( SinOsc.kr(0.5).range(0.1,18) ) * 200  )  * 0.5  ! 2) }.play
// ctrl + .
{SinOsc.ar( 440 + (LFTri.kr(0.5) * 400  )  * 0.5  ! 2) }.play
// ctrl + .

// to iste
(

		{
			var freq = 440;
			var amp = 0.5;
			var mod = LFTri.kr(0.5) * 400;
			var sig = SinOsc.ar(freq + mod) * amp;
			sig ! 2
		}.play


)


// biely sum

{ WhiteNoise.ar * 0.25 ! 2 }.play










