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
<YYINITIAL> "OMG" {return symbol(sym.OMG, yyline+1);}
<YYINITIAL> "hireYaya" {return symbol(sym.HIRE_YAYA, yyline+1);}
<YYINITIAL> "bayad" {return symbol(sym.BAYAD, yyline+1);}
<YYINITIAL> "makeBalik" {return symbol(sym.MAKE_BALIK, yyline+1);}
<YYINITIAL> "superYaya" {return symbol(sym.SUPER_YAYA, yyline+1);}
<YYINITIAL> "makeArte" {return symbol(sym.MAKE_ARTE, yyline+1);}
<YYINITIAL> "brandNew" {return symbol(sym.BRAND_NEW, yyline+1);}
<YYINITIAL> "makeUtusan" {return symbol(sym.MAKE_UTUSAN, yyline+1);}
<YYINITIAL> "breakup" {return symbol(sym.BREAKUP, yyline+1);}
<YYINITIAL> "makeup" {return symbol(sym.MAKEUP, yyline+1);}
<YYINITIAL> "makeTawag" {return symbol(sym.MAKE_TAWAG, yyline+1);}
<YYINITIAL> "makeSulat" {return symbol(sym.MAKE_SULAT, yyline+1);}
<YYINITIAL> "makeBasa" {return symbol(sym.MAKE_BASA, yyline+1);}
<YYINITIAL> "likeKapag" {return symbol(sym.LIKE_KAPAG, yyline+1);}
<YYINITIAL> "thisNalang" {return symbol(sym.THIS_NALANG, yyline+1);}
<YYINITIAL> "thisNalangKapag" {return symbol(sym.THIS_NALANG_KAPAG, yyline+1);}
<YYINITIAL> "makePalit" {return symbol(sym.MAKE_PALIT, yyline+1);}
<YYINITIAL> "MRW" {return symbol(sym.MRW, yyline+1);}
<YYINITIAL> "MDR" {return symbol(sym.MDR, yyline+1);}
<YYINITIAL> "likeHabang" {return symbol(sym.LIKE_HABANG, yyline+1);}
<YYINITIAL> "makeGawa" {return symbol(sym.MAKE_GAWA, yyline+1);}
<YYINITIAL> "makeUlit" {return symbol(sym.MAKE_ULIT, yyline+1);}
<YYINITIAL> "makeSabi" {return symbol(sym.MAKE_SABI, yyline+1);}
<YYINITIAL> "inty" {return symbol(sym.INTY, yytext());}
<YYINITIAL> "floaty" {return symbol(sym.FLOATY, yytext());}
<YYINITIAL> "chary" {return symbol(sym.CHARY, yytext());}
<YYINITIAL> "stringy" {return symbol(sym.STRINGY, yytext());}
<YYINITIAL> "booly" {return symbol(sym.BOOLY, yytext());}
<YYINITIAL> "yuhh" {return symbol(sym.BOOL_LITERAL, yytext());}
<YYINITIAL> "nuhh" {return symbol(sym.BOOL_LITERAL, yytext());}
<YYINITIAL> "poor" {return symbol(sym.POOR, yytext());}
<YYINITIAL> "waley" {return symbol(sym.WALEY, yytext());}
<YYINITIAL> "makeKuha" {return symbol(sym.MAKE_KUHA, yyline+1);}
<YYINITIAL> "makeSimula" {return symbol(sym.MAKE_SIMULA, yyline+1);}
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

