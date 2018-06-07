//+help(AGENT, H , F , PRIO): role(H,_,_,_,_,_,_,_,_,_,_)
//				<-
//				+stepsHelp( [goto(F) ]);
//				+todo( help, PRIO);
//				+quemPrecisaAjuda( AGENT );
//				.

+!craftSemParts(NOME , ITEM)	:	role(_,_,_,LOAD,_,_,_,_,_,_,_)	&	item(ITEM,TAM,_,_)
	<-	
		.wait(resourceNode(NOME,LATRESOUR,LONRESOUR,ITEM));
		LIST = [goto(LATRESOUR, LONRESOUR)];
		QTD = math.floor( (LOAD / TAM) ) ;
		!repeat( [gather], QTD, [], R );
		.concat(LIST, R, NLIST);
		.wait(centerStorage(FS));
		+currentStorage(FS);
		.concat(NLIST, [goto(FS)] , NNLIST);
		.concat(NNLIST, [store(ITEM,_)] , NNNLIST);
		-+stepsCraftSemParts(NNNLIST);
		+todo(craftSemParts,8);
	.

+!craftComParts(ITEM, ROLE, OTHERROLE)
	:	
		role(ROLE,_,_,LOAD,_,_,_,_,_,_,_)
	&	item( ITEM, TAM, roles(LROLES), parts(LPARTS) )
	&	storageCentral(STORAGE)
	&	workshopCentral(WORKSHOP)
	<-	
		.print("Entrou no craft");
		PASSOS_1 = [callBuddies( ROLE, STORAGE, 7), goto(STORAGE)];
		!passosPegarItens(PASSOS_1, LPARTS, PASSOS_2);
		.concat( PASSOS_2, [goto(WORKSHOP), assemble, goto(STORAGE),store(ITEM,_)], PASSOS_3 );
		.print( PASSOS_3 );
		-+stepsCraftComParts( PASSOS_3 );
		+todo(craftComParts,8);	
		.print("Saiu no craft");
	.

+!passosPegarItens(LIST, [], LISTARETRIEVE)
	:	true
	<-	
		LISTARETRIEVE = LIST;
	.

+!passosPegarItens(LIST, [H|T], LISTARETRIEVE)
	:	true
	<-	
		.concat(LIST, [retrieve( H, 1)], NLIST);
		!passosPegarItens(NLIST,T,LISTARETRIEVE);
	.

+stepHelp( [] ): 	quemPrecisaAjuda(QUEM)
	<- 	//-todo(help, _); 
		-stepsHelp([]);
		.send(QUEM, tell, cheguei);
		-quemPrecisaAjuda(QUEM);
	.

+stepsCraftSemParts( [] ): 	true
	<- 	
		-stepsCraftSemParts([]);
		-todo(craftSemParts, _);
		.print( "terminou craftsemPartes");
		//procura nova tarefa.
	.

+stepsCraftComParts( [] ): 	true
	<- 	
		-stepsCraftSemParts([]);
		-todo(craftSemParts, _);
		.print( "terminou craftComPartes");
		//procura nova tarefa.
	.


+!passosPegarItens(LIST, [], LISTARETRIEVE)	:	true
	<-	
		LISTARETRIEVE = LIST;
	.

+!passosPegarItens(LIST, [H|T], LISTARETRIEVE)	:	true
	<-	
		.concat(LIST, [retrieve( H, 1)], NLIST);
		!passosPegarItens(LIST,T,NLIST);
	.

+stepHelp( [] ): 	quemPrecisaAjuda(QUEM)
	<- 	//-todo(help, _); 
		-stepsHelp([]);
		.send(QUEM, tell, cheguei);
		-quemPrecisaAjuda(QUEM);
	.

+stepsCraftSemParts( [] ): 	true
	<- 	//-todo(help, _); 
		-stepsCraftSemParts([]);
		-todo(craftSemParts, _);
//		.print( "terminou craftsemPartes");
		//procura nova tarefa.
	.
+!gatherParts([H|T] , LST , R ) :  true
								<-
								.wait(resourceNode( _ , LAT , LON , H ));
//								.print([H|T]);
								//concatena a acao de ir para o resource node e gather em seguida
								.concat(LST , [ goto(LAT , LON) , gather] , NLST);
								//chama recursivamente
//								.print(NLST);
								!gatherParts(T , NLST , R )
								.
								
+!gatherParts([] , LST , R): true
							<- 
//							.print("Entrou no gatherParts Vazio");
							R = LST.

+!callBuddies([] , F , PRIO): true
						<-
						true//.print("Entrou no callbuddies vazio");
						.
				
+!callBuddies( [H|T], F , PRIO): name(QUEMPRECISA)
				<-
//				.print("Entrou no callbuddies");
				.broadcast(tell, help( QUEMPRECISA, H, F , PRIO));
				!callBuddies( T , F , PRIO);
				.
	
+!repeat(NNNR , QTD , L ,RR ): QTD> 0
							<-
//							.print("Entrou no repeat");
							.concat(L , NNNR , NL );
//							.print(NL);
							!repeat(NNNR , QTD-1 , NL , RR);
							.
							
+!repeat(NNNR , O , L , RR ) : true
							<-
//							.print("Entrou no repeat vazio");
							RR = L
							.

//-doing(exploration): explorationsteps(ACTS) & lat(LAT) & lon(LON)
//	<-
//		-+explorationsteps([goto(LAT,LON)|ACTS]);
//	.
-doing(craftSemParts)	:	stepsCraftSemParts(L)
	&	lat(LAT)
	&	lon(LON)
	& 	currentStorage(STORAGE)
	//&	acaoValida( ACTION )
	<-	
//		.print("ACTION: ", ACTION);
//		?stepsCraftSemParts( LIST );
//		.print( "1 ", LIST );
		-+stepsCraftSemParts([goto(STORAGE) | L]);
//		.print( "SLAT: ", SLAT, ", SLON: ", SLON );
//		?stepsCraftSemParts( LIST2 );
//		.print( "2 ",LIST2 );
	.
	
			
+step( _ ): doing(craft) & 	stepsCraft([H | T]) & not route([])
			<-
			.print("Entrou no step(_)");
			-+laststepcraft(H);
			action(H);
			-+stepsCraft(T);
			.								

//+!craftComParts(ITEM): item( ITEM, TAM, roles(LROLES), parts(LPARTS) )
//					 &	storageCentral(STORAGE)
//								  <-	
//		.print("Entrou no craftComParts");
//		.broadcast(tell ,tellLocation(ROLE));
//		.wait(nearRoleToStore(Facility , ROLE , NAME));
//		.print("O ", ROLE, " MAIS PR�XIMO � O: ", NAME);
//		!craftComParts
//	.
//+!tellLocation(ROLE)[source(SOURCE)]: entity(NAME,_,LAT,LON,ROLE)
//												<-
//		.print("contando localizacao");						
//		.send(SOURCE , tell , localizacaoAgProximo(ROLE, NAME , LAT , LON));
//	.


//+!verificaItensPossiveis( ITEM , NADA , LIST ): storageCentral(STORAGE) &
//							 storage(STORAGE,_,_,_,_,ITEMQUEPOSSUIMOS)
//							 & item(ITEM,_,_,parts([ITEMPARAOITEM|TAIL]))
//							& not verificado(ITEM , LISTADEITENSVERIFICADOS)&
//							POSSIVEL = .member(ITENSPARAOITEM ,ITEMQUEPOSSUIMOS)
//						<-
//						.concat(LISTADEITENSVERIFICADOS , ITENSPARAOITEM , NOVALISTA);
//						verificado(ITEM , NOVALISTA)
//						.print("Verificado");
//						!verificaItensPossiveis( ITEM , POSSIVEL);
//.
