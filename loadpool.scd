(
var poolname = 'barbican0';
var folder, folderrare, folderbasho;

folder = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
	folder.entries.do({
		arg path;
		~sst1 = ~sst1.add(Buffer.read(s, path.fullPath));
	});
poolname = 'barbican1';
folder = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
	folder.entries.do({
		arg path;
		~sst2 = ~sst2.add(Buffer.read(s, path.fullPath));
	});
poolname = 'ultrararemix';
folderrare = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
	folderrare.entries.do({
		arg path;
		~sst3 = ~sst3.add(Buffer.read(s, path.fullPath));
	});

poolname = 'quad_c2';
folderbasho = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
	folderbasho.entries.do({
		arg path;
		~sst4 = ~sst4.add(Buffer.read(s, path.fullPath));
	});

OSCdef(\pooler, { |msg, time|
	var poolname, folder;
	msg[1].postln;

	poolname = msg[1];
	~smple  = "/Users/canince/Desktop/Spat/SpatSC/SST/"++ poolname ++ "/*.wav".pathMatch.collect({ arg i;  Buffer.read(s, i)});
	// if(poolname == nil, {
	// 	~smple = ~smple;
	// });
	// if(poolname == 'barbican0', {
	// 	CmdPeriod.run;
	// 	s.freeAll;
	// 	~smple = ~sst1;
	// });
	// if(poolname == 'barbican1', {
	// 	CmdPeriod.run;
	// 	s.freeAll;
	// 	~smple = ~sst2;
	// });
	// if(poolname == 'ultrararemix', {
	// 	CmdPeriod.run;
	// 	s.freeAll;
	// 	~smple = ~sst3;
	// });
	// if(poolname == 'quad_c2', {
	// 	CmdPeriod.run;
	// 	s.freeAll;
	// 	~smple = ~sst3;
	// });
	/*if(poolname == 'quad', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst5;
	});
	if(poolname == 'quad2', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst6;
	});
	if(poolname == 'quad_c', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst7;
	});
	if(poolname == 'basho_stripe', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst8;
	});


*/

}, \scenepool).permanent_(true);


OSCdef(\sbooter, { |msg, time|
	var poolname, folder;
	msg[1].postln;
	s.freeAll;

}, \sbooter).permanent_(true);

)