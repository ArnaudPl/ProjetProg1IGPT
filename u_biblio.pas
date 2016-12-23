unit u_biblio;
interface
	uses u_livre, u_adherent, crt;
	
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

    //Déclaration des procédures privées
    procedure afficheEmprunts(biblio:Tbibliotheque);forward;
    procedure afficheAdherents(biblio:Tbibliotheque);forward;
    

	procedure initBiblio(var biblio:Tbibliotheque);
	begin
        //Initialise tous les compteurs relatifs à un tableau
		biblio.nbLivres := 0;
        biblio.nbEmprunts := 0;
        biblio.nbAdherents := 0;
	end;
	
	procedure afficherBibliotheque(biblio:Tbibliotheque);
	begin
        ClrScr;
		writeln('Affichage de ', biblio.nomBiblio, ' :');
        writeln('Adresse : ', biblio.adresse.rue, ' n°', biblio.adresse.numeroRue);
        writeln('Ville : ', biblio.adresse.npa, ' ', biblio.adresse.ville, ' - ', biblio.adresse.pays);
        afficheAdherents(biblio);
        writeln('');
        afficheEmprunts(biblio);
	end;
	
	function estOuverte(jour:string; heure:integer):boolean;
	begin
        estOuverte := false;
        case jour of
            'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi' : 
                begin
                    if (((heure >= 8) and (heure < 12)) or ((heure >= 14) and (heure < 20))) then
                        estOuverte := true;
                end;
            'lundi' :
                begin
                    if ((heure >= 14) and (heure < 18)) then
                        estOuverte := true;
                end;
        end;
	end;
	
	function ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; nouveauLivre : Tlivre) : boolean; 
	begin
        ajouterNouveauLivre := false;
        
        if nbLivres < Cmax - 1 then
            begin
		      tabLivres[nbLivres] := nouveauLivre;
              nbLivres := nbLivres + 1;
              ajouterNouveauLivre := true;
            end;
	end;
	
	function supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : integer; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
    var
        indiceLivre : integer;
        i : integer;
	begin
		supprimerLivre := false;
        i := 0;
        
        if trouverIndiceLivre(tabLivres, nbLivres, livre, indiceLivre) then
        begin
            if u_livre.compteExemplairesEmpruntes(livre, tabEmprunt, nbEmprunts) = 0 then
            begin
                for i := indiceLivre to nbLivres - 2 do
                begin
                    tabLivres[i] := tabLivres[i + 1];
                end;
                nbLivres := nbLivres - 1;
                supprimerLivre := true;
            end;
        end;
	end;
	
	function trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : integer; livre:Tlivre; var indiceRetour:integer):boolean;
    var
        i : integer;
	begin
        trouverIndiceLivre := false;
        i := 0;
        
		if nbLivres > 0 then
        begin
            while ((i <= nbLivres - 1) or (trouverIndiceLivre = false)) do
            begin
                if tabLivres[i].isbn = livre.isbn then
                begin
                    indiceRetour := i;
                    trouverIndiceLivre := true;
                end;
                
                i := i + 1;
            end;
        end;
	end;
	
	function trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : integer; isbn:string; var livre:Tlivre):boolean;
	var
        i : integer;
	begin
        trouverLivreParISBN := false;
        i := 0;
        
		if nbLivres > 0 then
        begin
            while ((i <= nbLivres - 1) and (trouverLivreParISBN = false)) do
            begin
                if tabLivres[i].isbn = isbn then
                begin
                    livre := tabLivres[i];
                    trouverLivreParISBN := true;
                end;
                
                i := i + 1;
            end;
        end;
	end;
	
	function trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : integer; codeAuteur:string; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:integer):boolean;
	var
        i : integer;
	begin
        trouverLivresParAuteur := false;
        
		if nbLivres > 0 then
        begin
            for i := 0 to nbLivres - 1 do
            begin
                if tabLivres[i].codeAuteur = codeAuteur then
                begin
                    tabLivresTrouves[nbLivresTrouves] := tabLivres[i];
                    nbLivresTrouves := nbLivresTrouves + 1;
                end;
            end;
        end;
        
        if nbLivresTrouves > 0 then
            trouverLivresParAuteur := true;
	end;
	
	function ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent) : boolean;
	begin
        ajouterNouvelAdherent := false;
        
		if nbAdherents < Cmax - 1 then
        begin
            tabAdherents[nbAdherents] := adherent;
            nbAdherents := nbAdherents + 1;
            ajouterNouvelAdherent := true;
        end;
	end;
	
	function supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : integer):boolean;
    var
        i : integer;
        indiceAdherent : integer;
	begin
		supprimerAdherent := false;
        
        // Vérifie d'abord qu'il y ait des adhérents
        if nbAdherents > 0 then
        begin
            //Vérifie ensuite que celui-ci n'a pas un emprunt actif
            if u_livre.compteEmpruntsParAdherent(tabEmprunt, nbEmprunts, adherent) = 0 then
            begin
                //Trouve l'adhérent dans la liste
                if trouverIndiceAdherent(tabAdherents, nbAdherents, adherent, indiceAdherent) then
                begin
                    //Le supprime et met à jour le nombre d'adhérents
                    for i := indiceAdherent to nbAdherents - 2 do
                    begin
                        tabAdherents[i] := tabAdherents[i + 1];
                    end;
                    nbAdherents := nbAdherents - 1;
                    supprimerAdherent := true;
                end;
            end;
        end;
	end;
	
	function trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:integer; adherent:Tadherent; var indiceRetour : integer) : boolean;
    var
        i : integer;
	begin
        trouverIndiceAdherent := false;
        i := 0;
        
		if nbAdherents > 0 then
        begin
            while ((i <= nbAdherents - 1) or (trouverIndiceAdherent = false)) do
            begin
                if tabAdherents[i].codeAdherent = adherent.codeAdherent then
                begin
                    indiceRetour := i;
                    trouverIndiceAdherent := true;
                end;
                
                i := i + 1;
            end;
        end;
	end;
	
	function trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:integer; codeAdherent:string; var adherentTrouve:Tadherent) : boolean;
	var
        i : integer;
	begin
        trouverAdherentParCode := false;
        i := 0;
        
		if nbAdherents > 0 then
        begin
            while ((i <= nbAdherents - 1) and (trouverAdherentParCode = false)) do
            begin
                if tabAdherents[i].codeAdherent = codeAdherent then
                begin
                    adherentTrouve := tabAdherents[i];
                    trouverAdherentParCode := true;
                end;
                
                i := i + 1;
            end;
        end;
	end;
	
	function emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):boolean;
    var
        emprunt : Temprunt;
	begin
        emprunterLivre := false;
		if nbEmprunts < Cmax - 1 then
            begin
                emprunt := u_livre.creerEmprunt(livre, adherent, dateEmprunt);
                tabEmprunts[nbEmprunts] := emprunt;
                nbEmprunts := nbEmprunts + 1;
                emprunterLivre := true;
            end;
	end;
	
	function rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; emprunt:Temprunt):boolean;
    var
        indiceEmprunt : integer;
        i : integer;
	begin
		rendreLivre := false;
        
        if trouverIndiceEmprunt(tabEmprunts, nbEmprunts, emprunt, indiceEmprunt) then
        begin
            for i := indiceEmprunt to nbEmprunts - 2 do
            begin
                tabEmprunts[i] := tabEmprunts[i + 1];
            end;
            nbEmprunts := nbEmprunts - 1;
            rendreLivre := true;
        end;
	end;
	
	function trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:integer; emprunt:Temprunt; var indiceRetour : integer):boolean;
    var
        i : integer;
	begin
        trouverIndiceEmprunt := false;
        i := 0;
        
        if nbEmprunts > 0 then
        begin
            while ((i <= nbEmprunts - 1) or (trouverIndiceEmprunt = false)) do
            begin
                if (tabEmprunts[i].numeroEmprunt = emprunt.numeroEmprunt) then
                begin
                    indiceRetour := i;
                    trouverIndiceEmprunt := true;
                end;
                i := i + 1;
            end;
        end;
	end;
	
	function trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:integer; var emprunt:Temprunt ;numero:integer):boolean;
	var
        i : integer;
	begin
        trouverEmpruntParNumero := false;
        i := 0;
        
        if nbEmprunts > 0 then
        begin
            while ((i <= nbEmprunts - 1) or (trouverEmpruntParNumero = false)) do
            begin
                if (tabEmprunts[i].numeroEmprunt = numero) then
                begin
                    emprunt := tabEmprunts[i];
                    trouverEmpruntParNumero := true;
                end;
                i := i + 1;
            end;
        end;
	end;
    
    //Procédures et fonctions privées
    procedure afficheAdherents(biblio:Tbibliotheque);
    var
        i : integer;
    begin
        if biblio.nbAdherents > 0 then
        begin
            writeln('Affichage des ', biblio.nbAdherents, ' adherents');
            for i := 0 to biblio.nbAdherents - 1 do
            begin
                writeln(' |- ', biblio.tabAdherents[i].nom, ' ', biblio.tabAdherents[i].prenom);
                writeln(' |  |- Code : ', biblio.tabAdherents[i].codeAdherent);
                writeln(' |  |- Adresse : ', biblio.tabAdherents[i].adresse.rue, ' ', biblio.tabAdherents[i].adresse.numeroRue);
                writeln(' |  |- Ville : ', biblio.tabAdherents[i].adresse.npa, ' ', biblio.tabAdherents[i].adresse.ville, ' - ', biblio.tabAdherents[i].adresse.pays);

                if i < biblio.nbAdherents - 1 then
                    writeln(' |  -')
                else
                    writeln('_____');
            end;
        end
        else
            writeln('Aucun adherent pour le moment.');
    end;
    
    procedure afficheEmprunts(biblio:Tbibliotheque);
    var
        i : integer;
    begin
        if biblio.nbEmprunts > 0 then
        begin
            writeln('Affichage des ', biblio.nbEmprunts, ' emprunts');
            for i := 0 to biblio.nbEmprunts - 1 do
            begin
                writeln(' |- ', biblio.tabEmprunts[i].numeroEmprunt);
                writeln(' |  |- Livre : ', biblio.tabEmprunts[i].livre.titre);
                writeln(' |  |  |- ISBN : ', biblio.tabEmprunts[i].livre.isbn);
                writeln(' |  |  |- Auteur : ', biblio.tabEmprunts[i].livre.codeAuteur);
                writeln(' |  |- Adherent : ', biblio.tabEmprunts[i].adherent.nom, ' ', biblio.tabEmprunts[i].adherent.prenom);
                writeln(' |  |  |- Code : ', biblio.tabEmprunts[i].adherent.codeAdherent);

                if i < biblio.nbEmprunts - 1 then
                    writeln(' |  ----')
                else
                    writeln('________');
            end;
        end
        else
            writeln('Aucun emprunt realise.')
    end;
end.