(
var playerz = Array2D.new(5,3),
closenessCheckerPVP,
closenessCheckerPVE,
closenessCheckerPVPeval,
closenessCheckerPVEeval,
panCal, panCalPVE,
playerChecker, // a.k.a Binder checker
zoneMainPVE, // PVE main ses ureten function (no binders)
zoneMainPVP, // PVP main ses ureten function (no binders)a
presetCaller,
defme,folder;

/*
~debugMode = 1;
if(~debugMode == 1, { //getting all player sounds to the main laptop speakers
{Out.ar(0, In.ar((1 * 2) , 2))}.play;
{Out.ar(0, In.ar((2 * 2) , 2))}.play;
{Out.ar(0, In.ar((3 * 2) , 2))}.play;
//{Out.ar(0, In.ar((4 * 2), 2))}.play;
//	{Out.ar(0, In.ar((5 * 2), 2))}.play;
});
*/

OSCdef(\player0, { |msg, time| //first player;
	msg.postln;

	~playerz[msg[1],0] = msg[2];
	~playerz[msg[1],1] = msg[3];
	~playerz[msg[1],2] = msg[4];
	~playerz[msg[1],3] = msg[5]; //player area,
	~playerz[msg[1],4] = msg[6]; //sample no
	~playerz[msg[1],5] = msg[7]; // preset #no
	~playerz[msg[1],6] = msg[8]; // parameter 1
	~playerz[msg[1],7] = msg[9]; // parameter 2
	~playerz[msg[1],8] = msg[10];// parameter 3
	~playerz[msg[1],9] = msg[11];// parameter 4
	~playerz[msg[1],10] = msg[12] + 90 ;// direction OLD VESION
	~playerz[msg[1],11] = msg[13]; //loop
	~playerz[msg[1],12] = msg[14]; //spread
	~playerz[msg[1],13] = msg[15]; //crossfade
	~playerz[msg[1],14] = msg[16]; //accelerometer
	~playerz[msg[1],15] = msg[17]; //attack
	~playerz[msg[1],16] = msg[18]; //release
	//read from input bus depending on the spread params
	~playerNumber.do({arg playerz;
		if(~playerz[playerz,0] != nil,
			{

				//Player vs player check
				if (playerz != msg[1],
					{
						if(msg[5] > ~disCal.value(~playerz[playerz,0] -
							~playerz[msg[1],0],~playerz[playerz,1] -
							~playerz[msg[1],1],~playerz[playerz,2] - ~playerz[msg[1],2]),
							{
								if(msg[1] >= 5, {
									if( ~boolMePVP[msg[1], playerz] == nil,
									{
											playerChecker.value(21, 0, playerz, msg[1]);
									},{
											playerChecker.value(23, 0, playerz, msg[1]);
									});

								},{
									if(~playerz[msg[1],11] == 1, {//eger yanlis loop ise sesi degistir
									zoneMainPVP.value(
										msg[1],
										~playerz[msg[1],3], //player area
										~playerz[msg[1],4], //sample no
										~playerz[msg[1],5],
										~playerz[msg[1],6],
										~playerz[msg[1],7],
										~playerz[msg[1],8],
										~playerz[msg[1],9],
										~playerz[msg[1],10], //important direction head
										~playerz[msg[1],11],
										~playerz[msg[1],12],
										~playerz[msg[1],13],
										~playerz[msg[1],14], //accel
										~playerz[msg[1],15],
										~playerz[msg[1],16]

									); //zone creator & modulator
								},{
									if(~player_Looper[playerz,msg[1]] != 1, {
										~player_Looper[playerz,msg[1]] = 1;
										zoneMainPVP.value(
											msg[1],
											~playerz[msg[1],3], //player area
											~playerz[msg[1],4], //sample no
											~playerz[msg[1],5],
											~playerz[msg[1],6],
											~playerz[msg[1],7],
											~playerz[msg[1],8],
											~playerz[msg[1],9],
											~playerz[msg[1],10], //important direction head
											~playerz[msg[1],11],
											~playerz[msg[1],12],
											~playerz[msg[1],13],
											~playerz[msg[1],14], //accel
											~playerz[msg[1],15],
											~playerz[msg[1],16]
									)});
								});
								if( ~boolMePVP[msg[1], playerz] == nil,
									{
											if(msg[1] >= 5 ,{
												playerChecker.value(22, 0, playerz, msg[1]);
											},
											{
												playerChecker.value(0, 0, playerz, msg[1]);
											}
										);
									},
									{
											if(msg[1] >= 5 ,
											{
												playerChecker.value(23, 0, playerz, msg[1]);
											},
											{
												playerChecker.value(2, 0, playerz, msg[1]);

											}
										);
									}
								);
							},
							{
								~player_Looper[playerz,msg[1]] = 0;
//								~player_Looper[playerz,msg[1]].free;
								//~boolMePVP[msg[1], playerz].free;
								if(~boolMePVP[msg[1], playerz] != nil,
									{
										//~boolMePVP[msg[1], playerz].release(3);
										~boolMePVP[msg[1], playerz].free;
										~boolMePVP[msg[1], playerz] = nil;
								});
							});
						});
					},
					{
						if(~boolMePVP[msg[1], msg[1]] == nil,
						{
							//player sound
							playerChecker.value(8, 0, playerz, msg[1])
						},
						{
							//"playerCheck10".postln;
							playerChecker.value(10, 0, playerz, msg[1])

						});

					}

				);
				///Zone Check by player movement
				~zoneNumber.do({arg zoneIndex;
					//Player vs zone check
					if(~zonez[zoneIndex,0] != nil,
						{
							if(~zonez[zoneIndex,3] > ~disCal.value(~zonez[zoneIndex,0] -
								~playerz[playerz,0], ~zonez[zoneIndex,1] -
								~playerz[playerz,1],~zonez[zoneIndex,2] - ~playerz[playerz,2]),
								{
									if(~zonez[zoneIndex,11] == 1, {
										zoneMainPVE.value(zoneIndex,//zone creator & modulator
											~zonez[zoneIndex,4],
											~zonez[zoneIndex,5],
											~zonez[zoneIndex,6],
											~zonez[zoneIndex,7],
											~zonez[zoneIndex,8],
											~zonez[zoneIndex,9],
											~zonez[zoneIndex,10],//direction
											~zonez[zoneIndex,11],//loop
											~zonez[zoneIndex,12],//spread
											~zonez[zoneIndex,13],//crossfade
											~zonez[zoneIndex,14],//
											~zonez[zoneIndex,15]//
										);
									},{
										if(~zone_Looper[zoneIndex,playerz] != 1, {
											~zone_Looper[zoneIndex,playerz] = 1;
											zoneMainPVE.value(zoneIndex,//zone creator & modulator
												~zonez[zoneIndex,4],
												~zonez[zoneIndex,5],
												~zonez[zoneIndex,6],
												~zonez[zoneIndex,7],
												~zonez[zoneIndex,8],
												~zonez[zoneIndex,9],
												~zonez[zoneIndex,10],//new ones distance zone area
												~zonez[zoneIndex,11],//loop
												~zonez[zoneIndex,12],//spread
												~zonez[zoneIndex,13],//exp curve
												~zonez[zoneIndex,14],
												~zonez[zoneIndex,15]
											);
										});

									}
									);
									if (~boolMe[zoneIndex, playerz] == nil,
										{
											if(msg[1] >= 5 ,{
												playerChecker.value(20, zoneIndex, playerz, msg[1]);
											},{
												playerChecker.value(4, zoneIndex, playerz, msg[1])

											});
										},
										{
											if(msg[1] >= 5 ,{
												playerChecker.value(21, zoneIndex, playerz, msg[1]);
											},{
												playerChecker.value(6, zoneIndex, playerz, msg[1])
											});
									})
							    },
								{
									~zone_Looper[zoneIndex,playerz] = 0;
									if(~boolMe[zoneIndex, playerz] != nil,
										{
											//~boolMe[zoneIndex, playerz].release(3);
											~boolMe[zoneIndex, playerz].free;
											~boolMe[zoneIndex, playerz] = nil;
									});
							});
					});
				});
		});
	});
}, \pozyxPlayerPos).permanent_(true);



OSCdef(\zone0, { |msg, time| //first player
	msg.postln;
	~zonez[msg[1],0] = msg[2];
	~zonez[msg[1],1] = msg[3];
	~zonez[msg[1],2] = msg[4];
	~zonez[msg[1],3] = msg[5]; //area covered
	~zonez[msg[1],4] = msg[6]; // sample no
	~zonez[msg[1],5] = msg[7]; // sample start
	~zonez[msg[1],6] = msg[8]; // sample end
	~zonez[msg[1],7] = msg[9]; // filter cutoff
	~zonez[msg[1],8] = msg[10];// pitch
	~zonez[msg[1],9] = msg[11];// volume
	~zonez[msg[1],10] = msg[12]; // loopF
	~zonez[msg[1],11] = msg[13]; // spreadF
	~zonez[msg[1],12] = msg[14]; // crossfade
	~zonez[msg[1],13] = msg[15]; // direction
	~zonez[msg[1],14] = msg[16]; // atk
	~zonez[msg[1],15] = msg[17]; // relesase

}, \zonePos).permanent_(true);

~disCal = { arg a1,b1,c1;
	(a1.squared + b1.squared + c1.squared).sqrt};

closenessCheckerPVE = { arg item, playerz;
	var abc;
	(~zonez[item,3] - ~disCal.value(~zonez[item,0] - ~playerz[playerz,0],
		~zonez[item,1] - ~playerz[playerz,1],~zonez[item,2] - ~playerz[playerz,2])).abs
};

closenessCheckerPVP = { arg item, playerz;
	var abc;
	(~playerz[item,3] - ~disCal.value(~playerz[item,0] - ~playerz[playerz,0],
		~playerz[item,1] - ~playerz[playerz,1],~playerz[item,2] - ~playerz[playerz,2])).abs
};

closenessCheckerPVEeval = { arg item, playerz;
	var abc;
	(~zonez[item,3] - ~disCal.value(~zonez[item,0] - ~playerz[playerz,0],
		~zonez[item,1] - ~playerz[playerz,1],~zonez[item,2] - ~playerz[playerz,2])).abs
};

closenessCheckerPVPeval = { arg item, playerz;
	var abc;
	(~playerz[item,3] - ~disCal.value(~playerz[item,0] - ~playerz[playerz,0],
		~playerz[item,1] - ~playerz[playerz,1],~playerz[item,2] - ~playerz[playerz,2])).abs
};


panCalPVE = { arg item, playerz;
	var x1, z1, rot1;
	x1 = ~playerz[playerz,0] - ~zonez[item,0];
	if(x1 == 0, {x1 = 0.001});
	z1 = ~playerz[playerz,2] - ~zonez[item,2];
	rot1 = 	~playerz[playerz,10]; //direction 0 - 360
	if(x1.abs > z1.abs, {
		if( ~playerz[playerz,0] >= ~zonez[item,0],
			{
				if( ~playerz[playerz,2] >= ~zonez[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k - 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
			)},{
				if( ~playerz[playerz,2] >= ~zonez[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k + 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
	)})},
	{
		if( ~playerz[playerz,0] >= ~zonez[item,0],
			{
				if( ~playerz[playerz,2] >= ~zonez[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k - 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
			)},{
				if( ~playerz[playerz,2] >= ~zonez[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k + 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
		)})

	}
	);
};


panCal = { arg item, playerz;
	var x1, z1, rot1;
	x1 = ~playerz[playerz,0] - ~playerz[item,0];
	z1 = ~playerz[playerz,2] - ~playerz[item,2];
	rot1 = 	~playerz[playerz,10]; //direction 0 ile 360
	if(x1.abs > z1.abs, {
		if( ~playerz[playerz,0] >= ~playerz[item,0],
			{
				if( ~playerz[playerz,2] >= ~playerz[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k - 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
			)},{
				if( ~playerz[playerz,2] >= ~playerz[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k + 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
	)})},
	{
		if( ~playerz[playerz,0] >= ~playerz[item,0],
			{
				if( ~playerz[playerz,2] >= ~playerz[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k - 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
			)},{
				if( ~playerz[playerz,2] >= ~playerz[item,2],
					{
						k = atan((z1 / x1)).raddeg;
						c = (rot1 + k + 90);
						c = c.mod(360);
						if ( c > 180, {c.linlin(180,360,1,-1)}, {c.linlin(0,180,-1,1)});
					}
		)})

	}
	);
};
zoneMainPVP = { arg
	msg1,
	msg5, //player area
	msg6, //sample no
	msg7, //sample start
	msg8, //sample end
	msg9, //filter cutoff
	msg10,//pitch
	msg11,//volume
	msg12,//direction
	msg13,//loop
	msg14,//spread
	msg15,//curve
	msg16,//accelerometer

	msg17,//attack
	msg18;//release

	if( ~pvp[msg1] == nil,
		{
			~pvp[msg1]= Synth(\Manchun, [
				\busOut, ~pvp_Bus[msg1],
				\busOut2, ~pvp_Bus2[msg1],
				\amp, 0] ++ ~defSampler.value(1, msg6, msg7, msg8, msg9, msg10,
				msg11,msg10,90,msg13,msg14,msg17,msg18)).onFree{~pvp[msg1]= nil}
		},
		{//clone
			if(~pvp[msg1] != nil,
				{
					~defSampler.value(0,msg6, msg7, msg8, msg9, msg10, msg11,~pvp[msg1],
						90,msg13,msg14,msg17,msg18);
				},
				{
					~pvp[msg1].free;
					~pvp[msg1] = Synth(\Manchun, [
						\busOut, ~pvp_Bus[msg1],
						\busOut2, ~pvp_Bus2[msg1],
						\amp, 0] ++ ~defSampler.value(1,msg6, msg7, msg8, msg9, msg10,
						msg11, msg10, 90,msg13,msg14,msg17,msg18)).onFree{~pvp[msg1]= nil}
				}
			);
		}
	);
};
zoneMainPVE = { arg
	msg1,
	msg6,//sample no
	msg7,//sample start
	msg8,//sample end
	msg9,//filter cutoff
	msg10,//pitch
	msg11,//volume
	msg13, //direction
	msg14, //loop
	msg15, //spread
	msg16, //crossfade
	msg17,//attack
	msg18;//release

	if(~boolMeZone[msg1] == nil,
		{ //creator
			~boolMeZone[msg1] = Synth(\Manchun, [
				\busOut, ~zone_Bus[msg1],
				\busOut2, ~zone_Bus2[msg1],
				\amp, 0] ++ ~defSampler.value(1, msg6, msg7, msg8, msg9, msg10, msg11, msg10,
				90,msg14, msg15,msg17,msg18)).onFree{~boolMeZone[msg1]= nil}
		},
		{ //modulator
			if("Manchun" == ~boolMeZone[msg1].defName.asString,
				{
					~defSampler.value(0, msg6, msg7, msg8, msg9, msg10, msg11,
						~boolMeZone[msg1],90,msg14,msg15,msg17,msg18);
				},
				{
					~boolMeZone[msg1].free;
					~boolMeZone[msg1] = Synth(\Manchun,
						[
							\busOut, ~zone_Bus[msg1],
							\busOut2, ~zone_Bus2[msg1],
							\amp, 0] ++ ~defSampler.value(1,msg6, msg7, msg8, msg9, msg10, msg11, msg10,
							90,msg14,msg15,msg17,msg18)).onFree{~boolMeZone[msg1]= nil}
				}
			);
		}
	)
};
playerChecker = { arg funcSelector, zoneIndex, playerz, msg;
	//Documentation
	//funcSelector = 0 -> visible pvp synth creator
	//funcSelector = 1 -> invisible pvp synth creator
	//funcSelector = 2 -> visible pvp synth modulator
	//funcSelector = 3 -> invisible pvp synth modulator
	//funcSelector = 4 -> visible pve synth creator
	//funcSelector = 5 -> invisible pve synth creator
	//funcSelector = 6 -> visible pve synth modulator
	//funcSelector = 7 -> invisible pve  synth modulator
	//player own sound allocate == 8
	//player own sound modulate == 10

	var abc;
	x = case
	//visible pvp binder synth creator
	{ funcSelector == 0 }
	{

		~boolMePVP[msg, playerz] = Synth.after(~pvp[msg], \binder,[
			\busMe, ~pvp_Bus[msg],
			\busMe2, ~pvp_Bus2[msg],
			\kanal8, ~sekiz_Bus8[playerz],
			\busOut, playerz * 2,
			\closeness, closenessCheckerPVP.value(msg, playerz).lincurve(0,~playerz[msg,3],
				-45,0,(~playerz[msg,13]/5)-10),
			\amp, 1,
			\panMe, panCal.value(msg, playerz)
		]
		).onFree{~boolMePVP[msg, playerz] = nil};
	}

	//invisible pvp binder synth creator
	{ funcSelector == 1 }
	{
		if(~pvp[msg] != nil, {
		"invisible func1".postln;
		~boolMePVP[msg, playerz] = Synth.after(~pvp[msg], \binder,[
			\busMe, ~pvp_Bus[msg],
			\busMe2, ~pvp_Bus2[msg],
			\kanal8, ~sekiz_Bus8[playerz],
			\busOut, playerz * 2,
			\amp, 1]).onFree{~boolMePVP[msg, playerz] = nil};
		},{

		});
	}

	//invisible pvp binder  synth modulator
	{ funcSelector == 3 }
	{
		"invisible func3".postln;
	}

	//visible pvp binder  synth modulator
	{ funcSelector == 2 }
	{
		//closenessCheckerPVP.value(msg, playerz).linlin(0,~playerz[msg,3], -45,0).postln;
		//closenessCheckerPVP.value(msg, playerz).postln;
		if(~boolMePVP[msg, playerz] != nil, {
		~boolMePVP[msg, playerz].set(
			\closeness, closenessCheckerPVP.value(msg, playerz).lincurve(0,~playerz[msg,3],
					-45,0,(~playerz[msg,13]/5)-10),
			\panMe, panCal.value(msg, playerz)

		);},{

			~boolMePVP[msg, playerz] = Synth.after(~pvp[msg], \binder,[
			\busMe, ~pvp_Bus[msg],
			\busMe2, ~pvp_Bus2[msg],
			\kanal8, ~sekiz_Bus8[playerz],
			\busOut, playerz * 2,
			\closeness, closenessCheckerPVP.value(msg, playerz).lincurve(0,~playerz[msg,3],
					-45,0,(~playerz[msg,13]/5)-10),
			\amp, 1,
			\panMe, panCal.value(msg, playerz)
		]
		).onFree{~boolMePVP[msg, playerz] = nil};
		})
	}

	//visible own sound creator
	{ funcSelector == 8 }
	{
			~boolMePVP[msg, msg] = Synth.after(~pvp[msg], \binder,[
			\busMe, ~pvp_Bus[msg],
			\busMe2, ~pvp_Bus2[msg],
			\kanal8, ~sekiz_Bus8[msg],
			\busOut, msg* 2,
			\closeness, 1,
			\amp, 1,
			\panMe, 0
		]
		).onFree{~boolMePVP[msg, msg] = nil};

	}

	//visible visible own sound modulator
	{ funcSelector == 10 }
	{
		~boolMePVP[msg, msg].set([
			\busMe, ~pvp_Bus[msg],
			\busMe2, ~pvp_Bus2[msg],
			\kanal8, ~sekiz_Bus8[msg],
			\busOut, msg* 2,
			\closeness, 1,
			\amp, 1,
			\panMe, 0])

	}
	{ funcSelector == 20 }
	{
		"SpeakerBinder".postln;
		~boolMe[zoneIndex, msg] = Synth.after(~boolMeZone[zoneIndex], \binderPlayerSpeaker,
			[
				\busMe, ~zone_Bus[zoneIndex],
				\busOut, msg+5,
				\amp, 1,
				\closeness, closenessCheckerPVE.value(zoneIndex, msg).lincurve(0,~zonez[zoneIndex,3],
					-45, 0,(~zonez[zoneIndex,13]/5)-10)
	//			\panMe, panCal.value(zoneIndex, msg)
			]
		).onFree{~boolMe[zoneIndex, msg] = nil};
	}


	{ funcSelector == 21 }
	{
		~boolMe[zoneIndex, msg].set(
			\closeness, closenessCheckerPVE.value(zoneIndex, msg).lincurve(0,~zonez[zoneIndex,3],
				-45,0,(~zonez[zoneIndex,13]/5)-10),
			\amp, 1
//			\panMe, panCalPVE.value(zoneIndex, msg);
		);
	}

	{ funcSelector == 22}
	{//MAYBE MESSED UP INDEXING
		~boolMePVP[playerz, msg]= Synth.after(~pvp[playerz], \binderPlayerSpeaker,[
			\busMe, ~pvp_Bus[playerz],
			\busOut, msg+5,
			\closeness, closenessCheckerPVP.value(playerz,msg).lincurve(0,~playerz[playerz,3],
				-45,0,(~playerz[playerz,13]/5)-10),
			\amp, 1
//			\panMe, panCal.value(playerz, msg)
		]
		).onFree{~boolMePVP[playerz, msg] = nil};
	}

	{ funcSelector == 23 }
	{
		~boolMePVP[playerz, msg].set(
			\closeness, closenessCheckerPVP.value(playerz,msg).lincurve(0,~playerz[playerz,3],
				-45,0,(~playerz[playerz,13]/5)-10),
			\amp, 1
//			\panMe, panCalPVE.value(playerz, msg);
		);
	}

	//visible pve synth creator.
	{ funcSelector == 4 }
	{
		//(zoneIndex + "zoneIndex").postln;
		//(playerz + "playerz").postln;
		//(zoneIndex + " " + playerz + " " + msg).postln;
		~boolMe[zoneIndex, playerz] = Synth.after(~boolMeZone[zoneIndex], \binder,
			[
				\busMe, ~zone_Bus[zoneIndex],
				\busMe2, ~zone_Bus2[zoneIndex],
				\kanal8, ~sekiz_Bus8[playerz],
				\busOut, playerz * 2,
				\amp, 1,
				\closeness, closenessCheckerPVE.value(zoneIndex, playerz).lincurve(0,~zonez[zoneIndex,3],
					-45, 0,(~zonez[zoneIndex,13]/5)-10),
				\panMe, panCalPVE.value(zoneIndex, playerz)
			]
		).onFree{~boolMe[zoneIndex, playerz] = nil};
	}

	//invisible pve synth creator.
	{ funcSelector == 5 }
	{
		"invisible -> func5".postln;
		~boolMe[zoneIndex, playerz] = Synth.after(~boolMeZone[zoneIndex], \binder,
			[
				\busMe, ~zone_Bus[zoneIndex],
				\busMe2, ~zone_Bus2[zoneIndex],
				\kanal8, ~sekiz_Bus8[playerz],
				\busOut, playerz * 2,
				\amp, 1,
				\closeness, closenessCheckerPVE.value(zoneIndex, playerz).lincurve(0,~zonez[zoneIndex,3],
					-45, 0,(~zonez[zoneIndex,13]/5)-10),
				\panMe, panCal.value(zoneIndex, playerz)
			]
		).onFree{~boolMe[zoneIndex, playerz] = nil};
	}

	//visible pve synth modulator
	{ funcSelector == 6 }//ambisonic modlar buraya
	{
		~boolMe[zoneIndex, playerz].set(
			\closeness, closenessCheckerPVE.value(zoneIndex, playerz).lincurve(0,~zonez[zoneIndex,3],
				-45,0,(~zonez[zoneIndex,13]/5)-10),
			\amp, 1,
			\panMe, panCalPVE.value(zoneIndex, playerz)
		);
	}

	//invisible pve synth modulator.
	{ funcSelector == 7 }//ambisonic modlar buraya
	{
	/*	"invisible -> func7".postln;
		~boolMe[zoneIndex, playerz].set(
			\closeness, closenessCheckerPVE.value(zoneIndex, playerz).lincurve(0,~zonez[zoneIndex,3], -45,0,(~zonez[zoneIndex,13]/5)-10), //yakinlastikca artan ses
			\amp, 1
		);*/
	}

}
)
// NOTES
/*
ACN	(l,m)	letter code
0	(0,0)	W
1	(1,-1)	Y
2	(1,0)	Z
3	(1,1)	X
4	(2,-2)	V
5	(2,-1)	T
6	(2,0)	R
7	(2,1)	S
8	(2,2)	U
*/