/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
letter = ([aA-zZ])
number  = ([0−9])
comilla = ("‘")|("’")|("'") 

%%
\s+                   /* skip whitespace */

//PALABRAS RESERVADAS
"Wison"               return 'WISON'
"Lex"                 return 'LEX'
"Terminal"            return 'TERMINAL'
"Syntax"              return 'SYNTAX'
"No_Terminal"         return 'NO_TERMINAL'
"Initial_Sim"         return 'INITIAL_SIM'
//COMENTARIOS, los ignoramos
//("/")("*")("*")([^\"/"]*)("*")("/") return 'COMMENT_BLOCK';
("/")("**")(.|\n|\r)*("*/")   /* return 'COMMENT_BLOCK'   */
("#")(.*)          /*return "COMMENT_LINE"   */

//EXPRESIONES REGULARES
("$")("_")({letter}|{number})+ return 'TERMINAL_NAME'
("%")("_")({letter}|{number})+ return 'NO_TERMINAL_NAME'
({comilla})({letter}|{number}|"{"|"}"|":"|"¿"|"?"|"<"|"-"|";")*({comilla}) return 'DECLARATION_VALUE'
"[aA-zZ]"             return 'ANY_LETTER'
"[0-9]"               return 'ANY_NUMBER'

//SIMBOLOS
"{"                   return '{'
"}"                   return '}'
":"                   return ':'
"¿"                   return '¿'
"?"                   return '?'
"<"                   return '<'
"-"                   return '-'
";"                   return ';'
{comilla}             return 'COMILLA_SIMPLE'
"*"                   return '*'
"("                   return '('
")"                   return ')'
"="                   return '='

//END OF FILE
<<EOF>>               return 'EOF';

/lex

/* operator associations and precedence */
/*
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS
*/
%start expressions

%% /* language grammar */
/**
%{
    var resultado = '';


%}*/


expressions : expressions_block EOF
        {return $1;}
    | EOF
    ;

expressions_block : expressions_block e
    | e
    ;


e   : WISON {return $1;}
    | LEX {return $1;}
    | TERMINAL {return $1;}
    | SYNTAX {return $1;}
    | NO_TERMINAL {return $1;}
    | INITIAL_SIM {return $1;}
    | TERMINAL_NAME {return $1;}
    | NO_TERMINAL_NAME {return $1;}
    | DECLARATION_VALUE {return $1;}
    | ANY_LETTER {return $1;}
    | ANY_NUMBER {return $1;}
    | '{' {return $1;}
    | '}' {return $1;}
    | ':' {return $1;}
    | '¿' {return $1;}
    | '?' {return $1;}
    | '<' {return $1;}
    | '-' {return $1;}
    | ';' {return $1;}
    | COMILLA_SIMPLE {return $1;}
    | '*' {return $1;}
    | '(' {return $1;}
    | ')' {return $1;}
    | '=' {return $1;}
    ;
