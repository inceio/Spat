(
s.quit;
Server.scsynth;
~playerNumber = 5;
~zoneNumber = 1000;
~speakerNumber = 6;
~debugMode = 0;
s.options.numOutputBusChannels = ~speakerNumber + ((~playerNumber) * 2);
s.options.hardwareBufferSize = 256;
s.options.numAudioBusChannels = 4096*4;
s.options.maxNodes = 1024 * 32;
s.options.numWireBufs = 512;
s.options.memSize = 131072 * 16;
s.options.sampleRate = 44100;
s.options.blockSize = 32;
s.options.numBuffers = 2048 * 64;
s.latency = 0.02;
s.meter;
s.quit;
m = NetAddr("127.0.0.1", 57120); // loopback

//Averaging Filter
~dataLen = 3;
~dataLenA = Array.fill(~playerNumber * ~dataLen,1);
~dataLenArray = Array2D.fromArray(~playerNumber,~dataLen, ~dataLenA);

~zone_Bus = Array.newClear(~zoneNumber); //zone
~zone_Looper = Array2D.new(~zoneNumber,~playerNumber); //zone
~player_Looper = Array2D.new(~playerNumber,~playerNumber); //zone
~zone_Bus2 = Array.newClear(~zoneNumber); //zone
~pvp_Bus = Array.newClear(~playerNumber); //player
~pvp_Bus2 = Array.newClear(~playerNumber); //player
s.plotTree;

//Synth
~pvp = Array.newClear(~playerNumber); //player index
~playerNumber.do({arg item; ~pvp_Bus[item] = Bus.audio(s,2)});
~sekiz_Bus8 = Array.newClear(~playerNumber); //player
~pvp_Bus8id = Array.newClear(~playerNumber); //player
~pvp_Fin8 = Array.newClear(~playerNumber); //player
~playerNumber.do({arg item; ~pvp_Fin8[item] = Bus.audio(s,2)});
~playerNumber.do({arg item; ~sekiz_Bus8[item] = Bus.audio(s,2)});

~playerNumber.do({arg item; ~pvp_Bus2[item] = Bus.control(s)});
~zoneNumber.do({arg item; ~zone_Bus[item] = Bus.audio(s,2)});
~zoneNumber.do({arg item; ~zone_Bus2[item] = Bus.control(s,3)});

//Wavefield synthesis

//~speaker_Bus = Array.newClear(~speakerNumber);
//~speakerNumber.do({arg item; ~zone_Bus[item] = Bus.audio(s,2)});



//Structures
~playerz = Array2D.new(~playerNumber,30);
~speakerz = Array2D.new(~speakerNumber,5);
~zonez = Array2D.new(~zoneNumber,30);
~boolMe = Array2D.new(~zoneNumber,~playerNumber);
~boolMeSpeaker = Array2D.new(~zoneNumber,~speakerNumber);
~boolMeTrigger = Array2D.new(~zoneNumber,~playerNumber);
~boolMePVP = Array2D.new(~playerNumber,~playerNumber);
~boolMePVPTrigger= Array2D.new(~playerNumber,~playerNumber);
~boolMeZone = Array.newClear(~zoneNumber);
~boolMeZoneTrigger = Array.newClear(~zoneNumber);
~boolMePlayerTrigger = Array.newClear(~playerNumber);

//Conditionals
~conditionalPlayerTrigger = Array2D.new(~zoneNumber,~playerNumber);

/*
2 = 1
3 = 3
4 = 6
5 = 10
6 = 15
7 = 21
*/
s.boot;
s.waitForBoot({
	"spatdefs.scd".loadRelative;
	"spat.scd".loadRelative;
	"tspat.scd".loadRelative;
	"multichannel.scd".loadRelative;
	"loadpool.scd".loadRelative;
	"modulations.scd".loadRelative;
	"multidefs.scd".loadRelative;

});
)

/*
-- Notes on ATK--
convolution is used to calibrate the signals from the capsules before matrixing,
ensuring that the derived B-format is accurate.

A-format is the four signals from the capsules
left-front/back and right-front/back.
// x -y pad
To get B-format:
X = 0.5 ((LF - LB) + (RF - RB))
Y = 0.5 ((LF - RB) - (RF - LB))
Z = 0.5 ((LF - LB) + (RB - RF))
W = 0.5 (LF + LB + RF + RB)

-- Interface Design --

HDMI screen: https://www.adafruit.com/product/2300
Joystick: https://www.adafruit.com/product/3102

*/