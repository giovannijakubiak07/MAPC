+step( _ ): ( role(truck,_,_,_,_,_,_,_,_,_,_) | role(car,_,_,_,_,_,_,_,_,_,_) | role(motorcycle,_,_,_,_,_,_,_,_,_,_) )& 
		lastAction(noAction)&
		charge(BAT)&
		BAT > 0 &
		resourceNode(A,B,C,D)[source(_)] &
		route([])& not esta_resource_node   
<-

	+item_carregar(D);
	+esta_resource_node;
	action( goto( B, C) )
.

+step( _ ): esta_resource_node &
 				route([]) &
  				load( CAPACIDADEATUAL ) &
  				role(_,_,_, CAPACIDADEBASE,_,_,_,_,_,_,_) &
 				CAPACIDADEATUAL<(CAPACIDADEBASE-10)
<-
	-esta_resource_node;
	+pegou_itens;
	action(gather);
.



+step( _ ): pegou_itens & 
				not esta_resource_node &
				route([])&
				load( CAPACIDADEATUAL ) &
  				role(_,_,_,CAPACIDADEBASE,_,_,_,_,_,_,_) &
 				CAPACIDADEATUAL>=(CAPACIDADEBASE-10)
<-
	-pegou_itens;
	+esta_no_workshop;
	?nearworkshop(Facility);
	action(goto(Facility));
	.

+step( _ ): esta_no_workshop & 
					route([])&
				not pegou_itens
<-
	-esta_no_workshop;
	?item_carregar(ITEM);
	action(assemble(ITEM));
.

+step( _ ): esta_resource_node &
 				route([]) &
  				load( CAPACIDADEATUAL ) &
  				role(_,_,_, CAPACIDADEBASE,_,_,_,_,_,_,_) &
 				CAPACIDADEATUAL==(CAPACIDADEBASE-10) &
 				name(NOME)
<-
	+toPraticamenteCheio;
	action(noAction);
	?hasItem(ITEM,QUANT);
	.print("Item ",ITEM,
		" QUANT ",QUANT
	)
	.broadcast(tell, tenhoItem(ITEM,QUANT,NOME));
.


+step( _ ): not route([])
<-
	action( continue );
	?name(NOME);
	?step(PASSO);
	?charge(CARGA);
	?routeLength(TAMANHOROTA);
	?role(PAPEL,_,_,_,_,_,_,_,_,_,_);
	.print("EU SOU O AGENTE ",NOME," SOU UM ",PAPEL," NO PASSO ",PASSO," A MINHA CARGA É ",
		CARGA," E O TAMANHO DA MINHA ROTA É ",TAMANHOROTA
	);.