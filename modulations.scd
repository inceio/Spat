(
OSCdef(\ParamModulationZone, { |msg, time|
	var toggle, bufnummsg, freqmsg, attkmsg, relmsg, loopMemsg,smplStmsg, smplEdmsg, trkVolmsg, frqLPFmsg, playerOut, zoneIndex,spreadmsg, crossfademsg, rotatonmsg;
/*	xmsg = msg[1];
	ymsg = msg[2];
	ymsg = msg[3];*/
	msg.postln;
	toggle  = msg[1];
	zoneIndex = msg[2];
	bufnummsg = msg[3];
	smplStmsg = msg[4];
	smplEdmsg = msg[5];
	freqmsg  = msg[6];
	frqLPFmsg = msg[7].linexp(0,100,20,20000);
	trkVolmsg = msg[8].linlin(0,100, 0, 36);
	loopMemsg = msg[9];
	attkmsg = msg[10];
	relmsg = msg[11];
	spreadmsg = msg[12];
	crossfademsg = msg[13];
	/*~zonez[zoneIndex,0] = msg[2];
	~zonez[zoneIndex,1] = msg[3];
	~zonez[zoneIndex,2] = msg[4];
	~zonez[zoneIndex,3] = msg[5]; //area covered
	~zonez[zoneIndex,4] = bufnummsg; // sample no
	~zonez[zoneIndex,5] = smplStmsg; // sample start
	~zonez[zoneIndex,6] = smplEdmsg; // sample end
	~zonez[zoneIndex,7] = frqLPFmsg; // filter cutoff
	~zonez[zoneIndex,8] = freqmsg;// pitch
	~zonez[zoneIndex,9] = trkVolmsg;// volume

	~zonez[zoneIndex,11] = loopMemsg; // spreadF
	~zonez[zoneIndex,12] = spreadmsg; // crossfade
	~zonez[zoneIndex,13] = crossfademsg; // accel
	~zonez[zoneIndex,14] = attkmsg; // atk
	~zonez[zoneIndex,15] = relmsg; // relesase*/
	if(~boolMeZone[zoneIndex] != nil , {
			~boolMeZone[zoneIndex].set(
			        \freq,freqmsg,
					\smplSt, smplStmsg,
					\bufnum, bufnummsg,
					\smplEd, smplEdmsg,
					\frqLPF, frqLPFmsg,
					\trkVol, trkVolmsg,
					\loopMe, loopMemsg,
					\spreadMe, spreadmsg);
		});
	if(~boolMeZoneTrigger[zoneIndex] != nil , {
			~boolMeZoneTrigger[zoneIndex].set(
			\freq,freqmsg,
					\smplSt, smplStmsg,
					\bufnum, bufnummsg,
					\smplEd, smplEdmsg,
					\frqLPF, frqLPFmsg,
					\trkVol, trkVolmsg,
					\loopMe, loopMemsg,
					\spreadMe, spreadmsg);
		});
	/*if(~boolMeTrigger[zoneIndex, playerIndex] != nil , {
			~boolMeTrigger[zoneIndex, playerIndex].set(\attk, attkmsg,\rel, relmsg);		});
*/
}, \paramModZone).permanent_(true);

OSCdef(\ParamModulationPlayer, { |msg, time|
	var toggle, bufnummsg, freqmsg, attkmsg, relmsg, loopMemsg,smplStmsg, smplEdmsg, trkVolmsg, frqLPFmsg, playerOut, playerIndex,spreadmsg;
	toggle = msg[1];
	playerIndex = msg[2];
	bufnummsg = ~smple[msg[3]];
	smplStmsg = msg[4];
	smplEdmsg = msg[5];
	freqmsg  = msg[6];
	frqLPFmsg = msg[7].linexp(0,100,20,20000);
	trkVolmsg = msg[8].linlin(0,100, 0, 36);
	loopMemsg = msg[9];
	attkmsg = msg[10];
	relmsg = msg[11];
	spreadmsg = msg[12];

		if(~boolMePlayerTrigger[playerIndex] != nil , {
		    ~boolMePlayerTrigger[playerIndex].set(
					\smplSt, smplStmsg,
					\bufnum, bufnummsg,
					\smplEd, smplEdmsg,
					\frqLPF, frqLPFmsg,
					\trkVol, trkVolmsg,
					\loopMe, loopMemsg,
					\spreadMe, spreadmsg);
		})

}, \paramModPlayer).permanent_(true);

OSCdef(\ParamModulationTrigger, { |msg, time|
	var toggle, bufnummsg, freqmsg, attkmsg, relmsg, loopMemsg ,smplStmsg, smplEdmsg, trkVolmsg, frqLPFmsg, playerOut, zoneIndex,spreadmsg,playerIndex;
	msg.postln;
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

		if(~boolMeZone[zoneIndex] != nil, {
			if("Manchun" == ~boolMeZone[zoneIndex].defName.asString, {
			~boolMeZone[zoneIndex].set(
				\freq, freqmsg,
				\smplSt, smplStmsg,
				\bufnum, bufnummsg,
				\smplEd, smplEdmsg,
				\frqLPF, frqLPFmsg,
				\trkVol, trkVolmsg,
				\loopMe, loopMemsg,
		        \spreadMe, spreadmsg);
			});
		});
		if(~boolMeTrigger[zoneIndex, playerIndex] != nil , {
				~boolMeTrigger[zoneIndex, playerIndex].set(\attk, attkmsg,\rel, relmsg);
		});
		if(~boolMeZoneTrigger[zoneIndex] != nil , {
			~boolMeZoneTrigger[zoneIndex].set(
			    \freq, freqmsg,
				\bufnum, bufnummsg,
				\smplSt, smplStmsg,
				\smplEd, smplEdmsg,
				\frqLPF, frqLPFmsg,
				\trkVol, trkVolmsg,
				\loopMe, loopMemsg,
		        \spreadMe, spreadmsg);
		})
}, \paramModOnTriggerStay).permanent_(true);

OSCdef(\topper, { |msg, time|
	s.quit;
}, \svstop).permanent_(true);
)
