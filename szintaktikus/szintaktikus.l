%option noyywrap c++ yylineno

%{
#include "Parserbase.h"
%}

SZAMJEGY    [0-9]
WS          [ \t\n]
BETU        [a-zA-Z]

%%

#[^#]*#    // nem kell semmit csinalni

{SZAMJEGY}+     return Parser::SZAMKONSTANS;

PROGRAM         return Parser::PROGRAM;
VALTOZOK:       return Parser::VALTOZOK;
UTASITASOK:     return Parser::UTASITASOK;
PROGRAM_VEGE    return Parser::PROGRAM_VEGE; 
HA              return Parser::HA;
AKKOR           return Parser::AKKOR;
KULONBEN        return Parser::KULONBEN;
HA_VEGE         return Parser::HA_VEGE; 
CIKLUS          return Parser::CIKLUS;
AMIG            return Parser::AMIG;
CIKLUS_VEGE     return Parser::CIKLUS_VEGE;
BE:             return Parser::BE;
KI:             return Parser::KI;
EGESZ           return Parser::EGESZ;
LOGIKAI         return Parser::LOGIKAI;
IGAZ            return Parser::IGAZ;
HAMIS           return Parser::HAMIS;
SKIP            return Parser::SKIP;

":="            return Parser::ERTEKADAS;
"="             return Parser::EGYENLO;
"<"             return Parser::KISEBB;
">"             return Parser::NAGYOBB;
"+"             return Parser::PLUSZ;
"-"             return Parser::MINUSZ;
"*"             return Parser::SZORZAS;
"/"             return Parser::OSZTAS;
"%"             return Parser::MARADEK;
ES              return Parser::ES;
VAGY            return Parser::VAGY;
NEM             return Parser::NEM;
"("             return Parser::BALZAROJEL;
")"             return Parser::JOBBZAROJEL;

{BETU}({BETU}|{SZAMJEGY})*  return Parser::AZONOSITO;

{WS}+   // feher szokozok: semmi teendo

. {
    std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
    exit(1);
}

%%
