-- Activité1

SELECT MAX(pfl_id) INTO @idMax FROM t_profil_pfl;
SELECT @idMax;

UPDATE t_profil_pfl SET pfl_statut = 'A' WHERE pfl_id = @idMax;

SELECT MIN(YEAR(pfl_date)) INTO @annee FROM t_profil_pfl;
SELECT @annee;

-- Activite2

CREATE VIEW NomsPrenoms AS SELECT pfl_nom, pfl_prenom FROM t_profil_pfl;

-- Activite3

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

-- Activite4

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

-- Activite5

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

-- SQL-PSM Approfondir

-- Activite 1

SELECT cpt_mail, cpt_nom, cpt_prenom, act_contenu FROM T_COMPTE_CPT LEFT JOIN T_ACTUALITE_ACT USING(cpt_id);

SELECT cpt_mail, cpt_nom, cpt_prenom FROM T_COMPTE_CPT WHERE cpt_id NOT IN (SELECT cpt_id FROM T_ACTUALITE_ACT);
-- ou EXCEPT ou LEFT JOIN WHERE contenu = NULL

-- Activite 2

DROP FUNCTION IF EXISTS nbParticipants;
DELIMITER //
CREATE FUNCTION nbParticipants(idScenario INT) RETURNS INT
BEGIN
	DECLARE NB INT;
	SELECT COUNT(*) INTO NB FROM T_PARTICIPATION_PON WHERE sce_id = idScenario;
    RETURN NB;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS infoScenario;
DELIMITER //
CREATE PROCEDURE infoScenario(IN idScenario INT, OUT MESSAGE TEXT)
infsce: BEGIN
    DECLARE intitule, mailPart TEXT;
    DECLARE nbParts INT;
    DECLARE datePart DATETIME;
    IF (SELECT sce_id FROM T_SCENARIO_SCE WHERE sce_id = idScenario) IS NULL THEN -- Aucun scenario d'ID `idScenario`
        SELECT "Scénario inexistant" INTO MESSAGE;
        LEAVE infsce; -- On quitte la procedure
    END IF;
    SELECT nbParticipants(idScenario) INTO nbParts;
    IF nbParts = 0 THEN
        SELECT "Aucun participant" INTO mailPart;
        SET datePart := NULL;
    ELSE
        SELECT pnt_mail INTO mailPart FROM T_PARTICIPANT_PNT JOIN T_PARTICIPATION_PON USING(pnt_id) WHERE pon_date_reussite = (SELECT MIN(pon_date_reussite) FROM T_PARTICIPATION_PON WHERE sce_id = idScenario) LIMIT 1;
        SELECT MIN(pon_date_reussite) INTO datePart FROM T_PARTICIPATION_PON WHERE sce_id = idScenario;
    END IF;
    SELECT SUBSTRING_INDEX(sce_intitule, ' - Caché le ', 1) INTO intitule FROM T_SCENARIO_SCE WHERE sce_id = idScenario; -- On oublie pas d'ajouter le substring car pour la suppression on compare le contenu avec le res de cette procedure
    SELECT CONCAT("Intitule scenario: ", intitule, "\nNombre de participants: ", nbParts, "\nEmail premier participant: ", mailPart, "\nDate premiere reussite: ", datePart) INTO MESSAGE;
END;
//
DELIMITER ;

-- Trigger activité 2 + Trigger 1 de l'activité 4

DROP TRIGGER IF EXISTS scenarioUpdate;
DELIMITER //
CREATE TRIGGER scenarioUpdate
BEFORE UPDATE ON T_SCENARIO_SCE
FOR EACH ROW
BEGIN
    DECLARE contenu TEXT;
    IF NEW.sce_statut = 'C' THEN -- Crée article et renomme scenario
        CALL infoScenario(NEW.sce_id, contenu);
        INSERT INTO T_ACTUALITE_ACT (act_titre, act_date, act_contenu, act_statut, cpt_id) VALUES (CONCAT('Scénario ', NEW.sce_id, ' retiré'), CURDATE(), contenu, 'P', 1);
        SET NEW.sce_intitule := CONCAT(NEW.sce_intitule, " - Caché le ", CURDATE());
    END IF;
    IF NEW.sce_statut = 'P' THEN -- Evite doublons article + Renomme scenario
        CALL infoScenario(NEW.sce_id, contenu);
        DELETE FROM T_ACTUALITE_ACT WHERE act_titre = CONCAT('Scénario ', NEW.sce_id, ' retiré') AND act_contenu LIKE (CONCAT('%', contenu ,'%'));
        SET NEW.sce_intitule := SUBSTRING_INDEX(NEW.sce_intitule, ' - Caché le', 1);
    END IF;
END;
//
DELIMITER ;

-- En changeant le delimiter par " - Caché le" je réduis les contraintes de nommage des scenarios en BDD (Avec " - " on ne pouvait plus réellement mettre ce bout de texte dans l'intitulé)
SELECT SUBSTRING_INDEX('Scenario PHP - Caché le 2023-10-17', ' - Caché le', 1) AS resultat; -- Resultat : Scenario PHP

-- Activite 3
DROP PROCEDURE IF EXISTS recap_participants_scenario;
DELIMITER //
CREATE PROCEDURE recap_participants_scenario(IN idScenario INT, OUT MESSAGE TEXT)
BEGIN
    SELECT GROUP_CONCAT(pnt_mail) INTO MESSAGE FROM T_PARTICIPANT_PNT JOIN T_PARTICIPATION_PON USING(pnt_id) WHERE sce_id = idScenario;
END;
//
DELIMITER ;

-- Si un des parametres d'appel de GROUP_CONCAT est NULL elle retournera NULL !

CALL recap_participants_scenario(1, @test);
SELECT @test;

-- Activite 4 Trigger 2

DROP TRIGGER IF EXISTS compteDelete;
DELIMITER //
CREATE TRIGGER compteDelete
BEFORE DELETE ON T_COMPTE_CPT
FOR EACH ROW
BEGIN
    IF OLD.cpt_role = 'O' THEN
        DELETE FROM T_ACTUALITE_ACT WHERE cpt_id = OLD.cpt_id;
        UPDATE T_SCENARIO_SCE SET cpt_id = 1 WHERE cpt_id = OLD.cpt_id;
    END IF;
END;
//
DELIMITER ;

-- Idee Trigger: trigger qui remplis code avant l'insert via SET NEW.sce_code := (UPPER(RIGHT(REPLACE(NEW.sce_intitule, ' ', ''), 8)));

SELECT CONCAT(UPPER(RIGHT(REPLACE('Scénario de test', ' ', ''), (8 - CHAR_LENGTH(12)))), RIGHT(12, 8)) -- -> 'Scenario de test' ID 12, Sortie: DETEST12

DROP TRIGGER IF EXISTS scenarioInsert;
DELIMITER //
CREATE TRIGGER scenarioInsert
BEFORE INSERT ON T_SCENARIO_SCE
FOR EACH ROW
BEGIN
    SET NEW.sce_code := CONCAT(UPPER(RIGHT(REPLACE(NEW.sce_intitule, ' ', ''), (8 - CHAR_LENGTH(NEW.sce_id)))), RIGHT(NEW.sce_id, 8));
END;
//
DELIMITER ;

-- 2e idee trigger -> Gestion de l'ordre des etapes en cas de desac d'une etape
DROP TRIGGER IF EXISTS etapeUpdate;
DELIMITER //
CREATE TRIGGER etapeUpdate
BEFORE UPDATE ON T_ETAPE_ETA
FOR EACH ROW
BEGIN
    DECLARE presenceScenario INT;
    IF NEW.eta_statut = 'C' THEN
        SELECT eta_id INTO presenceScenario FROM T_SCENARIO_SCE WHERE sce_id = OLD.sce_id;

        IF OLD.eta_prochaine_id IS NOT NULL AND presenceScenario = OLD.eta_id THEN
            UPDATE T_SCENARIO_SCE SET eta_id = OLD.eta_prochaine_id WHERE sce_id = OLD.sce_id;
        END IF;

        -- IF OLD.eta_prochaine_id IS NOT NULL AND presenceScenario != OLD.eta_id THEN
        --     UPDATE T_ETAPE_ETA SET eta_prochaine_id = OLD.eta_prochaine_id WHERE eta_id = (SELECT eta_id FROM T_ETAPE_ETA WHERE eta_prochaine_id = OLD.eta_id);
        -- END IF;

        IF OLD.eta_prochaine_id IS NULL AND presenceScenario = OLD.eta_id THEN
            UPDATE T_SCENARIO_SCE SET sce_statut = 'C' WHERE sce_id = OLD.sce_id;
        END IF;

    END IF;
END;
//
DELIMITER ;

-- Fonction qui a partir de l'id d'une etape nous renvoie son ordre sur le scénario associé

DROP PROCEDURE IF EXISTS orderEtape; -- Transformer en procedure pour double sortie ?
DELIMITER //
CREATE PROCEDURE orderEtape(IN idScenario INT, OUT MSG TEXT, OUT ETAPECOUNT INT)
ordeEtape: BEGIN
    DECLARE idTraite INT;
    SELECT eta_id INTO idTraite FROM T_SCENARIO_SCE WHERE sce_id = idScenario;
    IF idTraite IS NULL THEN
        SELECT "Le scénario n'a aucune étape" INTO MSG;
        SELECT 0 INTO ETAPECOUNT;
        LEAVE ordeEtape;
    ELSE
        SELECT CONCAT(idTraite) INTO MSG;
        SELECT 1 INTO ETAPECOUNT;
    END IF;
    WHILE idTraite IS NOT NULL DO
        SELECT eta_prochaine_id INTO idTraite FROM T_ETAPE_ETA WHERE eta_id = idTraite;
        IF FIND_IN_SET(idTraite, MSG) THEN
            SELECT "Boucle infinie dans les étapes" INTO MSG;
            SELECT 0 INTO ETAPECOUNT;
            LEAVE ordeEtape;
        END IF;
        IF idTraite IS NOT NULL THEN
            SELECT CONCAT(MSG, ",", idTraite) INTO MSG;
            SELECT (ETAPECOUNT+1) INTO ETAPECOUNT;
        END IF;
    END WHILE;
END;
//
DELIMITER ;

-- Procedure qui a partir d'un ID d'etape peut desactiver l'etape sans que l'ordre soit cassée en BDD

DROP PROCEDURE IF EXISTS turnOffStep;
DELIMITER //
CREATE PROCEDURE turnOffStep(IN etapeD INT)
label: BEGIN
    DECLARE etapeS INT;
    IF (SELECT eta_id FROM T_ETAPE_ETA WHERE eta_id = etapeD) IS NULL THEN
        LEAVE label; -- On quitte
    END IF;
    SELECT eta_prochaine_id INTO etapeS FROM T_ETAPE_ETA WHERE eta_id = etapeD;
    UPDATE T_ETAPE_ETA SET eta_statut = 'C' WHERE eta_id = etapeD;
    UPDATE T_ETAPE_ETA SET eta_prochaine_id = etapeS WHERE eta_id = (SELECT eta_id FROM T_ETAPE_ETA WHERE eta_prochaine_id = etapeD);
END;
//
DELIMITER ;