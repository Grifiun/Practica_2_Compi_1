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
//({comilla})(({letter})|({number})|("{")|("}")|(":")|("¿")|("?")|("<")|("-")|(";"))*({comilla}) return 'DECLARATION_VALUE'
//Aceptamos cualquier cadena de carater acotado por las comillas (', ‘, ’) a excepcion de las mismas comillas y espacios en blanco
({comilla})([^\s\"‘"\"’"\"'"])+({comilla}) return 'DECLARATION_VALUE'
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
//{comilla}             return 'COMILLA_SIMPLE'
"*"                   return '*'
"("                   return '('
")"                   return ')'
"="                   return '='
"|"                   return '|'

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

expressions_block : block_declaration_lex //DECLARATION LEXER
                    block_declaration_symbol //DECLARATION PARSER
    ;


/*
    BLOCK LEX DECLARATION: EXAMPLE
    Lex {:
        Terminal $_Una_A     <- ‘a’ ;    # cualquier carácter alfanumérico por separado
        Terminal $_Mas       <- ‘+’ ;    # cualquier carácter especial por separado
        Terminal $_Punto     <- ‘.’ ;    # cualquier carácter especial por separado    
    :}
*/
block_declaration_lex : LEX '{' ':' 
                            block_declaration_terminal 
                        ':' '}'
    ;
    
/*
    TERMINAL BLOCK: EXAMPLE
    Terminal $_Una_A     <- ‘a’ ;    # cualquier carácter alfanumérico por separado
    Terminal $_Mas       <- ‘+’ ;    # cualquier carácter especial por separado
    Terminal $_Punto     <- ‘.’ ;    # cualquier carácter especial por separado

*/
block_declaration_terminal : block_declaration_terminal line_declaration_terminal//
    | /*line_declaration_terminal*/
    ;

//EXAMPLE: Terminal $_Una_A <- ‘a’ ; 
line_declaration_terminal : TERMINAL TERMINAL_NAME '<' '-' DECLARATION_VALUE ';'
    ;

/*
    BLOCK SYNTAX DECLARATION: EXAMPLE
    Syntax {{:
    # Declaración de no terminales de la forma
    # No_Terminal %_Nombre ;

    No_Terminal %_Prod_A;
    No_Terminal %_Prod_B;
    No_Terminal %_Prod_C;
    No_Terminal %_S;
    
    
    # Simbolo inicial de la forma
    # Initial_Sim %_Nombre ;
    
    Initial_Sim %_S ;

    #Todo símbolo no terminal debe ser declarado antes de usarse en las producciones
    # Las producciones son de la siguiente forma
    # %_Initial_Sim  <= %_Prod_A ... %_No_terminal_N o $_Terminal_N ... ;
    
    %_S <= %_Prod_A $_FIN ;
    %_Prod_A <= $_P_Ab %_Prod_B $_P_Ce ;
    %_Prod_B <= %_Prod_B %_Prod_C | %_Prod_C ;
    %_Prod_C <= $_Una_A $_Mas $_Una_A ;
    :}}
*/
block_declaration_symbol : SYNTAX '{' '{' ':' 
                                block_declaration_no_terminal 
                                block_declaration_initial_production/*Have inicial and production block*/
                            ':' '}' '}' 
    ;

block_declaration_initial_production : line_declaration_initial_symbol block_declaration_production
    | /* empty */ 
    ;

/*
    NON TERMINAL DECLARATION: EXAMPLE
    
    No_Terminal %_Prod_A;
    No_Terminal %_Prod_B;
    No_Terminal %_Prod_C;
    No_Terminal %_S;
*/
block_declaration_no_terminal : block_declaration_no_terminal line_declaration_no_terminal//
    | /*line_declaration_terminal*/
    ;

/*
    NON TERMINAL LINE: EXAMPLE    
    No_Terminal %_Prod_A;
*/
line_declaration_no_terminal : NO_TERMINAL NO_TERMINAL_NAME ';'
    ;


/*
    BLOCK PRODUCTION DECLARATION: EXAMPLE
    %_S <= %_Prod_A $_FIN ;
    %_Prod_A <= $_P_Ab %_Prod_B $_P_Ce ;
    %_Prod_B <= %_Prod_B %Prod_C | %_Prod_C ;
    %_Prod_C <= $_Una_A $_Mas $_Una_A ;
*/
block_declaration_production : block_declaration_production line_declaration_production//
    | line_declaration_production /*line_declaration_terminal*/ //never can be empty
    ;
/*
    LINE PRODUCTION DECLARATION: EXAMPLE
    %_S <= %_Prod_A $_FIN ;
*/
line_declaration_production : NO_TERMINAL_NAME '<' '=' line_block_production_value ';'
    ;

/*
    LINE OF BLOCK DECLARATION VALUE EXAMPLE:
    %_Prod_B <= %_Prod_B %Prod_C 
                ^   
                init

        | %_Prod_C 
        | %_Prod_C 
        | %_Prod_C 
        | %_Prod_C 
                ^
                final
        ;
*/
line_block_production_value : line_block_production_value '|' line_production_value
    | line_production_value
    ;

/*
    PRODUCTION VALUE EXAMPLE: 
    %_Prod_A <=   $_P_Ab %_Prod_B $_P_Ce  ;
                 ^                     ^
                 init                  final
*/
line_production_value : line_production_value line_production_value_unit
    | /*empty, lambda value*/
    ;

/*
    PRODUCTION ONE VALUE EXAMPLE: 
    %_Prod_A <=   $_P_Ab %_Prod_B $_P_Ce  ;
                 ^      ^
                 init   final
*/
line_production_value_unit : NO_TERMINAL_NAME
    | TERMINAL_NAME;

/*
    INITIAL SYMBOL DECLARATION: EXAMPLE       
    Initial_Sim %_S ;
*/
line_declaration_initial_symbol : INITIAL_SIM NO_TERMINAL_NAME ';'
    ;
