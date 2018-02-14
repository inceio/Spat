(
~wavefield = 0;


OSCdef(\multiFunk, { |msg, time|
	var toggle, playerindex, multifunc, param1, param2;
	//msg.postln;
	toggle = msg[1];//on/off
	playerindex = msg[2];//pid
	multifunc = msg[3];// multich function
	param1 = msg[4];//msg4 = param1
	param2 = msg[5];//msg5 = param2
	//msg6 = param3
	//msg7 = param4
	if(toggle == 1,{
		if(~pvp_Bus8id[playerindex] == nil, {
			~pvp_Bus8id[playerindex] = Synth(\binderMulti, [\busMe, ~sekiz_Bus8[playerindex], \busOut, ~pvp_Fin8[playerindex]]);
			if(~multinode == nil,{
				if(multifunc == 0, {
					~multinode = Synth.after(~pvp_Bus8id[playerindex],\channel8dist, [\busMe, ~sekiz_Bus8[playerindex]]);
//					~wavefield = 0;
				});
				if(multifunc == 1, {
					~multinode = Synth.after(~pvp_Bus8id[playerindex],\channel8dist2,[\busMe, ~sekiz_Bus8[playerindex],\freq, param1, \keskin, param2]);
	//				~wavefield = 0;
				});
				if(multifunc == 2, {
					~multinode = Synth.after(~pvp_Bus8id[playerindex],\channel8dist3,[\busMe, ~sekiz_Bus8[playerindex],\freq, param1, \keskin, param2]);
		//			~wavefield = 0;
				});
				if(multifunc == 3, {
					~wavefield = 1;
				});
			});
		},{
			~multinode.free;

		})
	},
		{
		if(~multinode != nil, {
			~multinode.free;
			~wavefield = 0;

		});
	});
}, \multichannel).permanent_(true);



OSCdef(\multiSpk, { |msg, time|
	var playerindex, speakerindex, headrot, toggle,sp0amp,sp1amp,sp2amp,sp3amp,sp4amp,sp5amp , spread;
	msg.postln;
	toggle = msg[1];
	playerindex = msg[2];
	spread = msg[3];
	headrot= msg[4];
	sp0amp = msg[5];
	sp1amp = msg[6];
	sp2amp = msg[7];
	sp3amp = msg[8];
	sp4amp = msg[9];
	sp5amp = msg[10];

		if(~vBus == nil, {
			~vBus = Synth(\binderVB, [
				\spkbuf, ~spkbuf,
				\azimuth, headrot,
				\elevation, 0,
				\spread, spread,
				\busMe, ~sekiz_Bus8[playerindex],
				\sp0amp,sp0amp,
				\sp1amp,sp1amp,
				\sp2amp,sp2amp,
				\sp3amp,sp3amp,
				\sp4amp,sp4amp,
				\sp5amp,sp5amp

			]);
	},{
		if(toggle == 0, {
			~vBus.release(4);
			~vBus = nil;

		},
		{
		~vBus.set([
				\spkbuf, ~spkbuf,
				\azimuth, headrot,
				\elevation, 0,
				\spread, spread,
				\busMe, ~sekiz_Bus8[playerindex],
				\sp0amp,sp0amp,
				\sp1amp,sp1amp,
				\sp2amp,sp2amp,
				\sp3amp,sp3amp,
				\sp4amp,sp4amp,
				\sp5amp,sp5amp]);})
	});
	/*if(~speaker_Bus[speakerindex] == nil, {
		~speaker_Bus[speakerindex] = Synth(\binderSpeaker, [
			\busMe, ~sekiz_Bus8[playerindex],
			\busOut, speakerindex + 10,
			\closeness, volume]);
	},
	{
		~speaker_Bus[speakerindex].set(\closeness, volume);
	});*/


/*		if(toggle == 0, {
			~speaker_Bus[speakerindex].release(5);

		});*/



}, \multispeaker).permanent_(true);
)