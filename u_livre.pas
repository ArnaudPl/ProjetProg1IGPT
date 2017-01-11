{
Nom : 
Descritpion : 
Auteur : Christe Thibaud
Date création : 21.12.2016
Dernière modification : 21.12.2016
}

unit u_livre;
interface
	uses u_adherent;
	
	const
		Cmax = 100;
	var
		// Variable globale qui doit être initialisée à 0 au début du programme et incrémentée de 1 à chaque création d'emprunt !
		compteurEmprunt : integer;
	type
	
		Tlivre = record
			isbn : string;
			titre : string;
			codeAuteur : string;
			nbPages : integer;
			nbExemplaires : integer; // Par exemple, la bibliothèque peut posséder trois exemplaires du petit larousse illustré 2013
		end;
		
		TypeTabLivres = array[0..Cmax-1] of Tlivre;
		
		Tdate = record
			jour : integer;
			mois : integer;
			annee : integer;
		end;
	
		Temprunt = record
			numeroEmprunt : integer; //Incrémenté selon le compteur global "compteurEmprunt" déclaré ci-dessous.
			livre : Tlivre;
			adherent : Tadherent;
			dateEmprunt : Tdate;
		end;
		
		TypeTabEmprunts = array[0..Cmax-1] of Temprunt;
		
		// Initialise l'unité, en mettant le compteur d'emprunts à 0
		procedure initUnite();
        // Demande toutes les informations à l'utilisateur et retourne un nouveau livre ayant les informations saisies
		function saisirLivre():Tlivre;
        // Affiche toutes les informations du livre
		procedure afficherLivre(livre:Tlivre);
        // Retourne un nouvel emprunt contenant les informations passées en paramètres et un numéro unique (grâce à compteurEmprunt)
		function creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
        // Affiche les informations principales de l'emprunt
		procedure afficherEmprunt(emprunt:Temprunt);
		// Ajoute un exemplaire supplémentaire au livre passé en paramètre
		procedure ajouterExemplaire(var livre:Tlivre);
        // Supprime un exemplaire au livre passé en paramètre, à condition qu'il reste un moins un exemplaire du livre qui ne soit pas déjà emprunté !
		function supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean;
		// Vérifie s'il reste au moins un exemplaire du livre qui n'est pas emprunté
		function estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean;
        // Compte le nombre d'exemplaires du livre qui ne sont pas empruntés et retourne le total
		function compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer;
        // Compte le nombre d'exemplaires du livre qui sont empruntés et retourne le total
		function compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer;
        // Compte le nombre d'emprunts qui sont au code de l'adhérent et retourne le total
		function compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : integer; adherent : Tadherent) : integer;

implementation
    
    {   Nom fonction :  initUnit
        Description : Initialise le unit u_livre
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
    procedure initUnite();
	begin
        compteurEmprunt := 0;
	end;


    {   Nom fonction :  saisirLivre
        Description : Permet de saisir un livre et le retourne
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
	function saisirLivre(): Tlivre;
    var
        livreSaisi : Tlivre;
	begin
        writeln('------- Saisie d''un livre -------');
        writeln('- Veuillez saisir le numero ISBN : ');
        readln(livreSaisi.isbn);
        
        writeln('- Veuillez saisir le titre : ');
        readln(livreSaisi.titre);
        
        writeln('- Veuillez le nom de l''auteur : ');
        readln(livreSaisi.codeAuteur);
        
        repeat
            writeln('- Veuillez le nombre de pages : ');
            readln(livreSaisi.nbPages);
        until(livreSaisi.nbPages > 0);
        
        repeat
            writeln('- Veuillez le nombre d''exemplaires : ');
            readln(livreSaisi.nbExemplaires);
        until(livreSaisi.nbExemplaires > 0);    
    
		saisirLivre := livreSaisi;
	end;
	

    {   Nom fonction :  afficherLivre
        Description : Affiche le livre passé en paramètre
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
	procedure afficherLivre(livre:Tlivre);
	begin
        writeln('ISBN : ', livre.isbn);
        writeln('Titre : ', livre.titre);
        writeln('Auteur : ', livre.codeAuteur);
        writeln('Nombre de pages : ', livre.nbPages);
        writeln('Nombre d''exemplaire : ', livre.nbExemplaires);
	end;
	
    
    {   Nom fonction :  creerEmprunt
        Description : Créé un emprunt avec un numéro unique
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
	function creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
	var
        emprunt : Temprunt;
    begin
        compteurEmprunt := compteurEmprunt + 1;      //On incrémente le nombre d'emprunts ce qui donnera un identifiant unique à l'emprunt
            
        emprunt.numeroEmprunt := compteurEmprunt;
        emprunt.livre := livre;
        emprunt.adherent := adherent;
        emprunt.dateEmprunt := date;
        
        creerEmprunt := emprunt       
	end;
    
    
    {   Nom fonction :  afficherEmprunt
        Description : Affiche un emprunt
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
	procedure afficherEmprunt(emprunt:Temprunt);
	begin
        writeln('Num : ', emprunt.numeroEmprunt);
        writeln('Livre : ');
        afficherLivre(emprunt.livre);
        writeln('Adherent  : ');
        u_adherent.afficherAdherent(emprunt.adherent);
        writeln('Date : ', emprunt.dateEmprunt.jour,'.',emprunt.dateEmprunt.mois,'.',emprunt.dateEmprunt.annee); 
	end;
	
    
    
    {   Nom fonction :  ajouterExemplaire
        Description : Ajout un exemplaire au livre
        Auteur : Chritste Thibaud
        Date : 21.12.2016
    }
	procedure ajouterExemplaire(var livre:Tlivre);
	begin
        livre.nbExemplaires := livre.nbExemplaires + 1;
	end;
	
    
    {   Nom fonction :  supprimerExemplaire
        Description : Supprime un exemplaire d un livre à condition qu il y en a un et qu il soit disponible
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean;
	var
        deroulementOK : boolean;
    begin
    
        deroulementOK := false;
        if ((livre.nbExemplaires > 1) and (compteExemplairesDisponibles(livre,tabEmprunt,nbEmprunts) > 0)) then
            begin
                livre.nbExemplaires := livre.nbExemplaires - 1;
                deroulementOK := true;
            end; 
    
		supprimerExemplaire := deroulementOK;
	end;
    
	
    
    {   Nom fonction :  estDisponible
        Description : Vérifie si le livre est disponible
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean; 
	var
        disponible : boolean;
    begin
        if(compteExemplairesDisponibles(livre,tabEmprunt,nbEmprunts) > 0) then
            disponible := true
        else
            disponible := false;
        
        estDisponible := disponible;
	end;
	
    
    {  Nom fonction :  compteExemplairesDisponibles
        Description : Compte le nombre d exemplaire encore disponible
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer; // Retourne le nombre d'exemplaires encore disponibles
	var
        ind : integer;
        nbExemplairesDispo : integer;
    begin
        nbExemplairesDispo := livre.nbExemplaires;
        ind := 0;
        
        while((ind <= nbEmprunts-1) and (nbExemplairesDispo > 0)) do
        begin
            if(tabEmprunt[ind].livre.isbn = livre.isbn) then
            begin
                nbExemplairesDispo :=  nbExemplairesDispo - 1;
            end;
            ind := ind + 1;
        end;        
        compteExemplairesDisponibles := nbExemplairesDispo;
	end;
    
    {   Nom fonction :  compteExemplairesEmpruntes
        Description : Compte le nombre d exemplaire déjà emprunté
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer;
	var 
        nbExemplaireEmpruntes : integer;
    begin
        nbExemplaireEmpruntes := livre.nbExemplaires - compteExemplairesDisponibles(livre,tabEmprunt,nbEmprunts);
        compteExemplairesEmpruntes := nbExemplaireEmpruntes;
	end;
	
    
    {   Nom fonction :  compteEmpruntsParAdherent
        Description : Compte le nombre d emprunts pour un adhrent donné
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : integer; adherent : Tadherent) : integer;
    var 
        ind : integer;
        nbEmprunt : integer;
	begin
        nbEmprunt := 0;
        for ind:= 0 to (nbEmprunts-1) do
        begin
            if(tabEmprunt[ind].adherent.codeAdherent = adherent.codeAdherent) then
                nbEmprunt := nbEmprunt + 1;
        end;
        
        compteEmpruntsParAdherent := nbEmprunt;
	end;
end.
