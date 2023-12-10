import java.nio.file.Files;
import java.nio.file.Paths;

public class App {
    public static void generarLexerParser() throws Exception {
        String basePath, fullPathLexer, fullPathParser, jlexer, jparser, jlexerCarpeta;
        MainJflexCup mjfc;

        basePath = System.getProperty("user.dir");

        //java de paser y lexer default

        jparser = "parser.java";
        jlexer = "MyLexer.java";
        jlexerCarpeta = "";

        mjfc = new MainJflexCup();


        //Elimina el archivo sym.java si existe para crear el nuevo y evitar errores
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));

        //Guarda las ubicaciones de los archivos JFlex y Java Cup
        fullPathLexer = basePath + "\\src\\codigoParserLexer\\LexerJflex.jflex";
        fullPathParser = basePath + "\\src\\codigoParserLexer\\ParserJcupIni.cup";

        //Guarda los nombres finales que tendran los .java generados por el programa
        jparser = "parser.java";
        jlexer = "LexerJflex.java";
        jlexerCarpeta = "codigoParserLexer";

        //Elimina versiones anteriores de los Lexer y Parser correspondientemente
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
    //Funcion que prepara los archivos para ser probados por el LexerParser
    public static void pruebasLexerParser() throws Exception {
        String basePath, fullPathScanner, fullPathParser;
        MainJflexCup mjfc;

        //Rutas de archivos txt de prueba
        basePath = System.getProperty("user.dir");
        fullPathScanner = basePath + "\\src\\codigoPrueba\\prueba.txt";
        fullPathParser = basePath + "\\src\\codigoPrueba\\pruebaParser1.txt";

        mjfc = new MainJflexCup();


        //Archivo vacio
        mjfc.ejercicioParser(fullPathScanner);

        //Archivo de prueba simple (modificable)
        mjfc.ejercicioParser(fullPathParser);
    }
    
    public static void main(String[] args) throws Exception {
        //Quitar los comentarios de lo que se desee ejecutar se hace asi para evitar errores

        //generarLexerParser();

        /*Debido al package ParserLexer no se puede ejecutar si no hay archivos en dicha, carpeta mismos que se generan
        automaticamente al ejecutarse la funcion: generarLexerParser() (en la actual version deberia poder ejecutarse sin problemas)*/
       
        //pruebasLexerParser();
    }
}
