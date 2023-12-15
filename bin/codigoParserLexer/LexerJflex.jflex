package ParserLexer;
import java_cup.runtime.*;

%%

%class LexerJflex
%public
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* Comentarios */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/_" [^*] ~"_/" | "/_" "_"+ "/"

// El comentario puede ser final de documento sin necesidad de final de linea.
EndOfLineComment     = "@" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

Bool = "true" | "false"


%state CADENA

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.NAVIDAD);  }
<YYINITIAL> "public"             { return symbol(sym.FESTIVAL); }
<YYINITIAL> "private"            { return symbol(sym.FIESTA);   }

<YYINITIAL> {
  /* literales booleanos(se coloca aqui antes de los identificadores para evitar ser declarado como id en vez de boolean) */
  {Bool}                         { return symbol(sym.l_SANTA_CLAUS); }

  /* Estructuras de control */
  "if"                           { return symbol(sym.ELFO);     }
  "elif"                         { return symbol(sym.HADA);     }
  "else"                         { return symbol(sym.DUENDE);   }
  "for"                          { return symbol(sym.ENVUELVE); }
  "do"                           { return symbol(sym.HACE);     }
  "until"                        { return symbol(sym.REVISA);   }
  "return"                       { return symbol(sym.ENVIA);    }
  "break"                        { return symbol(sym.CORTA);    }

  /* identificadores */ 
  {Identifier}                   { return symbol(sym.PERSONA);  }
 
  /* literales */
  {DecIntegerLiteral}            { return symbol(sym.l_SANTA);  }
  \"                             { string.setLength(0); yybegin(CADENA); }

 /* Tipos*/
  "string"                       { return symbol(sym.SANTACLAUS);}
  "int"                          { return symbol(sym.PAPANOEL);}
  "float"                        { return symbol(sym.SANNICOLAS);}
  "double"                       { return symbol(sym.SINTERKLASS);}
  "void"                         { return symbol(sym.VIEJITOPASCUERO);}
  "char"                         { return symbol(sym.COLACHO);}
  
  /* operadores comparación*/
  "=="                           { return symbol(sym.ELFO1); }
  "!="                           { return symbol(sym.ELFO2); }
  ">"                            { return symbol(sym.ELFO3); }
  "<"                            { return symbol(sym.ELFO4); }
  ">="                           { return symbol(sym.ELFO5); }
  "<="                           { return symbol(sym.ELFO6); }

  /* operadores lógicos */
  "||"                           { return symbol(sym.MELCHOR); }
  "&&"                           { return symbol(sym.GASPAR); }
  "!"                            { return symbol(sym.BALTASAR); }

  /* operadores unarios */
  "++"                           { return symbol(sym.GRINCH);}
  "--"                           { return symbol(sym.QUIEN); }

  /* operadores aritméticos*/
  "+"                            { return symbol(sym.RODOLFO);}
  "-"                            { return symbol(sym.COMETA); }
  "*"                            { return symbol(sym.BAILARIN);}
  "/"                            { return symbol(sym.CUPIDO); }

  /* Paréntesis*/
  "("                            { return symbol(sym.ABRECUENTO);}
  ")"                            { return symbol(sym.CIERRACUENTO);}

  /* Paréntesis cuadrados*/
  "["                            { return symbol(sym.ABREEMPAQUE);}
  "]"                            { return symbol(sym.CIERRAEMPAQUE);}

  /* Llaves*/
  "{"                            { return symbol(sym.ABREREGALO);}
  "}"                            { return symbol(sym.CIERRAREGALO);}
 
  /* operador asignación */
  "="                            { return symbol(sym.ENTREGA);}

  /* Fin de expresión */
  ";"                            { return symbol(sym.FINREGALO); }

  /* Separador */
  ","                            { return symbol(sym.MUERDAGO); }

  /* print */
  "print"                        { return symbol(sym.NARRA); }

  /* read */
  "read"                         { return symbol(sym.ESCUCHA); }
  
  /* Comentarios */
  {Comment}                      { /* Se ignora */ }
 
  /* whitespace */
  {WhiteSpace}                   { /* Se ignora */ }
}



<CADENA> {
  \"                             { yybegin(YYINITIAL); 
                                   return symbol(sym.l_PAPANOEL, 
                                   '"'+string.toString()+'"'); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

/* Manejo de errores */
[^] {
    System.err.println("Error léxico en la línea " + (yyline + 1) + ": Carácter no reconocido '" + yytext() + "'");
}
