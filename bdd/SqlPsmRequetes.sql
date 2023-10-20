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
    DECLARE datePart DATETIME;
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
DELIMITER //
CREATE TRIGGER etapeUpdate
BEFORE UPDATE ON T_ETAPE_ETA
FOR EACH ROW
BEGIN
    -- Si l'etape est desac appliquer: 
    -- Si eta_prochaine_id && id apparait dans T_SCENARIO_SCE (1e etape une seconde existe)
    -- On met prochaine id dans T_SCENARIO_SCE 
    -- Si eta_prochaine_id !& id apparait dans T_SCENARIO_SCE (etape quelconque qui a une suivante)
    -- On repere là ou son ID (eta_id) est la prochaine dans les etapes (etape precedente a l'etape supr)
    -- On remplace a cette ligne l'id de la prochaine etape par id_prochaine_etape de notre etape supr
    -- Si !eta_prochaine_id && id apparait dans SCENARIO (1ere et derniere etape) -> On désactive le scenario
    -- Si !eta_prochaine_id && !id apparait dans Scenario (derniere etape du sce) -> On désactive sans rien faire de plus
    DECLARE presenceScenario INT;
    IF NEW.eta_statut = 'C' THEN
        SELECT eta_id INTO presenceScenario FROM T_SCENARIO_SCE WHERE sce_id = OLD.sce_id;

        IF OLD.eta_prochaine_id IS NOT NULL AND presenceScenario = OLD.eta_id THEN
            UPDATE T_SCENARIO_SCE SET eta_id = OLD.eta_prochaine_id WHERE sce_id = OLD.sce_id;
        END IF;

        IF OLD.eta_prochaine_id IS NOT NULL AND presenceScenario != OLD.eta_id THEN
            UPDATE T_ETAPE_ETA SET eta_prochaine_id = OLD.eta_prochaine_id WHERE eta_id = (SELECT eta_id FROM T_ETAPE_ETA WHERE eta_prochaine_id = OLD.eta_id);
        END IF;

        IF OLD.eta_prochaine_id IS NULL AND presenceScenario = OLD.eta_id THEN
            UPDATE T_SCENARIO_SCE SET sce_statut = 'C' WHERE sce_id = OLD.sce_id;
        END IF;

    END IF;
END;
//
DELIMITER ;

-- Soulager le trigger au dessus a l'aide d'une procedure qui via l'id de l'etape renvoie si c'est la premiere / derniere, une quelconque ou le seule
-- Cela rendrait mes conditions moins longue

-- Fonction qui a partir de l'id d'une etape nous renvoie son ordre sur le scénario associé ?