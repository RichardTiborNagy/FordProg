%baseclass-preinclude <iostream>
%lsp-needed

%token AZONOSITO
%token SZAMKONSTANS;
%token PROGRAM;
%token VALTOZOK;
%token UTASITASOK;
%token PROGRAM_VEGE; 
%token HA;
%token AKKOR;
%token KULONBEN;
%token HA_VEGE; 
%token CIKLUS;
%token AMIG;
%token CIKLUS_VEGE;
%token BE;
%token KI;
%token EGESZ;
%token LOGIKAI;
%token IGAZ;
%token HAMIS;
%token SKIP;
%token ERTEKADAS;
%token NEM;
%token BALZAROJEL;
%token JOBBZAROJEL;

%left VAGY;
%left ES;
%left EGYENLO;
%left KISEBB NAGYOBB;
%left PLUSZ MINUSZ;
%left SZORZAS OSZTAS MARADEK;

%%

start:
    PROGRAM AZONOSITO VALTOZOK valtozodeklaraciok UTASITASOK utasitas utasitasok PROGRAM_VEGE        //valtozodeklaraciokkal
    {
        std::cout << "start -> PROGRAM AZONOSITO VALTOZOk valtozodeklaraciok UTASITASOK utasitasok PROGRAM_VEGE" << std::endl;
    }
|
    PROGRAM AZONOSITO UTASITASOK utasitas utasitasok PROGRAM_VEGE                                    //deklaraciok nelkul
    {
        std::cout << "start -> PROGRAM AZONOSITO UTASITASOK utasitasok PROGRAM_VEGE" << std::endl;
    }
;

valtozodeklaraciok:
    valtozodeklaracio
    {
        std::cout << "valtozodeklaraciok -> valtozodeklaracio" << std::endl;
    }
|
    valtozodeklaracio valtozodeklaraciok
    {
        std::cout << "valtozodeklaraciok -> valtozodeklaracio valtozodeklaraciok" << std::endl;
    }
;

utasitasok:
    //ures
    {
        std::cout << "utasitasok -> epszilon" << std::endl;
    }
|
    utasitas utasitasok
    {
        std::cout << "utasitasok -> utasitas utasitasok" << std::endl;
    }
;

valtozodeklaracio:
    EGESZ AZONOSITO
    {
        std::cout << "valtozodeklaracio -> EGESZ AZONOSITO" << std::endl;
    }
|
    LOGIKAI AZONOSITO
    {
        std::cout << "valtozodeklaracio -> LOGIKAI AZONOSITO" << std::endl;
    }
;

utasitas:
    SKIP
    {
        std::cout << "utasitas -> SKIP" << std::endl;
    }
|
    AZONOSITO ERTEKADAS kifejezes
    {
        std::cout << "utasitas -> AZONOSITO ERTEKADAS kifejezes" << std::endl;
    }
|
    BE AZONOSITO
    {
        std::cout << "utasitas -> BE AZONOSITO" << std::endl;
    }
|
    KI kifejezes
    {
        std::cout << "utasitas -> KI kifejezes" << std::endl;
    }
|
    CIKLUS AMIG kifejezes utasitasok CIKLUS_VEGE
    {
        std::cout << "utasitas -> CIKLUS AMIG kifejezes utasitasok CIKLUS_VEGE" << std::endl;
    }
|
    HA kifejezes AKKOR utasitasok HA_VEGE
    {
        std::cout << "utasitas -> HA kifejezes AKKOR utasitasok HA_VEGE" << std::endl;
    }
|
    HA kifejezes AKKOR utasitasok KULONBEN utasitasok HA_VEGE
    {
        std::cout << "utasitas -> HA kifejezes AKKOR utasitasok KULONBEN utasitasok HA_VEGE" << std::endl;
    }
;

kifejezes:
    SZAMKONSTANS
    {
        std::cout << "kifejezes -> SZAMKONSTANS" << std::endl;
    }
|
    IGAZ
    {
        std::cout << "kifejezes -> IGAZ" << std::endl;
    }
|
    HAMIS
    {
        std::cout << "kifejezes -> HAMIS" << std::endl;
    }
|
    AZONOSITO
    {
        std::cout << "kifejezes -> AZONOSITO" << std::endl;
    }
|
    kifejezes PLUSZ kifejezes
    {
        std::cout << "kifejezes -> kifejezes PLUSZ kifejezes" << std::endl;
    }
|
    kifejezes MINUSZ kifejezes
    {
        std::cout << "kifejezes -> kifejezes MINUSZ kifejezes" << std::endl;
    }
|
    kifejezes SZORZAS kifejezes
    {
        std::cout << "kifejezes -> kifejezes SZORZAS kifejezes" << std::endl;
    }
|
    kifejezes OSZTAS kifejezes
    {
        std::cout << "kifejezes -> kifejezes OSZTAS kifejezes" << std::endl;
    }
|
    kifejezes MARADEK kifejezes
    {
        std::cout << "kifejezes -> kifejezes MARADEK kifejezes" << std::endl;
    }
|
    kifejezes EGYENLO kifejezes
    {
        std::cout << "kifejezes -> kifejezes EGYENLO kifejezes" << std::endl;
    }
|
    kifejezes KISEBB kifejezes
    {
        std::cout << "kifejezes -> kifejezes KISEBB kifejezes" << std::endl;
    }
|
    kifejezes NAGYOBB kifejezes
    {
        std::cout << "kifejezes -> kifejezes NAGYOBB kifejezes" << std::endl;
    }
|
    kifejezes ES kifejezes
    {
        std::cout << "kifejezes -> kifejezes ES kifejezes" << std::endl;
    }
|
    kifejezes VAGY kifejezes
    {
        std::cout << "kifejezes -> kifejezes VAGY kifejezes" << std::endl;
    }
|
    NEM kifejezes
    {
        std::cout << "kifejezes -> NEM kifejezes" << std::endl;
    }
|
    BALZAROJEL kifejezes JOBBZAROJEL
    {
        std::cout << "kifejezes -> BALZAROJEL kifejezes JOBBZAROJEL" << std::endl;
    }
;