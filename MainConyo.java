
/*Import*/
import java.io.*;
import java_cup.runtime.*;

class MainConyo 
{
	/**
   * Runs the scanner on input files.
   *
   * This main method is the debugging routine for the scanner.
   * It prints debugging information about each returned token to
   * System.out until the end of file is reached, or an error occured.
   *
   * @param argv   the command line, contains the filenames to run
   *               the scanner on.
   */
  public static void main(String argv[]) {
		for (int i = 0; i < argv.length; i++) {
		  try {
			ConyoLexer s = new ConyoLexer(new FileReader(argv[i]));
			Parser p = new Parser(s);
			p.parse();
		  }
		  catch (Exception e) {
			e.printStackTrace(System.out);
			System.exit(1);
		  }
		}
	}
}