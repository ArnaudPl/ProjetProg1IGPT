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
						writeln('-- Emprunt d''un livre --');
                        write('Veuillez entrer le code de l''adherent : ');
                        readln(codeAdherent);
                        
                        if (u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents, codeAdherent, adherent)) then
                        begin
                            write('Veuillez saisir l''ISBN du livre : ');
                            readln(isbn);
                            
                            if (u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre)) then
                            begin
                                writeln('Veuillez saisir la date de l''emprunt :');
                                write('Jour : ');
                                readln(date.jour);
                                write('Mois : ');
                                readln(date.mois);
                                write('Année : ');
                                readln(date.annee);
                                
                                if emprunterLivre(biblio.tabEmprunts, biblio.nbEmprunts, livre, adherent, date) then
                                    writeln('Emprunt effectue !')
                                else
                                    writeln('L''emprunt n''a pas pu etre effectue.');
                            end
                            else
                                writeln('Erreur - Aucun livre ne correspond à cet ISBN.');
                        end
                        else
                            writeln('Erreur - Aucun adherent trouve.');
					end;
				2 : begin
						writeln('-- Rendre un livre --');
						write('Veuillez entrer le numero de l''emprunt : ');
                        readln(numEmprunt);
                        
                        if trouverEmpruntParNumero(biblio.tabEmprunts, biblio.nbEmprunts, emprunt, numEmprunt) then
                        begin
                            if rendreLivre(biblio.tabEmprunts, biblio.nbEmprunts, emprunt) then
                                writeln('Le livre a ete rendu !')
                            else
                                writeln('Le livre n''a pas pu etre rendu.');
                        end
                        else
                            writeln('Erreur - Aucun emprunt ne correspond a ce numero.');
					end;
				3 : begin
						writeln('-- Verification de la disponibilite du livre --');
                        write('Veuillez enter l''ISBN du livre : ');
                        readln(isbn);
                        
                        if trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre) then
                            if estDisponible(livre, biblio.tabEmprunts, biblio.nbEmprunts) then
                                writeln('Le livre est disponible !')
                            else
                                writeln('Le livre n''est pas disponible.')
                        else
                            writeln('Erreur - Aucun livre ne correspond a cet ISBN.');
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
                        writeln('-- Verification si la bibliotheque est ouverte --');
                
                        repeat
                            write('Veuillez saisir un jour : ');
                            readln(jourOuvert);
                        until((jourOuvert = 'lundi') or (jourOuvert = 'mardi') or (jourOuvert = 'mercredi')
                        or (jourOuvert = 'jeudi') or (jourOuvert = 'vendredi') or (jourOuvert = 'samedi') 
                        or (jourOuvert = 'dimanche'));
                        
                        repeat
                            write('Veuillez saisir une heure (entre 0 et 24) : ');
                            readln(heureOuvert);
                        until((heureOuvert >= 0) and (heureOuvert <= 24));
                        
                        
                        if (u_biblio.estOuverte(jourOuvert,heureOuvert)) then
                            writeln('La bibliotheque est ouverte durant l''horaire saisi.')
                        else
                             writeln('La bibliotheque est fermee durant l''horaire saisi.');
                        	
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
