%baseclass-preinclude "semantics.h"

%lsp-needed

%union
{
  std::string *szoveg;
  kifejezes_leiro *kif;
}

%token SZAMKONSTANS
%token PROGRAM
%token VALTOZOK
%token UTASITASOK
%token PROGRAM_VEGE
%token HA
%token AKKOR
%token KULONBEN
%token HA_VEGE
%token CIKLUS
%token AMIG
%token CIKLUS_VEGE
%token BE
%token KI
%token EGESZ
%token LOGIKAI
%token ERTEKADAS
%token BALZAROJEL
%token JOBBZAROJEL
%token <szoveg> AZONOSITO
%token IGAZ
%token HAMIS
%token SKIP

%left VAGY
%left ES
%left NEM
%left EGYENLO
%left KISEBB NAGYOBB
%left PLUSZ MINUSZ
%left SZORZAS OSZTAS MARADEK

%type<kif> kifejezes


%%

start:
    kezdes deklaraciok utasitasok befejezes
;

kezdes:
    PROGRAM AZONOSITO
;

befejezes:
    PROGRAM_VEGE
;

deklaraciok:
    // ures
|
    VALTOZOK valtozolista
;

valtozolista:
    deklaracio
|
    deklaracio valtozolista
;

deklaracio:
    EGESZ AZONOSITO
    {
        if( szimbolumtabla.count(*$2) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$2 << ".\n"
            << "Korabbi deklaracio sora: " << szimbolumtabla[*$2].sor << std::endl;
            error( ss.str().c_str() );
        }
        szimbolumtabla[*$2] = kifejezes_leiro( d_loc__.first_line, Egesz );
    }
|
    LOGIKAI AZONOSITO
    {        
        if( szimbolumtabla.count(*$2) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$2 << ".\n"
            << "Korabbi deklaracio sora: " << szimbolumtabla[*$2].sor << std::endl;
            error( ss.str().c_str() );
        }
        szimbolumtabla[*$2] = kifejezes_leiro( d_loc__.first_line, Logikai );
    }
;

utasitasok:
    UTASITASOK utasitas utasitaslista
;

utasitaslista:
    // epsilon
|
    utasitas utasitaslista
;

utasitas:
    SKIP
|
    ertekadas
|
    be
|
    ki
|
    elagazas
|
    ciklus
;

ertekadas:
    AZONOSITO ERTEKADAS kifejezes
    {
        if( szimbolumtabla[*$1].ktip != $3->ktip )
        {
            error( "Tipushibas ertekadas.\n" );
        }
    }
;

be:
    BE AZONOSITO
;

ki:
    KI kifejezes
;

elagazas:
    HA kifejezes AKKOR utasitaslista HA_VEGE
    {
        const std::string hibauzenet = ": Az elagazas feltetele csak logikai tipusu kifejezes lehet.\n";
        if( $2->ktip != Logikai )
        {
            std::cerr << $2->sor << hibauzenet;
            exit(1);
        } 
        delete $2;
    }
|
    HA kifejezes AKKOR utasitaslista KULONBEN utasitaslista HA_VEGE
    {
        const std::string hibauzenet = ": Az elagazas feltetele csak logikai tipusu kifejezes lehet.\n";
        if( $2->ktip != Logikai )
        {
            std::cerr << $2->sor << hibauzenet;
            exit(1);
        } 
        delete $2;
    }
;

ciklus:
    CIKLUS AMIG kifejezes utasitaslista CIKLUS_VEGE
    {
        const std::string hibauzenet = ": Az ciklus feltetele csak logikai tipusu kifejezes lehet.\n";
        if( $3->ktip != Logikai )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        } 
        delete $3;
    }
;

kifejezes:
    SZAMKONSTANS
    {
        $$ = new kifejezes_leiro( d_loc__.first_line, Egesz );
    }
|
    IGAZ
    {
        $$ = new kifejezes_leiro( d_loc__.first_line, Logikai );
    }
|
    HAMIS
    {
        $$ = new kifejezes_leiro( d_loc__.first_line, Logikai );
    }
|
    AZONOSITO
    {
        $$ = new kifejezes_leiro( szimbolumtabla[*$1].sor, szimbolumtabla[*$1].ktip );
    }
|
    kifejezes PLUSZ kifejezes
    {
        const std::string hibauzenet = ": Az osszeadas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    kifejezes MINUSZ kifejezes
    {
        const std::string hibauzenet = ": A kivonas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    kifejezes SZORZAS kifejezes
    {        
        const std::string hibauzenet = ": A szorzas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    kifejezes OSZTAS kifejezes
    {
        const std::string hibauzenet = ": Az osztas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    kifejezes MARADEK kifejezes
    {
        const std::string hibauzenet = ": A maradekkepzes argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;        
    }
|
    kifejezes KISEBB kifejezes
    {
        const std::string hibauzenet = ": A kisebb argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;        
    }
|
    kifejezes NAGYOBB kifejezes
    {
        const std::string hibauzenet = ": A nagyobb argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;     
    }
|
    kifejezes EGYENLO kifejezes
    {
        if( $1->ktip != $3->ktip )
        {
            std::cerr << $1->sor << ": Az egyenloseg operatorral csak azonos tipusu kifejezeseket lehet osszehasonlitani.\n";
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;
    }
|
    kifejezes ES kifejezes
    {
        const std::string hibauzenet = ": Az es argumentuma csak logikai tipusu kifejezes lehet.\n";
        if( $1->ktip != Logikai )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Logikai )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;  
    }
|
    kifejezes VAGY kifejezes
    {
        const std::string hibauzenet = ": A vagy argumentuma csak logikai tipusu kifejezes lehet.\n";
        if( $1->ktip != Logikai )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Logikai )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;  
    }
|
    NEM kifejezes
    {
        const std::string hibauzenet = ": Az nem argumentuma csak logikai tipusu kifejezes lehet.\n";
        if( $2->ktip != Logikai )
        {
            std::cerr << $2->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $2->sor, Logikai );
        delete $2; 
    }
|
    BALZAROJEL kifejezes JOBBZAROJEL
    {
        $$ = $2;
    }
;
