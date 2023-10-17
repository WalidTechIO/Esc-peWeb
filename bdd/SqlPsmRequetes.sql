--Activité1

SELECT MAX(pfl_id) INTO @idMax FROM t_profil_pfl;
SELECT @idMax;

UPDATE t_profil_pfl SET pfl_statut = 'A' WHERE pfl_id = @idMax;

SELECT MIN(YEAR(pfl_date)) INTO @annee FROM t_profil_pfl;
SELECT @annee;

#Activite2

CREATE VIEW NomsPrenoms AS SELECT pfl_nom, pfl_prenom FROM t_profil_pfl;

--Activite3

DROP FUNCTION IF EXISTS age_profil;
DELIMITER //
//
CREATE FUNCTION age_profil(birthdate DATE) RETURNS INT
BEGIN
	DECLARE age INT;
    DECLARE birthday, today DATE;
    SET today := TIMESTAMP(CURDATE());
    SET birthday := TIMESTAMP(birthdate);
    SET age := TIMESTAMPDIFF(YEAR, birthday, today);
    RETURN age;
END;
//
DELIMITER ;
SELECT age_profil('2005-09-01');
SELECT age_profil('2005-12-01');
SELECT age_profil('2005-10-13');

--Activite4

DROP PROCEDURE IF EXISTS age_pfl_id;
DELIMITER //
CREATE PROCEDURE age_pfl_id(IN ID_PFL INT, OUT AGE_PFL INT)
BEGIN
    SELECT age_profil(pfl_date_naissance) INTO AGE_PFL FROM t_profil_pfl WHERE pfl_id = ID_PFL;
END;
//
DELIMITER ;
CALL age_pfl_id(1, @age);
SELECT @age;

CREATE VIEW vue_age AS SELECT pfl_nom, pfl_prenom, age_profil(pfl_date_naissance) AS pfl_age FROM t_profil_pfl;

--Activite5

DELIMITER //
CREATE TRIGGER dateProfil
AFTER INSERT ON t_profil_pfl
FOR EACH ROW
BEGIN
SET NEW.pfl_date = CURDATE();
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER hashPass
BEFORE INSERT ON t_compte_cpt
FOR EACH ROW
BEGIN
SET NEW.cpt_mot_de_passe = SHA2(CONCAT("dulongSelPourQueMdpRestes3curis65",NEW.cpt_mot_de_passe,"sel"),256);
END;
//
DELIMITER ;

SELECT cpt_mail, cpt_nom, cpt_prenom, act_contenu FROM T_COMPTE_CPT LEFT JOIN T_ACTUALITE_ACT USING(cpt_id);

SELECT cpt_mail, cpt_nom, cpt_prenom FROM T_COMPTE_CPT WHERE cpt_id NOT IN (SELECT cpt_id FROM T_ACTUALITE_ACT);
-- ou EXCEPT ou LEFT JOIN WHERE contenu = NULL

DELIMITER //
CREATE FUNCTION nbParticipants(idScenario INT) RETURNS INT
BEGIN
	DECLARE NB INT;
	SELECT COUNT(*) INTO NB FROM T_PARTICIPATION_PON WHERE sce_id = idScenario;
    RETURN NB;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE infoScenario(IN idScenario INT, OUT MESSAGE TEXT)
BEGIN
    DECLARE intitule, mailPart TEXT;
    DECLARE nbParts INT;
    DECLARE datePart DATE;
    SELECT pnt_mail INTO mailPart FROM T_PARTICIPANT_PNT JOIN T_PARTICIPATION_PON USING(pnt_id) WHERE pon_date_reussite = (SELECT MIN(pon_date_reussite) FROM T_PARTICIPATION_PON WHERE sce_id = idScenario);
    SELECT MIN(pon_date_reussite) INTO datePart FROM T_PARTICIPATION_PON WHERE sce_id = idScenario;
    SELECT nbParticipants(idScenario) INTO nbParts;
    SELECT sce_intitule INTO intitule FROM T_SCENARIO_SCE WHERE sce_id = idScenario;
    SELECT CONCAT("Intitule scenario: ", intitule, "\nNombre de participants: ", nbParts, "\nEmail premier participant: ", mailPart, "\nDate premiere reussite: ", datePart) INTO MESSAGE;
END;
//
DELIMITER ;

CALL infoScenario(2, @test);
SELECT @test;

DELIMITER //
CREATE TRIGGER scenarioCache
BEFORE UPDATE ON T_SCENARIO_SCE
FOR EACH ROW
BEGIN
    DECLARE contenu TEXT;
    IF NEW.sce_statut = 'C' THEN
        CALL infoScenario(NEW.sce_id, contenu);
        INSERT INTO T_ACTUALITE_ACT (act_titre, act_date, act_contenu, act_statut, cpt_id) VALUES (CONCAT('Scénario ', NEW.sce_id, ' retiré'), CURDATE(), contenu, 'P', 1);
        SET NEW.sce_intitule := CONCAT(NEW.sce_intitule, " - Caché le ", CURDATE());
    END IF;
END;
//
DELIMITER ;

--Idee Trigger: trigger qui remplis code avant l'insert via SET NEW.sce_code := (UPPER(RIGHT(REPLACE(NEW.sce_intitule, ' ', ''), 8)));