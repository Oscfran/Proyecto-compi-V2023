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
DocumentationComment = "/__" {CommentContent} "_"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

Digits = [0-9]*

Bool = "true" | "false"

char = "'" {InputCharacter} "'"


%state CADENA
%state INICIAL 

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.NAVIDAD);  }
<YYINITIAL> "public"             { return symbol(sym.FESTIVAL); }
<YYINITIAL> "private"            { return symbol(sym.FIESTA);   }

<YYINITIAL> {

  /* Main */
  "function"                     { return symbol(sym.EMPEZONAVIDAD, yytext()); }
  "main"                         { return symbol(sym.ENTREGAREGALOS, yytext()); }

  /* literales booleanos */
  {Bool}                         { return symbol(sym.l_SANTA_CLAUS, yytext()); }

  {char}                         { return symbol(sym.l_COLACHO, yytext()); }


  /* Estructuras de control */
  "if"                           { return symbol(sym.ELFO);      }
  "elif"                         { return symbol(sym.HADA);      }
  "else"                         { return symbol(sym.DUENDE);    }
  "for"                          { return symbol(sym.ENVUELVE);  }
  "while"                        { return symbol(sym.ENVOLTURA); }
  "do"                           { return symbol(sym.HACE);      }
  "until"                        { return symbol(sym.REVISA);    }
  "return"                       { return symbol(sym.ENVIA);     }
  "break"                        { return symbol(sym.CORTA);     }
  "local"                        { return symbol(sym.POLO);      }

 
  /* literales */
  {DecIntegerLiteral}            { return symbol(sym.l_SANTA, yytext());  }
  \"                             { string.setLength(0); yybegin(CADENA); }
  /* Número literal flotante */
  {DecIntegerLiteral} "." {Digits}   { return symbol(sym.l_PASCUERO, yytext()); }
  "0" "." {Digits}?                      { return symbol(sym.l_PASCUERO, yytext()); }

 /* Tipos*/
  "char"                         { return symbol(sym.COLACHO, yytext());}
  "string"                       { return symbol(sym.SANTACLAUS, yytext());}
  "bool"                         { return symbol(sym.SANTACLAUSULA, yytext());}
  "int"                          { return symbol(sym.PAPANOEL, yytext());}
  "float"                        { return symbol(sym.SANNICOLAS, yytext());}
  "double"                       { return symbol(sym.SINTERKLASS, yytext());}
  "void"                         { return symbol(sym.VIEJITOPASCUERO, yytext());}
  
  /* operadores comparación*/
  "=="                           { return symbol(sym.ELFO1); }
  "!="                           { return symbol(sym.ELFO2); }
  ">"                            { return symbol(sym.ELFO3); }
  "<"                            { return symbol(sym.ELFO4); }
  "=>"                           { return symbol(sym.ELFO5);}
  "=<"                           { return symbol(sym.ELFO6);}

  /* operadores lógicos */
  "#"                            { return symbol(sym.MELCHOR); }
  "^"                            { return symbol(sym.GASPAR); }
  "!"                            { return symbol(sym.BALTASAR); }

  /* operadores unarios */
  "++"                           { return symbol(sym.GRINCH);}
  "--"                           { return symbol(sym.QUIEN); }

  /* operadores aritméticos*/
  "+"                            { return symbol(sym.RODOLFO, yytext());}
  "-"                            { return symbol(sym.COMETA, yytext()); }
  "*"                            { return symbol(sym.BAILARIN, yytext());}
  "/"                            { return symbol(sym.CUPIDO, yytext()); }
  "~"                            { return symbol(sym.DONNER, yytext()); }
  "**"                           { return symbol(sym.DASHER, yytext()); }

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
  "<="                            { return symbol(sym.ENTREGA, yytext());}

  /* Fin de expresión */
  "|"                            { return symbol(sym.FINREGALO); }

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

  /* identificadores (se coloca al final para eviotar ambiguedades)*/ 
  {Identifier}                   { return symbol(sym.PERSONA, yytext());  }
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