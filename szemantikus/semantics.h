#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <iostream>
#include <string>
#include <map>
#include <sstream>

enum tipus { Egesz, Logikai };

struct kifejezes_leiro
{
    int sor;
    tipus ktip;
    kifejezes_leiro( int s, tipus t )
        : sor(s), ktip(t) {}    
    kifejezes_leiro() {};
};

#endif //SEMANTICS_H