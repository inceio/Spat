(
m.sendBundle(0.2, ["/zonePos", //in order to update player has to move
	0,  //zone number
	15, //zone x
	0, //zone y
	1111.1,  //zone z
	5, //zone area  //area covered
	1,  //new -> sample no
        0,  //  new -> sample start
	2,  // sample end
	94,  // filter cutoff
	60,  //pitch
	99,  // volume
]);
m.sendBundle(0.2, ["/zonePos", //in order to update player has to move
	3,  //zone number
	150, //zone x
	0, //zone y
	1111.1,  //zone z
	5, //zone area  //area covered
	1,  //new -> sample no
        0,  //  new -> sample start
	2,  // sample end
	94,  // filter cutoff
	60,  //pitch
	99,  // volume
]);
)
(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	1, //player number // zero means invisible
	15,//pos x
	0,//pos y
	1.1, //pos z
	25,//player area
	1,  // sample no
        1,  // sample start
	35,  // sample end
	95,  // filter cutoff
	60,  // pitch
	99,  // volume

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);
m.sendBundle(0.2, ["/zonePos", //in order to update player has to move
	2,  //zone number
	15, //zone x
	0, //zone y
	1.1,  //zone z
	30, //zone area 1 1 1 94
	1,  //sample no
        9,  //sample start
	99,  //sample end
	99, //filter cutoff
	90,  //pitch
	90,  //volume
]);
m.sendBundle(0.2, ["/pozyxPlayerPos",
	3, //player number // zero means invisible
	15,//pos x
	0,//pos y
	1.1, //pos z
	25,//player area
	1,  // sample no
        1,  // sample start
	35,  // sample end
	95,  // filter cutoff
	60,  // pitch
	99,  // volume

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);
m.sendBundle(0.2, ["/zonePos", //in order to update player has to move
	4,  //zone number
	15, //zone x
	0, //zone y
	1.1,  //zone z
	30, //zone area 1 1 1 94
	1,  //sample no
        9,  //sample start
	99,  //sample end
	99, //filter cutoff
	90,  //pitch
	90,  //volume
]);




)

/*
sample no
sample start
sample end
filter cutoff
pitch
volume
*/

(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	2, //player number // zero means invisible
	15,//pos x
	0,//pos y
	1, //pos z
	25,//player area
	1,  // sample no
        1,  // sample start
	35,  // sample end
	95,  // filter cutoff
	60,  // pitch
	99,  // volume

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);
)
(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	3, //player number // zero means invisible
	15.1,//pos x
	0,//pos y
	1.1, //pos z
	25,//player area
	1,  //zone synth type  (1 = sampler)
        1,  // preset #no // zero means no preset
	39,  // parameter 1 //sample no (for sampler)
	90,  // parameter2 //volume (for sampler)
	90,  // parameter 3
	90,  // parameter 4

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);

)
m.sendBundle(0.2, ["/pozyxPlayerPos",
	2, //player number // zero means invisible
	989,//pos x
	49,//pos y
	440, //pos z
	20,//player area
	1,  //zone synth type  (1 = sampler)
        1,  // preset #no // zero means no preset
	1,  // parameter 1 //sample no (for sampler)
	94,  // parameter2 //volume (for sampler)
	0,  // parameter 3
	0,  // parameter 4

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);
m.sendBundle(0.2, ["/pozyxPlayerPos",
	4, //player number // zero means invisible
	989,//pos x
	49,//pos y
	440, //pos z
	20,//player area
	1,  //zone synth type  (1 = sampler)
        1,  // preset #no // zero means no preset
	1,  // parameter 1 //sample no (for sampler)
	94,  // parameter2 //volume (for sampler)
	0,  // parameter 3
	0,  // parameter 4

	135,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);

)
(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	3, //player number // zero means invisible
	92,//pos x
	49,//pos y
	3, //pos z
	20,//player area
	1,  //zone synth type  (1 = sampler)
        1,  // preset #no // zero means no preset
	1,  // parameter 1 //sample no (for sampler)
	94, // parameter2 //volume (for sampler)
	0,  // parameter 3
	0,  // parameter 4

	255,  // direction 0 ile 360 degrees
	0,  // accelerometer
]);
);

m.sendBundle(0.2, ["\zoneTrigFUNK", 0, 90, 49, 1, 10]);
m.sendMsg("/zoneTrigFUNK", [1]);
m.sendMsg("/position", 22,200,1,1000);

m = NetAddr("127.0.0.1", 5000); // loopback


//zonetrig funk
m.sendBundle(0.2, ["/zoneTrigFUNK", 2, 1, "12345" ]);
m = NetAddr("127.0.0.1", 57120);

a = Synth(\zoneTrigFunk, [\bufnum, ~smple[2], \amp, 1, \loopMe, 0]);
a.free;
//zonetrigfunkend

OSCdef(\booter, { |msg, time| //first player
	msg.postln;

}, \pozyxPlayerPos).permanent_(true);


OSCdef(\psp, { |msg, time| //first player
	"ASDASD".postln;

}, \zonePos);

