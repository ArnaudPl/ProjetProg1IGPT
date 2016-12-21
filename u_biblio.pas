unit u_biblio;
interface
	uses u_livre, u_adherent;
	
	const
		Cmax = 100;
		
	type
	
		Tbibliotheque = record
			nomBiblio : string;
			tabLivres : TypeTabLivres;
			nbLivres : integer;
			tabEmprunts : TypeTabEmprunts;
			nbEmprunts : integer;
			tabAdherents : TypeTabAdherents;
			nbAdherents : integer;
			adresse : Tadresse;
		end;
	
	// Initialise les attributs de la bibliothèque
	procedure initBiblio(var biblio:Tbibliotheque);
	// Affiche l'ensemble des informations de la bibliothèque
	procedure afficherBibliotheque(biblio:Tbibliotheque);
	// Permet de savoir si la bibliothèque est ouverte ou non ! Elle est ouverte du mardi au samedi de 8h à 12h et de 14h à 20h, et le lundi de 14h à 18h !
	function estOuverte(jour:string; heure:integer):boolean;
	
	// Ajoute un nouveau livre à la bibliothèque
	function ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; nouveauLivre : Tlivre) : boolean; 
	// Supprime le livre de la bibliothèque, à condition qu'il ne soit plus emprunté !
	function supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
	// Cherche le livre dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau.
	function trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : integer; livre:Tlivre; var indiceRetour:integer):boolean;
	// Cherche dans la bibliothèque le livre qui correspond à l'ISBN passé en paramètre
	function trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : integer; isbn:string; var livre:Tlivre):boolean;
	// Cherche dans la bibliothèque tous les livres qui contiennent le code d'auteur passé en paramètre
	function trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : integer; codeAuteur:string; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:integer):boolean;
	
	// Ajoute un nouvel adhérent à la bibliothèque
	function ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent) : boolean;
	// Supprime de la bibliothèque l'adhérent passé en paramètre, à condition que celui-ci n'est plus d'emprunt à son code !
	function supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
	// Cherche l'adhérent dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau.
	function trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; var indiceRetour : integer) : boolean;
	// Cherche dans la bibliothèque l'adhérent qui correspond au code passé en paramètre.
	function trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:integer; codeAdherent:string; var adherentTrouve:Tadherent) : boolean;
	
	// Crée un emprunt avec les informations passées en paramètres et l'ajoute à la liste des emprunts de la bibliothèque
	function emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):boolean;
	// Supprime l'emprunt de la liste des emprunts de la bibliothèque
	function rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; emprunt:Temprunt):boolean;
	// Cherche l'emprunt dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau
	function trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:integer; emprunt:Temprunt; var indiceRetour : integer):boolean; 
	// Cherche dans la bibliothèque l'emprunt qui correspond au numéro passé en paramètre
	function trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; var emprunt:Temprunt ;numero:integer):boolean;

implementation

	procedure initBiblio(var biblio:Tbibliotheque);
	begin
		
	end;
	
	procedure afficherBibliotheque(biblio:Tbibliotheque);
	begin
		
	end;
	
	function estOuverte(jour:string; heure:integer):boolean;
	begin
		
	end;
	
	function ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; nouveauLivre : Tlivre) : boolean; 
	begin
		
	end;
	
	function supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
	begin
		
	end;
	
	function trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : integer; livre:Tlivre; var indiceRetour:integer):boolean;
	begin
		
	end;
	
	function trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : integer; isbn:string; var livre:Tlivre):boolean;
	begin
		
	end;
	
	function trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : integer; codeAuteur:string; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:integer):boolean;
	begin
		
	end;
	
	function ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent) : boolean;
	begin
		
	end;
	
	function supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
	begin
		
	end;
	
	function trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; var indiceRetour : integer) : boolean;
	begin
		
	end;
	
	function trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:integer; codeAdherent:string; var adherentTrouve:Tadherent) : boolean;
	begin
		
	end;
	
	function emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):boolean;
	begin
		
	end;
	
	function rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; emprunt:Temprunt):boolean; 
	begin
		
	end;
	
	function trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:integer; emprunt:Temprunt; var indiceRetour : integer):boolean; 
	begin
		
	end;
	
	function trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; var emprunt:Temprunt ;numero:integer):boolean;
	begin
		
	end;
end.
