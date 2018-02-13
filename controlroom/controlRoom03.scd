(


m.sendBundle(0.2, ["/pozyxPlayerPos",
	0, //player number // zero means invisible
	5,//pos x
	0,//pos y
	3, //pos z
	5,//player area
	3,  // sample no
	44,  // sample start
	35,  // sample end
	95,  // filter cutoff
	60,  // pitch
	99,  // volume
	135,  // direction 0 ile 360 degrees
	0,  // loop
	0,  // spread
	0,  // crossfade
	0,  // accelerometer
	0,  // atk
	0,  // rls
]);
)
m.sendBundle(0.2, ["/pozyxPlayerPos",
	0,
	9.9953079223633,
	0,
	13.662796974182,
	2.4000000953674,
	0,
	9,
	100,
	99,
	60,
	1,
	0,
	0,
	0,
	0,
	1,
	5,
	5]);

//[ /pozyxPlayerPos, 3, 25, 0, 34.349998474121, 0.40000000596046, 44, 0, 123, 90, 60, 80, 0, 1, 1, 1, 0 ]
/////
\multichannel
m.sendBundle(0.2, ["/position", 0, 90, 49, 1, 10]);
m.sendMsg("/pozyxPlayerPos", 1,2,1,4);
m.sendMsg("/multichannel", 1,0,1,1,1);
// on/off, target id, func = 0
m.sendMsg("/multichannel", 1,0,0);//first function ->4/4
// on/off, target id, multi func = 1, p1,p2,p3,p4 -> Sine spread
m.sendMsg("/multichannel", 1,1,1,5,0.001);//2nd function



m.sendMsg("/scenepool", 'Barbican2');//sample pool


x.free//test free
m = NetAddr("127.0.0.1", 5000); // loopback
m = NetAddr("127.0.0.1", 57121); // Unity listener


OSCdef(\tidalvis, { |msg, time| //first player
	msg.postln;

}, \vis).permanent_(true);
SuperDirt.start

OSCdef(\players, { |msg, time| //first player
	msg.postln;

}, \pozyxPlayerPos).permanent_(true);


OSCdef(\zones, { |msg, time| //first player
	msg.postln;

}, \zonePos).permanent_(true);

OSCdef(\booter, { |msg, time| //first player
	"Booted".postln;

}, \boot);


	// tester = (closeness + 45) / 45;
	// tester = tester * 21;
	// solA = XFade2.ar(Select.ar(0,out1),Select.ar(2,out1), (tester - 19).clip(-1,1));
	// sagA = XFade2.ar(Select.ar(1,out1),Select.ar(3,out1), (tester - 19).clip(-1,1));

)
