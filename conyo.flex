/*Import*/
import java.io.*;
import java_cup.runtime.*;

/**
 * Conyo++ Language Lexer
 * CHUA, Jedrick
 * LIVELO, Evan Dennison
 * YAO, John Paul
 */
%%

%class ConyoLexer
%unicode
%line
%column
%cup
%debug

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}

/*Regular Expressions*/
/*Atomic regex*/
letter = [a-zA-Z]
number = [0-9]
ascii = [^\n\r]
underscore = [_]
newline = \r|\n|\r\n
white_space = [\n\r\ \t\b\012] | {newline}

/*Validation regex*/

valid_char = [^\n\r\"\\]
valid_string = {valid_char}*
identifier = [a-zA-Z_][a-zA-Z0-9_]*

/*Numeric values*/
integer = 0 | [1-9]{number}*
float = {integer}\.{integer}(e{integer})?

/*Various states of lexer (excluding YYINITIAL)*/
%state STRING
%state CHARACTER

%%
/*Keywords*/
<YYINITIAL> "OMG" {return symbol(sym.OMG);}
<YYINITIAL> "hireYaya" {return symbol(sym.HIRE_YAYA);}
<YYINITIAL> "bayad" {return symbol(sym.BAYAD);}
<YYINITIAL> "makeBalik" {return symbol(sym.MAKE_BALIK);}
<YYINITIAL> "superYaya" {return symbol(sym.SUPER_YAYA);}
<YYINITIAL> "makeArte" {return symbol(sym.MAKE_ARTE);}
<YYINITIAL> "brandNew" {return symbol(sym.BRAND_NEW);}
<YYINITIAL> "makeUtusan" {return symbol(sym.MAKE_UTUSAN);}
<YYINITIAL> "breakup" {return symbol(sym.BREAKUP);}
<YYINITIAL> "makeup" {return symbol(sym.MAKEUP);}
<YYINITIAL> "makeTawag" {return symbol(sym.MAKE_TAWAG);}
<YYINITIAL> "makeSulat" {return symbol(sym.MAKE_SULAT);}
<YYINITIAL> "makeBasa" {return symbol(sym.MAKE_BASA);}
<YYINITIAL> "likeKapag" {return symbol(sym.LIKE_KAPAG);}
<YYINITIAL> "thisNalang" {return symbol(sym.THIS_NALANG);}
<YYINITIAL> "thisNalangKapag" {return symbol(sym.THIS_NALANG_KAPAG);}
<YYINITIAL> "makePalit" {return symbol(sym.MAKE_PALIT);}
<YYINITIAL> "MRW" {return symbol(sym.MRW);}
<YYINITIAL> "MDR" {return symbol(sym.MDR);}
<YYINITIAL> "likeHabang" {return symbol(sym.LIKE_HABANG);}
<YYINITIAL> "makeGawa" {return symbol(sym.MAKE_GAWA);}
<YYINITIAL> "makeUlit" {return symbol(sym.MAKE_ULIT);}
<YYINITIAL> "inty" {return symbol(sym.INTY, yytext());}
<YYINITIAL> "floaty" {return symbol(sym.FLOATY, yytext());}
<YYINITIAL> "chary" {return symbol(sym.CHARY, yytext());}
<YYINITIAL> "stringy" {return symbol(sym.STRINGY, yytext());}
<YYINITIAL> "booly" {return symbol(sym.BOOLY, yytext());}
<YYINITIAL> "yuhh" {return symbol(sym.BOOL_LITERAL, yytext());}
<YYINITIAL> "nuhh" {return symbol(sym.BOOL_LITERAL, yytext());}
<YYINITIAL> "poor" {return symbol(sym.POOR, yytext());}
<YYINITIAL> "waley" {return symbol(sym.WALEY, yytext());}
<YYINITIAL> "makeKuha" {return symbol(sym.MAKE_KUHA);}
<YYINITIAL> "makeSimula" {return symbol(sym.MAKE_SIMULA);}
<YYINITIAL> "db" {return symbol(sym.DB);}

/*YYINITIAL State*/
<YYINITIAL> {
	/*Symbols*/
	"," { return symbol(sym.COMMA); }
	":" { return symbol(sym.COLON); }
	"$" { return symbol(sym.DOLLAR_SIGN); }
	"(" { return symbol(sym.LEFT_PAREN); }
	")" { return symbol(sym.RIGHT_PAREN); }
	"[" { return symbol(sym.LEFT_BRACE); }
	"]" { return symbol(sym.RIGHT_BRACE); }
	"{" { return symbol(sym.LEFT_CURLY); }
	"}" { return symbol(sym.RIGHT_CURLY); }
	"." { return symbol(sym.PERIOD); }
	"+" { return symbol(sym.PLUS); }
	"-" { return symbol(sym.MINUS); }
	"*" { return symbol(sym.TIMES); }
	"/" { return symbol(sym.DIVIDE); }
	"%" { return symbol(sym.MODULO); }
	"<>" { return symbol(sym.NOT_EQUAL); }
	"<"  { return symbol(sym.LESS_THAN); }
	"<=" { return symbol(sym.LT_EQUAL); }
	">"  { return symbol(sym.GREATER_THAN); }
	">=" { return symbol(sym.GT_EQUAL); }
	"==" { return symbol(sym.EQUAL_EQUAL); }
	"&"  { return symbol(sym.AND); }
	"|"  { return symbol(sym.OR); }
	"!" { return symbol(sym.NOT); }
	\'  { yybegin(CHARACTER); }
	\" { yybegin(STRING); }
	"++" { return symbol(sym.POS_INC); }
	"--" { return symbol(sym.NEG_INC); }
	
	/*Literals*/
	{integer} {return symbol(sym.INT_LITERAL, Integer.parseInt(yytext()));}
	{float} {return symbol(sym.FLOAT_LITERAL, Float.parseFloat(yytext()));}
	{identifier} {return symbol(sym.IDENTIFIER, yytext());}
}

/*When inputting a string*/
<STRING> { 
	\" {yybegin(YYINITIAL);}
	{valid_string} {return symbol(sym.STRING_LITERAL, yytext());}
}

/*When inputting a character*/
<CHARACTER> {
	{valid_char}\' {yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, yytext().substring(0, 1));}
}

{white_space} {/*blank*/}

<<EOF>> {return symbol(sym.EOF);}

. {
	System.out.println("Invalid.");
}

