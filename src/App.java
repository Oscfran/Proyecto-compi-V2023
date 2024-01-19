import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.FileReader;
import ParserLexer.LexerJflex;
import ParserLexer.parser;

public class App {
    public static void generarLexerParser() throws Exception {
        String basePath, fullPathLexer, fullPathParser, jlexer, jparser, jlexerCarpeta;
        MainJflexCup mjfc;

        basePath = System.getProperty("user.dir");

        //java de paser y lexer default

         //Guarda los nombres finales que tendran los .java generados por el programa
        jparser = "parser.java";
        jlexer = "LexerJflex.java";
        jlexerCarpeta = "codigoParserLexer";

        mjfc = new MainJflexCup();

        //Elimina el archivo sym.java si existe para crear el nuevo y evitar errores
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));

        //Elimina versiones anteriores de los Lexer y Parser correspondientemente
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));

        //Guarda las ubicaciones de los archivos JFlex y Java Cup
        fullPathLexer = basePath + "\\src\\codigoParserLexer\\LexerJflex.jflex";
        fullPathParser = basePath + "\\src\\codigoParserLexer\\ParserJcupIni.cup";

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
        String basePath, fullPathScanner, fullPathParser, fullPathError, fullPathSyntax, fullPathSyntax2;
        MainJflexCup mjfc;

        //Rutas de archivos txt de prueba
        basePath = System.getProperty("user.dir");
        fullPathScanner = basePath + "\\src\\codigoPrueba\\prueba.txt";
        fullPathParser = basePath + "\\src\\codigoPrueba\\pruebaParser1.txt";
        fullPathError = basePath + "\\src\\codigoPrueba\\pruebaError.txt";
        fullPathSyntax = basePath + "\\src\\codigoPrueba\\pruebaSintax.txt";
        fullPathSyntax2 = basePath + "\\src\\codigoPrueba\\pruebaSintax2.txt";

        mjfc = new MainJflexCup();

        /*//Archivo vacio
        System.out.println("Primer Archivo:");
        mjfc.ejercicioParser(fullPathScanner);

        //Archivo de prueba simple (modificable)
        System.out.println("\nSegundo Archivo:");
        mjfc.ejercicioParser(fullPathParser);

        //Archivo de prueba con errores
        System.out.println("\nTercer Archivo:");
        mjfc.ejercicioParser(fullPathError);*/

        //Archivos de prueba sintax Proyecto 2(se debe realizar un analisis lexico primero para que se genere de manera correcta)
        System.out.println("\nPrueba 1 (analisis lexico):");
        mjfc.ejercicioParser(fullPathSyntax);
        System.out.println("\nPrueba 1 (analisis sintactico):");
        mjfc.ejercicioParserSintax(fullPathSyntax);


        /*System.out.println("\nPrueba 2 (analisis lexico):");
        mjfc.ejercicioParser(fullPathSyntax2);

        System.out.println("\nPrueba 2 (analisis sintactico):");
        mjfc.ejercicioParserSintax(fullPathSyntax2);*/

    }
    
    public static void main(String[] args) throws Exception {
        /*Poner o quitar comentarios de lo que se desee ejecutar se hace asi para evitar errores(ejemplo al hacer cambios y 
        ejecutar las pruebas en la primera pasada los cambio no se han guardado y dirá que tiene errores o directamente no se mostraran los cambios, 
        pero en la segunda ejecución ya no estarán dichos errores)*/

        //generarLexerParser();
        pruebasLexerParser();

        /*Debido al package ParserLexer no se puede ejecutar si no hay archivos en dicha, carpeta mismos que se generan
        automaticamente al ejecutarse la funcion: generarLexerParser() (en la actual version deberia poder ejecutarse sin problemas)*/
    }
}