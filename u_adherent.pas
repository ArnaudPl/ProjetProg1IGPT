unit u_adherent;
interface
    uses u_biblio,u_livre;
	const
		Cmax = 100;
		
	type
	
		Tadresse = record
			rue : string;
			numeroRue : string;
			npa : string;
			ville : string;
			pays : string;
		end;
		
		Tadherent = record
		    codeAdherent : string;
			nom : string;
			prenom : string;
			adresse : Tadresse;
		end;	
		
		TypeTabAdherents = ARRAY[0..Cmax-1] of Tadherent;
		
		// Demande toutes les informations à l'utilisateur et retourne un nouveau adherent ayant les informations saisies
		function saisirAdherent():Tadherent;
		// Affiche toutes les informations de l'adherent
		procedure afficherAdherent(adherent:Tadherent);
		
implementation
	
	function saisirAdherent():Tadherent;
    var
        adherentSaisi : Tadherent;
	begin
        writeln('------- Saisie d''un adherent -------');
        repeat
            writeln('- Veuillez saisir le code : ');
            readln(adherentSaisi.codeAdherent);
        until (not trouverAdherentParCode(tabAdherents,nbAdherents,adherentSaisi.codeAdherent,indiceRetour,adherentSaisi));
        
        writeln('- Veuillez saisir le nom : ');
        readln(adherentSaisi.nom);
        writeln('- Veuillez saisir le prenom : ');
        readln(adherentSaisi.prenom);
        writeln('- Veuillez saisir la rue : ');
        readln(adherentSaisi.adresse.rue);
        writeln('- Veuillez saisir le numero de la rue : ');
        readln(adherentSaisi.adresse.numeroRue);
        writeln('- Veuillez saisir le npa  : ');
        readln(adherentSaisi.adresse.npa);
        writeln('- Veuillez saisir la ville : ');
        readln(adherentSaisi.adresse.ville);
        writeln('- Veuillez saisir le pays : ');
        readln(adherentSaisi.adresse.pays);
        
        
		
	end;
	
	
	procedure afficherAdherent(adherent:Tadherent);
	begin
		//Affichage réalisé dans u_biblio procedure afficheAdherents !
	end;

end.
