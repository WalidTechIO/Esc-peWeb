-- Comptes

INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('admin@escapeweb.fr', 'administrATeur', 'admin23_XEUJ', NULL, NULL, 'A', 'A');
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('john@doe.fr', 'johndoe', 'motdepasse1', 'John', 'Doe', 'A', 'O');
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('jane@doe.fr', 'janedoe', 'motdepasse2', 'Jane', 'Doe', 'A', 'O');
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('jean.pierre@orange.fr', 'jp29200', 'motdepasse3', 'Jean', 'Pierre', 'A', 'O');
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('walid.elouazizi@univ-brest.fr', 'walid.elouazizi', 'motdepasse4', "Walid", "El Ouazizi", 'A', 'O');
INSERT INTO T_COMPTE_CPT (cpt_mail, cpt_pseudo, cpt_password, cpt_prenom, cpt_nom, cpt_statut, cpt_role) 
VALUES ('will.smith@gmail.com', 'will.smith', 'motdepasse5', "Will", "Smith", 'A', 'O');

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
VALUES ('Scénario PHP', 'P', UPPER(RIGHT(REPLACE('Scénario PHP', ' ', ''), 8)), 2);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario JavaScript', 'P', UPPER(RIGHT(REPLACE('Scénario JavaScript', ' ', ''), 8)), 3);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario SQL', 'P', UPPER(RIGHT(REPLACE('Scénario SQL', ' ', ''), 8)), 4);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario HTML', 'P', UPPER(RIGHT(REPLACE('Scénario HTML', ' ', ''), 8)), 5);
INSERT INTO `e22000229_db2`.`T_SCENARIO_SCE` (`sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`)
VALUES ('Scénario CSS', 'P', UPPER(RIGHT(REPLACE('Scénario CSS', ' ', ''), 8)), 6);

-- Ressources
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'documents/php.jpg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'documents/javascript.jpg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'documents/sql.jpg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'documents/html.jpg');
INSERT INTO `e22000229_db2`.`T_RESSOURCE_RES` (`res_type`, `res_chemin`)
VALUES ('Image', 'documents/css.jpg');

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
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Affichage en PHP', 'P', "Quelle fonction de PHP permet d'afficher sur la sortie standard ?", 'echo', 1, 1),
('Variables en PHP', 'P', "Quelle est le signe que l'on met devant une var en php ?" , '$', 1, 1),
('Conditions en PHP', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en PHP ? (mot clé seul)', 'if', 1, 1),
('Boucles en PHP', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en PHP ? (mot clé seul)', 'for', 1, 1),
('Fonctions en PHP', 'P', 'Avec quel mot clé déclare-t-on une fonction en PHP? (mot clé seul)', 'function', 1, 1);

-- Etapes pour JavaScript (sce_id = 2)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Variables en JavaScript', 'P', "Quelle méthode permet d'ecrire dans la console en JavaScript ?", 'console.log()', 2, 2),
('Fonctions en JavaScript', 'P', 'Comment définir une fonction en JavaScript ? (mot clé seul)', 'function', 2, 2),
('Objets en JavaScript', 'P', "Ecrire l'objet vide en JS", '{}', 2, 2),
('Conditions en JavaScript', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en JavaScript ? (mot clé seul)', 'if', 2, 2),
('Boucles en JavaScript', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en JavaScript ? (mot clé seul)', 'for', 2, 2);

-- Etapes pour SQL (sce_id = 3)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Requêtes permettant de trouver des donées', 'P', 'Mot clé pour retrouver des donées', 'SELECT', 3, 3),
('Retrouver tout une table en SQL', 'P', "Requete qui récupère tout sur les utilisateurs (table: 'compte')", 'SELECT * FROM compte;', 3, 3),
('Requêtes de suppression en SQL', 'P', "Quelle est le mot clé qui permet la suppression d'une ligne en SQL", 'DELETE', 3, 3),
('Requêtes de mise a jour en SQL', 'P', "Quelle est le mot clé qui permet la maj d'une ligne en SQL", 'UPDATE', 3, 3),
('Clauses WHERE en SQL', 'P', "Quelle est le mot clé qui permet de filtrer les résultats d'une requete ?", 'WHERE;', 3, 3);

-- Etapes pour HTML (sce_id = 4)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Balises HTML', 'P', 'Quelle balise est utilisée pour créer un lien hypertexte en HTML ?', '<a>', 4, 4),
('Balises de structure en HTML', 'P', 'Quelle balise est utilisée pour créer un paragraphe en HTML ?', '<p>', 4, 4),
('Listes en HTML', 'P', 'Dans quelle balise déclare-t-on le titre de la page HTML ?', '<title>', 4, 4),
('Balises d''image en HTML', 'P', "Quelle balise permet d'insérer une image ?", '<img/>', 4, 4),
('Formulaires en HTML', 'P', 'Quelle balise permet de créer un formulaire en HTML ?', '<form>', 4, 4);

-- Etapes pour CSS (sce_id = 5)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Sélecteurs CSS', 'P', "Quelle est la syntaxe d''un sélecteur CSS pour sélectionner la classe 'contenu'?", '.contenu', 5, 5),
('Propriétés CSS', 'P', 'Comment définir la couleur du texte en CSS ?', 'color', 5, 5),
('Box Model en CSS', 'P', 'Quelle ligne CSS permet de rendre un élément flex', 'display: flex;', 5, 5),
('Positionnement en CSS', 'P', 'Comment positionner un élément en haut à droite de son conteneur en CSS ? (Espace apres les ; et les : seulement)', 'position: absolute; top: 0; right: 0;', 5, 5),
('Couleur hexa', 'P', 'Ecrire en hexadecimal la couleure noir (1 octet par couleur)', '#000000', 5, 5);


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