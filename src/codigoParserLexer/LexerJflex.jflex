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
<YYINITIAL> {

  /* Main */
  "function"                     { return symbol(sym.EMPEZONAVIDAD, yytext()); }
  "main"                         { return symbol(sym.ENTREGAREGALOS, yytext()); }

  /* Literales booleanos */
  {Bool}                         { return symbol(sym.l_SANTA_CLAUS, yytext()); }

  /* Literal Char*/
  {char}                         { return symbol(sym.l_COLACHO, yytext()); }

  /* Literales enteros*/
  {DecIntegerLiteral}            { return symbol(sym.l_SANTA, yytext());}

  \"                             { string.setLength(0); yybegin(CADENA); }

  /* Literales flotante */
  {DecIntegerLiteral} "." {Digits}   { return symbol(sym.l_PASCUERO, yytext()); }
  "0" "." {Digits}                   { return symbol(sym.l_PASCUERO, yytext()); }


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

  /* Tipos*/
  "char"                         { return symbol(sym.COLACHO, yytext());}
  "string"                       { return symbol(sym.SANTACLAUS, yytext());}
  "bool"                         { return symbol(sym.SANTACLAUSULA, yytext());}
  "int"                          { return symbol(sym.PAPANOEL, yytext());}
  "float"                        { return symbol(sym.SANNICOLAS, yytext());}
  "double"                       { return symbol(sym.SINTERKLASS, yytext());}
  "void"                         { return symbol(sym.VIEJITOPASCUERO, yytext());}
  "static"                       { return symbol(sym.GALLETAQUIETA, yytext());}
  
  
  /* operadores comparación*/
  "=="                           { return symbol(sym.ELFO1, yytext());}
  "!="                           { return symbol(sym.ELFO2, yytext());}
  ">"                            { return symbol(sym.ELFO3, yytext());}
  "<"                            { return symbol(sym.ELFO4, yytext());}
  "=>"                           { return symbol(sym.ELFO5, yytext());}
  "=<"                           { return symbol(sym.ELFO6, yytext());}

  /* operadores lógicos */
  "#"                            { return symbol(sym.MELCHOR, yytext()); }
  "^"                            { return symbol(sym.GASPAR, yytext()); }
  "!"                            { return symbol(sym.BALTASAR, yytext()); }

  /* operadores unarios */
  "++"                           { return symbol(sym.GRINCH, yytext());}
  "--"                           { return symbol(sym.QUIEN, yytext()); }

  /* operadores aritméticos*/
  "+"                            { return symbol(sym.RODOLFO, yytext());}
  "-"                            { return symbol(sym.COMETA, yytext()); }
  "*"                            { return symbol(sym.BAILARIN, yytext());}
  "/"                            { return symbol(sym.CUPIDO, yytext()); }
  "//"                           { return symbol(sym.CUPIENTERO, yytext());} // PARA DIVISIÓN ENTERA
  "~"                            { return symbol(sym.DONNER, yytext()); }
  "**"                           { return symbol(sym.DASHER, yytext()); }

  /* Paréntesis*/
  "("                            { return symbol(sym.ABRECUENTO, yytext());}
  ")"                            { return symbol(sym.CIERRACUENTO, yytext());}

  /* Paréntesis cuadrados*/
  "["                            { return symbol(sym.ABREEMPAQUE, yytext());}
  "]"                            { return symbol(sym.CIERRAEMPAQUE, yytext());}

  /* Llaves*/
  "{"                            { return symbol(sym.ABREREGALO, yytext());}
  "}"                            { return symbol(sym.CIERRAREGALO, yytext());}
 
  /* operador asignación */
  "<="                            { return symbol(sym.ENTREGA, yytext());}

  /* Fin de expresión */
  "|"                            { return symbol(sym.FINREGALO, yytext());}

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