%{
#include <stdio.h>
#include <stdlib.h>
#include "bts.tab.h"	
%}

%%
"print"    		{
				
					return print;
				}

int|float|char|String  {
					
					return data_typed;
				}
[-+/*="]	 { 
				
				return yytext[0];
			}
"("                           {return OP;}
")"                           {return CP;}
";"                           {return SC;}
[a-zA-Z]+[a-zA-Z0-9]* 	{
					yylval.string = yytext; 
					return parameter;
				}

[0-9]+			{
					yylval.dig = atoi(yytext); 
					return digit;
				}
[\n]                             ;
%%
 
int yywrap(void) {return 1;}