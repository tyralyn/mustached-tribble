%option yylineno
%pointer

%{
    #define YYSTYPE char*
    #include <stdlib.h>
    void yyerror(const char *);
    #include "parser.hpp"
%}

/* WRITEME: Write any definitions here. You can find information on
            definitions here:
            http://flex.sourceforge.net/manual/Definitions-Section.html */

digit			[0-9]
lChar 			[a-z]
uChar			[A-Z]		
			
/* WRITEME: If you are going to use start conditions, write them here.
            You can find more information on start conditions here:
            http://flex.sourceforge.net/manual/Start-Conditions.html
            You will probably want to use exclusive conditions rather
            than inclusive conditions (use the %x instead of the %s). */

%%

  /* WRITEME: Write your Flex token rules here */

[{] 			{ return T_OPEN_BRACKET; }
				
[}]				{ return T_CLOSE_BRACKET; }

[(]				{ return T_OPEN_PARENS; }

[)]				{ return T_CLOSE_PARENS; }

[+]				{ return T_PLUS; }

[-]				{ return T_MINUS; }

[*]				{ return T_MULTIPLY; }

[/]				{ return T_DIVIDE; }

"=="			{ return T_EQUAL_TO; }

"<="			{ return T_LESS_THAN_EQUAL_TO; }

[=]				{ return T_ASSIGNMENT; }

[<]				{ return T_EQUAL_TO; }

"\." 			{ return T_DOT; }

[:]				{ return T_COLON; }

[;]				{ return T_SEMICOLON; }

[,]				{ return T_COMMA; }
  
"print"			{ 
						return T_PRINT; }
						
"return"		{ return T_RETURN; }

"if"			{ return T_IF; }

"else" 			{ return T_ELSE; }

"for"			{ return T_FOR; }

"new"			{ return T_NEW; }

"int"			{ return T_INT; }

"bool"			{ return T_BOOL; }

"none"			{ return T_NONE; }

"and"			{ return T_AND; }

"or"			{ return T_OR; }

"not"			{ return T_NOT; }

"true"			{ return T_TRUE; }

"false"			{ return T_FALSE; }

(({uChar}|{lChar})({digit}|{uChar}|{lChar})*) {
						return T_IDENTIFIER; }  
  
([0]|[1-9]{digit}*) { ;
						return T_NUMBER; }


\n					{ }						
[ \t]				{ }
  
.                 	{ yyerror("invalid character"); }

%%

int yywrap(void) {
  return 1;
}
