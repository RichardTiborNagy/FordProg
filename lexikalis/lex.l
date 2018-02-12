%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

BETU        [a-zA-Z]
SZAMJEGY    [0-9]
WS          [ \t\n]

%%

#(.|\n)*#            std::cout << "megjegyzes" << std::endl;

PROGRAM         std::cout << "kulcsszo: " << YYText() << std::endl;
PROGRAM_VEGE    std::cout << "kulcsszo: " << YYText() << std::endl;
VALTOZOK:       std::cout << "kulcsszo: " << YYText() << std::endl;
UTASITASOK:     std::cout << "kulcsszo: " << YYText() << std::endl;
EGESZ           std::cout << "kulcsszo: " << YYText() << std::endl;
LOGIKAI         std::cout << "kulcsszo: " << YYText() << std::endl;
IGAZ            std::cout << "kulcsszo: " << YYText() << std::endl;
HAMIS           std::cout << "kulcsszo: " << YYText() << std::endl;
ES              std::cout << "kulcsszo: " << YYText() << std::endl;
VAGY            std::cout << "kulcsszo: " << YYText() << std::endl;
NEM             std::cout << "kulcsszo: " << YYText() << std::endl;
SKIP            std::cout << "kulcsszo: " << YYText() << std::endl;
HA              std::cout << "kulcsszo: " << YYText() << std::endl;
AKKOR           std::cout << "kulcsszo: " << YYText() << std::endl;
KULONBEN        std::cout << "kulcsszo: " << YYText() << std::endl;
HA_VEGE         std::cout << "kulcsszo: " << YYText() << std::endl;
CIKLUS          std::cout << "kulcsszo: " << YYText() << std::endl;
AMIG            std::cout << "kulcsszo: " << YYText() << std::endl;
CIKLUS_VEGE     std::cout << "kulcsszo: " << YYText() << std::endl;
KI:             std::cout << "kulcsszo: " << YYText() << std::endl;
BE:             std::cout << "kulcsszo: " << YYText() << std::endl;

"("             std::cout << "nyito zarojel" << std::endl;
")"             std::cout << "csuko zarojel" << std::endl;
"+"             std::cout << "osszeadas" << std::endl;
"-"             std::cout << "kivonas" << std::endl;
"*"             std::cout << "szorzas" << std::endl;
"/"             std::cout << "egeszosztas" << std::endl;
"%"             std::cout << "maradekkepzes" << std::endl;
"<"             std::cout << "kisebb" << std::endl;
">"             std::cout << "nagyobb" << std::endl;
"="             std::cout << "egyenloseg" << std::endl;
":="            std::cout << "ertekadas" << std::endl;

{SZAMJEGY}+     std::cout << "szam konstans: " << YYText() << std::endl;
{BETU}+[{BETU}{SZAMJEGY}]*  std::cout << "azonosito: " << YYText() << std::endl;

{WS}+       // feher szokozok: semmi teendo


.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%