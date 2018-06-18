-- Property declaration
$prop (String, Verplicht, Niet Functioneel) -- commentaar
$Aangifte$verbalisant$betrouwbaarheid (Number, Verplicht, Functioneel) -- commentaar.

-- Rol declaration
$Aangifte$verbalisant (Verplicht, Functioneel) gevuld door per:Persoon heeft --commentaar
pol:Aangifte$verbalisant (Verplicht, Functioneel) gevuld door per:Persoon heeft --commentaar
model:Politie$Aangifte$verbalisant (Verplicht, Functioneel) gevuld door per:Persoon heeft --commentaar

-- Context declaration
$Aangifte heeft
pol:Aangifte heeft
model:Politie$Aangifte heeft

-- Import declaration
import model:PersoonlijkDomein als per:

Tekstnaam representatief voorbeeld van ARC -- Deze regel geeft de instantie van GepresenteerdContextType van de omhullende context zijn naam
{-
Deze tekst heeft alle mogelijke expressies die de ARC syntax toelaat.
-}
Domein model:Politie heeft --Commentaar achter de context declaratie.

Zaken

	-- Dit commentaar staat boven de zaak Aangifte.
	pol:Aangifte heeft
		import model:PersoonlijkDomein als per:
		Properties
			-- Dit commentaar staat boven de sectie intern van Aangifte.
			intern -- Dit commentaar staat achter het sleutelwoord 'intern'.
				$urgentie (String, Verplicht, Functioneel)
				-- Dit commentaar staat onderin de sectie 'intern' van Aangifte.
			extern
				pol:Aangifte$aantekening (String, Niet Verplicht, Functioneel)
		Rollen
			$userRol (Niet Functioneel, Verplicht) gevuld door per:Persoon heeft --commentaar
				Properties
					$naam (String, Verplicht, Functioneel)
				Views
					$adres met properties
						-- hieronder alle properties van de view.
						$betrouwbaarheid -- Dit is een property van de rol.
			$Verbalisant (Functioneel) gevuld door Medewerker
			Start (Functioneel) gevuld door Intake heeft
				Properties
					$toegewezen (Boolean, Niet Verplicht, Functioneel)
		Activiteiten
			$Intake heeft
				Rollen
					Uitvoerder (Functioneel) gevuld door Verbalisant
		Acties
			Verbalisant beheert locatiegegevens van Verbaal
