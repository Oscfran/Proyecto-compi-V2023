/* JFlex example: partial Java language lexer specification */
package ParserLexer;
import java_cup.runtime.*;

/**
 * This class is a simple example lexer.
 */
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

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state CADENA

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.NAVIDAD); }
<YYINITIAL> "public"              { return symbol(sym.FESTIVAL); }
<YYINITIAL> "private"              { return symbol(sym.FIESTA); }

<YYINITIAL> {
  /* identifiers */ 
  {Identifier}                   { return symbol(sym.PERSONA); }
 
  /* literals */
  {DecIntegerLiteral}            { return symbol(sym.l_SANTA); }
  \"                             { string.setLength(0); yybegin(CADENA); }

  /* operators */
  "="                            { return symbol(sym.ENTREGA); }
  "=="                           { return symbol(sym.ELFO1); }
  "+"                            { return symbol(sym.RODOLFO); }

  /* comments */
  {Comment}                      { /* ignore */ }
 
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
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

/* error fallback */
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }