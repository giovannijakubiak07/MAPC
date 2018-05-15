+step(_):role(truck,_,_,_,_,_,_,_,_,_,_) & 
		resourceNode(A,B,C,D)[source(_)] &
		
		load(100)
				<-
				action(workshop3).
			
			
+step(_):role(truck,_,_,_,_,_,_,_,_,_,_) & 
		resourceNode(A,B,C,D)[source(_)] &
		lat(B) & lon(C) &
		not hasItem(D , 5)
				<-
				action(gather).
				
//+step(_): role(truck,_,_,_,_,_,_,_,_,_,_) & 
//		resourceNode(A,B,C,D)[source(_)] &
//		hasItem(D , 5)
//				<-
//				action(goto( 48.86256,2.32476 )).
			

+step( _ ): role(truck,_,_,_,_,_,_,_,_,_,_) & 
			resourceNode(A,B,C,D)[source(_)] &
			route([])   
	<-
	action( goto( B, C) );
	.

+step( _ ): not route([])
	<-
	action( continue );
	.