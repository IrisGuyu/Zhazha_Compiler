%option c++ noyywrap

%{
using namespace std;
#include "iostream"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
#include "MidCalc.tab.h"

%}

space			[ ]
tab				[	]
whitespace		({space}|{tab})+
digit			[0-9]
lower			[a-z]
upper			[A-Z]
alphabet		{lower}|{upper}
num1			{digit}+\.?([eE][-+]?{digit}+)?
num2			{digit}*\.{digit}+([eE][-+]?{digit}+)?
number			{num1}|{num2}
name 			{alphabet}+
%%


{whitespace}	/**/
"\n"			{
					return NEWLINE;
				}
{number}		{
					yylval.Number = atof(YYText());
					return NUM;
				}
"+"				{
					return PLUS;
				}
"-"				{
					return MINUS;
				}
"*"				{
					return MULTI;
				}
"/"				{
					return DIVIDE;
				}
"%"				{
					return MOD;
				}
"^"				{
					return POWER;
				}
"="				{
					return EQUAL;
				}
"("				{
					return LBRACKET;
				}
")"             {
					return RBRACKET;
				}
{name}			{	
					//cout << "FOUND A NAME" << endl;
					yylval.Name = new char[128];
					strcpy(yylval.Name, YYText());
					//cout << "NAME GIVEN TO yylval" << endl;
					return NAME;
				}
.				{
					fprintf(stderr, "\'%s\' is invalid\n", YYText());
				}
%%
FlexLexer * lexer = new yyFlexLexer(&cin, &cout);
int yylex(){
	return lexer->yylex();
};
