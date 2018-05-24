ultimoCaminhaoAvisadoResourceNode( 23 ).

+resourceNode(A,B,C,D)[source(percept)]:
			not (resourceNode(A,B,C,D)[source(SCR)] &
			SCR\==percept)
	<-
		.print( "Nome ResourceNode: ", A);
		+resourceNode(A,B,C,D);
		.broadcast(tell,resourceNode(A,B,C,D));
	.

//+step(_): name(agentA1)
//	<-
//		.wait(100);
//		for(chargingStation(_,X,Y,_)) {
//			addPoint(X,Y);
//		}
//		buildPolygon;
//		getPolygon(X);
//		.print(X);
//		+X;
//	.

+todo(ACTION,PRIORITY): true
	<-
		?priotodo(ACTION);
		-+doing(ACTION);
	.

-todo(ACTION,_):true
<-
	-doing(ACTION);
.

{ include("gathering.asl") }
{ include("posicaoinicial.asl") }	
{ include("charging.asl") }		
{ include("regras.asl") }
//{ include("itens.asl") }

+resourceNode(NOME,B,C,ITEM): name(agentA23) & ultimoCaminhaoAvisadoResourceNode( NUM ) & NUM <= 34
		<-
//		.send(agentA24, achieve, craftSemParts(NOME));
		.concat( "agentA", NUM, NOMEAGENT );
		.send(NOMEAGENT, achieve, craftSemParts(NOME , ITEM));
		-+ultimoCaminhaoAvisadoResourceNode( NUM+1 );
		.print("NOME: ", NOME, ", NOMEAGENT: ", NOMEAGENT);
		.

+step( _ ): not route([]) 
	<-	.print("continue");
		action( continue );
	.

+step( _ )
	:	lastAction(randomFail)
	&	acaoValida( ACTION )
	<-	
		.print( "Fazendo de novo ", ACTION);
		action( ACTION );
	.

+step(_)
	:	lastActionResult(successful_partial)
	&	acaoValida( ACTION )
	<-	.print("corigindo partial_success");
		action( ACTION );
	.

+step( _ ): doing(exploration) &	explorationsteps([ACT|T])			
	<-
	.print( "exploration: ", ACT);
	action(ACT);
	-+explorationsteps(T);
	.

+step( _ ): doing(craft) &	stepsCraft([callBuddies( ROLES , FACILITY , PRIORITY)|T])			
	<-
	//action(ACT);
	.print("craft: ", callBuddies);
	!!callBuddies( ROLES , FACILITY , PRIORITY);
	-+stepsCraft(T);
	.

+step( _ ): doing(help) & stepsHelp([ACT|T])			
	<-	.print("help: ", ACT);
		action( ACT );
		-+stepsHelp(T);
	.

//+step( _ ): doing(craftSemParts) & 
//			stepsCraftSemParts([store(ITEM,QUANTIDADE)|T])
//			& hasItem( ITEM, NOVAQUANTIDADE)
//			& lat(LATAG) & lon(LONAG) & currentStorage(STORAGE) &
//			//storage(storage2,48.86243,2.30345,9401,0,[])
//			storage(STORAGE , LATSTR , LONSTR , _ , _ )
//	<-
//		
//		.

+step( _ ): doing(craftSemParts) & 
			stepsCraftSemParts([store(ITEM,QUANTIDADE)|T])
			& hasItem( ITEM, NOVAQUANTIDADE)
			
	<-	
		
		.print( "quantidade: ", NOVAQUANTIDADE, " ITEM: ", ITEM );
		action( store(ITEM,NOVAQUANTIDADE) );
		-+stepsCraftSemParts(T);
		-+acaoValida( store(ITEM,NOVAQUANTIDADE) );
	.



+step( _ ): doing(craftSemParts) &
			stepsCraftSemParts([ACT|T])			
	<-
		.print( "craftSemParts: ", ACT);
		action( ACT );
		-+stepsCraftSemParts(T);
		-+acaoValida( ACT );
	.
	
+step( _ ): doing(craft) & stepsCraft([ACT|T])			
	<-
		.print( "craft:", ACT);
		action( ACT );
		-+stepsCraft(T);
		-+acaoValida( ACT );
	.

+step( _ ): doing(recharge) & rechargesteps([ACT|T])			
	<-
		.print( "recharge:", ACT);
		action( ACT );
		-+rechargesteps(T);
	.

+step( _ ): priotodo(ACTION)
	<-
		.print( "priotodo:", ACTION);
		-+doing(ACTION);
	.
	
+step( _ ): true
	<-
	.print("noAction");
	action( noAction );
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }