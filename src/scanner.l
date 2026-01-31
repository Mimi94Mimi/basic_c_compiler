%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#include "code.h"
int line_cnt = 0;
int p1 = 0;  // 0 for source, 1 for token
int source = 1;
int token = 1;
char* first = NULL;
char* tokens[300];
int n_tokens = 9999;
int line_num = 1;
int is_pragma = 0;
int first_line = 1;

char buf[50000];
int buf_size = 50000;
char* get_stringVal(char* yytext){
    sprintf(buf, "%s", yytext);
    int sz = strlen(buf) + 1;
    char* str = malloc(sz * sizeof(char));
    memset(str, 0, sizeof(char)*sz);
    str = strcpy(str, buf);
    memset(buf, 0, sz * sizeof(char));
    return str;
}

extern int yydebug;
%}

%x COMMENT
%x COMMENT2
%option noyywrap

key  for|do|while|break|continue|if|else|return|struct|switch|case|default|void|int|double|float|char|const|signed|unsigned|short|"long long"|long
macro  NULL|__COUNTER__|__LINE__|INT_MAX|INT_MIN|CHAR_MAX|CHAR_MIN|MAX|MIN
gap [ \t\n]+
spec_func_id  digitalWrite|delay
high_low  HIGH|LOW
id  [[:alpha:]_][[:alnum:]_]*
op  (\+)|(-)|(\*)|(\/)|(%)|(\+)(\+)|(--)|(<)|(<=)|(>)|(>=)|(==)|(!=)|(=)|(&&)|(\|)(\|)|(!)|(~)|(&)|(\^)|(\|)|(>>)|(<<)
_comment  (([^\*\n]*|(\*)+[^\/\n])*(\*)*\n)
_comment_end  (([^\*\n]*|(\*)+[^\/\n])*(\*)+(\/))
_comment2  [^\n]*\n
_oct  [0-7]
_hex  [0-9a-fA-F]
_char  [^\\]|(\\([abefrntv(\\)(\')(\")(\?)]|{_oct}{1,3}|x{_hex}+|u{_hex}{4,4}|U{_hex}{8,8}))
_string  [^\\"]|(\\([abefrntv(\\)(\')(\")(\?)]|{_oct}{1,3}|x{_hex}+|u{_hex}{4,4}|U{_hex}{8,8}))
punc  :|;|,|\.|\[|\]|\(|\)|\{|\}
integer  [[:digit:]]+
float  ([[:digit:]]+\.[[:digit:]]+)|(\.[[:digit:]]+)|([[:digit:]]+\.)
char  \'{_char}\'
string  \"{_string}*\"
_pragma_arg1  (source|token)
_pragma_arg2  (on|off)
pragma  [ \t]*#pragma

%%
{_pragma_arg1}  {
    if(strcmp(yytext, "source") == 0){
        p1 = 0;
    }
    if(strcmp(yytext, "token") == 0){
        p1 = 1;
    }
    return NONE;
}
{_pragma_arg2}  {
    if(p1 == 0){
        if(strcmp(yytext, "on") == 0){
            source = 1;
        }
        if(strcmp(yytext, "off") == 0){
            source = 0;
        }
    }
    if(p1 == 1){
        if(strcmp(yytext, "on") == 0){
            token = 1;
        }
        if(strcmp(yytext, "off") == 0){
            token = 0;
        }
    }
    return NONE;
}
{pragma}  {
    if (first == NULL) first = yytext;
    is_pragma = 1;
    return NONE;
}
{gap}  {
    if (first == NULL) first = yytext;
}
{key}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#key:%s", yytext);
    }
    if (first == NULL) first = yytext;
    
    yylval.stringVal = get_stringVal(yytext);
    if(strcmp(yytext, "const")==0){
        return CONST;
    }
    if(strcmp(yytext, "signed")==0 || strcmp(yytext, "unsigned")==0){
        return SIGNED_OR_NOT;
    }
    if(strcmp(yytext, "long long")==0 || strcmp(yytext, "long")==0 || strcmp(yytext, "short")==0){
        if(strcmp(yytext, "long long")==0){
            yylval.stringVal = "longlong";
        }
        return LONG_OR_SHORT;
    }
    if(strcmp(yytext, "int")==0){
        return KEY_INT;
    }
    if(strcmp(yytext, "char")==0){
        return KEY_CHAR;
    }
    if(strcmp(yytext, "float")==0 || strcmp(yytext, "double")==0 || strcmp(yytext, "void")==0){
        yylval.stringVal = "non-void";
        if(strcmp(yytext, "void")==0){
            yylval.stringVal = "void";
        }
        return KEY_OTHER_TYPE;
    }
    if(strcmp(yytext, "return")==0){
        return RETURN;
    }
    if(strcmp(yytext, "break")==0){
        return BREAK;
    }
    if(strcmp(yytext, "continue")==0){
        return CONTINUE;
    }
    if(strcmp(yytext, "for")==0){
        label_cnt++;
        yylval.intVal = label_cnt;
        return FOR;
    }
    if(strcmp(yytext, "while")==0){
        label_cnt++;
        yylval.intVal = label_cnt;
        return WHILE;
    }
    if(strcmp(yytext, "do")==0){
        yylval.intVal = label_cnt + 1;
        return DO;
    }
    if(strcmp(yytext, "switch")==0){
        return SWITCH;
    }
    if(strcmp(yytext, "case")==0){
        return CASE;
    }
    if(strcmp(yytext, "default")==0){
        return DEFAULT;
    }
    if(strcmp(yytext, "if")==0){
        label_cnt++;
        yylval.intVal = label_cnt;
        return IF;
    }
    if(strcmp(yytext, "else")==0){
        return ELSE;
    }
}
{macro} {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#macro:%s", yytext);
    }
    if (first == NULL) first = yytext;
    
    yylval.stringVal = get_stringVal(yytext);
    if(strcmp(yytext, "NULL") == 0){
        return NUL;
    }
    return NONE;
}
{spec_func_id}  {
    if (token == 1){
        if(first_line == 0){
        }
        else{
            first_line = 0;
        }
    }
    if (first == NULL) first = yytext;

    if(strcmp(yytext, "digitalWrite")==0){
        return DIGITAL_WRITE;
    }
    if(strcmp(yytext, "delay")==0){
        return DELAY;
    }
}
{high_low}  {
    if (token == 1){
        if(first_line == 0){
        }
        else{
            first_line = 0;
        }
    }
    if (first == NULL) first = yytext;

    if(strcmp(yytext, "HIGH")==0){
        yylval.intVal = 1;
    }
    if(strcmp(yytext, "LOW")==0){
        yylval.intVal = 0;
    }
    return HIGH_LOW;
}
{id}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#id:%s", yytext);
    }
    if (first == NULL) first = yytext;

    yylval.stringVal = get_stringVal(yytext);
    return ID;
}
{op}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#op:%s", yytext);
    }
    if (first == NULL) first = yytext;

    // more symbols
    if(strcmp(yytext, "++") == 0){
        return INC;
    }
    if(strcmp(yytext, "--") == 0){
        return DEC;
    }
    if(strcmp(yytext, "<=") == 0){
        return NMT;
    }
    if(strcmp(yytext, ">=") == 0){
        return NLT;
    }
    if(strcmp(yytext, "==") == 0){
        return EQ;
    }
    if(strcmp(yytext, "!=") == 0){
        return NEQ;
    }
    if(strcmp(yytext, "&&") == 0){
        return AND;
    }
    if(strcmp(yytext, "||") == 0){
        return OR;
    }
    if(strcmp(yytext, ">>") == 0){
        return RS;
    }
    if(strcmp(yytext, "<<") == 0){
        return LS;
    }
    return yytext[0];
}
{integer}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#integer:%s", yytext);
    }
    if (first == NULL) first = yytext;

    sscanf(yytext, "%d", &(yylval.intVal));
    return INT;
}
{float}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#float:%s", yytext);
    }
    if (first == NULL) first = yytext;

    sscanf(yytext, "%f", &(yylval.floatVal));
    return FLOAT;
}
{punc}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#punc:%s", yytext);
    }
    if (first == NULL) first = yytext;

    return yytext[0];
}
{char}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#char:%s", yytext);
    }
    if (first == NULL) first = yytext;

    yylval.stringVal = get_stringVal(yytext);
    return CHAR;
}
{string}  {
    if (token == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else{
            first_line = 0;
        }
        //printf("#string:%s", yytext);
    }
    if (first == NULL) first = yytext;

    yylval.stringVal = get_stringVal(yytext);
    return STRING;
}
"/*"  {
    if (first == NULL) first = yytext;
    BEGIN COMMENT;
    //return NONE;
}
"//"  {
    if (first == NULL) first = yytext;
    BEGIN COMMENT2;
    //return NONE;
}
<COMMENT>{_comment}  {
    if (first == NULL) first = yytext;
    if (source == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else first_line = 0;
        if (first != NULL) {
            first[strlen(first) - 1] = '\0';
            //printf("%d:%s", line_num, first);
        }
        else {
            //printf("%d:", line_num);
        }
    }
    line_num++;
    first = NULL;
    //return NONE;
}
<COMMENT>{_comment_end}  {
    if (first == NULL) first = yytext;
    BEGIN 0;
    //return NONE;
}
<COMMENT2>{_comment2}  {
    if (first == NULL) first = yytext;
    if (source == 1){
        if(first_line == 0){
            //printf("\n");
        }
        else first_line = 0;
        if (first != NULL) {
            first[strlen(first) - 1] = '\0';
            //printf("%d:%s", line_num, first);
        }
        else {
            //printf("%d:", line_num);
        }
    }
    line_num++;
    first = NULL;
    BEGIN 0;
    //return NONE;
}
%%
