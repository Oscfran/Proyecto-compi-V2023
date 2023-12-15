import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import ParserLexer.*;
import java_cup.runtime.Symbol;
import java_cup.internal_error;
import jflex.exceptions.SilentExit;

public class MainJflexCup {
    
    //Funcio que invoca las subfunciones responsables de la generacion de los archivos del package ParserLexer
    public void iniLexerParser(String rutaLexer, String[] strArrParser) throws internal_error, Exception {
        GenerateLexer(rutaLexer);
        Generateparser(strArrParser);
    }
    //Genera el lexer
    public void GenerateLexer(String ruta) throws IOException, SilentExit {

        String[] strArr = {ruta};
        jflex.Main.generate(strArr);

    }
    //Genera el parser
    public void Generateparser(String[] strArr) throws internal_error ,IOException, Exception {
        java_cup.Main.main(strArr);
    }


    //Genera la revision de los archivos de prueba (codigoPrueba)
    public void ejercicioParser(String rutaScanear) throws IOException{
        Reader reader = new BufferedReader(new FileReader(rutaScanear));
        reader.read();
        LexerJflex lex = new LexerJflex(reader);
        int i = 0;
        Symbol token;
        while(true){
            token = lex.next_token();
            if(token.sym != 0){
                System.out.println("Token: " + token.sym + ", Valor: " + (token.value==null?lex.yytext():token.value.toString()));
            }
            else{
                System.out.println("Cantidad de lexemas encontrados: " + i);
                return;
            }
            i++;
        }
    }
}
