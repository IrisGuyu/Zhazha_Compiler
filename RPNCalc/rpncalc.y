/* Reverse polish notation calculator. */
%{ 
#include <math.h> 
#include "stdio.h"
#include "rpncalc.tab.h"
extern int yylex();
void yyerror(char const *s);
%}
%define api.value.type {double} 

%token NUM
%token PLUS 	"+"
%token MINUS	"-"
%token MULTI	"*"
%token DIVIDE	"/"
%token NEGA		"n"
%token NEWLINE  "\n"


%% /* Grammar rules and actions follow. */ 
input: 
	%empty 
	| input line ;
line: 
	"\n" 
	| exp "\n" { printf ("%.10g\n", $1); } 
	| error "\n"
	;
exp: 
	NUM { $$ = $1; } 
	| exp exp "+" { $$ = $1 + $2; } 
	| exp exp "-" { $$ = $1 - $2; } 
	| exp exp "*" { $$ = $1 * $2; } 
	| exp exp "/" { $$ = $1 / $2; } 
	| exp exp "^" { $$ = pow ($1, $2); } /* Exponentiation */ 
	| exp "n" { $$ = -$1; } /* Unary minus */ 
	; 
%%
int main (int argc, char const* argv[]) {
	yyparse();//这个函数用来执行语法和语义分析
	return 0;
}
void yyerror(char const *s){
	fprintf(stderr, "%s\n", s);
};