(
var closenessCheckerPVE = { arg item, playerz;
	var abc;

	(~zonez[item,3] - ~disCal.value(~zonez[item,0] - ~playerz[playerz,0],~zonez[item,1] - ~playerz[playerz,1],~zonez[item,2] - ~playerz[playerz,2])).abs
};
var closenessCheckerPVP = { arg item, playerz;
	var abc;
	(~playerz[item,3] - ~disCal.value(~playerz[item,0] - ~playerz[playerz,0],~playerz[item,1] - ~playerz[playerz,1],~playerz[item,2] - ~playerz[playerz,2])).abs
};
OSCdef(\trigSynthZ, { |msg, time|
	var toggle, bufnummsg, freqmsg, attkmsg, relmsg, loopMemsg,smplStmsg, smplEdmsg, trkVolmsg, frqLPFmsg, playerOut, zoneIndex,playerIndex,spreadmsg;
	toggle = msg[1];
	zoneIndex = msg[2];
	playerIndex = msg[3];
	bufnummsg = ~smple[msg[4]];
	smplStmsg = msg[5];
	smplEdmsg = msg[6];
	freqmsg  = msg[7];
	frqLPFmsg = msg[8].linexp(0,100,20,20000);
	trkVolmsg = msg[9].linlin(0,100, 0, 36);
	loopMemsg = msg[10];
	attkmsg = msg[11];
	relmsg = msg[12];
	spreadmsg = msg[13];
	msg.postln;

	if(msg[1] == 1,{
		if(~boolMeZoneTrigger[zoneIndex] == nil,
			{ //creator
				~boolMeZoneTrigger[zoneIndex] = Synth(\TrigManchun, [
					\busOut, ~zone_Bus[zoneIndex],
					\freq, freqmsg,
					\frqLPF, frqLPFmsg,
					\bufnum, bufnummsg,
					\smplSt, smplStmsg,
					\smplEd, smplEdmsg,
					\trkVol, trkVolmsg,
					\loopMe, loopMemsg,
					\spreadMe, spreadmsg,
					\busOut2,~zone_Bus2[zoneIndex],
				\amp, 0]).onFree{~boolMeZoneTrigger[zoneIndex]= nil};
				~boolMeTrigger[zoneIndex, playerIndex] = Synth.after( ~boolMeZoneTrigger[zoneIndex],\trigBinder,[
					\zoneOut, ~zone_Bus[zoneIndex],
					\kanal8, ~sekiz_Bus8[playerIndex],
					\busOut, playerIndex * 2,
					\attk, attkmsg,
					\rel, relmsg,
					\zoneControlOut, ~zone_Bus2[zoneIndex],
				\amp, 1]).onFree{~boolMeTrigger[zoneIndex, playerIndex] = nil};//boolmezone modulator here

				//if (boolme(zi,pi) !== nil
				//synth after
				//else
				//modulate added binder
				//Params for the general ecosystem bindings

			},
			{
			if(~boolMeTrigger[zoneIndex, playerIndex] == nil, {
				~boolMeTrigger[zoneIndex, playerIndex] = Synth.after( ~boolMeZoneTrigger[zoneIndex],\trigBinder,[
					\zoneOut, ~zone_Bus[zoneIndex],
					\kanal8, ~sekiz_Bus8[playerIndex],
					\busOut, playerIndex * 2,
					\attk, attkmsg,
					\rel, relmsg,
					\zoneControlOut, ~zone_Bus2[zoneIndex],
				\amp, 1]).onFree{~boolMeTrigger[zoneIndex, playerIndex] = nil};//boolmezone modulator here
				},
				{
					if("TrigManchun" == ~boolMeZoneTrigger[zoneIndex].defName.asString,
						{
							~boolMeZoneTrigger[zoneIndex].set(
								\smplSt, smplStmsg,
								\bufnum, bufnummsg,
								\smplEd, smplEdmsg,
								\frqLPF, frqLPFmsg,
								\trkVol, trkVolmsg,
								\loopMe, loopMemsg,
								\spreadMe, spreadmsg)
						},
						{
							~boolMeZoneTrigger[zoneIndex].free;
							~boolMeZoneTrigger[zoneIndex] = Synth(\TrigManchun, [
								\busOut, ~zone_Bus[zoneIndex],
								\freq, freqmsg,
								\frqLPF, frqLPFmsg,
								\bufnum, bufnummsg,
								\smplSt, smplStmsg,
								\smplEd, smplEdmsg,
								\trkVol, trkVolmsg,
								\loopMe, loopMemsg,
								\spreadMe, spreadmsg,
								\busOut2,~zone_Bus2[zoneIndex],
								\amp, 0]).onFree{~boolMeZoneTrigger[zoneIndex]= nil};
						}
					);

				});

		});
	},{
			~boolMeTrigger[zoneIndex, playerIndex].release(relmsg);
	});

/*	if(closenessCheckerPVE.value(zoneIndex, playerIndex).lincurve(0,~playerz[playerIndex,3], -45,0,(~playerz[playerIndex,13]/5)-10) < 0,{
		~boolMe[zoneIndex, playerIndex].free;
		~boolMe[zoneIndex, playerIndex]= nil;
	});*/
}, \trigSynthZone).permanent_(true);

//playerzarray
OSCdef(\trigSynthPlayerZ, { |msg, time|
	var toggle, bufnummsg, freqmsg, attkmsg, relmsg, loopMemsg,smplStmsg, smplEdmsg, trkVolmsg, frqLPFmsg, playerOut, zoneIndex,playerIndex,spreadmsg;
	toggle = msg[1];
	zoneIndex = msg[2];
	playerIndex = msg[3];
	bufnummsg = ~smple[msg[4]];
	smplStmsg = msg[5];
	smplEdmsg = msg[6];
	freqmsg  = msg[7];
	frqLPFmsg = msg[8].linexp(0,100,20,20000);
	trkVolmsg = msg[9].linlin(0,100, 0, 36);
	loopMemsg = msg[10];
	attkmsg = msg[11];
	relmsg = msg[12];
	spreadmsg = msg[13];
	msg.postln;

	if(msg[1] == 1,{
		if(~boolMePlayerTrigger[zoneIndex] == nil,
			{ //creator
				~boolMePlayerTrigger[zoneIndex] = Synth(\TrigManchun, [
					\busOut, ~pvp_Bus[zoneIndex],
					\freq, freqmsg,
					\frqLPF, frqLPFmsg,
					\bufnum, bufnummsg,
					\smplSt, smplStmsg,
					\smplEd, smplEdmsg,
					\trkVol, trkVolmsg,
					\loopMe, loopMemsg,
					\spreadMe, spreadmsg,
					\busOut2,~pvp_Bus2[zoneIndex],
					\amp, 0]).onFree{~boolMePlayerTrigger[zoneIndex]= nil};
				~boolMePVPTrigger[zoneIndex, playerIndex] = Synth.after( ~boolMePlayerTrigger[zoneIndex],\trigBinder,[
					\zoneOut, ~pvp_Bus[zoneIndex],
					\kanal8, ~sekiz_Bus8[playerIndex],
					\busOut, playerIndex * 2,
					\attk, attkmsg,
					\rel, relmsg,
					\zoneControlOut, ~pvp_Bus2[zoneIndex],
					\amp, 1]).onFree{~boolMePVPTrigger[zoneIndex, playerIndex] = nil};//boolmezone modulator here

			},
			{
				if(~boolMePVPTrigger[zoneIndex, playerIndex] == nil,
					{
					~boolMePVPTrigger[zoneIndex, playerIndex] = Synth.after( ~boolMePlayerTrigger[zoneIndex],\trigBinder,[
						\zoneOut, ~pvp_Bus[zoneIndex],
						\kanal8, ~sekiz_Bus8[playerIndex],
						\busOut, playerIndex * 2,
						\attk, attkmsg,
						\rel, relmsg,
						\zoneControlOut, ~pvp_Bus2[zoneIndex],
						\amp, 1]).onFree{~boolMePVPTrigger[zoneIndex, playerIndex] = nil};//boolmezone modulator here
				},
				{
						if("TrigManchun" == ~boolMePlayerTrigger[zoneIndex].defName.asString,
							{
								~boolMePlayerTrigger[zoneIndex].set(
									\smplSt, smplStmsg,
									\bufnum, bufnummsg,
									\smplEd, smplEdmsg,
									\frqLPF, frqLPFmsg,
									\trkVol, trkVolmsg,
									\loopMe, loopMemsg,
									\spreadMe, spreadmsg)
							},
							{
								~boolMePlayerTrigger[zoneIndex].free;
								~boolMePlayerTrigger[zoneIndex] = Synth(\TrigManchun, [
									\busOut, ~pvp_Bus[zoneIndex],
									\freq, freqmsg,
									\frqLPF, frqLPFmsg,
									\bufnum, bufnummsg,
									\smplSt, smplStmsg,
									\smplEd, smplEdmsg,
									\trkVol, trkVolmsg,
									\loopMe, loopMemsg,
									\spreadMe, spreadmsg,
									\busOut2,~pvp_Bus2[zoneIndex],
									\amp, 0]).onFree{~boolMePlayerTrigger[zoneIndex]= nil};
							}
						);

				});

		});
		},{
		~boolMePVPTrigger[zoneIndex, playerIndex].release(relmsg);
	    });
/*	if(closenessCheckerPVP.value(zoneIndex, playerIndex).lincurve(0,~playerz[playerIndex,3], -45,0,(~playerz[playerIndex,13]/5)-10) < 0,{
		~boolMePVP[zoneIndex, playerIndex].free;
		~boolMePVP[zoneIndex, playerIndex]= nil;
	});*/
}, \trigSynthPlayer).permanent_(true);



OSCdef(\ztf, { |msg, time|

	j = Synth(\zoneTrigFunk, [\bufnum, ~smple[msg[1]], \closeness, 1 ,\out, msg[3] * 2, \loopMe, msg[2]]);
}, \zoneTrig).permanent_(true);
)