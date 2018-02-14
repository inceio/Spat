(

SynthDef(\channel8dist,{ arg out = 0, busMe, amp = 1, busOut, closeness; //8 channel implementation
	var inMe, sol, sag;
	inMe = In.ar(busMe,2);
	//sol = SinOsc.ar(440);
	//sag = SinOsc.ar(4444);
	sol = Select.ar(0,inMe);
	sag = Select.ar(1,inMe);
	Out.ar(10, [sol,sol,sol]);
	Out.ar(13, [sag,sag,sag]);
}).add;

SynthDef(\channel8dist2,{ arg out = 0, busMe, amp = 1, busOut, clo = 2pi, freq = 30, keskin = 0.5; //8 channel implementation
	var inMe, sig, sigout;
	inMe = In.ar(busMe,2);
	sig = Mix.ar(inMe);
	//sig= SinOscFB.ar(440,0.5555pi);
	sigout = sig * SinOsc.ar(freq,[(1*clo)/6, (2*clo)/6, (3*clo)/6, (4*clo)/6, (5*clo)/6, (6*clo)/6],0.5,0.5).linexp(0,1,keskin,1);
	Out.ar(10, sigout);
}).add;


SynthDef(\channel8dist3,{ arg out = 0, busMe, amp = 1, busOut, clo = 2pi, freq = 30, keskin = 0.5; //8 channel implementation
	var inMe, sol, sag, sig, chain;
	inMe = In.ar(busMe);
	sig = Mix.ar(inMe);

	//sig = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(4096), sig);
	//chain = PV_RectComb(chain, MouseX.kr(0, 32), SinOsc.ar(freq,[(1*clo)/8, (2*clo)/8, (3*clo)/8, (4*clo)/8, (5*clo)/8, (6*clo)/8,(7*clo)/8,(8*clo)/8],0.5,0.5).linexp(0,1,keskin,1), MouseY.kr);
	chain = PV_RectComb(chain, MouseX.kr(0, 32), [1/6,2/6,3/6,4/6,5/6,6/6], MouseY.kr);
	Out.ar(10, IFFT(chain));
}).add;

SynthDef(\channel8dist3,{ arg out = 0, busMe, amp = 1, clo = 2pi, freq = 30, keskin = 0.5; //8 channel implementation
	var inMe, sol, sag, sig, chain;
	inMe = In.ar(busMe,2);
	sig = Mix.ar(inMe);
	//sig = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(4096), sig);
	//chain = PV_RectComb(chain, MouseX.kr(0, 32), SinOsc.ar(freq,[(1*clo)/8, (2*clo)/8, (3*clo)/8, (4*clo)/8, (5*clo)/8, (6*clo)/8,(7*clo)/8,(8*clo)/8],0.5,0.5).linexp(0,1,keskin,1), MouseY.kr);
	chain = PV_RectComb(chain, MouseX.kr(0, 32), [1/6,2/6,3/6,4/6,5/6,6/6], MouseY.kr);
	Out.ar(4, IFFT(chain));
}).add;
~pvp_Bus8id[0] = Synth(\binderMulti, [\busMe, ~sekiz_Bus8[0], \busOut, ~pvp_Fin8[0]]);
//x = Synth(\channel8dist3,[\busMe, ~sekiz_Bus8[0]]);
/*x = Synth(\channel8dist,[\busMe, ~sekiz_Bus8[0]]);
x = Synth(\channel8dist2,[\busMe, ~sekiz_Bus8[0]]);
x.free
a= VBAPSpeakerArray.new(2, [0, 60, 120, 180, -60, -120]); // 8 channel ring
b = a.loadToBuffer;
x = Synth(\binderVB, [
				\azimuth, 0.3,
				\elevation, 0,
	            \spkbuf,~spkbuf,
				\spread, 10,
				\busMe, ~sekiz_Bus8[0],
				\sp0amp,1,
				\sp1amp,1,
				\sp2amp,1,
				\sp3amp,1,
				\sp4amp,1,
				\sp5amp,1

			]);*/
)