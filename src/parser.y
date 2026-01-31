%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <err.h>
#include "code.h"
int yylex();


%}

%union {
    float   floatVal;
    int     intVal;
    char*   stringVal;
    int*    params;
}

%token<stringVal> NONE NUL RETURN BREAK CONTINUE CASE SWITCH DEFAULT
%token<stringVal> CONST SIGNED_OR_NOT LONG_OR_SHORT KEY_INT KEY_CHAR KEY_OTHER_TYPE ID STRING CHAR
%token<stringVal> DIGITAL_WRITE DELAY
%token<intVal> INT HIGH_LOW IF ELSE WHILE FOR DO
%token<floatVal> FLOAT
%token ',' '(' ')' ':' ';' '[' ']' '{' '}'

%nonassoc PREC_IF
%nonassoc PREC_IFELSE
%nonassoc PREC_SWITCH
%right '=' 
%left OR
%left AND
%left '|'
%left '^'
%left '&'
%left EQ NEQ
%left NLT NMT '<' '>'
%left LS RS
%left '+' '-'
%left '*' '/' '%'
%right PREC_2
%nonassoc INC DEC

%type<intVal> _if_stmt call_params
%type<intVal> param
%type<params> _params params


%type<stringVal> end _end stmts _stmt for_stmt compound_stmt
while_stmt switch_stmt if_stmt switch_clauses switch_clause
stmt var_decl func_def func_decl scalar_decl array_decl idents
_ident array compound_stmt_func
ident type type1 type0 expr factor _expr
array_subsc



%%
end:    _end {}
    |   end _end {}

_end:   scalar_decl {}
    |   array_decl {}
    |   func_decl {}
    |   func_def {}

compound_stmt_func:  '{' '}' {}
            |   '{' {
                    //cur_scope++;
                } 
                stmts {
                    pop_up_symbol(cur_scope);
                    cur_scope--;
                }
                '}' {}

compound_stmt:  '{' '}' {}
            |   '{' stmts '}' {}

stmts:  _stmt {}
    |   stmts _stmt {}

_stmt:  stmt {}
    |   var_decl {}

for_stmt:   FOR '(' expr ';' 
            {
                printf("F%d_0:\n", $1);
            }
            expr ';' 
            {
                printf("lw t1, 0(sp)\n");
                printf("addi sp, sp, 4\n");  // condition
                printf("lw t0, 0(sp)\n");
                printf("addi sp, sp, 4\n");  // cur_i
                printf("bne t1, zero, F%d_2\n", $1);
                printf("j F%d_3\n", $1);

                printf("\nF%d_1:\n", $1);
            }
            expr ')' 
            {
                printf("j F%d_0\n", $1);

                printf("\nF%d_2:\n", $1);
            }compound_stmt {
                printf("j F%d_1\n", $1);

                printf("\nF%d_3:\n", $1);
            }

while_stmt: WHILE '(' {
                printf("W%d:\n", $1);
            } 
            expr {
                printf("lw t0, 0(sp)\n");
                printf("addi sp, sp, 4\n");
                printf("beq t0, zero, EW%d\n", $1);
            } 
            ')' compound_stmt {
                printf("j W%d\n", $1);
                printf("\nEW%d:\n", $1);
            }
        |   DO {
                printf("\nDW%d:\n", $1);
            }
            compound_stmt WHILE '(' expr {
                printf("lw t0, 0(sp)\n");
                printf("addi sp, sp, 4\n");
                printf("bne t0, zero, DW%d\n", $1);
            } 
            ')' ';' {}

switch_stmt:    SWITCH '(' expr ')' '{' switch_clauses '}' {}
            |   SWITCH '(' expr ')' '{' '}' {}

if_stmt:    _if_stmt {
                printf("\nI%d_1:\n", $1);
            }
        |   _if_stmt ELSE compound_stmt {
                printf("\nI%d_1:\n", $1);
            }

_if_stmt:   IF '(' expr ')' {
                printf("lw t0, 0(sp)\n");
                printf("addi sp, sp, 4\n");
                printf("beq t0, zero, I%d_0\n", $1);
            } compound_stmt %prec PREC_IF {
                printf("j I%d_1\n", $1);
                printf("\nI%d_0:\n", $1);
                $$ = $1;
            }

switch_clauses: switch_clause %prec PREC_SWITCH {}
            |   switch_clauses switch_clause %prec PREC_SWITCH {}

switch_clause:  CASE expr ':' %prec PREC_SWITCH {}
            |   CASE expr ':' stmts %prec PREC_SWITCH {}
            |   DEFAULT ':' %prec PREC_SWITCH {}
            |   DEFAULT ':' stmts %prec PREC_SWITCH {}

stmt:   compound_stmt {}
    |   for_stmt {}
    |   while_stmt {}
    |   switch_stmt {}
    |   if_stmt {}
    |   RETURN ';' {
            printf("j %s_end\n", cur_func);
        }
    |   RETURN expr ';' {
            printf("lw a0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("j %s_end\n", cur_func);
        }
    |   BREAK ';' {}
    |   CONTINUE ';' {}
    |   expr ';' {}

var_decl:   scalar_decl {
                
            }
        |   array_decl {}
        |   func_decl {}

func_def:   type ident '(' params ')' {
                int* param = $4;
                int index = look_up_symbol($2);
                
                cur_func = $2;
                cur_scope++;
                
                for(int i = 0; i < argument_cnt; i++){
                    install_symbol(argument_id[i]);
                    set_param(argument_id[i]);
                }
                printf("\n");
                
                code_gen_func_header($2);
                
            } 
            compound_stmt_func {
                code_gen_at_end_of_function_body($2);
            }
            

func_decl:  type ident '(' params ')' ';' {
                printf(".global %s\n", $2);
                install_symbol($2);
                int index = look_up_symbol($2);
                if($1 != NULL && strcmp($1, "void")==0){
                    table[index].has_return_value = 0;
                }
                else{
                    table[index].has_return_value = 1;
                }
                argument_cnt = 0;
            }

scalar_decl:    type idents ';' {
                }

array_decl: type array ';' {}

idents: idents ',' _ident {}
    |   _ident {}

_ident: ident {
            install_symbol($1);
            set_local_var($1);
            $$ = $1;
        }
    |   ident '=' expr {
            install_symbol($1);
            set_local_var($1);
            int index = look_up_symbol($1);
            int func_args = args_of_scope[cur_scope];
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("sw t0, %d(s0) \n", func_args*(-4)+table[index].offset*(-4)-8);
            printf("addi sp, sp, -4\n");
            printf("sw t0, 0(sp)\n"); break;
            $$ = NULL;
        }

array:  ident '[' INT ']' {
            install_symbol($1);
            set_local_array($1, $3);
            $$ = $1;
        }

params: {} 
    |    _params {}

_params: param {}
    |   _params ',' param {}

param:  type ID {
            argument_id[argument_cnt] = copys($2);
            is_arg_pointer[argument_cnt] = 0;
            argument_cnt++;
            $$ = 0;
        }
    |   type '*' ID {
            argument_id[argument_cnt] = copys($3);
            is_arg_pointer[argument_cnt] = 1;
            argument_cnt++;
            $$ = 1;
        }

ident:  ID {
            $$ = $1;
        }
    |   '*' ID %prec PREC_2 {
            $$ = $2;
        }

type:   type1 {
            if($1 != NULL && strcmp($1, "void")==0)  $$ = $1;
        }
    |   CONST type1 {
            if($2 != NULL && strcmp($2, "void")==0)  $$ = $2;
        }
    |   CONST {
            $$ = NULL;  
        }

type1:  type0 {
            $$ = NULL;  
        }
    |   SIGNED_OR_NOT type0 {
            $$ = NULL;  
        }
    |   SIGNED_OR_NOT {
            $$ = NULL;  
        }
    |   KEY_OTHER_TYPE {
            if($1 != NULL && strcmp($1, "void")==0)  $$ = $1;
            else 
            $$ = NULL;
        }

type0:  KEY_INT {}
    |   LONG_OR_SHORT KEY_INT {}
    |   LONG_OR_SHORT {}
    |   KEY_CHAR {}

expr:   _expr {
            $$ = $1;
        }
    |   expr '+' expr {
            if(trace_on) printf("// add begin\n");
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            $$ = NULL;
            if ($1 != NULL){
                int index = look_up_symbol($1);
                if (index != -1 && table[index].type == T_ARRAY){
                    printf("li t2, -4\n");
                    printf("mul t1, t1, t2\n");
                    $$ = $1;
                }
            }
            printf("add t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            if(trace_on) printf("// add end:\n");
        }
    |   expr '-' expr {
            if(trace_on) printf("// sub begin:\n");
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            $$ = NULL;
            if ($1 != NULL){
                int index = look_up_symbol($1);
                if (index != -1 && table[index].type == T_ARRAY){
                    printf("li t2, -4\n");
                    printf("mul t1, t1, t2\n");
                    $$ = $1;
                }
            }
            printf("sub t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            if(trace_on) printf("// sub end:\n");
            $$ = NULL;
        }
    |   expr '*' expr {
            if(trace_on) printf("// mul begin:\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("mul t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            if(trace_on) printf("// mul end:\n");
            $$ = NULL;
        }
    |   expr '/' expr {
            if(trace_on) printf("// div begin:\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("div t0, t1, t0\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            if(trace_on) printf("// div end:\n");
            $$ = NULL;
        }
    |   expr '%' expr {}
    |   expr '<' expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("slt t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr '>' expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("slt t0, t1, t0\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr NLT expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("addi t1, t1, -1\n");
            printf("slt t0, t1, t0\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr NMT expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("addi t0, t0, -1\n");
            printf("slt t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr EQ expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("slt t2, t0, t1\n");
            printf("slt t3, t1, t0\n");
            printf("not t2, t2\n");
            printf("not t3, t3\n");
            printf("and t2, t2, t3\n");
            printf("and t2, t2, 1\n");
            printf("sw t2, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr NEQ expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("slt t2, t0, t1\n");
            printf("slt t3, t1, t0\n");
            printf("or t2, t2, t3\n");
            printf("sw t2, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   expr AND expr {}
    |   expr OR expr {}
    |   expr '^' expr {}
    |   expr '&' expr {}
    |   expr '|' expr {}
    |   expr LS expr {}
    |   expr RS expr {}
    |   ID '=' expr {
            int index = look_up_symbol($1);
            int offset = table[index].mode == ARGUMENT_MODE ?
            table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("sw t0, %d(s0)\n", offset);
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   '*' factor '=' expr {
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("sw t1, 0(t0)\n");
            printf("sw t1, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   ID '[' expr ']' '=' expr {
            printf("lw t2, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t1, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            
            int index = look_up_symbol($1);
            int offset = table[index].mode == ARGUMENT_MODE ?
            table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
            printf("addi t0, s0, %d\n", offset);
            printf("slli t1, t1, 2\n");
            printf("sub t0, t0, t1\n");
            printf("sw t2, 0(t0)\n");

            printf("sw t2, -4(sp)\n");
            printf("addi sp, sp, -4\n");

            $$ = NULL;
        }

_expr:  factor {
            $$ = $1;
        }
    |   INC _expr {
            int index = look_up_symbol($2);
            int offset = table[index].mode == ARGUMENT_MODE ?
            table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
            printf("addi sp, sp, 4\n");
            printf("lw t0, %d(s0)\n", offset);
            printf("addi t0, t0, 1\n");
            printf("sw t0, %d(s0)\n", offset);
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   DEC _expr {
            int index = look_up_symbol($2);
            int offset = table[index].mode == ARGUMENT_MODE ?
            table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
            printf("addi sp, sp, 4\n");
            printf("lw t0, %d(s0)\n", offset);
            printf("addi t0, t0, -1\n");
            printf("sw t0, %d(s0)\n", offset);
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   '+' _expr {}
    |   '-' _expr {
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("li t1, -1\n");
            printf("mul t0, t0, t1\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
        }
    |   '!' _expr {}
    |   '~' _expr {}
    |   '*' _expr {
            if (trace_on) printf("// derefernce begin\n");
            printf("lw t0, 0(sp)\n");
            printf("addi sp, sp, 4\n");
            printf("lw t0, 0(t0)\n");
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
            if (trace_on) printf("// derefernce end\n");
        }
    |   '&' _expr {
            printf("addi sp, sp, 4\n");
            if (trace_on) printf("// get reference begin\n");
            int index = look_up_symbol($2);
            int offset = table[index].mode == ARGUMENT_MODE ?
            table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
            printf("addi t0, s0, %d\n", offset);
            printf("sw t0, -4(sp)\n");
            printf("addi sp, sp, -4\n");
            $$ = NULL;
            if (trace_on) printf("// get reference end\n");
        }
    |   '(' type ')' _expr {}

factor:     ID {
                if(trace_on) printf("// fetch id begin\n");
                int index = look_up_symbol($1);
                int offset = table[index].mode == ARGUMENT_MODE ?
                table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
                if(table[index].type == T_SCALAR || table[index].mode == ARGUMENT_MODE){
                    printf("lw t0, %d(s0)\n", offset);
                }
                else{
                    printf("addi t0, s0, %d\n", offset);
                }
                printf("sw t0, -4(sp)\n");
                printf("addi sp, sp, -4\n");
                if(trace_on) printf("// fetch id end\n");
                $$ = $1;
            }
        |   ID INC {
                int index = look_up_symbol($1);
                int offset = table[index].mode == ARGUMENT_MODE ?
                table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
                printf("lw t0, %d(s0)\n", offset);
                printf("addi t1, t0, 1\n");
                printf("sw t1, %d(s0)\n", offset);
                printf("sw t0, -4(sp)\n");
                printf("addi sp, sp, -4\n");
                $$ = $1;
            }
        |   ID DEC {
                int index = look_up_symbol($1);
                int offset = table[index].mode == ARGUMENT_MODE ?
                table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
                printf("lw t0, %d(s0)\n", offset);
                printf("addi t1, t0, -1\n");
                printf("sw t1, %d(s0)\n", offset);
                printf("sw t0, -4(sp)\n");
                printf("addi sp, sp, -4\n");
                $$ = $1;
            }
        |   '(' expr ')' {
                $$ = NULL;
            }
        |   array_subsc {}
        |   INT {
                printf("li t0, %d\n", $1);
                printf("sw t0, -4(sp)\n");
                printf("addi sp, sp, -4\n");
                $$ = NULL;
            }
        |   FLOAT {}
        |   CHAR {}
        |   STRING {}
        |   ID '(' ')' {}
        |   ID '(' call_params ')' {
                if (trace_on) printf("// call function begin\n");
                int num_of_params = $3;
                for(int i = num_of_params - 1; i >= 0; i--){
                    printf("lw a%d, 0(sp)\n", i);
                    printf("addi sp, sp, 4\n");
                }
                printf("jal ra, %s\n", $1);
                int index = look_up_symbol($1);
                if(table[index].has_return_value){
                    printf("mv t0, a0\n");
                    printf("sw a0, -4(sp)\n");
                    printf("addi sp, sp, -4\n");
                }
                if (trace_on) printf("// call function end\n");
            }
        |   NUL {}
        |   DIGITAL_WRITE '(' expr ',' HIGH_LOW ')' {
                printf("lw a0, 0(sp)\n");
                printf("addi sp, sp, 4\n");
                printf("li a1, %d\n", $5);
                //printf("addi sp, sp, 4\n");
                //printf("sw ra, 0(sp)\n");
                printf("jal ra, digitalWrite\n");
                //printf("lw ra, 0(sp)\n");
                //printf("addi sp, sp, 4\n");
                $$ = NULL;
            }
        |   DELAY '(' expr ')' {
                printf("lw a0, 0(sp)\n");
                printf("addi sp, sp, 4\n");
                //printf("addi sp, sp, -4\n");
                //printf("sw ra, 0(sp)\n");
                printf("jal ra, delay\n");
                //printf("lw ra, 0(sp)\n");
                //printf("addi sp, sp, 4\n");
                $$ = NULL;
            }

call_params:    expr {
                    $$ = 1;
                }
            |   call_params  ',' expr {
                    $$ = $1 + 1;
                }

array_subsc:    ID '[' expr ']' {
                    int index = look_up_symbol($1);
                    int offset = table[index].mode == ARGUMENT_MODE ?
                    table[index].offset * (-4) - 8 : table[index].offset * (-4) - 8 - argument_cnt * 4;
                    
                    if (table[index].type != T_ARRAY){
                        err(0, "ID is not an array");
                    }
                    printf("lw t1, 0(sp)\n");
                    printf("addi sp, sp, 4\n");
                    printf("addi t0, s0, %d\n", offset);

                    printf("slli t1, t1, 2\n");
                    printf("sub t0, t0, t1\n");
                    printf("lw t0, 0(t0)\n");
                    printf("sw t0, -4(sp)\n");
                    printf("addi sp, sp, -4\n");
                    $$ = NULL;
                }

%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void) {
    // yydebug = 1;
    yyparse();
    return 0;
}