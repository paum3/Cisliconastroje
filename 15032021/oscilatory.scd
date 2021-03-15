

s.boot



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

[
	4,
	54,
	6,
	7,
	87
]

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

{SinOsc.ar(800) * MouseX.kr(0,2)}.play


{SinOsc.ar( 440 + (LFSaw.kr(0.5) * 200  )  * 0.5  ! 2) }.play


{SinOsc.ar( 440 + (LFTri.kr(0.5) * 200  )  * 0.5  ! 2) }.play

// to iste
(

		{
			var freq = 440;
			var amp = 0.5;
			var mod = LFTri.kr(0.5) * 200;
			var sig = SinOsc.ar(freq + mod) * amp;
			sig
		}.play


)


// biely sum

{ WhiteNoise.ar * 0.25 ! 2 }.play










