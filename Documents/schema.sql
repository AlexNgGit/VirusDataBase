SET DEFINE OFF

CREATE TABLE Virus1 (
    Family char(30) PRIMARY KEY,
    Strandedness char(30));


CREATE TABLE Virus2 (
    Genus char(30) PRIMARY KEY, Family char(30),
    FOREIGN KEY (Family) REFERENCES Virus1(Family) ON DELETE CASCADE);


CREATE TABLE Virus3 (
    virusCommonName char(30) PRIMARY KEY, Genus char(30), Status char(30), TransmissionType char(30),
    FOREIGN KEY (Genus) REFERENCES Virus2(Genus) ON DELETE CASCADE);


CREATE TABLE RNAVirus (
    virusCommonName char(30) PRIMARY KEY, Sense char(30),
    FOREIGN KEY (virusCommonName)
        REFERENCES Virus3(virusCommonName) 
        ON DELETE CASCADE); 


CREATE TABLE DNAVirus(
    virusCommonName char(30) PRIMARY KEY, GenomeShape char(30),
    FOREIGN KEY (virusCommonName)  
        REFERENCES Virus3(virusCommonName) 
        ON DELETE CASCADE);


CREATE TABLE VaccineAgainst1(
    Type char(30) PRIMARY KEY,
    ImmunocompromiseSafety char(30));


CREATE TABLE VaccineAgainst2(
    virusCommonName char(30) NOT NULL, 
    Type char(30) NOT NULL, 
    Manufacture char(35) NOT NULL, 
    Valence int, 
    DeliveryMode char(30),
    Year float,
    PRIMARY KEY(Type, virusCommonName, Manufacture),
    FOREIGN KEY(Type) REFERENCES VaccineAgainst1(Type) ON DELETE CASCADE,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE
);


CREATE TABLE Host(
    hostCommonName char(30) PRIMARY KEY, 
    Type char(30));


CREATE TABLE Infects(
    hostCommonName char(30) NOT NULL,
    virusCommonName char(30) NOT NULL,
    PRIMARY KEY(hostCommonName, virusCommonName),
    FOREIGN KEY(hostCommonName) REFERENCES Host(hostCommonName) ON DELETE CASCADE,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE);
/*assertion needed*/


CREATE TABLE Receptor(
    receptorName char(30) PRIMARY KEY,
    CellType char(30),
    TissueType char(30));


CREATE TABLE Targets(
    receptorName char(30) NOT NULL, 
    virusCommonName char(30) NOT NULL,
    PRIMARY KEY(receptorName,virusCommonName ),
    FOREIGN KEY(receptorName) REFERENCES Receptor ON DELETE CASCADE ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE ); 
/*assertion needed*/


CREATE TABLE ViralDisease(
    diseaseName char(30) PRIMARY KEY, 
    diseaseType char(30));


CREATE TABLE Causes(
diseaseName char(30) NOT NULL,
virusCommonName char(30),
PRIMARY KEY (diseaseName, virusCommonName),
FOREIGN KEY(diseaseName) REFERENCES ViralDisease(diseaseName) ON DELETE CASCADE ,
FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE 
);
/*assertion needed*/


CREATE TABLE Symptom(
 symptomName char(30) PRIMARY KEY,
 Specificity char(30));


CREATE TABLE Has(
    diseaseName char(30), 
    symptomName char(30), 
    Severity char(30),
    PRIMARY KEY(diseaseName, symptomName),
    FOREIGN KEY (diseaseName) REFERENCES ViralDisease(diseaseName) ,
    FOREIGN KEY(symptomName) REFERENCES Symptom(symptomName) 
);


CREATE TABLE Country(
    countryName char(30) PRIMARY KEY,
    PopulationDensity float, 
    Continent char(30), 
    Status char(30));


CREATE TABLE Outbreak(
    countryName char(30), 
    virusCommonName char(30),
    outbreakSize char(30), 
    Casualty integer, 
    Year integer, 
    Origin char(30),
    PRIMARY KEY(countryName, virusCommonName),
    FOREIGN KEY(countryName) REFERENCES Country(countryName) ON DELETE CASCADE ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE  
);


CREATE TABLE EndemicTo(
    countryName char(30), 
    virusCommonName char(30), 
    PRIMARY KEY(countryName, virusCommonName),
    FOREIGN KEY(countryName) REFERENCES Country(countryName)  ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE  
);


CREATE TABLE Application(
    applicationName char(30) PRIMARY KEY, 
    Usage char(30));


CREATE TABLE UsedIn(
    applicationName char(30) NOT NULL, 
    virusCommonName char(30),
    PRIMARY KEY(applicationName, virusCommonName),
    FOREIGN KEY (applicationName) REFERENCES Application ,
    FOREIGN KEY (virusCommonName) REFERENCES Virus3 ON DELETE CASCADE
);