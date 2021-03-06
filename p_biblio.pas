program p_biblio;
uses u_biblio, u_livre, u_adherent, crt, sysutils;

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
        livre.codeAuteur := 'Leila Slimani';
        livre.nbPages := 240;
        livre.nbExemplaires := 3;
        
        u_biblio.ajouterNouveauLivre(biblio.tabLivres, biblio.nbLivres, livre);
        
        livre.isbn := '9782749928937';
        livre.titre := 'Instincts';
        livre.codeAuteur := 'Sarah Marquis';
        livre.nbPages := 274;
        livre.nbExemplaires := 1;
        
        u_biblio.ajouterNouveauLivre(biblio.tabLivres, biblio.nbLivres, livre);
        
        
        //Insertion d'adhérents
        adherent.codeAdherent := 'A';
        adherent.nom := 'Quiroule';
        adherent.prenom := 'Pierre';
        adherent.adresse.rue := 'Rue de l''hopital';
        adherent.adresse.numeroRue := '15';
        adherent.adresse.npa := '2000';
        adherent.adresse.ville := 'Neuchatel';
        adherent.adresse.pays := 'Suisse';
        u_biblio.ajouterNouvelAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent);
        
        adherent.codeAdherent := 'B';
        adherent.nom := 'Perret';
        adherent.prenom := 'Hubert';
        adherent.adresse.rue := 'Rue principale';
        adherent.adresse.numeroRue := '54';
        adherent.adresse.npa := '2000';
        adherent.adresse.ville := 'Neuchatel';
        adherent.adresse.pays := 'Suisse';
        u_biblio.ajouterNouvelAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent);
        
        
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
    dateCorrecte : boolean;
	
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
            writeln('15. Afficher les livres de la bibliotheque');
			writeln('0. Quitter l''application');
			repeat
				readln(choix);
			until (choix >= 0) AND (choix <= 15);
			
			ClrScr;
			case choix of 
				1 : begin
						writeln('-- Emprunt d''un livre --');
                        write('Veuillez entrer le code de l''adherent : ');
                        readln(codeAdherent);
                        
                        if u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents, codeAdherent, adherent) then
                        begin
                            write('Veuillez saisir l''ISBN du livre : ');
                            readln(isbn);
                            
                            if u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre) then
                            begin
                                writeln('Veuillez saisir la date de l''emprunt :');
                                
                                dateCorrecte := false;
                                repeat
                                    write('Annee : ');
                                    readln(date.annee);
                                    if ( date.annee >= 1900 ) then
                                        dateCorrecte := true
                                    else
                                        writeln('Merci de saisir une annee superieure a 1900.');
                                until dateCorrecte;
                                
                                dateCorrecte := false;
                                repeat
                                    write('Mois : ');
                                    readln(date.mois);
                                    if ( (date.mois <= 12) and (date.mois >= 1) ) then
                                        dateCorrecte := true
                                    else
                                        writeln('Le mois saisi est incorrect. Veuillez saisir un mois entre 1 et 12.');
                                until dateCorrecte;
                                
                                dateCorrecte := false;
                                repeat
                                    write('Jour : ');
                                    readln(date.jour);
                                    if ( date.jour > 0 ) then
                                        begin
                                            if ( (date.mois = 1) or (date.mois = 3) or (date.mois = 5) or (date.mois = 7) or (date.mois = 8) or (date.mois = 10) or (date.mois = 12)) then //Mois à 31 jours
                                                begin
                                                    if ( date.jour <= 31 ) then
                                                        dateCorrecte := true;
                                                end
                                            else //Mois à 30 jours + février
                                                begin
                                                    if ( date.mois = 2 ) then //Février
                                                        begin
                                                            if ( date.jour <= 28 ) then
                                                                begin
                                                                    dateCorrecte := true;
                                                                end
                                                        end
                                                    else
                                                        begin
                                                            if ( date.jour <= 30 ) then
                                                                begin
                                                                    dateCorrecte := true;
                                                                end
                                                        end
                                                end
                                        end;
                                    
                                    if ( dateCorrecte = false ) then
                                        writeln('Le jour saisi n''est pas valide. Merci de saisir un jour valide.');
                                until dateCorrecte;
                                
                                
                                if(u_livre.estDisponible(livre, biblio.tabEmprunts, biblio.nbEmprunts)) then
                                    begin
                                        if u_biblio.emprunterLivre(biblio.tabEmprunts, biblio.nbEmprunts, livre, adherent, date) then
                                            writeln('Emprunt effectue !')
                                        else
                                            writeln('L''emprunt n''a pas pu etre effectue.');
                                    end
                                else
                                     writeln('Erreur - Le livre n''est pas disponible.');
                            end
                            else
                                writeln('Erreur - Aucun livre ne correspond a cet ISBN.');
                        end
                        else
                            writeln('Erreur - Aucun adherent trouve.');
					end;
				2 : begin
						writeln('-- Rendre un livre --');
						write('Veuillez entrer le numero de l''emprunt : ');
                        readln(numEmprunt);
                        
                        if u_biblio.trouverEmpruntParNumero(biblio.tabEmprunts, biblio.nbEmprunts, emprunt, numEmprunt) then
                        begin
                            if u_biblio.rendreLivre(biblio.tabEmprunts, biblio.nbEmprunts, emprunt) then
                                writeln('Le livre a ete rendu !')
                            else
                                writeln('Le livre n''a pas pu etre rendu.');
                        end
                        else
                            writeln('Erreur - Aucun emprunt ne correspond a ce numero.');
					end;
				3 : begin
						writeln('-- Verification de la disponibilite du livre --');
                        write('Veuillez entrer l''ISBN du livre : ');
                        readln(isbn);
                        
                        if u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre) then
                            if estDisponible(livre, biblio.tabEmprunts, biblio.nbEmprunts) then
                                writeln('Le livre est disponible !')
                            else
                                writeln('Le livre n''est pas disponible.')
                        else
                            writeln('Erreur - Aucun livre ne correspond a cet ISBN.');
					end;
				4 : begin
						writeln('-- Ajouter un livre a la bibliotheque --');
                        livre := u_livre.saisirLivre();
                        if u_biblio.ajouterNouveauLivre(biblio.tabLivres, biblio.nbLivres, livre) then
                            writeln('Le livre a ete ajoute !')
                        else
                            writeln('Le livre n''a pas pu etre ajoute !');
					end;
				5 : begin
						writeln('-- Ajout d''un exemplaire d''un  livre --');
                        write('Veuillez entrer l''ISBN du livre : ');
                        readln(isbn);
                        
                        if u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre) then
                        begin
                            if u_biblio.trouverIndiceLivre(biblio.tabLivres, biblio.nbLivres, livre, indiceLivre) then
                            begin
                                u_livre.ajouterExemplaire(biblio.tabLivres[indiceLivre]);
                                writeln('Un exemplaire a ete ajoute !');
                            end
                            else
                                writeln('L''exemplaire n''a pas pu etre ajoute.');
                        end
                        else
                            writeln('Erreur - Aucun livre ne correspond a cet ISBN.');
					end;
				6 : begin
						writeln('-- Ajout d''un nouvel adherent --');
                        adherent := u_adherent.saisirAdherent();
                        if u_biblio.ajouterNouvelAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent) then
                            writeln('Adherent ajoute !')
                        else
                            writeln('L''adherent n''a pas pu etre ajoute.');
					end;
				7 : begin
						writeln('-- Recherche et affichage de livre(s) --');
                        continuer := 'go';
                        repeat
                            write('Veuillez entrer l''ISBN du livre : ');
                            readln(isbn);
                            
                            if u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre) then
                            begin
                                u_livre.afficherLivre(livre);
                            end
                            else
                                writeln('Le livre n''a pas ete trouve.');
                                
                            write('Entrez "stop" pour arreter ou "go" pour continuer : ');
                            readln(continuer);
                        until (continuer = 'stop');
                        ClrScr;
					end;
				8 : begin
						writeln('-- Recherche et affichage d''emprunts --');
                        continuer := 'go';
                        repeat
                            write('Veuillez entrer le numero d''emprunt : ');
                            readln(numEmprunt);
                            
                            if u_biblio.trouverEmpruntParNumero(biblio.tabEmprunts, biblio.nbEmprunts, emprunt, numEmprunt) then
                                u_livre.afficherEmprunt(emprunt)
                            else
                                writeln('L''emprunt n''a pas pu etre trouve.');
                                
                            write('Entrez "stop" pour arreter ou "go" pour continuer : ');
                            readln(continuer);
                        until (continuer = 'stop');
                        ClrScr;
					end;
				9 : begin
                        writeln('-- Recherche et affichage d''adherent --');
                        continuer := 'go';
                        
                        repeat
                            write('Veuillez entrer le code d''un adherent : ');
                            readln(codeAdherent); 
                            
                            if (u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents,codeAdherent,adherent)) then
                                u_adherent.afficherAdherent(adherent)
                            else
                               writeln('Erreur - Aucun adherent porte ce code.'); 
                               
                            write('Entrez "stop" pour arreter ou "go" pour continuer : ');
                            readln(continuer);
                        until(continuer = 'stop');
						
					end;
				10 : begin
                     writeln('-- Suppression d''un exemplaire d''un livre --');
                     write('Veuillez enter l''ISBN du livre : ');
                     readln(isbn);
                     
                     if (u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre)) then
                        begin
                            if(livre.nbExemplaires <= 1) then
                                if(u_biblio.supprimerLivre(biblio.tabLivres,biblio.nbLivres,livre,biblio.tabEmprunts,biblio.nbEmprunts)) then
                                    writeln('Supression effectue !')
                                else
                                    writeln('Erreur - le livre n''a pas pu etre supprime.')
                            else
                                begin
                                    if u_biblio.trouverIndiceLivre(biblio.tabLivres, biblio.nbLivres, livre, indiceLivre) then
                                        begin
                                            u_livre.supprimerExemplaire(biblio.tabLivres[indiceLivre],biblio.tabEmprunts, biblio.nbEmprunts);
                                            writeln('Un exemplaire a ete supprime !');
                                        end
                                    else
                                        writeln('L''exemplaire n''a pas pu etre supprime.');
                                end
                        end
                    else
                        writeln('Erreur - Aucun livre ne correspond a cet ISBN.');
                    end;
				11 : begin
                    writeln('-- Suppression d''un livre --');
                    write('Veuillez saisir l''ISBN du livre : ');
                    readln(isbn);
                    if (u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre)) then
                        if(u_biblio.supprimerLivre(biblio.tabLivres,biblio.nbLivres,livre,biblio.tabEmprunts,biblio.nbEmprunts)) then
                            writeln('Supression effectue !')
                        else
                             writeln('Erreur - le livre n''a pas pu etre supprime.')
                    else
                        writeln('Erreur - Aucn livre ne correspond a cet isbn.');
						
					end;
				12 : begin
						 writeln('-- Suppression d''un adherent --');
                         write('Veuillez saisir le code de l''adherent : ');
                         readln(codeAdherent);
                         
                         if(u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents, codeAdherent, adherent)) then
                            begin
                                if (u_biblio.supprimerAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent,biblio.tabEmprunts,biblio.nbEmprunts)) then
                                    writeln('Supression effectuee !')
                                else
                                    writeln('Erreur -  l''adherent n''a pas pu etre supprime, verfiez les emprunts.');
                            end
                         else
                            begin
                                writeln('Erreur - Aucun adherent ne correspond a ce code.');
                            end;
                            
					end;
				13 : begin
                       
                        writeln('-- Verification si la bibliotheque est ouverte --');
                        repeat
                            write('Veuillez saisir un jour : ');
                            readln(jourOuvert);
                            jourOuvert := LowerCase(jourOuvert);
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
                        writeln('Appuyez sur une touche pour continuer.');
                        readln();
					end;
                15: begin
                        afficherLivres(biblio.tabLivres, biblio.nbLivres);
                        writeln('Appuyez sur une touche pour continuer.');
                        readln();
                    end;
				0 : begin
						
					end;
			end;
			
		end
	until (choix = 0);
end.
