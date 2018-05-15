//job(job0,storage0,392,1,77,[required(item6,1),required(item7,2),required(item9,3)])

hasItem(item0,10).
hasItem(item1,10).
hasItem(item2,10).
hasItem(item3,10).
hasItem(item4,10).
hasItem(item5,10).
hasItem(item6,10).
hasItem(item7,10).
hasItem(item8,10).
hasItem(item9,10).


//1- Verificando se o grupo de agentes tem os itens necessario para o job			
+job( TITLE , _ , _ , _ , _ , LISTA) :  name(NOME)  
										<- 	
			
			
			for( hasItem( ITEM, QTD ) ){
		
			!percorrerLista( LISTA, ITEM, QTD, R );
			
			if( R == true ){
				.print( "SIM! Eu tenho ", ITEM, ", ", QTD, " suficiente para realizar o job " , TITLE );
				.broadcast( tell , agentePossuiItemParaJob(NOME, TITLE , ITEM , QTD));
				
			}else{
				.print( "Eu não tenho ", ITEM, ", ", QTD, " suficiente." );
			}
			
			!verificaItensParaJob(R ,TITLE,  0);
	   	}
	.

+!percorrerLista( [], _, _, R )
	: true 
	<- R = false.

+!percorrerLista( [ required( I, Q ) | T ], ITEM, QTD, R )
	: I == ITEM & Q <= QTD
	<- 
	R = true
	.

+!percorrerLista( [ required( I, Q ) | T ], ITEM, QTD, R )
	: I \== ITEM | Q > QTD
	<- 
	!percorrerLista( T, ITEM, QTD, R ).
	

//2 - VERIFICANDO SE TEM TODOS OS ITENS PARA REALIZAR O JOB


+!verificaItensParaJob(R , TITLE , X): R==false 
		<-
		true
		.
		


+!verificaItensParaJob(R , TITLE , X): job( TITLE, _, _, _, _, [ required( I, Q ) | T ] ) &
										 R==true &
										 .length(LISTA , TAMANHO)
		<-
		
		for(agentePossuiItemParaJob(NOME, TITLE , ITEM , QTD)){
			if(I == ITEM){
				X = X+1;
				.print("Item compatível para este job.");
				
			}
			else{
				.print("Item incompatível para este job.");
			}
			!verificaItensParaJob(R , T , X);
		}
		if (X == TAMANHO){
			.print("Tem todos os itens!");
			
		}
		.