#ifndef CODE_H
#define CODE_H

#define MAX_TABLE_SIZE 5000

typedef enum {
    T_FUNCTION,
    T_ARRAY,
    T_SCALAR
} symbol_type;

typedef enum {
    ARGUMENT_MODE,
    LOCAL_MODE
} id_mode;

struct symbol_entry {
    char *name;
    int scope;
    int offset;
    int id;
    int variant;
    symbol_type type;
    int total_args;
    int total_locals;
    id_mode mode;
    int has_return_value;
} table[MAX_TABLE_SIZE];

extern int cur_scope;
extern int cur_counter;
extern int trace_on;
extern int local_vars_of_scope[10];
extern int args_of_scope[10];
extern int label_cnt;
extern char* argument_id[10];
extern int is_arg_pointer[10];
extern int argument_cnt;
extern char* cur_func;

char *copys(char* s);
char* install_symbol(char *s);
int look_up_symbol(char* s);
void pop_up_symbol(int scope);
void set_scope_and_offset_of_param(char *s);
void set_local_var(char* s);
void set_local_array(char* s, int size);
void set_param(char* id);
void code_gen_func_header(char* functor);
void code_gen_at_end_of_function_body(char* functor);

#endif