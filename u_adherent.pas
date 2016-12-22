{
Nom : u_adherent
Descritpion : Unit gérant un adherent
Auteur : Christe Thibaud
Date création : 21.12.2016
Dernière modification : 21.12.2016
}

unit u_adherent;
interface
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
	{   Nom fonction :  saisirAdherent
        Description : Permet de saisir un nouveau adherent
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	function saisirAdherent():Tadherent;
    var
        adherentSaisi : Tadherent;
	begin
        writeln('------- Saisie d''un adherent -------');
    
        writeln('- Veuillez saisir le code : ');
        readln(adherentSaisi.codeAdherent);
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
        
        
		saisirAdherent := adherentSaisi;
		
	end;
	
	{   Nom fonction :  afficherAdherent
        Description : Permet d afficher un adherent donné
        Auteur : Chritste Thibaud
        Date : 22.12.2016
    }
	procedure afficherAdherent(adherent:Tadherent);
	begin        
        writeln(' |- ', adherent.nom, ' ', adherent.prenom);
        writeln(' |  |- Code : ', adherent.codeAdherent);
        writeln(' |  |- Adresse : ', adherent.adresse.rue, ' ', adherent.adresse.numeroRue);
        writeln(' |  |- Ville : ', adherent.adresse.npa, ' ', adherent.adresse.ville, ' - ', adherent.adresse.pays);
            
	end;

end.
