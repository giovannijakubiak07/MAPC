+!craft(ITEM , QTD) : item(ITEM , VOL , roles([H|T]) ,parts(LP))
					<-
					.print("Entrou no craft");
						// reune partes : LISTA DE PARTES, LISTA VAZIA , RETORNO
						// plano que monta passos para ir ao nó de recurso e pegar o item.
					!gatherParts(LP , [] , R);
						//Verifica a workshop mais proxima
					?nearworkshop(F);
						//concatena na lista R a ação de ir para a workshop na lista R e retorna a nova lista
					.concat(R , goto(F) , NR);
						//envia para todos os agentes a crenca help para que os agentes necessários  
						//vão para o workshop, com prioridade 1(altissima).
					!callBuddies(roles([H|T]) , F , 1);
						//concatena a acao de construir o item 
					.concat(NR , [assemble] , NNR);
						//encontra o storage central no mapa
					?centerStorage(FS);
						//concatena a acao de ir para o storage central 
					.concat(NNR , [goto(FS) , NNNR]);
						//acao que repete o plano por quantas vezes for necessario
					!repeat(NNNR , QTD , [] , RR);
					//adiciona a lista com todos os steps na crença
					+stepsCraft(RR);
					//
					+todo(crafts)	
					.print("Saiu no craft");
					.
+!callBuddies(LISTROLES , F , PRIO): LISTROLES[]
						<-
						.print("Entrou no callbuddies vazio");
						true;
						.
				
+!callBuddies(LISTROLES , F , PRIO): LISTROLES[H|T]
				<-
				.print("Entrou no callbuddies");
				.broadcast(help(H , F , 1));
				!callBuddies(T , F , PRIO)
	.

					
+!gatherParts([H|T] , LST , R ) :  resourceNode( _ , LAT , LON , H )
								<-
								.print("Entrou no gatherParts");
								//concatena a acao de ir para o resource node e gather em seguida
								.concat(LST , [ goto(LAT , LON) , gather] , NLST);
								//chama recursivamente
								!gatherParts(T , NLST , R )
								.
								
+!gatherParts([] , LST , R): true
							<- 
							.print("Entrou no gatherParts Vazio");
							R = LST.
							
							
+!repeat(NNNR , O , L , RR ) : true
							<-
							.print("Entrou no repeat vazio");
							RR = L
							.


+!repeat(NNNR , QTD , L ,RR ): QTD> 0
							<-
							.print("Entrou no repeat");
							.concat(L , NNNR , NL );
							!repeat(NNNR , QTD-1 , NL , RR)
							.
							
						
+step( _ ): doing(craft) & 
			stepsCraft([H | T])
			<-
			.print("Entrou no step(_)");
			-+laststepcraft(H);
			.action(H);
			-+stepsCraft(T);
			.

-doing(craft):lastStepCraft(ACT) & 
		      stepsCraft(L)
		      <-
		      -+stepsCraft(ACT | L).
		      
		      
+help(H , F , 1): role(H,_,_,_,_,_,_,_,_,_,_)
				<-
				action(goto(F))
				.
			
								
	


// uncomment the include below to have an agent compliant with its organization
//{ include("$moiseJar/asl/org-obedient.asl") }
