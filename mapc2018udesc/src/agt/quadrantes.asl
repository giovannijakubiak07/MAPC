//EIXO Y = ALTURA
//EIXO X = LARGURA

quadranteA(AY,AX,BY,BX,CY,CX,DY,DX,EY,EX):-
			maxLat(MAXLAT) & minLon(MINLON) & minLat(MINLAT) & maxLon(MAXLON) & 
			AY = MAXLAT -0.0001 		&
			AX = MINLON + 0.0001		&
			BY = MAXLAT -0.0001 		&
			BX = ((MINLON+MAXLON)/2) 	&
			CY = ((MAXLAT + MINLAT)/2) 	&
			CX = ((MINLON+MAXLON)/2) 	&
			DY = ((MAXLAT+MINLAT)/2) 	&
			DX =  MINLON + 0.0001 		&
			EY = ((AY + DY)/2)			&
			EX = ((AX + BX)/2)
			.
			
quadranteB(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY):-
			maxLat(MAXLAT) & minLon(MINLON) & minLat(MINLAT) & maxLon(MAXLON) & 
			AY = MAXLAT -0.0001 			&
			AX = ((MINLON+MAXLON)/2) 		&
			BY = MAXLAT -0.0001 			&
			BX = MAXLON -0.0001 			&
			CY = ((MAXLAT + MINLAT)/2) 		&
			CX = MAXLON - 0.0001 			&
			DY = ((MAXLAT + MINLAT)/2) 		&
			DX = ((MINLON+MAXLON)/2) 		&
			EY = (AY + DY)/2 				&
			EX = (AX + BX)/2  
			.
			

quadranteC(AX, AY,BX,BY,CX,CY,DX,DY,EX,EY):-
			maxLat(MAXLAT) & minLon(MINLON) & minLat(MINLAT) & maxLon(MAXLON) & 
			AY = ((MAXLAT + MINLAT)/2) 		&
			AX = ((MINLON+MAXLON)/2)  		&
			BY = ((MAXLAT + MINLAT)/2) 		&
			BX = MAXLON - 0.0001  			&
			CY = MINLAT + 0.0001  			&
			CX = MAXLON - 0.0001 			&
			DY = MINLAT + 0.0001  			&
			DX = ((MINLON+MAXLON)/2) 		&
			EY = (AY + DY)/2             	&
			EX = (AX + BX)/2
			.

						
quadranteD(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY):-
			maxLat(MAXLAT) & minLon(MINLON) & minLat(MINLAT) & maxLon(MAXLON) & 
			AY = ((MAXLAT+MINLAT)/2) 	&
			AX = (MINLON + 0.0001) 		&
			BY = ((MAXLAT + MINLAT)/2)  & 
			BX =((MINLON+MAXLON)/2)		&
			CY = MINLAT + 0.0001 		&
			CX = ((MINLON+MAXLON)/2) 	&
			DY = MINLAT+ 0.0001 		&
			DX = MINLON+ 0.0001 		&
			EY = (AY + DX)/2 			&
			EX = (AX + BY)/2
			.
		
+step (_):quadranteA(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY) &
			( name(agentA1)
			| name(agentA5)
			| name(agentA6)
			| name(agentA13)
			| name(agentA14)
			| name(agentA23)
			| name(agentA24)
			| name(agentA25))
			<-
			.print("estou indo");
			action(goto(EY,EX))
			.

+step (_):quadranteB(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY)&
			( name(agentA2)
			| name(agentA7)
			| name(agentA8)
			| name(agentA15)
			| name(agentA16)
			| name(agentA26)
			| name(agentA27)
			| name(agentA28))
			<-
			.print("estou indo");
			action(goto(EY , EX))
			.
			
+step (_):quadranteC(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY) &
			(name(agentA3)
			| name(agentA9)
			| name(agentA10)
			| name(agentA17)
			| name(agentA18)
			| name(agentA29)
			| name(agentA30)
			| name(agentA31))
			<-
			.print("estou indo");
			action(goto(EY,EX)).
			
+step (_):quadranteD(AX,AY,BX,BY,CX,CY,DX,DY,EX,EY) &
			( name(agentA4)
			| name(agentA11)
			| name(agentA12)
			| name(agentA19)
			| name(agentA20)
			| name(agentA32)
			| name(agentA33)
			| name(agentA34))
			<-
			.print("estou indo");
			action(goto(EY,EX))
			.

+step(_): true
		<-
		action(continue)
		.