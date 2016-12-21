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
	procedure initUnite();
	begin
        compteurEmprunt := 0;
	end;

	function saisirLivre(): Tlivre;
	begin
		
	end;
	

	
	procedure afficherLivre(livre:Tlivre);
	begin
		
	end;
	
	function creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
	begin
		
	end;
	
	procedure afficherEmprunt(emprunt:Temprunt);
	begin
		
	end;
	
	procedure ajouterExemplaire(var livre:Tlivre);
	begin
		
	end;
	
	function supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean;
	begin
		
	end;
	
	function estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:integer):boolean; 
	begin
		
	end;
	
	function compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer; // Retourne le nombre d'exemplaires encore disponibles		
	begin
		
	end;
	
	function compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):integer;
	begin
		
	end;
	
	function compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : integer; adherent : Tadherent) : integer;
	begin
		
	end;
	
end.
