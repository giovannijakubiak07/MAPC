+help(AGENT, H , F , PRIO): role(H,_,_,_,_,_,_,_,_,_,_)
				<-
				+stepsHelp( [goto(F) ]);
				+todo( help, PRIO);
				+quemPrecisaAjuda( AGENT );
				.

+!craftSemParts(NOME , ITEM)
	:	role(_,_,_,LOAD,_,_,_,_,_,_,_)
	&	item(ITEM,TAM,_,_)
	<-	
		.wait(resourceNode(NOME,LATRESOUR,LONRESOUR,ITEM));
		LIST = [goto(LATRESOUR, LONRESOUR)];
		QTD = math.floor( (LOAD / TAM) ) ;
		!repeat( [gather], QTD, [], R );
		.concat(LIST, R, NLIST);
		.wait(centerStorage(FS));
//		.wait(nearstorage(FS, LATRESOUR, LONRESOUR));
		+currentStorage(FS);
						//concatena a acao de ir para o storage central 
						.concat(NLIST, [goto(FS)] , NNLIST);
//						.print("printando nova nova nova nova lista" , NNLIST);
						.concat(NNLIST, [store(ITEM,_)] , NNNLIST);
//						.print("3nlist " , NNNLIST);
						//.concat(NNNLIST, [retrieve(ITEM,1)], NNNNLIST);
						//adiciona a lista com todos os steps na crença
						-+stepsCraftSemParts(NNNLIST);
						+todo(craftSemParts,8);
					.

//+!craftComParts : storage(storage2,_,_,_,_,LISTADEITENS)
//				<-	
//				
//				.

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
-doing(craftSemParts)
	:	stepsCraftSemParts(L)
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
	