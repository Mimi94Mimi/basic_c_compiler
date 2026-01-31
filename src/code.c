#include <stdio.h>  
#include <stdlib.h>
#include <string.h>
#include <err.h>  
#include "code.h"

int cur_counter = 0;
int cur_scope = 1;
int local_vars_of_scope[10] = {0};
int args_of_scope[10] = {0};
int trace_on = 0;
int label_cnt = 0;
char* argument_id[10];
int is_arg_pointer[10] = {0};
int argument_cnt = 0;
char* cur_func = NULL;

char *copys(char* s){
    int sz = strlen(s) + 1;
    char* str = malloc(sz * sizeof(char));
    memset(str, 0, sizeof(char)*sz);
    str = strcpy(str, s);
    return str;
}

char *install_symbol(char *s){ 
    if (cur_counter >= MAX_TABLE_SIZE) err(2, "Symbol Table Full");
    else {
        table[cur_counter].scope = cur_scope;
        table[cur_counter].name = copys(s);
        if(trace_on){
            printf("// install symbol\n");
            printf("// name: %s, scope: %d, cur_counter: %d\n"
        , table[cur_counter].name, table[cur_counter].scope, cur_counter);
        }
        cur_counter++;
    }
    return s;
}

int look_up_symbol(char* s){
    int i;
    if (cur_counter == 0) return -1;  // no entries
    for (i = cur_counter - 1; i >= 0; i--) {
        if (!strcmp(s, table[i].name)) return i;
    }
    return -1;
}

void pop_up_symbol(int scope){
    int i;
    if (cur_counter == 0) return;
    for (i = cur_counter - 1; i >= 0; i--){
        if (table[i].scope != scope) break;
    }
    if (i < 0) cur_counter = 0;
    cur_counter = i + 1;
    local_vars_of_scope[scope] = 0;
    args_of_scope[scope] = 0;
}

void set_scope_and_offset_of_param(char *s){
    int i, j, index;
    int total_args;
    index = look_up_symbol(s);
    if (index < 0) err(2, "Error in function header");
    else {
        table[index].type = T_FUNCTION;
        total_args = cur_counter - index - 1;
        table[index].total_args = total_args;
        args_of_scope[cur_scope + 1] = total_args;  // has not cur_scope++ yet
        for (j = total_args, i = cur_counter - 1; i > index; i--, j--){
            table[i].scope = cur_scope;
            table[i].offset = j;
            table[i].mode = ARGUMENT_MODE;

            printf("sw a%d %d(s0)\n", j - 1, -8 - j * 4);
        }
    }
}

void set_local_var(char* id){
    local_vars_of_scope[cur_scope]++;
    int index = look_up_symbol(id);
    table[index].offset = local_vars_of_scope[cur_scope];
    table[index].mode = LOCAL_MODE;
    table[index].type = T_SCALAR;
    if(trace_on){
        printf("// set local variable\n");
        printf("// name: %s, offset: %d\n", table[index].name, table[index].offset);
    }
}

void set_param(char* id){
    args_of_scope[cur_scope]++;
    int index = look_up_symbol(id);
    table[index].offset = args_of_scope[cur_scope];
    table[index].mode = ARGUMENT_MODE;
    table[index].type = is_arg_pointer[args_of_scope[cur_scope] - 1] ? T_ARRAY : T_SCALAR;
    if(trace_on){
        printf("// set param\n");
        printf("// name: %s, offset: %d, type: %d\n", table[index].name, table[index].offset, table[index].type);
    }
}


void set_local_array(char* id, int size){
    int index = look_up_symbol(id);
    table[index].offset = local_vars_of_scope[cur_scope] + 1;
    local_vars_of_scope[cur_scope] += size;
    table[index].mode = LOCAL_MODE;
    table[index].type = T_ARRAY;
    if(trace_on){
        printf("// set local array\n");
        printf("// name: %s, offset: %d\n", table[index].name, table[index].offset);
    }
}

void code_gen_func_header(char* functor){
    if(trace_on) printf("// code_gen_func_header begin: %s\n", functor);
    int index = look_up_symbol(functor);
    table[index].type = T_FUNCTION;
    table[index].total_args = argument_cnt;
    printf("%s:\n", functor);
    printf("addi sp, sp, -200\n");
    printf("sw ra, 196(sp)\n");
    printf("sw s0, 192(sp)\n");
    for (int i = 0; i < argument_cnt; i++) {
        printf("mv t0, a%d\n", i);
        //if(is_arg_pointer[i]) printf("add t1, a0\n");
        printf("sw t0, %d(sp)\n", 200 - 4 * i - 12);
    }
    printf("addi s0, sp, 200\n");
    if(trace_on) printf("// code_gen_func_header end: %s\n", functor);

    // printf("sw sp, -4(s0)\n");
    // printf("sw s1, -8(s0)\n");
    // printf("sw s2, -12(s0)\n");
    // printf("sw s3, -16(s0)\n");
    // printf("sw s4, -20(s0)\n");
    // printf("sw s5, -24(s0)\n");
    // printf("sw s6, -28(s0)\n");
    // printf("sw s7, -32(s0)\n");
    // printf("sw s8, -36(s0)\n");
    // printf("sw s9, -40(s0)\n");
    // printf("sw s10, -44(s0)\n");
    // printf("sw s11, -48(s0)\n");

    // printf("addi sp, s0, -48\n");
}

void code_gen_at_end_of_function_body(char* functor){
    if(trace_on) printf("// code_gen_at_end_of_function_body begin: %s\n", functor);
    printf("%s_end:\n", functor);
    printf("addi sp, s0, -200\n");
    printf("lw ra, 196(sp)\n");
    printf("lw s0, 192(sp)\n");
    printf("addi sp, sp, 200\n");
    printf("jalr zero, 0(ra)\n");
    if(trace_on) printf("// code_gen_at_end_of_function_body end: %s\n", functor);
}
