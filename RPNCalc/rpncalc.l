%option c++ noyywrap

%{
using namespace std;
#include "iostream"
#include "stdlib.h"
#include "stdio.h"
#include "rpncalc.tab.h"

%}

space			[ ]
tab				[	]
whitespace		({space}|{tab})+
digit			[0-9]
num1			{digit}+\.?([eE][-+]?{digit}+)?
num2			{digit}*\.{digit}+([eE][-+]?{digit}+)?
number			{num1}|{num2}
%%


{whitespace}	/**/
"\n"			{
					return NEWLINE;
				}
{number}		{
					yylval = atof(YYText());
					return NUM;
				}
"+"				{
					return PLUS;
				}
"-"				{
					return 	MINUS;
				}
"^"				{
					return MULTI;
				}
"/"				{
					return DIVIDE;
				}
"n"				{
					return NEGA;
				}
.				{
					fprintf(stderr, "\'%s\' is invalid\n", YYText());
				}
%%
FlexLexer * lexer = new yyFlexLexer(&cin, &cout);
int yylex(){
	return lexer->yylex();
};
