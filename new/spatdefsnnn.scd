(
///////////////////////// DSP /////////////////////////
var folder = PathName.new(("SST".resolveRelative).asAbsolutePath);
folder.entries.do({
	arg path;
	~smple = ~smple.add(Buffer.read(s, path.fullPath));
});
SynthDef(\Manchun,{ arg out = 0,  bufnum,  freq, amp = 1, gate = 1, busOut, busOut2, loopMe,
	smplSt, smplEd, trkVol, frqLPF,coarse, attk, rell, spreadMe;
	var src;
	//--------------------------Signal Processing Side--------------------------\\
	var start1 = smplSt.linlin(0,100,1,(BufFrames.kr(bufnum))-3);
	var end1 = BufFrames.kr(bufnum)-smplEd.linlin(0,100,( BufFrames.kr(bufnum))-start1-3, 1)-2;
	var phaz = Phasor.ar(
			trig: 1,
			rate: (BufRateScale.kr(bufnum) *  (freq.midicps)/261),
			start: start1,
			end: end1,
			resetPos:0);
	var odod = InRange.ar(phaz,start1+1 ,end1-1000);
	//var tester = Poll.ar(odod, DC.ar(3), \test);
	var sndsnd =  BufRd.ar(
		numChannels: 2,
		bufnum: bufnum,
		phase: phaz,
		loop: 0,
		interpolation:4);
	//Volume Envelope Signal
	var snd1 = sndsnd * EnvGen.ar(Env.asr(0.04, 1, 0.04, -4), odod);
	var aftFilt = LPF.ar(snd1, Lag2.kr(frqLPF));
	src = aftFilt * (trkVol - 20).dbamp;
	Out.kr(busOut2, [spreadMe,spreadMe,spreadMe]);
	Out.ar(busOut, src);
	FreeSelf.kr(phaz >= (end1 + (loopMe * 100) - 50));
}).add;
~defSampler = { arg selector,
	msg6, msg7, msg8, msg9, msg10, msg11,
	voice,c1,msg13, msg14, msg17,msg18;
	var vrManchun = Array.fill(128, 63);
	vrManchun[6] = msg6; //sample no
	vrManchun[8] = msg7; 			//sample start
	vrManchun[9] = msg8;	 		//sample end
	vrManchun[18] = msg9;	 		//filter cutoff
	vrManchun[0] = msg10;			//pitch
	vrManchun[7] = msg11;			//volume
	if(selector == 1,
		{ [
			\freq, 	vrManchun[0],
			\trkVol, vrManchun[7].linlin(0,100, 0, 36),
			\bufnum, ~smple[vrManchun[6]],
			\smplSt, vrManchun[8],
			\smplEd, vrManchun[9],
			\frqLPF, vrManchun[18].linexp(0,100,20,20000),
			\loopMe, msg13,
			\spreadMe, msg14,
			\attk, msg17,
			\rell, msg18,
		]},
		{
			voice.set(
				\freq, 	vrManchun[0],
				\smplSt, vrManchun[8],
				\bufnum, ~smple[vrManchun[6]],
				\smplEd, vrManchun[9],
				\frqLPF, vrManchun[18].linexp(0,100,20,20000),
				\trkVol, vrManchun[7].linlin(0,100, 0, 36),
				\loopMe, msg13,
				\spreadMe, msg14,
				\attk, msg17,
			    \rell, msg18
			)
		}

)};

SynthDef(\TrigManchun,{ arg busOut = 0,amp = 1, gate = 1, bufnum, freq , loopMe, smplSt, smplEd, trkVol, frqLPF, spreadMe, busOut2;
	var start1 = smplSt.linlin(0,100,1,(BufFrames.kr(bufnum))-3);

	var end1 = BufFrames.kr(bufnum)-smplEd.linlin(0,100,( BufFrames.kr(bufnum))-start1-3, 1)-2;
	var phaz = Phasor.ar(
		trig: 1,
		rate: (BufRateScale.kr(bufnum)  *  (freq.midicps)/261),
		start: start1,
		end: end1,
		//end: BufFrames.kr(bufnum) + 1,
	resetPos:0);
	var odod = InRange.ar(phaz,start1+1 ,end1-1000);
	var sndsnd =  BufRd.ar(
		numChannels: 2,
		bufnum: bufnum,
		phase: phaz,
		loop: loopMe,
	interpolation:4);
	//Volume Envelope Signal
	var snd1 = sndsnd * EnvGen.ar(Env.asr(0.04, 1, 0.04, -4), odod);
	var aftFilt = LPF.ar(snd1, Lag2.kr(frqLPF));
	aftFilt = aftFilt * (trkVol - 20).dbamp;
	Out.kr(busOut2, [spreadMe,spreadMe,spreadMe]);
	Out.ar(busOut, aftFilt);
	FreeSelf.kr(phaz >= (end1 + (loopMe * 100) - 50));
}).add;

SynthDef(\zoneTrigFunk,{ arg out, bufnum,closeness, loopMe ;
	var out1, abc;
	var phaz = Phasor.ar(
		trig: 1,
		rate: BufRateScale.kr(bufnum) * 1,
		start: 0,
		end: BufFrames.kr(bufnum) + 1,
	resetPos:0);
	var sndsnd =  BufRd.ar(
		numChannels: 1,
		bufnum: bufnum,
		phase: phaz,
		loop: 0,
	interpolation:4);
	//Out.ar(0,sndsnd); //for debug use
	//sndsnd = sndsnd * (closeness).dbamp;
	sndsnd = Limiter.ar(sndsnd);
	Out.ar(out,sndsnd);
	FreeSelf.kr(phaz >= ((loopMe * 100) - 50));
}).add;

/////////////////////////BINDERS/////////////////////////
SynthDef(\binder,{ arg out = 0, busMe,busMe2, panMe, amp = 1, busOut, closeness, phi = 0, kanal8, gate =1;
	var out1, decoderMatrix, foa1, theta1, src,spreadtoggle;
	var inMe = In.ar(busMe,2);
	var inMe2 = In.kr(busMe2,3);
	spreadtoggle = Select.kr(0,inMe2);
	inMe = inMe * EnvGen.kr(Env.asr, gate, doneAction:2);
	src = inMe * closeness.dbamp;
	Out.ar(kanal8,src);
	src = Mix.ar(src);
	src = Limiter.ar(src);
	theta1 = panMe * -pi;
	// Encode into foa signal
	foa1 = FoaPanB.ar(src, theta1, phi);
	//Poll.kr(Impulse.kr(1), spreadtoggle, \PANNED);
	// Cardioids at 131 deg
	decoderMatrix = FoaDecoderMatrix.newStereo(131/2 * pi/180, 0.5);
	out1 = FoaDecode.ar(foa1, decoderMatrix);
	out1 = out1 * spreadtoggle;
	//out1 = Limiter.ar(out1);
	Out.ar(busOut, out1);
}).add;


//8channel Binder
SynthDef(\binderMulti,{ arg out = 0, busMe, amp = 1, busOut, closeness; //general-purpose multichannel binder
	var inMe = In.ar(busMe,2);
//	inMe = Limiter.ar(inMe);
	Out.ar(busOut, inMe);
}).add;

SynthDef(\binderSpeaker,{ arg out = 0, busMe, amp = 1, busOut, closeness, gate = 1; //wavefield
	var src = In.ar(busMe,2);
	src = src * closeness.dbamp;
	src = src  * EnvGen.kr(Env.asr(0.001), gate, doneAction:2);
	src = Mix.ar(src);
	Out.ar(busOut, src);
}).add;

~speakerArr = VBAPSpeakerArray.new(2, [0, 60, 120, 180, -60, -120]); // 8 channel ring
~spkbuf = ~speakerArr.loadToBuffer;

SynthDef(\binderVB,{ arg out = 0, spkbuf = ~spkbuf, azimuth, elevation, spread, busMe, amp = 1, busOut, gate = 1,sp0amp, sp1amp,sp2amp,sp3amp,sp4amp,sp5amp; //wavefield Synthesis with distance amplitude calibration
	var panned;
	var src = In.ar(busMe,2);
	src = src  * EnvGen.kr(Env.asr(0.001), gate, doneAction:2);
	src = Mix.ar(src);
	panned = VBAP.ar(6, src, spkbuf,azimuth, elevation, spread);
	Out.ar(10, panned[0]*sp0amp.dbamp);
	Out.ar(11, panned[1]*sp1amp.dbamp);
	Out.ar(12, panned[2]*sp2amp.dbamp);
	Out.ar(13, panned[3]*sp3amp.dbamp);
	Out.ar(14, panned[4]*sp4amp.dbamp);
	Out.ar(15, panned[5]*sp5amp.dbamp);
}).add;


SynthDef(\trigBinder,{ arg out = 0, zoneOut, amp = 1, busOut, kanal8, gate =1,attk, rel,zoneControlOut;
	var out1,spi, src, playerAudioOut, atkRel, zoneControl,spreadtoggle;
	var input = In.ar(zoneOut,2);
	zoneControl = In.kr(zoneControlOut,3);
	spreadtoggle= Select.kr(0,zoneControl);
	//Poll.kr(Impulse.kr(1), spreadtoggle, \NOSPREAD);
	Out.ar(kanal8,input);
	playerAudioOut = input  * EnvGen.kr(Env.asr(attk), gate, doneAction:2);
	playerAudioOut  = playerAudioOut * ((spreadtoggle*(-1))+1);
	playerAudioOut = Limiter.ar(playerAudioOut);
	Out.ar(busOut, playerAudioOut);
}).add;


SynthDef(\binderPlayerSpeaker,{arg out = 0, busMe, gate = 1, amp = 1, busOut, closeness; //playerspeaker
	var src = In.ar(busMe,2);
	src = src * closeness.dbamp;
	src = Mix.ar(src);
	src = src  * EnvGen.kr(Env.asr(0.001), gate, doneAction:2);
	Out.ar(busOut, src);
}).add;



)