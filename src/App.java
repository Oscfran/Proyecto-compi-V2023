import java.nio.file.Files;
import java.nio.file.Paths;

public class App {
    public static void generarLexerParser() throws Exception {
        String basePath, fullPathLexer, fullPathParser, jlexer, jparser, jlexerCarpeta;
        MainJflexCup mjfc;

        basePath = System.getProperty("user.dir");

        //java de paser y lexer

        jparser = "parser.java";
        jlexer = "MyLexer.java";
        jlexerCarpeta = "";

        mjfc = new MainJflexCup();


        //Elimina el archivo sym.java si existe para crear el nuevo y evitar errores
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));

        fullPathLexer = basePath + "\\src\\codigoParserLexer\\LexerJflex.jflex";
        fullPathParser = basePath + "\\src\\codigoParserLexer\\ParserJcupIni.cup";

        jparser = "parser.java";
        jlexer = "LexerJflex.java";
        jlexerCarpeta = "codigoParserLexer";


        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));

        //crear el analizador lexico y sintactico

        String[] strArrParser = {fullPathParser}; //flag para el nombre del parser
        mjfc.iniLexerParser(fullPathLexer, strArrParser);


        //Mueve los archivos generados a la carpeta parser lexer para mauor facilidad
        Files.move(Paths.get(basePath + "\\sym.java"),Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));
        Files.move(Paths.get(basePath + "\\" + jparser),Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));
        Files.move(Paths.get(basePath + "\\src\\" + jlexerCarpeta + "\\" + jlexer),Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));

    }

    public static void pruebasLexerParser() throws Exception {
        String basePath, fullPathScanner, fullPathParser;
        MainJflexCup mjfc;

        basePath = System.getProperty("user.dir");
        fullPathScanner = basePath + "\\src\\codigoPrueba\\prueba.txt";
        fullPathParser = basePath + "\\src\\codigoPrueba\\pruebaParser1.txt";

        mjfc = new MainJflexCup();

        //mjfc.ejercicioParser(fullPathScanner);

        mjfc.ejercicioParser(fullPathParser);
    }
    
    public static void main(String[] args) throws Exception {
        //generarLexerParser();
        pruebasLexerParser();
    }
}
