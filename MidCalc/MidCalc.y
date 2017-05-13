/* Reverse polish notation calculator. */
%{ 
#include "math.h" 
#include "stdio.h"
#include "iostream"
#include "string.h"
#include "tchar.h"
#include "MidCalc.tab.h"
#include "SymbolTable.h"
extern int yylex();
void yyerror(char const *s);
%}

%union{
	double Number;
	char * Name;
}
%token <Number>	NUM
%token <Name>	NAME
%token SQRT		"sqrt"
%token CMP		"cmp"
%token PLUS 	"+"
%token MINUS	"-"
%token MULTI	"*"
%token DIVIDE	"/"
%token MOD		"%"
%token POWER	"^"
%token EQUAL	"="
%token LBRACKET "("
%token RBRACKET ")"
%token NEWLINE  "\n"


%% /* Grammar rules and actions follow. */ 
input: 
	%empty 
	| input line
	;
line: 
	"\n" 
	| exp "\n" { printf ("%.10g\n", $<Number>1); } 
	| assign_stmt "\n"
	| comparison "\n"
	| error "\n"
	;

assign_stmt:
	NAME "=" exp {
		//cout << "assign_stmt : NAME \"=\" exp" << endl;
		ST_Entry * A = SymbolTable.insertEntry($<Name>1, $<Number>3);
		if(!A)
			fprintf(stderr, "Empty string or not enough space\n");
	};
comparison:
	exp "cmp" exp {
		if ($<Number>1 > $<Number>3)
			cout << ">" << endl;
		else if ($<Number>1 < $<Number>3)
			cout << "<" << endl;
		else if ($<Number>1 == $<Number>3)
			cout << "=" << endl;
	};
	
exp:
	term {$<Number>$ = $<Number>1;}
	|exp "+" term {$<Number>$ = $<Number>1 + $<Number>3;}
	|exp "-" term {$<Number>$ = $<Number>1 - $<Number>3;}
	;
term:
	factor {$<Number>$ = $<Number>1;}
	|term "*" factor {$<Number>$ = $<Number>1 * $<Number>3;}
	|term "/" factor {$<Number>$ = $<Number>1 / $<Number>3;}
	|term "%" factor {$<Number>$ = int($<Number>1) % int($<Number>3);}
	;
factor:
	atom {$<Number>$ = $<Number>1;}
	|factor "^" atom { $<Number>$ = pow ($<Number>1, $<Number>3); }
	;
atom:
	NUM { $<Number>$ = $<Number>1; }
	|NAME {
			ST_Entry * A = SymbolTable.searchEntry($<Name>1);
			if (!A){
				fprintf(stderr, "NAME not found\n");
				exit(1);
			}
			$<Number>$ = A->value;
		}
	|"-" NUM { $<Number>$ = - $<Number>2; }
	|"(" exp ")"{ $<Number>$ = $<Number>2; }
	| "sqrt" "(" exp ")" {$<Number>$ = sqrt($<Number>3);}
	;
%%	
int main (int argc, char const* argv[]) {
	yyparse();//这个函数用来执行语法和语义分析
	return 0;
}
void yyerror(char const *s){
	fprintf(stderr, "%s\n", s);
};