/**
 * @file
 * 	\brief Este fichero es la implementación de un scanner en flex. 
 * Para compilarlo, es necesario generar primero el fichero parser.tab.h con
 * bison, usando la opción -d en la línea de comandos
 * Luego, puede usar la herramienta flex para traducir el código fuente de
 * este fichero, a código C
 * @author Silvia Popa y Víctor Ruiz Gómez
 */

%{
 /* Necesaria la inclusión de esta cabecera para que los tokens (definidos
  * por bison), puedan sean visibles para flex)
  */
#include "parser.tab.h"
						
#include <stdio.h>

%}

/* Definición de las expresiones regulares */

/* Algunas expresiones regulares básicas */
letra [A-Za-z]
digito [0-9]
delim [ \t\n]
id {letra}({letra}|{digito})*

/* Expresiones regulares para algunos operadores */
asignacion ":="
comp_secuencial ";"
separador ","
subrango ".."
def_tipo_variable ":"
entonces "->"
si_no_si "[]"
creacion_tipo "="
inicio_array "["
fin_array "]"

/* Definición de expresiones regulares para las palabras reservadas */
r_accion (?i:"accion")
r_de (?i:"de")
r_algoritmo (?i:"algoritmo")
r_const (?i:"const")
r_continuar (?i:"continuar")
r_dev (?i:"dev")
r_div (?i:"div")
r_ent (?i:"ent")
r_es (?i:"e\/s")
r_faccion (?i:"faccion")
r_falgoritmo (?i:"falgoritmo")
r_fconst (?i:"fconst")
r_ffuncion (?i:"ffuncion")
r_fmientras (?i:"fmientras")
r_fpara (?i:"fpara")
r_fsi (?i:"fsi")
r_ftipo (?i:"ftipo")
r_ftupla (?i:"ftupla")
r_funcion (?i:"funcion")
r_fvar (?i:"fvar")
r_hacer (?i:"hacer")
r_hast (?i:"hasta")
r_mientras (?i:"mientras")
r_mod (?i:"mod")
r_no (?i:"no")
r_o (?i:"o")
r_para (?i:"para")
r_ref (?i:"ref")
r_sal (?i:"sal")
r_si (?i:"si")
r_tabla (?i:"tabla")
r_tipo (?i:"tipo")
r_tupla (?i:"tupla")
r_var (?i:"var")
r_y (?i:"y")

r_verdadero(?i:"verdadero")
r_falso(?i:"falso")
r_entero (?i:"entero")
r_booleano (?i:"booleano")
r_caracter (?i:"caracter")
r_real (?i:"real")
r_string (?i:"string")


/* Definición de expresiones regulares asociadas a literales */
literal_entero (\+|\-)?{digito}{digito}*((e|E){digito}{digito})? 
literal_real (\+|\-)?{digito}{digito}*(\.{digito}{digito}*)?((e|E){digito}{digito}*)?
literal_booleano (?i:"verdadero"|"falso")
literal_caracter \'{letra}\'
literal_string \"([^\"]|\/\")*\"

/* Definición de la expresión regular para comentarios */
comentario \{([^\}]|\/\})*\} 

%%
	/* Zona de definición de reglas */
{delim} { } 
	/* Reglas para literales */
{literal_entero} { yylval.C_literal_entero=atoi(yytext);return T_literal_entero;}
{literal_real} {yylval.C_literal_entero=atof(yytext); return T_literal_real; }
{literal_booleano} {yylval.C_literal_entero=atoi(yytext); return T_literal_booleano; }
{literal_caracter} {strcpy(yylval.C_literal_string, yytext); return T_literal_caracter;}
{literal_string} { strcpy(yylval.C_literal_string, yytext);  return T_literal_string; }
{comentario} {}

{asignacion} { printf("dr_asignacion\n"); }
{comp_secuencial} {return T_comp_secuencial; }
{separador} { printf("dr_separador: '%c'\n", yytext[0]); }
{subrango} { return T_subrango; }
{def_tipo_variable} { return T_def_tipo_variable; }
{entonces} { printf("dr_entonces\n"); }
{si_no_si} { printf("dr_si_no_si\n"); }
{creacion_tipo} {return T_creacion_tipo; }
{inicio_array} { return T_inic_array; }
{fin_array} { return T_fin_array; }
	/* Reglas para palabras reservadas */
{r_accion} { printf("r_accion\n"); }
{r_real} {strcpy(yylval.C_tipo_base,"real"); return T_tipo_base;}
{r_entero} {strcpy(yylval.C_tipo_base,"entero"); return T_tipo_base;}
{r_caracter} {strcpy(yylval.C_tipo_base,"caracter"); return T_tipo_base;}
{r_booleano} {strcpy(yylval.C_tipo_base,"booleano"); return T_tipo_base;}
{r_string} {strcpy(yylval.C_tipo_base,"string"); return T_tipo_base;}
{r_ref} {return T_ref;}
{r_de} {return T_de;}
{r_algoritmo} { printf("r_algoritmo\n"); }
{r_const} { printf("r_const\n"); }
{r_continuar} { printf("r_continuar\n"); }
{r_dev} { printf("r_dev\n"); } 
{r_div} { printf("r_div\n"); }
{r_ent} { printf("r_ent\n"); }
{r_es} { printf("r_es\n"); }
{r_faccion} { printf("r_faccion\n"); } 
{r_falgoritmo} { printf("r_falgoritmo\n"); }
{r_fconst} { printf("r_fconst\n"); }
{r_ffuncion} { printf("r_ffuncion\n"); }
{r_fmientras} { printf("r_fmientras\n"); }
{r_fpara} { printf("r_fpara\n"); }
{r_fsi} { printf("r_fsi\n"); }
{r_ftipo} { printf("r_ftipo\n"); }
{r_ftupla} { return T_ftupla; } 
{r_funcion} { printf("r_funcion\n"); } 
{r_fvar} { printf("r_fvar\n"); }
{r_hacer} { printf("r_hacer\n"); }
{r_hast} { printf("r_hast\n"); }
{r_mientras} { printf("r_mientras\n"); }
{r_mod} { printf("r_mod\n"); }
{r_no} { printf("r_no\n"); }
{r_o} { printf("r_o\n"); }
{r_para} { printf("r_para\n"); } 
{r_sal} { printf("r_sal\n"); }
{r_si} { printf("r_si\n"); }
{r_tabla}  { return T_tabla; }
{r_tipo} { printf("r_tipo\n"); }
{r_tupla} { return T_tupla; }
{r_var} { printf("r_var\n"); }
{r_y} { printf("r_y\n"); }
	
	
{id} { strcpy(yylval.C_id, yytext); return T_id;}

%%


