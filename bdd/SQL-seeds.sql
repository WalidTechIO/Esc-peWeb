-- MySQL Script generated by MySQL Workbench
-- Tue Oct 17 19:52:40 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema e22000229_db2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e22000229_db2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e22000229_db2` DEFAULT CHARACTER SET utf8mb4 ;
USE `e22000229_db2` ;

-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_COMPTE_CPT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_COMPTE_CPT` (
  `cpt_id` INT NOT NULL AUTO_INCREMENT,
  `cpt_mail` VARCHAR(255) NOT NULL,
  `cpt_pseudo` VARCHAR(255) NOT NULL,
  `cpt_password` CHAR(64) NOT NULL,
  `cpt_nom` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `cpt_prenom` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `cpt_statut` CHAR(1) NOT NULL,
  `cpt_role` CHAR(1) NOT NULL,
  PRIMARY KEY (`cpt_id`),
  UNIQUE INDEX `mail_UNIQUE` (`cpt_mail` ASC),
  UNIQUE INDEX `pseudo_UNIQUE` (`cpt_pseudo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_ACTUALITE_ACT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_ACTUALITE_ACT` (
  `act_id` INT NOT NULL AUTO_INCREMENT,
  `act_titre` VARCHAR(255) NOT NULL,
  `act_date` DATE NOT NULL,
  `act_contenu` TEXT NOT NULL,
  `act_statut` CHAR(1) NOT NULL,
  `cpt_id` INT NOT NULL,
  PRIMARY KEY (`act_id`),
  INDEX `AtualiteUtilisateurFK1_idx` (`cpt_id` ASC),
  CONSTRAINT `AtualiteUtilisateurFK`
    FOREIGN KEY (`cpt_id`)
    REFERENCES `e22000229_db2`.`T_COMPTE_CPT` (`cpt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_PARTICIPANT_PNT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_PARTICIPANT_PNT` (
  `pnt_id` INT NOT NULL AUTO_INCREMENT,
  `pnt_mail` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`pnt_id`),
  UNIQUE INDEX `mail_UNIQUE` (`pnt_mail` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_RESSOURCE_RES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_RESSOURCE_RES` (
  `res_id` INT NOT NULL AUTO_INCREMENT,
  `res_type` VARCHAR(255) NOT NULL,
  `res_chemin` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`res_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_ETAPE_ETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_ETAPE_ETA` (
  `eta_id` INT NOT NULL AUTO_INCREMENT,
  `eta_intitule` VARCHAR(255) NOT NULL,
  `eta_statut` CHAR(1) NOT NULL,
  `eta_code` CHAR(8) NOT NULL,
  `eta_question` VARCHAR(255) NOT NULL,
  `eta_reponse` VARCHAR(45) NOT NULL,
  `res_id` INT NOT NULL,
  `sce_id` INT NOT NULL,
  `eta_prochaine_id` INT NULL,
  PRIMARY KEY (`eta_id`),
  UNIQUE INDEX `code_UNIQUE` (`eta_code` ASC),
  INDEX `EtapeRessourceFK1_idx` (`res_id` ASC),
  INDEX `EtapeScenarioFK1_idx` (`sce_id` ASC),
  INDEX `EtapeEtapeFK1_idx` (`eta_prochaine_id` ASC),
  CONSTRAINT `EtapeRessourceFK`
    FOREIGN KEY (`res_id`)
    REFERENCES `e22000229_db2`.`T_RESSOURCE_RES` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EtapeEtapeFK`
    FOREIGN KEY (`eta_prochaine_id`)
    REFERENCES `e22000229_db2`.`T_ETAPE_ETA` (`eta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_SCENARIO_SCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_SCENARIO_SCE` (
  `sce_id` INT NOT NULL AUTO_INCREMENT,
  `sce_intitule` VARCHAR(45) NOT NULL,
  `sce_statut` CHAR(1) NOT NULL,
  `sce_code` CHAR(8) NOT NULL,
  `cpt_id` INT NOT NULL,
  `res_id` INT NULL,
  `eta_id` INT NULL,
  PRIMARY KEY (`sce_id`),
  INDEX `ScfenarioUtilisateurFK1_idx` (`cpt_id` ASC),
  INDEX `ScenarioRessourceFK2_idx` (`res_id` ASC),
  INDEX `ScenarioEtapeFK_idx` (`eta_id` ASC),
  CONSTRAINT `ScenarioUtilisateurFK`
    FOREIGN KEY (`cpt_id`)
    REFERENCES `e22000229_db2`.`T_COMPTE_CPT` (`cpt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ScenarioRessourceFK`
    FOREIGN KEY (`res_id`)
    REFERENCES `e22000229_db2`.`T_RESSOURCE_RES` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ScenarioEtapeFK`
    FOREIGN KEY (`eta_id`)
    REFERENCES `e22000229_db2`.`T_ETAPE_ETA` (`eta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_INDICE_IND`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_INDICE_IND` (
  `ind_id` INT NOT NULL AUTO_INCREMENT,
  `ind_texte` VARCHAR(255) NOT NULL,
  `ind_lien` VARCHAR(255) NOT NULL,
  `ind_niveau` INT NOT NULL,
  `eta_id` INT NOT NULL,
  PRIMARY KEY (`ind_id`),
  INDEX `EtapeIndiceFK1_idx` (`eta_id` ASC),
  CONSTRAINT `EtapeIndiceFK`
    FOREIGN KEY (`eta_id`)
    REFERENCES `e22000229_db2`.`T_ETAPE_ETA` (`eta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22000229_db2`.`T_PARTICIPATION_PON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22000229_db2`.`T_PARTICIPATION_PON` (
  `pnt_id` INT NOT NULL AUTO_INCREMENT,
  `sce_id` INT NOT NULL,
  `pon_date_reussite` DATETIME NOT NULL,
  `pon_date_derniere_participation` DATETIME NOT NULL,
  `pon_difficulte_max_reussie` INT NOT NULL,
  PRIMARY KEY (`pnt_id`, `sce_id`),
  INDEX `ParticipationScenarioFK2_idx` (`sce_id` ASC),
  CONSTRAINT `ParticipationParticipantFK`
    FOREIGN KEY (`pnt_id`)
    REFERENCES `e22000229_db2`.`T_PARTICIPANT_PNT` (`pnt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ParticipationScenarioFK`
    FOREIGN KEY (`sce_id`)
    REFERENCES `e22000229_db2`.`T_SCENARIO_SCE` (`sce_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE T_ETAPE_ETA ADD CONSTRAINT `EtapeScenarioFK` FOREIGN KEY (`sce_id`) REFERENCES `e22000229_db2`.`T_SCENARIO_SCE` (`sce_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Comptes

INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('admin@escapeweb.fr', 'administrATeur', '59edd5af9e84b37a6c081c6563f528c0c7f5f6a945358e23ab7bebbf8d435a34', "Admin", "Esc@peWeb", 'A', 'A'); -- admin23_XEUJ
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('john@doe.fr', 'johndoe', '9461b850a6eb0dd26a4899d93d6a15ea7a4b1c4d9fa97d0b477dae31657ed0d8', 'John', 'Doe', 'A', 'O'); -- motdepasse1
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('jane@doe.fr', 'janedoe', 'd2182b0874e5886f118cefe4e8f1dec8bcb34ff781055ed42dc71d96874f9d7a', 'Jane', 'Doe', 'A', 'O'); -- motdepasse2
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('jean.pierre@orange.fr', 'jp29200', '013f94ea4e0ed42db4fd492140a6f800dbe0ed90f902eb2db5ca8b624156f38e', 'Jean', 'Pierre', 'A', 'O'); -- motdepasse3
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('walid.elouazizi@univ-brest.fr', 'walid.elouazizi', '7df01fd0c1ef559301e0b6a7fa066ee5e448fb8b0fad6f0a81013f7438ecae3e', "Walid", "El Ouazizi", 'A', 'O'); -- motdepasse4
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('will.smith@gmail.com', 'will.smith', '312e58b567deaf37c7dd6ed6b6ce137bd78147e4e86658abf3d160253b284499', "Will", "Smith", 'A', 'O'); -- motdepasse5

-- Actualités
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`) 
VALUES ('Introduction à Python', '2023-10-16', 'Ceci est un article sur Python.', 'P', 1);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('JavaScript pour débutants', '2023-10-17', 'Un guide pour commencer avec JavaScript.', 'P', 2);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('PHP avancé', '2023-10-18', 'Exploration des fonctionnalités avancées de PHP.', 'P', 3);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Les bases de la programmation', '2023-10-19', 'Un aperçu des concepts de base de la programmation.', 'P', 4);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Sécurité en programmation', '2023-10-20', 'Conseils pour assurer la sécurité dans le code.', 'P', 5);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Fondamentaux de JavaScript', '2023-10-21', 'Les bases de la programmation JavaScript.', 'P', 6);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Introduction à PHP', '2023-10-22', 'Premiers pas avec PHP.', 'P', 1);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Python pour les datascientists', '2023-10-23', "Utilisation de Python dans l'analyse de données.", 'P', 2);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Les bases de la programmation orientée objet', '2023-10-24', "Comprendre les concepts de l'OO.", 'P', 3);
INSERT INTO `e22000229_db2`.`T_ACTUALITE_ACT` (`act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`)
VALUES ('Développement web avec JavaScript', '2023-10-25', 'Création de sites web interactifs avec JavaScript.', 'P', 4);

-- Participants
INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES ('jeremey292@orange.fr');
INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES ('challenger29@gmail.com');
INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES ('superdev@outlook.fr');
INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES ('john@doe.fr');
INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES ('walid@gmail.com');

-- Scenariis
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario PHP', 'P', LEFT(UPPER(UUID()), 8), 2);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario JavaScript', 'P', LEFT(UPPER(UUID()), 8), 3);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario SQL', 'P', LEFT(UPPER(UUID()), 8), 4);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario HTML', 'P', LEFT(UPPER(UUID()), 8), 5);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario CSS', 'P', LEFT(UPPER(UUID()), 8), 6);

-- Ressources
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'images/php.svg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'images/js.png');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'images/sql.svg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'images/html.svg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'images/css.svg');

-- Participations
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (1, 1, '2023-10-16 00:00:00', '2023-10-15 00:00:00', 3);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (2, 2, '2023-10-17 00:00:00', '2023-10-16 00:00:00', 2);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (3, 3, '2023-10-18 00:00:00', '2023-10-17 00:00:00', 4);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (4, 4, '2023-10-19 00:00:00', '2023-10-18 00:00:00', 1);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (5, 5, '2023-10-20 00:00:00', '2023-10-19 00:00:00', 5);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (1, 2, '2023-10-21 00:00:00', '2023-10-20 00:00:00', 2);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (2, 3, '2023-10-22 00:00:00', '2023-10-21 00:00:00', 3);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (3, 4, '2023-10-23 00:00:00', '2023-10-22 00:00:00', 4);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (4, 5, '2023-10-24 00:00:00', '2023-10-23 00:00:00', 1);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (5, 1, '2023-10-25 00:00:00', '2023-10-24 00:00:00', 5);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (1, 3, '2023-10-26 00:00:00', '2023-10-25 00:00:00', 3);
INSERT INTO `e22000229_db2`.`T_PARTICIPATION_PON` (`sce_id`, `pnt_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`)
VALUES (2, 4, '2023-10-27 00:00:00', '2023-10-26 00:00:00', 2);

-- Etapes
-- Etapes pour PHP (sce_id = 1)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Affichage en PHP', LEFT(UPPER(UUID()), 8), 'P', "Quelle fonction de PHP permet d'afficher sur la sortie standard ?", 'echo', 1, 1),
('Variables en PHP', LEFT(UPPER(UUID()), 8), 'P', "Quelle est le signe que l'on met devant une var en php ?" , '$', 1, 1),
('Conditions en PHP', LEFT(UPPER(UUID()), 8), 'P', 'Quelle structure de contrôle est utilisée pour les conditions en PHP ? (mot clé seul)', 'if', 1, 1),
('Boucles en PHP', LEFT(UPPER(UUID()), 8), 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en PHP ? (mot clé seul)', 'for', 1, 1),
('Fonctions en PHP', LEFT(UPPER(UUID()), 8), 'P', 'Avec quel mot clé déclare-t-on une fonction en PHP? (mot clé seul)', 'function', 1, 1);

-- Etapes pour JavaScript (sce_id = 2)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Variables en JavaScript', LEFT(UPPER(UUID()), 8), 'P', "Quelle méthode permet d'ecrire dans la console en JavaScript ?", 'console.log()', 2, 2),
('Fonctions en JavaScript', LEFT(UPPER(UUID()), 8), 'P', 'Comment définir une fonction en JavaScript ? (mot clé seul)', 'function', 2, 2),
('Objets en JavaScript', LEFT(UPPER(UUID()), 8), 'P', "Ecrire l'objet vide en JS", '{}', 2, 2),
('Conditions en JavaScript', LEFT(UPPER(UUID()), 8), 'P', 'Quelle structure de contrôle est utilisée pour les conditions en JavaScript ? (mot clé seul)', 'if', 2, 2),
('Boucles en JavaScript', LEFT(UPPER(UUID()), 8), 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en JavaScript ? (mot clé seul)', 'for', 2, 2);

-- Etapes pour SQL (sce_id = 3)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Requêtes permettant de trouver des donées', LEFT(UPPER(UUID()), 8), 'P', 'Mot clé pour retrouver des donées', 'SELECT', 3, 3),
('Retrouver tout une table en SQL', LEFT(UPPER(UUID()), 8), 'P', "Requete qui récupère tout sur les utilisateurs (table: 'compte')", 'SELECT * FROM compte;', 3, 3),
('Requêtes de suppression en SQL', LEFT(UPPER(UUID()), 8), 'P', "Quelle est le mot clé qui permet la suppression d'une ligne en SQL", 'DELETE', 3, 3),
('Requêtes de mise a jour en SQL', LEFT(UPPER(UUID()), 8), 'P', "Quelle est le mot clé qui permet la maj d'une ligne en SQL", 'UPDATE', 3, 3),
('Clauses WHERE en SQL', LEFT(UPPER(UUID()), 8), 'P', "Quelle est le mot clé qui permet de filtrer les résultats d'une requete ?", 'WHERE', 3, 3);

-- Etapes pour HTML (sce_id = 4)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Balises HTML', LEFT(UPPER(UUID()), 8), 'P', 'Quelle balise est utilisée pour créer un lien hypertexte en HTML ?', '<a>', 4, 4),
('Balises de structure en HTML', LEFT(UPPER(UUID()), 8), 'P', 'Quelle balise est utilisée pour créer un paragraphe en HTML ?', '<p>', 4, 4),
('Listes en HTML', LEFT(UPPER(UUID()), 8), 'P', 'Dans quelle balise déclare-t-on le titre de la page HTML ?', '<title>', 4, 4),
('Balises d''image en HTML', LEFT(UPPER(UUID()), 8), 'P', "Quelle balise permet d'insérer une image ?", '<img/>', 4, 4),
('Formulaires en HTML', LEFT(UPPER(UUID()), 8), 'P', 'Quelle balise permet de créer un formulaire en HTML ?', '<form>', 4, 4);

-- Etapes pour CSS (sce_id = 5)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Sélecteurs CSS', LEFT(UPPER(UUID()), 8) ,'P', "Quelle est la syntaxe d''un sélecteur CSS pour sélectionner la classe 'contenu'?", '.contenu', 5, 5),
('Propriétés CSS', LEFT(UPPER(UUID()), 8),'P', 'Comment définir la couleur du texte en CSS ?', 'color', 5, 5),
('Box Model en CSS', LEFT(UPPER(UUID()), 8),'P', 'Quelle ligne CSS permet de rendre un élément flex', 'display: flex;', 5, 5),
('Positionnement en CSS', LEFT(UPPER(UUID()), 8),'P', 'Comment positionner un élément en haut à droite de son conteneur en CSS ? (Espace apres les ; et les : seulement)', 'position: absolute; top: 0; right: 0;', 5, 5),
('Couleur hexa', LEFT(UPPER(UUID()), 8),'P', 'Ecrire en hexadecimal la couleure noir (1 octet par couleur)', '#000000', 5, 5);


-- Indices
INSERT INTO `e22000229_db2`.`T_INDICE_IND` (`ind_texte`, `ind_lien`, `ind_niveau`, `eta_id`)
VALUES
("Pour afficher du texte en PHP, utilisez la fonction echo.", 'https://www.php.net/manual/en/function.echo.php', 1, 1),
("En JavaScript, console.log() est utilisé pour afficher des messages dans la console.", 'https://developer.mozilla.org/en-US/docs/Web/API/Console/log', 1, 6),
("Dans SQL, utilisez SELECT * FROM table pour récupérer toutes les lignes de la table.", 'https://www.w3schools.com/sql/sql_select.asp', 2, 11),
("En HTML, la balise <a> est utilisée pour créer des liens hypertexte.", 'https://www.w3schools.com/html/html_links.asp', 2, 16),
("CSS utilise la propriété color pour définir la couleur du texte.", 'https://developer.mozilla.org/en-US/docs/Web/CSS/color', 2, 22),
("En PHP, le signe $ est utilisé pour déclarer une variable.", 'https://www.php.net/manual/en/language.variables.basics.php', 3, 2),
("JavaScript utilise la structure de contrôle if...else pour les conditions.", 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/if...else', 3, 9),
("SQL utilise le mot clé WHERE pour filtrer les résultats d'une requête.", 'https://www.w3schools.com/sql/sql_where.asp', 3, 15),
("Les balises HTML <p> sont utilisées pour créer des paragraphes.", 'https://www.w3schools.com/html/html_paragraphs.asp', 1, 17),
("En CSS, display: flex; permet de rendre un élément flex.", 'https://developer.mozilla.org/en-US/docs/Web/CSS/display', 1, 23);

-- MAJ Premieres Etapes + Ressource dans les Scenarii
UPDATE T_SCENARIO_SCE SET res_id = '1', eta_id = '1' WHERE sce_id = 1;
UPDATE T_SCENARIO_SCE SET res_id = '2', eta_id = '6' WHERE sce_id = 2;
UPDATE T_SCENARIO_SCE SET res_id = '3', eta_id = '11' WHERE sce_id = 3;
UPDATE T_SCENARIO_SCE SET res_id = '4', eta_id = '16' WHERE sce_id = 4;
UPDATE T_SCENARIO_SCE SET res_id = '5', eta_id = '21' WHERE sce_id = 5;

-- MAJ ordre des etapes
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 2 WHERE eta_id = 1;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 3 WHERE eta_id = 2;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 4 WHERE eta_id = 3;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 5 WHERE eta_id = 4;

UPDATE T_ETAPE_ETA SET eta_prochaine_id = 7 WHERE eta_id = 6;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 8 WHERE eta_id = 7;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 9 WHERE eta_id = 8;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 10 WHERE eta_id = 9;

UPDATE T_ETAPE_ETA SET eta_prochaine_id = 12 WHERE eta_id = 11;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 13 WHERE eta_id = 12;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 14 WHERE eta_id = 13;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 15 WHERE eta_id = 14;

UPDATE T_ETAPE_ETA SET eta_prochaine_id = 17 WHERE eta_id = 16;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 18 WHERE eta_id = 17;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 19 WHERE eta_id = 18;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 20 WHERE eta_id = 19;

UPDATE T_ETAPE_ETA SET eta_prochaine_id = 22 WHERE eta_id = 21;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 23 WHERE eta_id = 22;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 24 WHERE eta_id = 23;
UPDATE T_ETAPE_ETA SET eta_prochaine_id = 25 WHERE eta_id = 24;

DROP FUNCTION IF EXISTS nbEtapeSce;
DELIMITER //
CREATE FUNCTION nbEtapeSce(idScenario INT) RETURNS INT
BEGIN
    DECLARE ETAPECOUNT INT;
    SELECT COUNT(*) INTO ETAPECOUNT FROM T_ETAPE_ETA WHERE sce_id = idScenario;
    RETURN ETAPECOUNT;
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS scenarioInsert;
DELIMITER //
CREATE TRIGGER scenarioInsert
BEFORE INSERT ON T_SCENARIO_SCE
FOR EACH ROW
BEGIN
    SET NEW.sce_code := (LEFT(UPPER(UUID()), 8));
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS suppressionScenario
DELIMITER //
CREATE PROCEDURE suppressionScenario(IN idSce INT)
BEGIN
    DELETE FROM T_PARTICIPATION_PON WHERE sce_id = idSce;
    UPDATE T_SCENARIO_SCE SET eta_id = NULL WHERE sce_id = idSce;
    DELETE FROM T_INDICE_IND WHERE eta_id IN (SELECT eta_id FROM T_ETAPE_ETA WHERE sce_id = idSce);
    DELETE FROM T_ETAPE_ETA WHERE sce_id = idSce;
    DELETE FROM T_SCENARIO_SCE WHERE sce_id = idSce;
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS compteDelete;
DELIMITER //
CREATE TRIGGER compteDelete
BEFORE DELETE ON T_COMPTE_CPT
FOR EACH ROW
BEGIN
    UPDATE T_ACTUALITE_ACT SET cpt_id = (SELECT cpt_id FROM T_COMPTE_CPT WHERE cpt_pseudo = "administrATeur") WHERE cpt_id = OLD.cpt_id;
    UPDATE T_SCENARIO_SCE SET cpt_id = (SELECT cpt_id FROM T_COMPTE_CPT WHERE cpt_pseudo = "administrATeur") WHERE cpt_id = OLD.cpt_id;
END;
//
DELIMITER ;

CREATE VIEW articlesAproposPhp AS SELECT * FROM T_ACTUALITE_ACT WHERE act_titre LIKE "%php%" OR act_contenu LIKE "%php%";