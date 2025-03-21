# Windpark Stammdatensatz

Dieses Dokument beschreibt die Struktur und Inhalte eines fiktiven, aber 
realitätsnahen Datensatzes für Windparks in Deutschland. Er soll als Vorlage 
für eine Stammdatenverwaltung dienen, in der alle relevanten Informationen 
zu einem Windpark erfasst und verwaltet werden können.

---

## Inhaltsverzeichnis

1. [Allgemeines](#allgemeines)



2. [Standort](#standort)
3. [Technische-Merkmale](#technische-merkmale)
4. [Wirtschaftliche-und-regulatorische-Daten](#wirtschaftliche-und-regulatorische-daten)
5. [Betrieb-und-Status](#betrieb-und-status)
6. [Kontakt-und-Verwaltungsdaten](#kontakt-und-verwaltungsdaten)
7. [Sonstiges](#sonstiges)
8. [Beispieldatensatz](#beispieldatensatz)

---

## Allgemeines

| Attribut                 | Typ     | Beschreibung                                                                 | Beispiel                |
|--------------------------|---------|------------------------------------------------------------------------------|-------------------------|
| **Windpark-ID**          | String  | Eindeutige Kennung des Windparks (z.B. eine laufende Nummer oder UUID)       | `WP_1001`               |
| **Name des Windparks**   | String  | Offizieller/interner Name                                                    | *Windpark Hohe Marsch*  |
| **Betreiber**            | String  | Name des Unternehmens, das den Windpark betreibt                             | *GreenEnergy GmbH*      |
| **Eigentuemergesellschaft** | String  | Gesellschaft, die Eigentuemer des Windparks ist (falls abweichend vom Betreiber) | *Windkraft AG*          |

---

## Standort

| Attribut               | Typ     | Beschreibung                                                                                  | Beispiel                          |
|------------------------|---------|-----------------------------------------------------------------------------------------------|-----------------------------------|
| **Bundesland**         | String  | Bundesland in Deutschland, in dem der Windpark liegt                                          | *Niedersachsen*                   |
| **Landkreis / Region** | String  | Detailliertere regionale Angabe                                                               | *Landkreis Cuxhaven*              |
| **Postleitzahl**       | String  | PLZ zur genaueren Verortung                                                                   | `21762`                           |
| **Ort**                | String  | Ort oder Gemeinde                                                                             | *Osterbruch*                      |
| **Geokoordinaten**     | String  | Breiten- und Längengrad, z.B. für GIS-Analysen                                               | `53.7765° N, 8.8950° E`           |
| **Lagebeschreibung**   | String  | Optionaler Freitext (z.B. Erreichbarkeit über Strasse, nächste Orte etc.)                    | *In direkter Nähe zur Bundesstrasse B73* |

---

## Technische Merkmale

| Attribut                     | Typ     | Beschreibung                                                                     | Beispiel             |
|-----------------------------|---------|----------------------------------------------------------------------------------|----------------------|
| **Anzahl WEA**             | Integer | Anzahl der Windenergieanlagen im Park                                            | `12`                 |
| **Hersteller und Modell**   | String  | Hersteller und Modellbezeichnung der Turbinen                                   | *Enercon E-115*      |
| **Nennleistung pro WEA**    | Float   | Installierte Leistung pro Anlage in kW oder MW                                  | `3000 kW`            |
| **Gesamtleistung**          | Float   | Gesamtleistung des Windparks (Summe der Nennleistungen) in MW                   | `36 MW`              |
| **Nabenhoehe**             | Integer | Höhe der Gondel über Grund (in m)                                               | `135`                |
| **Rotordurchmesser**        | Integer | Rotordurchmesser in m                                                           | `115`                |
| **Baujahr**                 | Integer | Baujahr bzw. Herstellungsjahr der Anlagen                                       | `2018`               |
| **Inbetriebnahmedatum**     | String  | Datum der Inbetriebnahme (TT.MM.JJJJ)                                           | `15.03.2018`         |
| **Technologie-Typ**         | String  | Onshore oder Offshore                                                           | *Onshore*            |

---

## Wirtschaftliche und regulatorische Daten

| Attribut               | Typ     | Beschreibung                                                                                                  | Beispiel                          |
|------------------------|---------|---------------------------------------------------------------------------------------------------------------|-----------------------------------|
| **EEG-Foerderende**    | String  | Auslaufdatum der EEG-Foerderung (TT.MM.JJJJ)                                                                  | `15.03.2038`                      |
| **Netzanschlusspunkt** | String  | Umspannwerk oder Anschlussstelle, an der der Windpark ins Netz einspeist                                     | *UW Cuxhaven Ost*                 |
| **PPA-Vertraege**      | String  | Informationen über Power Purchase Agreements (z.B. Laufzeit, Vertragspartner)                                 | *5-Jahres-PPA mit Energieversorger X* |
| **Zugehoerige Genehmigungen** | String  | Nummern/Details zu behoerdlichen Genehmigungen (z.B. BImSchG)                                              | *Genehmigungsnr. 12/45/6789*      |
| **Wartungsvertrag / Servicevertrag** | String  | Wartungs- oder Servicepartner, Laufzeit                                                                    | *Wartung durch Hersteller Enercon, bis 31.12.2030* |

---

## Betrieb und Status

| Attribut                  | Typ     | Beschreibung                                                                           | Beispiel        |
|---------------------------|---------|----------------------------------------------------------------------------------------|-----------------|
| **Aktueller Status**      | String  | Aktueller Betriebszustand (z.B. in Betrieb, in Wartung, repowered, stillgelegt)       | *in Betrieb*    |
| **Repowering-Datum**      | String  | Datum (TT.MM.JJJJ), an dem ein Repowering erfolgt ist oder geplant ist (optional)      | `01.09.2025`    |
| **Geplante Stilllegung**  | String  | Datum (TT.MM.JJJJ), an dem die Stilllegung vorgesehen ist (optional)                  | `15.03.2040`    |
| **Verfuegbarkeitsquote**  | Float   | Durchschnittliche Verfuegbarkeit in Prozent (z.B. über ein Jahr)                      | `97.5`          |
| **Produzierte Jahresenergiemenge** | Float | Tatsächlich erzeugte Jahresenergiemenge in MWh                                         | `85000` (MWh)   |

---

## Kontakt und Verwaltungsdaten

| Attribut                     | Typ     | Beschreibung                                                             | Beispiel                        |
|-----------------------------|---------|--------------------------------------------------------------------------|---------------------------------|
| **Zustaendiger Netzbetreiber** | String  | Name des Netzbetreibers, der den Netzanschluss bereitstellt              | *TenneT*                        |
| **Zustaendige Kommune / Behoerde** | String  | Kommune oder Behoerde für Genehmigungen, Meldepflichten etc.            | *Gemeinde Nordleda, Landkreis Cuxhaven* |
| **Notfall-Kontakt**         | String  | Telefonnummer oder Mailadresse für Stoerungs- oder Notfallmeldungen      | *Notfall-Hotline +49 40 1234567* |

---

## Sonstiges

| Attribut                | Typ     | Beschreibung                                                                         | Beispiel                                              |
|-------------------------|---------|--------------------------------------------------------------------------------------|-------------------------------------------------------|
| **Datenverantwortlicher** | String  | Person oder Abteilung, die für die Pflege der Stammdaten verantwortlich ist         | *Datenmanagement - Max Mustermann*                    |
| **Bemerkungen**         | String  | Freitext für sonstige Informationen, z.B. Besonderheiten beim Zugang zum Gelände     | *Zugang nur mit Genehmigung, Privatweg*               |
| **Dokumentenlinks**     | String  | Links oder Pfade zu relevanten Dokumenten (Genehmigungen, Wartungsberichte etc.)     | `\\Server\WindparkHoheMarsch\Dokumente`              |

---

## Beispieldatensatz

Nachfolgend ein Beispiel, wie die Daten in einer konkreten Instanz aussehen könnten:

```plaintext
Windpark-ID:               WP_1001
Name des Windparks:        Windpark Hohe Marsch
Betreiber:                 GreenEnergy GmbH
Eigentuemergesellschaft:   Windkraft AG
Bundesland:                Niedersachsen
Landkreis/Region:          Landkreis Cuxhaven
Postleitzahl:              21762
Ort:                       Osterbruch
Geokoordinaten:            53.7765° N, 8.8950° E
Anzahl WEA:                12
Hersteller/Modell:         Enercon E-115
Nennleistung pro WEA:      3000 kW
Gesamtleistung:            36 MW
Nabenhoehe:                135 m
Rotordurchmesser:          115 m
Baujahr:                   2018
Inbetriebnahmedatum:       15.03.2018
Technologie-Typ:           Onshore
EEG-Foerderende:           15.03.2038
Netzanschlusspunkt:        UW Cuxhaven Ost
PPA-Vertraege:             5-Jahres-PPA mit Energieversorger X
Zugehoerige Genehmigungen: Genehmigungsnr. 12/45/6789
Wartungsvertrag:           Enercon, bis 31.12.2030
Aktueller Status:          in Betrieb
Repowering-Datum:          -
Geplante Stilllegung:      15.03.2040
Verfuegbarkeitsquote:      97.5
Produzierte Jahresenergiemenge: 85000 MWh
Zustaendiger Netzbetreiber: TenneT
Zustaendige Kommune:       Gemeinde Nordleda, Landkreis Cuxhaven
Notfall-Kontakt:           Notfall-Hotline +49 40 1234567
Datenverantwortlicher:     Datenmanagement - Max Mustermann
Bemerkungen:               Zugang über Privatweg
Dokumentenlinks:           \\Server\WindparkHoheMarsch\Dokumente


```

## Zusammenfassung Windpark-Stammdaten

- **Name des Windparks:** Windpark Hohe Marsch  
- **Windpark-ID:** WP_1001  
- **Betreiber:** GreenEnergy GmbH  
- **Eigentümerschaft:** Windkraft AG  

### Standort
- **Bundesland:** Niedersachsen  
- **Landkreis/Region:** Landkreis Cuxhaven  
- **PLZ / Ort:** 21762 / Osterbruch  
- **Geokoordinaten:** 53.7765° N, 8.8950° E  
- **Lagebeschreibung:** In direkter Nähe zur Bundesstrasse B73  

### Technische Daten
- **Anzahl WEA:** 12  
- **Hersteller/Modell:** Enercon E-115  
- **Nennleistung pro WEA:** 3000 kW (3 MW)  
- **Gesamtleistung:** 36 MW  
- **Nabenhöhe:** 135 m  
- **Rotordurchmesser:** 115 m  
- **Baujahr:** 2018  
- **Inbetriebnahmedatum (TT.MM.JJJJ):** 15.03.2018  
- **Technologie-Typ:** Onshore  

### Wirtschaftlich / Regulatorisch
- **EEG-Förderende (TT.MM.JJJJ):** 15.03.2038  
- **Netzanschlusspunkt:** UW Cuxhaven Ost  
- **PPA-Verträge:** 5-Jahres-PPA mit Energieversorger X  
- **Genehmigung:** Genehmigungsnr. 12/45/6789  
- **Wartungsvertrag:** Wartung durch Enercon, bis 31.12.2030  

### Betrieb und Status
- **Aktueller Status:** in Betrieb  
- **Repowering-Datum (TT.MM.JJJJ):** - (derzeit nicht geplant)  
- **Geplante Stilllegung (TT.MM.JJJJ):** 15.03.2040  
- **Verfügbarkeitsquote:** 97,5 %  
- **Produzierte Jahresenergiemenge:** 85.000 MWh  

### Kontakt / Verwaltung
- **Zuständiger Netzbetreiber:** TenneT  
- **Zuständige Kommune / Behörde:** Gemeinde Nordleda, Landkreis Cuxhaven  
- **Notfall-Kontakt:** Notfall-Hotline +49 40 1234567  
- **Datenverantwortlicher:** Datenmanagement - Max Mustermann  

### Sonstiges
- **Bemerkungen:** Zugang nur mit Genehmigung, Zufahrt über Privatweg  
- **Dokumentenlinks:** \\Server\WindparkHoheMarsch\Dokumente  

Dieses Summary bietet einen kompakten Überblick über die wichtigsten Daten des 
fiktiven Windparks. Es kann als Vorlage für die Verwaltung und Dokumentation 
von Windparks in Deutschland dienen.
