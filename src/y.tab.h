#ifndef _yy_defines_h_
#define _yy_defines_h_

#define NONE 257
#define NUL 258
#define RETURN 259
#define BREAK 260
#define CONTINUE 261
#define CASE 262
#define SWITCH 263
#define DEFAULT 264
#define CONST 265
#define SIGNED_OR_NOT 266
#define LONG_OR_SHORT 267
#define KEY_INT 268
#define KEY_CHAR 269
#define KEY_OTHER_TYPE 270
#define ID 271
#define STRING 272
#define CHAR 273
#define DIGITAL_WRITE 274
#define DELAY 275
#define INT 276
#define HIGH_LOW 277
#define IF 278
#define ELSE 279
#define WHILE 280
#define FOR 281
#define DO 282
#define FLOAT 283
#define PREC_IF 284
#define PREC_IFELSE 285
#define PREC_SWITCH 286
#define OR 287
#define AND 288
#define EQ 289
#define NEQ 290
#define NLT 291
#define NMT 292
#define LS 293
#define RS 294
#define PREC_2 295
#define INC 296
#define DEC 297
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE {
    float   floatVal;
    int     intVal;
    char*   stringVal;
    int*    params;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */
