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
('Affichage en PHP', 'ABCDEA12', 'P', "Quelle fonction de PHP permet d'afficher sur la sortie standard ?", 'echo', 1, 1),
('Variables en PHP', 'ABCDEA13', 'P', "Quelle est le signe que l'on met devant une var en php ?" , '$', 1, 1),
('Conditions en PHP', 'ABCDEA14', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en PHP ? (mot clé seul)', 'if', 1, 1),
('Boucles en PHP', 'ABCDEA15', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en PHP ? (mot clé seul)', 'for', 1, 1),
('Fonctions en PHP', 'ABCDEA16', 'P', 'Avec quel mot clé déclare-t-on une fonction en PHP? (mot clé seul)', 'function', 1, 1);

-- Etapes pour JavaScript (sce_id = 2)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Variables en JavaScript', 'ABCDEB12', 'P', "Quelle méthode permet d'ecrire dans la console en JavaScript ?", 'console.log()', 2, 2),
('Fonctions en JavaScript', 'ABCDEB13', 'P', 'Comment définir une fonction en JavaScript ? (mot clé seul)', 'function', 2, 2),
('Objets en JavaScript', 'ABCDEB14', 'P', "Ecrire l'objet vide en JS", '{}', 2, 2),
('Conditions en JavaScript', 'ABCDEB15', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en JavaScript ? (mot clé seul)', 'if', 2, 2),
('Boucles en JavaScript', 'ABCDEB16', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en JavaScript ? (mot clé seul)', 'for', 2, 2);

-- Etapes pour SQL (sce_id = 3)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Requêtes permettant de trouver des donées', 'ABCDEC12', 'P', 'Mot clé pour retrouver des donées', 'SELECT', 3, 3),
('Retrouver tout une table en SQL', 'ABCDEC13', 'P', "Requete qui récupère tout sur les utilisateurs (table: 'compte')", 'SELECT * FROM compte;', 3, 3),
('Requêtes de suppression en SQL', 'ABCDEC14', 'P', "Quelle est le mot clé qui permet la suppression d'une ligne en SQL", 'DELETE', 3, 3),
('Requêtes de mise a jour en SQL', 'ABCDEC15', 'P', "Quelle est le mot clé qui permet la maj d'une ligne en SQL", 'UPDATE', 3, 3),
('Clauses WHERE en SQL', 'ABCDEC16', 'P', "Quelle est le mot clé qui permet de filtrer les résultats d'une requete ?", 'WHERE;', 3, 3);

-- Etapes pour HTML (sce_id = 4)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Balises HTML', 'ABCDED12', 'P', 'Quelle balise est utilisée pour créer un lien hypertexte en HTML ?', '<a>', 4, 4),
('Balises de structure en HTML', 'ABCDED13', 'P', 'Quelle balise est utilisée pour créer un paragraphe en HTML ?', '<p>', 4, 4),
('Listes en HTML', 'ABCDED14', 'P', 'Dans quelle balise déclare-t-on le titre de la page HTML ?', '<title>', 4, 4),
('Balises d''image en HTML', 'ABCDED15', 'P', "Quelle balise permet d'insérer une image ?", '<img/>', 4, 4),
('Formulaires en HTML', 'ABCDED16', 'P', 'Quelle balise permet de créer un formulaire en HTML ?', '<form>', 4, 4);

-- Etapes pour CSS (sce_id = 5)
INSERT INTO `e22000229_db2`.`T_ETAPE_ETA` (`eta_intitule`, `eta_code`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`)
VALUES
('Sélecteurs CSS', 'ABCDEF12' ,'P', "Quelle est la syntaxe d''un sélecteur CSS pour sélectionner la classe 'contenu'?", '.contenu', 5, 5),
('Propriétés CSS', 'ABCDEF13','P', 'Comment définir la couleur du texte en CSS ?', 'color', 5, 5),
('Box Model en CSS', 'ABCDEF14','P', 'Quelle ligne CSS permet de rendre un élément flex', 'display: flex;', 5, 5),
('Positionnement en CSS', 'ABCDEF15','P', 'Comment positionner un élément en haut à droite de son conteneur en CSS ? (Espace apres les ; et les : seulement)', 'position: absolute; top: 0; right: 0;', 5, 5),
('Couleur hexa', 'ABCDEF16','P', 'Ecrire en hexadecimal la couleure noir (1 octet par couleur)', '#000000', 5, 5);


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