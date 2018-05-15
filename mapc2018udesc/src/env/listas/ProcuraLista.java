// CArtAgO artifact code for project mapc2018udesc

package listas;

import cartago.*;
import jason.asSyntax.ASSyntax;
import jason.asSyntax.Literal;
import jason.asSyntax.parser.ParseException;

public class ProcuraLista extends Artifact {
	
	void init(int initialValue) {
	}

	@OPERATION
	void procurar( String lista[], String item, int quantidade, OpFeedbackParam<Literal> resultado ) {
		//[required(item6,1),required(item7,2),required(item9,3)]
//		lista = lista.replaceAll("[", "").replaceAll("]", "");
//		System.out.println( lista );
//		String s[] = lista.split("required");
//		System.out.println( s );
//		item = item.replaceAll( "required", "" );
//		
//		for( int i = 0; i < s.length; i++ ) {
//			if( s[ i ].endsWith( "," ) ) {
//				s[ i ] = s[ i ].substring(0,  s[i].length() - 1);
//			}
//			s[ i ] = s[i].substring(1, s[i].length()- 1 );
//			String s2[] = s[i].split(",");
//			if( s2[ 0 ].equals( item ) && Integer.parseInt( s2[1]) >= quantidade ) {
//				try {
//					resultado.set( ASSyntax.parseLiteral( "possue" ) );
//					break;
//				} catch (ParseException e) {
//					e.printStackTrace();
//				}
//			}
//		}
		
		try {
			resultado.set( ASSyntax.parseLiteral( "naoPossue" ) );
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}

