%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror (char *s); 
int counter=0;
int c;        /*index stop*/
int checkvar(char *var);
struct{
    
    char name[20];
    int x;
    
}datastruct[20];


%}

%union {char *string,equal; int dig;}
%start main
%token print data_typed OP CP SC
%token <string>parameter
%token <dig>digit
%type <dig> exp term factor assignment
%type <string>word 
%type <string>varname

%%
main        :   print OP '"' word '"' CP SC       {;} 
            |   data_typed varname '=' exp  SC      {datastruct[counter].x=$4; counter++;}  
        |   main data_typed varname '=' exp SC {datastruct[counter].x=$5; counter++;}   
        |   main assignment '=' exp SC          {datastruct[c].x=$4;}
        |   main print OP exp CP SC            {printf("%d",$4);} 
        |   data_typed varname '=' '"'exp'"' SC {printf("cannot convert from String to int");}   
        ;
word        : parameter                              {printf("%s",$1);}
            | word parameter                         {printf("%s",$2);}
            ;
varname     : parameter                              {strcpy(datastruct[counter].name, $1);}    
        ;
assignment  : parameter                              {checkvar($1);}
            ;
exp         :    term                                {$$ = $1;}
            |    exp '+' term                        {$$ = $1 + $3;}
            |    exp '-' term                        {$$ = $1 - $3;}
            ;
term        :    factor          {$$ = $1;}
            |    term '*' factor {$$ = $1 * $3;}
            |    term '/' factor {$$ = $1 / $3;}
        |    parameter       {$$ = checkvar($1);}
            ;
factor      :    digit           {$$ = $1;}
            |    '(' exp ')'     {$$ = $2;}
            |    '-' factor      {$$ = -$2;}
            ;

%%
int checkvar(char *var){
      int i,x=0;
      for(i=0;i<20;i++){
        if(strcmp(datastruct[i].name,var)==0){
      x=1;
      c=i;
      return datastruct[i].x;
      break;
    }
      }
      if(x==0){printf("%s is undeclared variable",var);}
     
}
 main(void) {
                     yyparse();
                    // int i;
                     //for(i=0;i<20;i++){
                     //printf("\n %s",datastruct[i].name);
                     //}
    }
void yyerror(char *s) {
    printf("Syntax Error!");
}