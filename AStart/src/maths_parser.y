%code requires{
  #include "ast.hpp"

  #include <cassert>

  extern const MainBody *g_root; // A way of getting the AST out

  //! This is to fix problems when generating C++
  // We are declaring the functions provided by Flex, so
  // that Bison generated code can call them.
  int yylex(void);
  void yyerror(const char *);
}

// Represents the value associated with any kind of
// AST node.
%union{
  const MainBody *compptr;
  const Expression *expr;
  double number;
  std::string *string;
}

%token T_LSQBRACKET T_RSQBRACKET T_LCUBRACKET T_RCUBRACKET T_LTRIBRACKET T_RTRIBRACKET T_LBRACKET T_RBRACKET
%token T_ASSIGN T_DOT T_COMMA T_COLON T_SEMICOLON
%token T_LAND T_LOR T_LEQUAL T_LNOTEQUAL T_LLESSOREQUAL T_LMOREOREQUAL
%token T_INT T_DOUBLE T_STRING T_BOOL T_VOID
%token T_TIMES T_DIVIDE T_PLUS T_MINUS T_EXPONENT
%token T_LOG T_EXP T_SQRT
%token T_NUMBER T_ID 
%token T_RETURN

%type <compptr> MAIN_BODY FUNCTION_LIST DEC_FUNCTION BODY
%type <compptr> STATEMENT RETURN_STATEMENT DECLARE_VAR ASSIGN_STATEMENT FUNCTION_STATEMENT
%type <expr> EXPR TERM FACTOR
%type <number> T_NUMBER
%type <string> T_ID 
%type <string> T_LOG T_EXP T_SQRT
%type <string> TYPE T_INT T_DOUBLE T_STRING T_BOOL T_VOID

%start ROOT

%%
//syntax notes P_ means its a primative

ROOT : DEC_FUNCTION { g_root = $1; }

//choose main in main body so it gets priority
MAIN_BODY : FUNCTION_LIST {$$ = $1; }

FUNCTION_LIST : FUNCTION_LIST DEC_FUNCTION      {$$ = new Function_List($2,$1);}
    | DEC_FUNCTION                      {$$ = $1;}

//delcares a new function with the func_id and runs through body recursively arg implimented late
DEC_FUNCTION : TYPE T_ID T_LBRACKET T_RBRACKET T_LCUBRACKET BODY T_RCUBRACKET {$$ = new Function(*$1, *$2, $6);}

//terminal cases
TYPE : T_INT      {$$=$1;}
    | T_DOUBLE    {$$=$1;}
    | T_STRING    {$$=$1;}
    | T_VOID      {$$=$1;}
    | T_BOOL      {$$=$1;}

//recursive with each line of code left associative
//each body contains one statement and a body pointer
BODY : BODY STATEMENT   {$$ = new Body($2,$1);}
    | STATEMENT         {$$ = $1;}
    
STATEMENT :  RETURN_STATEMENT          {$$=$1;}
    | DECLARE_VAR               {$$=$1;}
    //| FUNCTION                  {$$=$1;}
    | ASSIGN_STATEMENT   {$$=$1;}

RETURN_STATEMENT : T_RETURN EXPR T_SEMICOLON {$$ = new ReturnStatement($2);}

DECLARE_VAR : TYPE T_ID T_ASSIGN EXPR T_SEMICOLON {$$ = new DeclareStatement(*$1, *$2, $4);}  
    | TYPE T_ID T_SEMICOLON {$$ = new DeclareStatement(*$1, *$2);}

ASSIGN_STATEMENT : T_ID T_ASSIGN EXPR T_SEMICOLON {$$ = new AssignStatement(*$1, $3);}

FUNCTION_STATEMENT : T_ID T_LBRACKET T_RBRACKET T_SEMICOLON {$$ = new FunctionStatement(*$1);}

EXPR : TERM                 { $$ = $1; }
        | EXPR T_PLUS TERM       { $$ = new AddOperator( $1 , $3 ); }
        | EXPR T_MINUS TERM       { $$ = new SubOperator( $1 , $3 ); }

TERM : FACTOR               { $$ = $1; }
        | TERM T_TIMES FACTOR  { $$ = new MulOperator( $1 , $3 ); }
        | TERM T_DIVIDE FACTOR  { $$ = new DivOperator( $1 , $3 ); }
        | FACTOR T_EXPONENT TERM  { $$ = new ExpOperator( $1 , $3 ); }

FACTOR : T_NUMBER           { $$ = new Number( $1 ); }
        | T_LBRACKET EXPR T_RBRACKET { $$ = $2; }
        | T_ID { $$ = new Variable( *$1 );}
        | T_LOG T_LBRACKET EXPR T_RBRACKET { $$ = new LogFunction( $3 ); }
        | T_EXP T_LBRACKET EXPR T_RBRACKET { $$ = new ExpFunction( $3 ); }
        | T_SQRT T_LBRACKET EXPR T_RBRACKET { $$ = new SqrtFunction( $3 ); }
%%

const MainBody *g_root; // Definition of variable (to match declaration earlier)

const MainBody *parseAST()
{
  g_root=0;
  yyparse();
  return g_root;
}
