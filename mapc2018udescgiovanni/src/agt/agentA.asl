+resourceNode(A,B,C,D)[source(percept)]:
			not (resourceNode(A,B,C,D)[source(SCR)] &
			SCR\==percept)
	<-
		+resourceNode(A,B,C,D);
		.broadcast(tell,resourceNode(A,B,C,D));
	.

//+step( 0 ): name(agentA1)
//	<-
//		//.wait(100);
//		for(chargingStation(_,X,Y,_)) {
//			addPoint(X,Y);
//		}
//		for(dump(_,X,Y)) {
//			addPoint(X,Y);
//		}
//		for(shop(_,X,Y)) {
//			addPoint(X,Y);
//		}
//		for(workshop(_,X,Y)) {
//			addPoint(X,Y);
//		}
//		for(chargingStation(_,X,Y,_)) {
//			addPoint(X,Y);
//		}
//		for(storage(_,X,Y,_,_,_)) {
//			addPoint(X,Y);
//		}
//		buildPolygon;
//		getPolygon(X);
//		.println("Poligono pronto !!");
//		+X;
//	.

//+step(30):true
//	<-
//	+doing(exploration);
//	.s
+simStart
	:	name(agentA4) | name(agentA12) | name(agentA18)| name(agentA19)| name(agentA20)| name(agentA21)| name(agentA33)| name(agent34)
	<-	!craft
	.


//{ include("construcao_pocos.asl")}
//{ include("charging.asl") }	
{ include("gather.asl") }
{ include("posicaoinicial.asl") }		
{ include("cantomaisproximo.asl") }		
{ include("regras.asl") }

//+simStart
//	:	name( agentA2 )
//	<-	!!buildWell( weelType0, agentA2 );
//	.
//
//+step( _ )
//	:	entity(_,b,_,_,_)
//	<-	action( noAction );
//	.
//
//+todo(ACTION,PRIORITY)
//	: true
//	<-
//	?priotodo(ACTION);
//	-+doing(ACTION);
//	-+todo(ACTION,PRIORITY);
//	.
//
+step(30):true
	<-
	+todo(exploration,6);	
	.
+step( _ ): not route([]) 
	<-
		action( continue );
	.
	
+step( _ ): route([]) & doing(exploration) &
			explorationsteps([ACT|T])			
	<-
		action( ACT );
		-+explorationsteps(T);
	.
	
+step( _ ): route([]) & doing(recharge) &
			rechargesteps([ACT|T])			
	<-
		action( ACT );
		-+rechargesteps(T);
	.

//+step( _ )
//	:	route( [] )
//	&	doing( buildWell )
//	&	stepsBuildWell( H | T )
//	<-	action( H );
//		-+stepsBuildWell( T );
//	.

+step( _ ): priotodo(ACTION)
	<-
		-+doing(ACTION);
	.
+step( _ ): true
	<-
	action( noAction );
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }