program p_biblio;
uses u_biblio, u_livre, u_adherent, crt;

	procedure initProgram();
	begin
		u_livre.initUnite();
	end;
	
	//Procedure chargeant quelques donées de base
	procedure chargeDonneesInitiales(var biblio:Tbibliotheque; var adherent: Tadherent; var livre: Tlivre);
	begin
        //Insertion d'une bibliothèque
		biblio.nomBiblio:='Arc Biblio';
		biblio.adresse.rue:='Espace de l''Europe';
		biblio.adresse.numeroRue:='21';
		biblio.adresse.npa:='2000';
		biblio.adresse.ville:='Neuchatel';	
		biblio.adresse.pays:='Suisse';
        
        
         //Insertion de livres bibliothèque
        livre.isbn := '9782070196678';
        livre.titre := 'Chanson douce';
        livre.codeAuteur := 'Leïla Slimani';
        livre.nbPages := 240;
        livre.nbExemplaires := 3;
        
        livre.isbn := '9782070196678';
        livre.titre := 'Chanson douce';
        livre.codeAuteur := 'Leïla Slimani';
        livre.nbPages := 240;
        livre.nbExemplaires := 3;
        
        livre.isbn := '9782749928937';
        livre.titre := 'Instincts';
        livre.codeAuteur := 'Sarah Marquis';
        livre.nbPages := 274;
        livre.nbExemplaires := 1;
	end;
var
	biblio : Tbibliotheque;
	choix : integer;
	adherent : Tadherent;
	livre : Tlivre;
	date : Tdate;
	numEmprunt : integer;
	emprunt : Temprunt;
	continuer : string;
	heureOuvert : integer;
	jourOuvert : string;
	indiceLivre : integer;
	
	// Attribut(s) d'un livre :
	isbn:string;

	// Attribut(s) d'un adherent :
	codeAdherent: string;

begin
	initProgram(); // Va initialiser la variable globale compteurEmprunt a 0
	u_biblio.initBiblio(biblio);

	chargeDonneesInitiales(biblio, adherent, livre);
	
	repeat
		begin
			writeln('Que souhaitez-vous faire ?');
			writeln('1. Emprunter un livre');
			writeln('2. Rendre un livre');
			writeln('3. Verifier la disponibilite d''un livre');
			writeln('4. Ajouter un livre a la bibliotheque');
			writeln('5. Ajouter un exemplaire d''un livre');
			writeln('6. Ajouter un nouvel adherent');
			writeln('7. Recherche et affichage de livre(s)');
			writeln('8. Recherche et affichage d''emprunt');
			writeln('9. Recherche et affichage d''adherent');
			writeln('10. Supprimer un exemplaire d''un livre');
			writeln('11. Supprimer un livre');
			writeln('12. Supprimer un adherent');
			writeln('13. Verifier si la bibliotheque est ouverte');
			writeln('14. Afficher toutes les informations de la bibliotheque');
			writeln('0. Quitter l''application');
			repeat
				readln(choix);
			until (choix >= 0) AND (choix <= 14);
			
			ClrScr;
			case choix of 
				1 : begin
						
					end;
				2 : begin
						
					end;
				3 : begin
						
					end;
				4 : begin
						
					end;
				5 : begin
						
					end;
				6 : begin
						
					end;
				7 : begin
						
					end;
				8 : begin
						
					end;
				9 : begin
						
					end;
				10 : begin
						
					end;
				11 : begin
						
					end;
				12 : begin
						
					end;
				13 : begin
						
					end;
				14 : begin
				        afficherBibliotheque(biblio);
					end;
				0 : begin
						
					end;
			end;
			
		end
	until (choix = 0);
end.
