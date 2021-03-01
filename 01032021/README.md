


SuperCollider
-------------

Nainštalujte si [SuperCollider](https://supercollider.github.io). SuperCollider je programovací jazyk určený na hudobné aplikácie.
Najlepšie sa v ňom pracuje keď si zapnete anglickú klávesnicu - kôli rôznym špeciálnym znakom, ktoré sa v ňom využívajú ```[](){}^&$#;:!"```



Základy v SC:
------------

```supercollider

// Jednotlive prikazy sa spustaju kombinaciou klaves shift + enter (jeden riadok), alebo ctrl + enter (blok kodu)
// za takymito dvoma lomitkami je tzv. komentar, to je text ktory sluzi na poznamkovanie kodu


3 + 6 // shift + enter

2.sqrt // odmocnina z 2

prikaz_ktory_neexistuje // ERROR ...

"supercollider".scramble // vyskusajte spustit viac krat po sebe ...

// blok kodu je uzavrety v okruhlych zatvorkach:
(
	"prvy riadok".postln;
	"druhy riadok".postln;
	" a posledny, ktory vypise este raz, lebo SC vzdy vracia poslednu hodnodu. k tomu sa dostaneme neskor".postln;

) // kurzor hocikde v ramci bloku a ctrl + enter
```


Zvuk v SC
---------

Ak chceme robiť so zvukom, musíme to SC špeciáne "povedať" , naštartovaním ```localhost``` audio servera.
Server ma defaultne 2 audio vstupy a 2 audio vystupy, čo sa da zmeniť nastavením ```options```. Táto časť nebude dôležitá pre náš kurz, ale možno to využijete vo vašom projekte.

```supercollider
s.boot // pozri post window
s.meter // level meter

s.quit // quit server

s.options.numInputBusChannels = 1 // nastav jeden vstup
s.options.numOutputBusChannels = 8 // nastav osem vystupov
s.options.sampleRate = 48000

// po nastaveni options bootneme server a nastavenia budu aktivne
s.boot

s.meter

```

jednoduchý theremin
-------------------

Ešte jedna super dôležitá vec. Na týchle zastavenie zvuku je klávesová skratka ```ctrl + .``` (control + bodka)

```supercollider

{SinOsc.ar(250)}.play // toto bude mozno hlasne, hra iba v jednom kanali

//ctrl + . 
{SinOsc.ar(250) * 0.2}.play // tichsie


//ctrl + . 

{SinOsc.ar(250) * MouseX.kr(0,0.5) ! 2}.play // ovladanie hlasitosti myskou

//ctrl + . 

{SinOsc.ar(MouseY.kr(50,800)) * MouseX.kr(0,0.5) ! 2}.play // .. aj frekvencie

//ctrl + . 

// mysaci theremin s vibratom
(
	{
		SinOsc.ar(
			MouseY.kr(50,800)  // frekvencia ovladana mysou
			+ SinOsc.kr(5).range(-20,20) // vibrato
		)
		* 0.3 // hlasitost
		! 2 // stereo
	}.play
) // ctrl + enter (spustanie bloku)

```

SC má vinkajúci HELP system dostuný aj na webe  (http://doc.sccode.org/)[http://doc.sccode.org/] tak6e si ho môžete študovať aj vo vlaku, ale vlastne sa teraz aj tak nikam necestuje...

Doporučené čítanie z SC helpu:
(Setting started tutorial)[http://doc.sccode.org/Browse.html#Tutorials%3EGetting-Started]



Hudba na vypočutie:

[Slovenská elektrooakustická hudba 1966 - 1994](https://monoskop.org/CECM/Anthology_of_Slovak_Electroacoustic_Music)


Doporučená litaratúra

[Thor Magnusson - Sonic Writing](https://www.bloomsbury.com/us/sonic-writing-9781501313868/)

[Web Sonic Writing](http://www.sonicwriting.org/)

SuperCollider video tutoriály (doporučujem pozrieť aspoň prvé tri)

[Eli Fieldsteel Supercollider tutorial series](https://www.youtube.com/watch?v=yRzsOOiJ_p4&list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC)
