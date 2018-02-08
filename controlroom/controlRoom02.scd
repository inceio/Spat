//alttaki ikisi main,,
(
m.sendBundle(0.2, ["/zonePos", //in order to update player has to move
	~zoneNo0 = 0,  //zone number
	~zoneX0 = 17.1, //zone x
	~zoneY0= 0.1, //zone y
	~zoneZ0= 15,  //zone z
	~zoneArea0 =15, //zone area 1 1 1 94
	~smpleNo0= 0,  //sample no
	~smplSt0 =6,  //sample start
	~smplEd0 =99,  //sample end
	~filter0 =95, //filter cutoff
	~pitch0 = 50,  //pitch 0-100, original playback 50
	~volume0 =10,  //volume
	~direction0=  44, //direction mi ne sikimse
	~loop0= 1, //loop
	~spread0 =1,//spread 0-1
	~crossfade0= 50,//crossfade
	~attk0 = 1,//attack
	~rel0 = 12//release
]);
if(~debugMode == 1,{
(
" PVEzoneeeNo0:"++~zoneNo0++
" smpleNo:"++~smpleNo0++
" smplSt:"++~smplSt0++
" smplEd:"++~smplEd0++
" filter:"++~filter0++
" pitch:"++~pitch0++
" volume:"++~volume0++
" direction:"++~direction0++
" loop:"++~loop0++
" spread:"++~spread0++
" crossfade:"++~crossfade0++
" attk:"++~attk0++
" rel:"++~rel0
).postln});
m.sendBundle(0.2, ["/pozyxPlayerPos",
	~playerNo1 = 0,
	~playerX1 = 14,
	~playerY1 = 0.11,
	~playerZ1 = 14.1,
	~playerArea1 = 30,
	~smpleNo1 =0,
	~smplSt1 = 1,
	~smplEd1 = 99,
	~filter1 = 95,
	~pitch1 = 55,
	~volume1 = 30,
	~direction1 = 120,
	~loop1 = 0,
	~spread1 = 0,
	~crossfade1 = 50,
	~accel1 = 0,
	~attk1 = 40,
	~rel1 = 50,

]);
)
if(~debugMode == 1,{(
" PVPplayerNo0:"++~playerNo1++
" smpleNo:"++~smpleNo1++
" smplSt:"++~smplSt1++
" smplEd:"++~smplEd1++
" filter:"++~filter1++
" pitch:"++~pitch1++
" volume:"++~volume1++
" direction:"++~direction1++
" loop:"++~loop1++
" spread:"++~spread1++
" crossfade:"++~crossfade1++
" accel:"++~accel1++
" attk:"++~attk1++
" rel:"++~rel1
).postln;})
)

s.plotTree;
(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	1, //player number // zero means invisible
	16,//pos x
	0.11,//pos y
	12.9, //pos z
	10,//player area
	0,  // sample no
	0,  // sample start
	99,  // sample end
	95,  // filter cutoff
	45,  // pitch
	15,  // volume
	10,  // direction 0 ile 360 degrees
	0,  // loop
	0,  // spread
	50,  // crossfade
	0,  // accelerometer
	1,//atk
	1,//rel
]);
m.sendBundle(0.2, ["/pozyxPlayerPos",
	~playerNo1 = 0,
	~playerX1 = 15.1,
	~playerY1 = 0.112,
	~playerZ1 = 12.97,
	~playerArea1 = 10,
	~smpleNo1 =0,
	~smplSt1 = 1,
	~smplEd1 = 99,
	~filter1 = 95,
	~pitch1 = 55,
	~volume1 = 30,
	~direction1 =30,
	~loop1 = 1,
	~spread1 = 0,
	~crossfade1 = 50,
	~accel1 = 0,
	~attk1 = 4,
	~rel1 = 5,

]);
if(~debugMode == 1,{(
" PVPplayerNo0:"++~playerNo1++
" smpleNo:"++~smpleNo1++
" smplSt:"++~smplSt1++
" smplEd:"++~smplEd1++
" filter:"++~filter1++
" pitch:"++~pitch1++
" volume:"++~volume1++
" direction:"++~direction1++
" loop:"++~loop1++
" spread:"++~spread1++
" crossfade:"++~crossfade1++
" accel:"++~accel1++
" attk:"++~attk1++
" rel:"++~rel1
).postln;})
)
m.sendBundle(0.2, ["/pozyxPlayerPos",
	1, //player number // zero means invisible
	21,//pos x
	0.1,//pos y
	12.9, //pos z
	30,//player area
	0,  // sample no
	44,  // sample start
	35,  // sample end
	95,  // filter cutoff
	99,  // pitch
	99,  // volume
	105,  // direction 0 ile 360 degrees
	1,  // loop
	1,  // spread
	50,  // crossfade
	0,  // accelerometer
	44,
	3
]);
)

[ /zonePos, 0, 8.3000001907349, 0.049999997019768, 43.449996948242, 1.2953641414642, 2, 6, 124, 99, 64, 80, 0, 1, 1, 0 ]
(
m.sendBundle(0.2, ["/pozyxPlayerPos",
	3, //player number // zero means invisible
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
]);
)



//[ /pozyxPlayerPos, 3, 25, 0, 34.349998474121, 0.40000000596046, 44, 0, 123, 90, 60, 80, 0, 1, 1, 1, 0 ]


m.sendBundle(0.2, ["/position", 0, 90, 49, 1, 10]);
m.sendMsg("/pozyxPlayerPos", 1,2,1,4);
// on/off, target id, func = 0
m.sendMsg("/multichannel", 1,0,0);//first function ->4/4
// on/off, target id, multi func = 1, p1,p2,p3,p4 -> Sine spread
m.sendMsg("/multichannel", 1,1,1,5,0.001);//2nd function

x.free//test free
m = NetAddr("127.0.0.1", 5000); // loopback
m = NetAddr("127.0.0.1", 57120); // Unity listener

OSCdef(\players, { |msg, time| //first player

	msg.postln;

}, \pozyxPlayerPos).permanent_(true);


OSCdef(\zones, { |msg, time| //first player
	msg.postln;

}, \zonePos).permanent_(true);

OSCdef(\booter, { |msg, time| //first player
	"ASDASD".postln;

}, \boot);

)