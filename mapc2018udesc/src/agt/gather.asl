+help(H , F , 1): role(H,_,_,_,_,_,_,_,_,_,_)
				<-
				action(goto(F));
				.
				
+help(H , F , 1): role(H,_,_,_,_,_,_,_,_,_,_) & not route([])
				<-
				action(continue);
				.

+!craft(ITEM , QTD) : 
	//item(item1,5,roles([]),parts([]))
	item( ITEM , VOL , roles( ROLES ), parts(LP) )
					<-
					.print("Entrou no craft");
						// reune partes : LISTA DE PARTES, LISTA VAZIA , RETORNO
						// plano que monta passos para ir ao nó de recurso e pegar o item.
					!gatherParts( LP , [] , R);
						//Verifica a workshop mais proxima
					?nearworkshop(FACILITY);
						//concatena na lista R a ação de ir para a workshop na lista R e retorna a nova lista
					.concat(R , [goto(FACILITY)] , NR);
						//envia para todos os agentes a crenca help para que os agentes necessários  
						//vão para o workshop, com prioridade 1(altissima).
					.concat(NR , [callBuddies( ROLES , FACILITY , 1)] , NNR);
						//concatena a acao de construir o item 
					.concat(NR , [assemble] , NNR);
					.print("printando nova nova lista" , NNR);
						//encontra o storage central no mapa
					?centerStorage(FS);
						//concatena a acao de ir para o storage central 
					.concat(NNR , [goto(FS)] , NNNR);
					.print("printando nova nova nova lista" , NNNR);
						//acao que repete o plano por quantas vezes for necessario
					!repeat(NNNR , QTD , [] , RR);
					//adiciona a lista com todos os steps na crença
					+stepsCraft(RR);
					//
					+todo(crafts)	
					.print("Saiu no craft");
					.

+!gatherParts([H|T] , LST , R ) :  true
								<-
								.wait (resourceNode( _ , LAT , LON , H ));
								.print([H|T]);
								//concatena a acao de ir para o resource node e gather em seguida
								.concat(LST , [ goto(LAT , LON) , gather] , NLST);
								//chama recursivamente
								.print(NLST);
								!gatherParts(T , NLST , R )
								.
								
+!gatherParts([] , LST , R): true
							<- 
							.print("Entrou no gatherParts Vazio");
							R = LST.

+!callBuddies([] , F , PRIO): true
						<-
						.print("Entrou no callbuddies vazio");
						.
				
+!callBuddies( [H|T], F , PRIO): true
				<-
				.print("Entrou no callbuddies");
				.broadcast(tell, help(H , F , 1));
				!callBuddies(T , F , PRIO)
	.
	
+!repeat(NNNR , QTD , L ,RR ): QTD> 0
							<-
							.print("Entrou no repeat");
							.concat(L , NNNR , NL );
							.print(NL);
							!repeat(NNNR , QTD-1 , NL , RR);
							.
							
+!repeat(NNNR , O , L , RR ) : true
							<-
							.print("Entrou no repeat vazio");
							RR = L
							.

-doing(craft):lastStepCraft(ACT) &    stepsCraft(L)
		      <-
		      -+stepsCraft(ACT | L)
		      .
		      

			
+step( _ ): doing(craft) & 	stepsCraft([H | T]) & not route([])
			<-
			.print("Entrou no step(_)");
			-+laststepcraft(H);
			action(H);
			-+stepsCraft(T);
			.								
	
