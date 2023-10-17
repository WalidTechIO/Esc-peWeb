-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 17 oct. 2023 à 22:05
-- Version du serveur :  10.5.19-MariaDB-0+deb11u2
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `e22000229_db2`
--

-- --------------------------------------------------------

--
-- Structure de la table `T_ACTUALITE_ACT`
--

CREATE TABLE `T_ACTUALITE_ACT` (
  `act_id` int(11) NOT NULL,
  `act_titre` varchar(255) NOT NULL,
  `act_date` date NOT NULL,
  `act_contenu` text NOT NULL,
  `act_statut` char(1) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_ACTUALITE_ACT`
--

INSERT INTO `T_ACTUALITE_ACT` (`act_id`, `act_titre`, `act_date`, `act_contenu`, `act_statut`, `cpt_id`) VALUES
(1, 'Introduction à Python', '2023-10-16', 'Ceci est un article sur Python.', 'P', 1),
(2, 'JavaScript pour débutants', '2023-10-17', 'Un guide pour commencer avec JavaScript.', 'P', 2),
(3, 'PHP avancé', '2023-10-18', 'Exploration des fonctionnalités avancées de PHP.', 'P', 3),
(4, 'Les bases de la programmation', '2023-10-19', 'Un aperçu des concepts de base de la programmation.', 'P', 4),
(5, 'Sécurité en programmation', '2023-10-20', 'Conseils pour assurer la sécurité dans le code.', 'P', 5),
(6, 'Fondamentaux de JavaScript', '2023-10-21', 'Les bases de la programmation JavaScript.', 'P', 6),
(7, 'Introduction à PHP', '2023-10-22', 'Premiers pas avec PHP.', 'P', 1),
(8, 'Python pour les datascientists', '2023-10-23', 'Utilisation de Python dans l\'analyse de données.', 'P', 2),
(9, 'Les bases de la programmation orientée objet', '2023-10-24', 'Comprendre les concepts de l\'OO.', 'P', 3),
(10, 'Développement web avec JavaScript', '2023-10-25', 'Création de sites web interactifs avec JavaScript.', 'P', 4);

-- --------------------------------------------------------

--
-- Structure de la table `T_COMPTE_CPT`
--

CREATE TABLE `T_COMPTE_CPT` (
  `cpt_id` int(11) NOT NULL,
  `cpt_mail` varchar(255) NOT NULL,
  `cpt_pseudo` varchar(255) NOT NULL,
  `cpt_password` char(64) NOT NULL,
  `cpt_nom` varchar(50) DEFAULT NULL,
  `cpt_prenom` varchar(50) DEFAULT NULL,
  `cpt_statut` char(1) NOT NULL,
  `cpt_role` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_COMPTE_CPT`
--

INSERT INTO `T_COMPTE_CPT` (`cpt_id`, `cpt_mail`, `cpt_pseudo`, `cpt_password`, `cpt_nom`, `cpt_prenom`, `cpt_statut`, `cpt_role`) VALUES
(1, 'admin@escapeweb.fr', 'administrATeur', 'admin23_XEUJ', NULL, NULL, 'A', 'A'),
(2, 'john@doe.fr', 'johndoe', 'motdepasse1', 'Doe', 'John', 'A', 'O'),
(3, 'jane@doe.fr', 'janedoe', 'motdepasse2', 'Doe', 'Jane', 'A', 'O'),
(4, 'jean.pierre@orange.fr', 'jp29200', 'motdepasse3', 'Pierre', 'Jean', 'A', 'O'),
(5, 'walid.elouazizi@univ-brest.fr', 'walid.elouazizi', 'motdepasse4', 'El Ouazizi', 'Walid', 'A', 'O'),
(6, 'will.smith@gmail.com', 'will.smith', 'motdepasse5', 'Smith', 'Will', 'A', 'O');

-- --------------------------------------------------------

--
-- Structure de la table `T_ETAPE_ETA`
--

CREATE TABLE `T_ETAPE_ETA` (
  `eta_id` int(11) NOT NULL,
  `eta_intitule` varchar(255) NOT NULL,
  `eta_statut` char(1) NOT NULL,
  `eta_question` varchar(255) NOT NULL,
  `eta_reponse` varchar(45) NOT NULL,
  `res_id` int(11) NOT NULL,
  `sce_id` int(11) NOT NULL,
  `eta_prochaine_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_ETAPE_ETA`
--

INSERT INTO `T_ETAPE_ETA` (`eta_id`, `eta_intitule`, `eta_statut`, `eta_question`, `eta_reponse`, `res_id`, `sce_id`, `eta_prochaine_id`) VALUES
(1, 'Affichage en PHP', 'P', 'Quelle fonction de PHP permet d\'afficher sur la sortie standard ?', 'echo', 1, 1, NULL),
(2, 'Variables en PHP', 'P', 'Quelle est le signe que l\'on met devant une var en php ?', '$', 1, 1, NULL),
(3, 'Conditions en PHP', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en PHP ? (mot clé seul)', 'if', 1, 1, NULL),
(4, 'Boucles en PHP', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en PHP ? (mot clé seul)', 'for', 1, 1, NULL),
(5, 'Fonctions en PHP', 'P', 'Avec quel mot clé déclare-t-on une fonction en PHP? (mot clé seul)', 'function', 1, 1, NULL),
(6, 'Variables en JavaScript', 'P', 'Quelle méthode permet d\'ecrire dans la console en JavaScript ?', 'console.log()', 2, 2, NULL),
(7, 'Fonctions en JavaScript', 'P', 'Comment définir une fonction en JavaScript ? (mot clé seul)', 'function', 2, 2, NULL),
(8, 'Objets en JavaScript', 'P', 'Ecrire l\'objet vide en JS', '{}', 2, 2, NULL),
(9, 'Conditions en JavaScript', 'P', 'Quelle structure de contrôle est utilisée pour les conditions en JavaScript ? (mot clé seul)', 'if', 2, 2, NULL),
(10, 'Boucles en JavaScript', 'P', 'Quelle boucle est utilisée pour répéter une instruction un nb de fois prédéfini en JavaScript ? (mot clé seul)', 'for', 2, 2, NULL),
(11, 'Requêtes permettant de trouver des donées', 'P', 'Mot clé pour retrouver des donées', 'SELECT', 3, 3, NULL),
(12, 'Retrouver tout une table en SQL', 'P', 'Requete qui récupère tout sur les utilisateurs (table: \'compte\')', 'SELECT * FROM compte;', 3, 3, NULL),
(13, 'Requêtes de suppression en SQL', 'P', 'Quelle est le mot clé qui permet la suppression d\'une ligne en SQL', 'DELETE', 3, 3, NULL),
(14, 'Requêtes de mise a jour en SQL', 'P', 'Quelle est le mot clé qui permet la maj d\'une ligne en SQL', 'UPDATE', 3, 3, NULL),
(15, 'Clauses WHERE en SQL', 'P', 'Quelle est le mot clé qui permet de filtrer les résultats d\'une requete ?', 'WHERE;', 3, 3, NULL),
(16, 'Balises HTML', 'P', 'Quelle balise est utilisée pour créer un lien hypertexte en HTML ?', '<a>', 4, 4, NULL),
(17, 'Balises de structure en HTML', 'P', 'Quelle balise est utilisée pour créer un paragraphe en HTML ?', '<p>', 4, 4, NULL),
(18, 'Listes en HTML', 'P', 'Dans quelle balise déclare-t-on le titre de la page HTML ?', '<title>', 4, 4, NULL),
(19, 'Balises d\'image en HTML', 'P', 'Quelle balise permet d\'insérer une image ?', '<img/>', 4, 4, NULL),
(20, 'Formulaires en HTML', 'P', 'Quelle balise permet de créer un formulaire en HTML ?', '<form>', 4, 4, NULL),
(21, 'Sélecteurs CSS', 'P', 'Quelle est la syntaxe d\'\'un sélecteur CSS pour sélectionner la classe \'contenu\'?', '.contenu', 5, 5, NULL),
(22, 'Propriétés CSS', 'P', 'Comment définir la couleur du texte en CSS ?', 'color', 5, 5, NULL),
(23, 'Box Model en CSS', 'P', 'Quelle ligne CSS permet de rendre un élément flex', 'display: flex;', 5, 5, NULL),
(24, 'Positionnement en CSS', 'P', 'Comment positionner un élément en haut à droite de son conteneur en CSS ? (Espace apres les ; et les : seulement)', 'position: absolute; top: 0; right: 0;', 5, 5, NULL),
(25, 'Couleur hexa', 'P', 'Ecrire en hexadecimal la couleure noir (1 octet par couleur)', '#000000', 5, 5, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `T_INDICE_IND`
--

CREATE TABLE `T_INDICE_IND` (
  `ind_id` int(11) NOT NULL,
  `ind_texte` varchar(255) NOT NULL,
  `ind_lien` varchar(255) NOT NULL,
  `ind_niveau` int(11) NOT NULL,
  `eta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_INDICE_IND`
--

INSERT INTO `T_INDICE_IND` (`ind_id`, `ind_texte`, `ind_lien`, `ind_niveau`, `eta_id`) VALUES
(1, 'Pour afficher du texte en PHP, utilisez la fonction echo.', 'https://www.php.net/manual/en/function.echo.php', 1, 13),
(2, 'En JavaScript, console.log() est utilisé pour afficher des messages dans la console.', 'https://developer.mozilla.org/en-US/docs/Web/API/Console/log', 1, 14),
(3, 'Dans SQL, utilisez SELECT * FROM table pour récupérer toutes les lignes de la table.', 'https://www.w3schools.com/sql/sql_select.asp', 2, 15),
(4, 'En HTML, la balise <a> est utilisée pour créer des liens hypertexte.', 'https://www.w3schools.com/html/html_links.asp', 2, 16),
(5, 'CSS utilise la propriété color pour définir la couleur du texte.', 'https://developer.mozilla.org/en-US/docs/Web/CSS/color', 2, 17),
(6, 'En PHP, le signe $ est utilisé pour déclarer une variable.', 'https://www.php.net/manual/en/language.variables.basics.php', 3, 18),
(7, 'JavaScript utilise la structure de contrôle if...else pour les conditions.', 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/if...else', 3, 19),
(8, 'SQL utilise le mot clé WHERE pour filtrer les résultats d\'une requête.', 'https://www.w3schools.com/sql/sql_where.asp', 3, 20),
(9, 'Les balises HTML <p> sont utilisées pour créer des paragraphes.', 'https://www.w3schools.com/html/html_paragraphs.asp', 1, 21),
(10, 'En CSS, display: flex; permet de rendre un élément flex.', 'https://developer.mozilla.org/en-US/docs/Web/CSS/display', 1, 22);

-- --------------------------------------------------------

--
-- Structure de la table `T_PARTICIPANT_PNT`
--

CREATE TABLE `T_PARTICIPANT_PNT` (
  `pnt_id` int(11) NOT NULL,
  `pnt_mail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_PARTICIPANT_PNT`
--

INSERT INTO `T_PARTICIPANT_PNT` (`pnt_id`, `pnt_mail`) VALUES
(2, 'challenger29@gmail.com'),
(1, 'jeremey292@orange.fr'),
(4, 'john@doe.fr'),
(3, 'superdev@outlook.fr'),
(5, 'walid@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `T_PARTICIPATION_PON`
--

CREATE TABLE `T_PARTICIPATION_PON` (
  `pnt_id` int(11) NOT NULL,
  `sce_id` int(11) NOT NULL,
  `pon_date_reussite` date NOT NULL,
  `pon_date_derniere_participation` date NOT NULL,
  `pon_difficulte_max_reussie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_PARTICIPATION_PON`
--

INSERT INTO `T_PARTICIPATION_PON` (`pnt_id`, `sce_id`, `pon_date_reussite`, `pon_date_derniere_participation`, `pon_difficulte_max_reussie`) VALUES
(1, 1, '2023-10-16', '2023-10-15', 3),
(1, 5, '2023-10-25', '2023-10-24', 5),
(2, 1, '2023-10-21', '2023-10-20', 2),
(2, 2, '2023-10-17', '2023-10-16', 2),
(3, 1, '2023-10-26', '2023-10-25', 3),
(3, 2, '2023-10-22', '2023-10-21', 3),
(3, 3, '2023-10-18', '2023-10-17', 4),
(4, 2, '2023-10-27', '2023-10-26', 2),
(4, 3, '2023-10-23', '2023-10-22', 4),
(4, 4, '2023-10-19', '2023-10-18', 1),
(5, 4, '2023-10-24', '2023-10-23', 1),
(5, 5, '2023-10-20', '2023-10-19', 5);

-- --------------------------------------------------------

--
-- Structure de la table `T_RESSOURCE_RES`
--

CREATE TABLE `T_RESSOURCE_RES` (
  `res_id` int(11) NOT NULL,
  `res_type` varchar(255) NOT NULL,
  `res_chemin` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_RESSOURCE_RES`
--

INSERT INTO `T_RESSOURCE_RES` (`res_id`, `res_type`, `res_chemin`) VALUES
(1, 'Image', 'documents/php.jpg'),
(2, 'Image', 'documents/javascript.jpg'),
(3, 'Image', 'documents/sql.jpg'),
(4, 'Image', 'documents/html.jpg'),
(5, 'Image', 'documents/css.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `T_SCENARIO_SCE`
--

CREATE TABLE `T_SCENARIO_SCE` (
  `sce_id` int(11) NOT NULL,
  `sce_intitule` varchar(45) NOT NULL,
  `sce_statut` char(1) NOT NULL,
  `sce_code` char(8) NOT NULL,
  `cpt_id` int(11) NOT NULL,
  `res_id` int(11) DEFAULT NULL,
  `eta_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `T_SCENARIO_SCE`
--

INSERT INTO `T_SCENARIO_SCE` (`sce_id`, `sce_intitule`, `sce_statut`, `sce_code`, `cpt_id`, `res_id`, `eta_id`) VALUES
(1, 'Scénario PHP', 'P', 'NARIOPHP', 2, NULL, NULL),
(2, 'Scénario JavaScript', 'P', 'VASCRIPT', 3, NULL, NULL),
(3, 'Scénario SQL', 'P', 'NARIOSQL', 4, NULL, NULL),
(4, 'Scénario HTML', 'P', 'ARIOHTML', 5, NULL, NULL),
(5, 'Scénario CSS', 'P', 'NARIOCSS', 6, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `T_ACTUALITE_ACT`
--
ALTER TABLE `T_ACTUALITE_ACT`
  ADD PRIMARY KEY (`act_id`),
  ADD KEY `AtualiteUtilisateurFK1_idx` (`cpt_id`);

--
-- Index pour la table `T_COMPTE_CPT`
--
ALTER TABLE `T_COMPTE_CPT`
  ADD PRIMARY KEY (`cpt_id`),
  ADD UNIQUE KEY `mail_UNIQUE` (`cpt_mail`),
  ADD UNIQUE KEY `pseudo_UNIQUE` (`cpt_pseudo`);

--
-- Index pour la table `T_ETAPE_ETA`
--
ALTER TABLE `T_ETAPE_ETA`
  ADD PRIMARY KEY (`eta_id`),
  ADD KEY `EtapeRessourceFK1_idx` (`res_id`),
  ADD KEY `EtapeScenarioFK1_idx` (`sce_id`),
  ADD KEY `EtapeEtapeFK1_idx` (`eta_prochaine_id`);

--
-- Index pour la table `T_INDICE_IND`
--
ALTER TABLE `T_INDICE_IND`
  ADD PRIMARY KEY (`ind_id`),
  ADD KEY `EtapeIndiceFK1_idx` (`eta_id`);

--
-- Index pour la table `T_PARTICIPANT_PNT`
--
ALTER TABLE `T_PARTICIPANT_PNT`
  ADD PRIMARY KEY (`pnt_id`),
  ADD UNIQUE KEY `mail_UNIQUE` (`pnt_mail`);

--
-- Index pour la table `T_PARTICIPATION_PON`
--
ALTER TABLE `T_PARTICIPATION_PON`
  ADD PRIMARY KEY (`pnt_id`,`sce_id`),
  ADD KEY `ParticipationScenarioFK2_idx` (`sce_id`);

--
-- Index pour la table `T_RESSOURCE_RES`
--
ALTER TABLE `T_RESSOURCE_RES`
  ADD PRIMARY KEY (`res_id`);

--
-- Index pour la table `T_SCENARIO_SCE`
--
ALTER TABLE `T_SCENARIO_SCE`
  ADD PRIMARY KEY (`sce_id`),
  ADD KEY `ScfenarioUtilisateurFK1_idx` (`cpt_id`),
  ADD KEY `ScenarioRessourceFK2_idx` (`res_id`),
  ADD KEY `ScenarioEtapeFK_idx` (`eta_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `T_ACTUALITE_ACT`
--
ALTER TABLE `T_ACTUALITE_ACT`
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `T_COMPTE_CPT`
--
ALTER TABLE `T_COMPTE_CPT`
  MODIFY `cpt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `T_ETAPE_ETA`
--
ALTER TABLE `T_ETAPE_ETA`
  MODIFY `eta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `T_INDICE_IND`
--
ALTER TABLE `T_INDICE_IND`
  MODIFY `ind_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `T_PARTICIPANT_PNT`
--
ALTER TABLE `T_PARTICIPANT_PNT`
  MODIFY `pnt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `T_PARTICIPATION_PON`
--
ALTER TABLE `T_PARTICIPATION_PON`
  MODIFY `pnt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `T_RESSOURCE_RES`
--
ALTER TABLE `T_RESSOURCE_RES`
  MODIFY `res_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `T_SCENARIO_SCE`
--
ALTER TABLE `T_SCENARIO_SCE`
  MODIFY `sce_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `T_ACTUALITE_ACT`
--
ALTER TABLE `T_ACTUALITE_ACT`
  ADD CONSTRAINT `AtualiteUtilisateurFK` FOREIGN KEY (`cpt_id`) REFERENCES `T_COMPTE_CPT` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `T_ETAPE_ETA`
--
ALTER TABLE `T_ETAPE_ETA`
  ADD CONSTRAINT `EtapeEtapeFK` FOREIGN KEY (`eta_prochaine_id`) REFERENCES `T_ETAPE_ETA` (`eta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `EtapeRessourceFK` FOREIGN KEY (`res_id`) REFERENCES `T_RESSOURCE_RES` (`res_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `EtapeScenarioFK` FOREIGN KEY (`sce_id`) REFERENCES `T_SCENARIO_SCE` (`sce_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `T_INDICE_IND`
--
ALTER TABLE `T_INDICE_IND`
  ADD CONSTRAINT `EtapeIndiceFK` FOREIGN KEY (`eta_id`) REFERENCES `T_ETAPE_ETA` (`eta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `T_PARTICIPATION_PON`
--
ALTER TABLE `T_PARTICIPATION_PON`
  ADD CONSTRAINT `ParticipationParticipantFK` FOREIGN KEY (`pnt_id`) REFERENCES `T_PARTICIPANT_PNT` (`pnt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ParticipationScenarioFK` FOREIGN KEY (`sce_id`) REFERENCES `T_SCENARIO_SCE` (`sce_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `T_SCENARIO_SCE`
--
ALTER TABLE `T_SCENARIO_SCE`
  ADD CONSTRAINT `ScenarioEtapeFK` FOREIGN KEY (`eta_id`) REFERENCES `T_ETAPE_ETA` (`eta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ScenarioRessourceFK` FOREIGN KEY (`res_id`) REFERENCES `T_RESSOURCE_RES` (`res_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ScenarioUtilisateurFK` FOREIGN KEY (`cpt_id`) REFERENCES `T_COMPTE_CPT` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
