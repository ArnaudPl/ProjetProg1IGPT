unit u_services;
interface

    const
        Cmax = 100;
    type
        Tlistereel = record
            tab : array[0..Cmax] of real;
            nbEle : integer;
        end;
        
    //Procédure d'initialisation 
	procedure initialise(var liste:Tlistereal);
    //Fonction de test pour savoir si le tableau donné en paramètre est plein ou non. 
	function tableauEstPlein(nbEle : integer):boolean;
    //Fonction de test pour savoir si le tableau donné en paramètre est vide ou non. 
	function tableauEstVide(nbEle : integer):boolean;
    //Fonction qui ajoute une valeur à la fin du tableau
	function ajouteFin (var liste: Tlistereal ; nouvelleValeur: real) : boolean;
    //Fonction qui ajoute au début du tableau
	function ajouteDebut (var liste:Tlistereal; nouvelleValeur : real) : boolean;
    //Fonction qui supprime à la fin du tableau
	function supprimeFin (var liste : Tlistereal) : boolean;
    //Fonction qui supprime au début du tableau
	function supprimeDebut(var liste: Tlistereal) : boolean;
    //Fonction qui retourne la valeur à l'indice donné
	function donneElement(liste:Tlistereal ; indice : integer) : real;
    //Fonction qui ajoute à une position donné un élément donné
	function ajouteAPosition (var liste:Tlistereal ; indice:integer ; nouvelleValeur: real) : boolean;
    //Fonction qui supprime un élément à une position donnée
	function supprimeAPosition (var liste: Tlistereal ; indice:integer) : boolean;
    //Fonction qui donne le nombre d'élément
	function donneNbElements(liste:Tlistereal):integer;
    
implementation
	procedure initialise(var liste:Tlistereal);
	begin
		liste.nbEle := 0;
	end;
	
    function tableauEstPlein(nbEle : integer):boolean;
	var
		estPlein : boolean;
	begin
		if (nbEle < Cmax) then
			estPlein := false
		else
			estPlein := true;
			
		tableauEstPlein := estPlein;
	end;
 
	function tableauEstVide(nbEle : integer):boolean;
	var
		estVide : boolean;
	begin
		if (nbEle > 0) then
			estVide := false
		else
			estVide := true;
			
		tableauEstVide := estVide;
	end;	
	
	function ajouteFin (var liste: Tlistereal ; nouvelleValeur: real) : boolean;
	var
		deroulementOK : boolean;
	begin
		if not tableauEstPlein(liste.nbEle) then 
			begin
				liste.tab[liste.nbEle] := nouvelleValeur;
				liste.nbEle := liste.nbEle + 1;
				deroulementOK := true;
			end
		else
			begin
				deroulementOK := false;
			end;
		
		ajouteFin := deroulementOK;
	end;
	
	function ajouteDebut (var liste:Tlistereal; nouvelleValeur : real) : boolean;
	var
		deroulementOK : boolean;
		ind : integer;
	begin
		if not tableauEstPlein(liste.nbEle) then 
			begin
				FOR ind:= liste.nbEle doWNTO 1 do
				begin
					liste.tab[liste.nbEle] := liste.tab[ind-1];
				end;
				liste.tab[0] := nouvelleValeur;
				liste.nbEle := liste.nbEle + 1;
				
				deroulementOK := true;
			end
		else
			begin
				deroulementOK := false;
			end;
		
		ajouteDebut := deroulementOK;
	end;
	
	function supprimeFin (var liste : Tlistereal) : boolean;
	var
		deroulementOK : boolean;
	begin
		if not tableauEstVide(liste.nbEle) then 
			begin
				liste.nbEle := liste.nbEle-1;
				deroulementOK := true;
			end
		else
			begin
				deroulementOK := false;
			end;
		
		supprimeFin := deroulementOK;
	end;
	
	function supprimeDebut(var liste: Tlistereal) : boolean;
	var 
		deroulementOK : boolean;
		ind : integer;
	begin
		if not tableauEstVide(liste.nbEle) then
		begin
				FOR ind:=1 TO (liste.nbEle - 1) do
				begin
					liste.tab[ind-1]:=liste.tab[ind];
				end;
				liste.nbEle := liste.nbEle - 1;

				deroulementOK := true;
			end
		else
			begin
				deroulementOK := false;
			end;
		
		supprimeDebut := deroulementOK;
	end;
	
	function donneElement(liste:Tlistereal ; indice : integer) : real;
	begin
		donneElement :=  liste.tab[indice];
	end;
	
	function ajouteAPosition (var liste:Tlistereal ; indice:integer ; nouvelleValeur: real) : boolean;
	var	
		deroulementOK : boolean;
		ind: integer;
	begin
		if not positionEstCorrete(liste.nbEle,indice) then
			begin
				deroulementOK := false;
			end
		else
			begin
				FOR ind:=liste.nbEle doWNTO (indice+1) do
				begin
					liste.tab[ind] := liste.tab[ind-1];
				end;
				liste.tab[indice] := nouvelleValeur;
				liste.nbEle := liste.nbEle + 1;
				deroulementOK := true;
			end;
		ajouteAPosition := deroulementOK;	
	end;
	
	function supprimeAPosition (var liste: Tlistereal ; indice:integer) : boolean;
	var
		deroulementOK : boolean;
		ind : integer;
	begin
		if not positionEstCorrete(liste.nbEle,indice) then
			begin
				deroulementOK := false;
			end
		else
			begin
				FOR ind:=indice TO liste.nbEle-1 do
				begin
					liste.tab[ind] := liste.tab[ind+1];
				end;
				liste.nbEle := liste.nbEle -1;
				deroulementOK := true;
			end;
		supprimeAPosition := deroulementOK;
	end;
	
	function donneNbElements(liste:Tlistereal):integer;
	begin
		donneNbElements := liste.nbEle;
	end;
end.