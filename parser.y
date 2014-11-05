%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <iostream>
    #define YYDEBUG 1

    int yylex(void);
    void yyerror(const char *);
%}

%error-verbose

/* WRITEME: List all your tokens here */
%token T_NUMBER
%token T_IDENTIFIER

%token T_PRINT T_RETURN T_IF T_ELSE T_FOR T_NEW T_INT T_BOOL T_NONE T_TRUE T_FALSE

%token T_COLON T_SEMICOLON T_COMMA

%right T_ASSIGNMENT 
%left T_OR
%left T_AND
%left T_LESS_THAN T_LESS_THAN_EQUAL_TO T_EQUAL_TO
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE
%right T_NOT T_UNARY_MINUS

%token T_OPEN_PARENS T_CLOSE_PARENS T_OPEN_BRACKET T_CLOSE_BRACKET T_DOT

/* WRITEME: Specify precedence here */
%%

/* WRITEME: This rule is a placeholder, since Bison requires
            at least one rule to run successfully. Replace
            this with your appropriate start rules. */
start : class startp
      ;

/* WRITME: Write your Bison grammar specification here */

startp : class startp
		|
		;
		
		
class : T_IDENTIFIER classtyper classbody
		;

classtyper: T_COLON T_IDENTIFIER 
		|
		;

classbody : T_OPEN_BRACKET membersmethods T_CLOSE_BRACKET
		;
		
membersmethods: members T_IDENTIFIER methods
		| T_IDENTIFIER methods
		
		;

members: type T_IDENTIFIER members
		;
				

		
type: T_INT | T_BOOL | T_IDENTIFIER
		;
		
returntype: type | T_NONE
		;
	
methods: methods T_OPEN_PARENS arguments T_CLOSE_PARENS T_COLON returntype T_OPEN_BRACKET body T_CLOSE_BRACKET 
		|
		;
		
arguments: argument argumentsp
		|
		;
		
argumentsp: T_COMMA argument
		|
		;
		
argument: type T_IDENTIFIER
		;
		
body: declarations statements returnstatement
		;
		
declarations: declarations declaration
		|
		;
		
declaration: T_IDENTIFIER T_IDENTIFIER declarationp
		;
		
declarationp: declarationp T_COMMA T_IDENTIFIER
		|
		;
		
returnstatement: T_RETURN expression
		|
		;
		
statements: statements statement 
		|
		;
		
statement: assignment
		| methodcall
		| ifelse
		| forloop
		| print
		;
		
assignment: T_IDENTIFIER T_ASSIGNMENT expression
		;
		
methodcall: T_IDENTIFIER T_OPEN_PARENS parameters T_CLOSE_PARENS
		| T_IDENTIFIER T_DOT T_IDENTIFIER T_OPEN_PARENS parameters T_CLOSE_PARENS
		;
		
ifelse: if else
		;
		
if: T_IF expression T_OPEN_BRACKET block T_CLOSE_BRACKET
		;
		
else: T_ELSE T_OPEN_BRACKET block T_CLOSE_BRACKET 
		|
		;
		
forloop: T_FOR assignment T_SEMICOLON expression T_SEMICOLON assignment T_OPEN_BRACKET block T_CLOSE_BRACKET
		;
		
print: T_PRINT expression
		;
		
block: statement statements
		;
		
parameters: parametersp
		|
		;
		
parametersp: parametersp T_COMMA expression
		| expression
		;
		
expression: expression T_PLUS expression
		| expression T_MINUS expression
		| expression T_MULTIPLY expression
		| expression T_DIVIDE expression
		| expression T_LESS_THAN expression
		| expression T_LESS_THAN_EQUAL_TO expression
		| expression T_EQUAL_TO expression
		| expression T_AND expression
		| expression T_OR expression
		| T_NOT expression
		| T_MINUS expression
		| T_IDENTIFIER
		| T_IDENTIFIER T_DOT T_IDENTIFIER
		| methodcall
		| T_OPEN_PARENS expression T_CLOSE_PARENS
		| T_NUMBER
		| T_FALSE
		| T_TRUE
		| T_NEW T_IDENTIFIER
		| T_NEW T_IDENTIFIER  T_OPEN_PARENS parameters T_CLOSE_PARENS
		;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(0);
}
