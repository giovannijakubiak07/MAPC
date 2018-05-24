
+charge(BAT): not todo(recharge,10)
	<-
		!calcular(STEPS);
	.

+!calcular(STEPS):true
	<-
		?charge(BAT);
		?lat(LATATUAL);
		?lon(LONATUAL);
		?calculatenearchargingstation(Facility,X1,Y1);
		!calculatehowmanystepsrecharge(Facility);
		!calculatedistance( LATATUAL, LONATUAL, X1, Y1, DISTANCIA );
		!calculatesteps(DISTANCIA,STEPS);
		.print(" STEPS CALCULADOS ",STEPS, " BAT ",BAT);
		!proximoPasso(STEPS,BAT);
	.

+!calculatesteps(DISTANCIA,STEPS):true
	<-
		?role(_,VELOCIDADE,_,_,_,_,_,_,_,_,_);
		.wait(constante_folga(CONSTANTE));
		DISTANCIAMTS=math.round(((DISTANCIA*112.120)*1.2)+0.5);
		ROTA= math.round(((DISTANCIAMTS/VELOCIDADE))+0.5);
		STEPSNECESSARIOS=(ROTA/VELOCIDADE)+CONSTANTE;
		STEPS=math.round(STEPSNECESSARIOS+0.5);	
	.
	
+!proximoPasso(STEPS,BAT):STEPS>=BAT
	<-
		?timerecharge(QTD);
		?calculatenearchargingstation(Facility,X1,Y1);
		.concat([goto(Facility)],LS);
		!buildstepsrecharge(LS,QTD,R);
		-+rechargesteps(R);
		+todo(recharge,10);
	.
	
	
+!proximoPasso(STEPS,BAT):STEPS<BAT
	<-
		true
	.
	
	
+!buildstepsrecharge(LS,QTD,R):QTD>0
	<-
		.concat(LS,[charge],NLS);
		!buildstepsrecharge(NLS,QTD-1,R);
	.

+!buildstepsrecharge(LS,0,R):true
	<-
		R=LS;
	.

+rechargesteps([]):true
	<-
		-todo(recharge,_);
		-rechargesteps([]);
	.
+!calculatehowmanystepsrecharge(Facility):true
	<-
		?chargingStation(Facility,_,_,CAP);
		?role(_,_,_,BAT,_,_,_,_,_,_,_);
		TEMPO = math.round((BAT/CAP)+0.5);
		-+timerecharge(TEMPO);
	.

+charge(BAT):BAT==0
	<-
		.print("Acabou minha bateria.")
	.	
{ include("regras.asl") }