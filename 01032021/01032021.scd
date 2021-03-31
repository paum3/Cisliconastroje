//////////////////////////////////////////////////
///////////// 1 //////////////////////////////////
//////////////////////////////////////////////////




// SuperCollider je objektovo orientovany jazyk pre zvukovy syntezu, hudobnu kompoziciu,  experimentovanie so zvukom, vytvaranie novych nastrojov, grafiku, networking  a tak dalej

// Ma velmi dobru dokumentaciu, takze sa da najst podrobny popis jeho funkcii priamo v SCIDE alebo na webe


// Jednotlive prikazy sa spustaju kombinaciou klaves:
//             SHIFT + ENTER (jeden riadok),
//             alebo
//             CTRL + ENTER (blok kodu)
// ako vyzera blok kodu si ukazeme neskor
// za takymito dvoma lomitkami je tzv. komentar, to je text ktory sluzi na poznamkovanie kodu

/*

	viacriadkovy komentar ma na zaciatku lomitko a hviezdicku
	a na konci to iste v opacnom poradi

*/



// vzdy ked spustime kod, do POST WINDOW sa vypise hlaska, ak je tam ERROR, chybicka se vloudila, nastasite sa to da opravit
// vykona sa len to co spustime




// tak ako v inych progamovacich jazykoch, poradie cisel sa zacina 0


// jednotlive prikazy su od seba oddelene dvojbodkou;

"aaa ".post; "bbb ".postln;


"aaa ".post "bbb ".postln; // ERROR




//////////////////////////////////////
// Cisla            Cele cisla (Integers) a desatinne (Floats)
//////////////////////////////////////

1
20.546
pi

3 + 6 // shift + enter, jednoduchá kalkulačka

2 * 5 // čo robí hviezdička ? '*'

10 / 2 //  a lomítko ?

2.sqrt // odmocnina z 2, square root
// bondka za dvojkou a nasledne slovo 'sqrt' je priklad objektovho pisania. V tomto pripade je objektom dvojka, s ktorou sa vykona operacia, (tzv. message), ktora je s objektom spojena znakom 'bodka'

2.sqrt.log.cubed // odmocnina z 2 a nasledne jej logaritmus na tretiu

2.magic // ERROR ... nevie co je magic

2 + (2 * 3)
2 + 2 * 3 // na zatvorkach zalezi

// Cislo je len cislo, zavisi na co ho pouzijeme. Moze to byt freqvencia, hlasitost, farba, cokolvek..
SimpleNumber.help



//////////////////////////////////////
// Polia                    Collections, Arrays, Lists, Dictionries
//////////////////////////////////////

[ 1, 2, 3]
[ 1, 2, 3].class
[ 1, 2, 3].at(2)
[ 1, 2, 3].size
[ 1, 2, 3] + 3.2

a = [6,7,8,9]
a
a.class
a.at(0)
a[0] //6
a[3].postln
a.size

a.do({ |i| (i + 2).postln })



//////////////////////////////////////
// Retazce znakov = slova, vety. Musia byt v dvojitych uvodzovkach               String
//////////////////////////////////////

String.help

"supercollider".class
String.help
"supercollider".scramble // vyskusajte spustit viac krat po sebe ...

// blok kodu je uzavrety v okruhlych zatvorkach:
(
	"prvy riadok".postln; // skuste vymazat bodkociarku
	"druhy riadok".postln;
	" a posledny, ktory vypise este raz, lebo SC vzdy vracia poslednu hodnodu. k tomu sa dostaneme neskor. mozno.".postln;

) // kurzor hocikde v ramci bloku a ctrl + enter

a = "supercollider"

a.do({ |i| i.ascii.postln })










//////////////////////////////////////
// Zvuk v SC
//////////////////////////////////////

// Do teraz sme pouzivali jen jeden program,   jazyk supercollideru = SCLANG
// ak chceme robit so zvukom, potrebujeme spustit dalsi program, ktory sa postara o zvuk = SCSYNTH
// tento program nazvali Audio Server a spusta sa prikazom:
s.boot; // Ctrl + b

s.class

// oba tieto programy si medzi sebou posielaju informacie/data, takze my pohodlne ostavame v SCLANGU

// scynth sa sputsti vo svojich default options, co su dva vstupne kanaly a dva vystupne so samplerate 44100
// toto sa da samozrejme nastavit ako len chceme

s.meter // voila

s.quit // skonci  server

// zmenime nastavenia
s.options.numInputBusChannels = 1 // nastav jeden vstup
s.options.numOutputBusChannels = 8 // nastav osem vystupov
s.options.sampleRate = 48000

// po nastaveni options bootneme server a nastavenia budu aktivne
s.boot

s.meter // hohoo

// tymto prikazom sa nahrava vsetko co sa deje
s.record("/home/paum/Recordings/audio.wav")
s.stopRecording // nahravanie treba zastavit


"Server".help



s.quit // skonci  server
s.options.numInputBusChannels = 1 // nastav jeden vstup
s.options.numOutputBusChannels = 2 // nastav osem vystupov
s.options.sampleRate = 44100

s.boot


//////////////////////////////////////
// jednoduchý theremin
//////////////////////////////////////

/*
	VELMI DOLEZITE

	CTRL + . (control + bodka) je klavesova skratka, ktoru si treba pamatat
	zastavi vsetky procesy, teda aj zvuk

*/

{SinOsc.ar(250) * 0.1}.play //  hra iba v jednom kanali




//ctrl + .
// prestalo hrat ?

{SinOsc.ar(250) * 0.5}.play // hlasnejsie


//ctrl + .

{SinOsc.ar(250) * MouseX.kr(0,0.5) ! 2}.play // ovladanie hlasitosti myskou

//ctrl + .

{SinOsc.ar(MouseY.kr(50,800)) * MouseX.kr(0,0.5) ! 2}.play // .. aj frekvencie

//ctrl + .

// mysaci theremin s vibratom
(
	{
		SinOsc.ar(
			freq: MouseY.kr(50,800)  // frekvencia ovladana mysou
			+ SinOsc.kr(freq: 5).range(-20,20) // vibrato
		)
		* 0.3 // hlasitost
		! 2 // stereo
	}.play
) // ctrl + enter (spustanie bloku)


// SC má vinkajúci HELP system dostuný aj na webe  (http://doc.sccode.org/)[http://doc.sccode.org/] tak6e si ho môžete študovať aj vo vlaku, ale vlastne sa teraz aj tak nikam necestuje...


"Getting-Started-With-SC".help;







///////////////////////////
/// OOP

Objekty -> Classes

3.class

3000.do( { "supercollider".postln }  )

40.factorial

40.0.class

"fero".class
"fero".at(1)
