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
	
	function saisirAdherent():Tadherent;
	begin
		
	end;
	
	
	procedure afficherAdherent(adherent:Tadherent);
	begin
		
	end;

end.
