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
/*poolname = 'barbican0';
 folder = PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
 folder.entries.do({
	arg path;
	~sst3 = ~sst3.add(Buffer.read(s, path.fullPath));
});
poolname = 'barbican1';
folder = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
	folder.entries.do({
		arg path;
		~sst4 = ~sst4.add(Buffer.read(s, path.fullPath));*/
	//});
// poolname = 'basho2';
// PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst4 = ~sst4.add(Buffer.read(s, path.fullPath));
// });
// poolname = 'quad';
// folder = PathName.new((("SST"++(poolname.asString)).resolveRelative).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst5 = ~sst5.add(Buffer.read(s, path.fullPath));
// });
// poolname = 'ultrararemix';
// PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst6 = ~sst6.add(Buffer.read(s, path.fullPath));
// });
// poolname = 'quad_c';
// PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst7 = ~sst7.add(Buffer.read(s, path.fullPath));
// });
// poolname = 'basho_stripe';
// PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst8 = ~sst8.add(Buffer.read(s, path.fullPath));
// });
//
// poolname = 'mashup';
// PathName.new((("SST"++(poolname.asString))).asAbsolutePath);
// folder.entries.do({
// 	arg path;
// 	~sst11 = ~sst11.add(Buffer.read(s, path.fullPath));
// });


OSCdef(\pooler, { |msg, time|
	var poolname, folder;
	msg[1].postln;

	poolname = msg[1];
	if(poolname == nil, {
		~smple = ~smple;
	});
	if(poolname == 'barbican0', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst1;
	});
	if(poolname == 'barbican1', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst2;
	});
	if(poolname == 'ultrararemix', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst3;
	});
	if(poolname == 'quad_c2', {
		CmdPeriod.run;
		s.freeAll;
		~smple = ~sst3;
	});
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