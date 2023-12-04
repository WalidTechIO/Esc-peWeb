<?php
namespace App\Models;

use CodeIgniter\Model;

use CodeIgniter\Database\ConnectionInterface;

class Db_model extends Model {

    /**
     * Variable d'instance stockant la connexion à la BD
     */
    protected $db;

    /**
     * Variable d'instance stockant le sel pour les méthodes d'inscription et de connexion (On pourrait facilement changer poru le recuperer depuis une var d'environnement)
     */
    private $salt;
    
    /**
     * Constructeur de notre model
     * Initialise la BDD et le sel pour mot de passe
     */
    public function __construct() {
        $this->db = db_connect();
        $this->salt = "SelPOUrMd5d5e6pass_";
    }

    /**
     * @param int Le numéro de la page a spécifier dans la requête
     * @return Array Tableau contenant les 10 dernieres actualites puis offset de 10 via $page
     */
    public function get_actualites_publiee($page){
        $offset = ($page-1) * 5;
        $resultat = $this->db->query("SELECT * FROM T_ACTUALITE_ACT JOIN T_COMPTE_CPT USING(cpt_id) WHERE act_statut = 'P' ORDER BY act_date DESC LIMIT 5 OFFSET $offset;");
        return $resultat->getResultArray();
    }

    /**
     * @return int Nb total d'actualités publiées
     */
    public function count_actualites_publiee(){
        $resultat = $this->db->query("SELECT COUNT(*) AS total FROM T_ACTUALITE_ACT WHERE act_statut = 'P';")->getRow()->total;
        return intval($resultat);
    }

    /**
     * @param Actualite avec infos mis a jour
     * Met a jour l'actualite correspondante en BDD
     */
    public function update_actualite($params){
        $id = $params['act_id'];
        $titre = $params['act_titre'];
        $contenu = $params['act_contenu'];
        $statut = $params['act_statut'];
        $this->db->query("UPDATE T_ACTUALITE_ACT SET act_titre = \"$titre\", act_statut = '$statut', act_contenu = \"$contenu\" WHERE act_id = $id;");
    }

    /**
     * @param int id de l'actualité a selectionner
     * @return Actualite|null actualité trouvé ou NULL
     */
    public function get_actualite($id){
        return $this->db->query("SELECT * FROM T_ACTUALITE_ACT JOIN T_COMPTE_CPT USING(cpt_id) WHERE act_id = $id")->getRowArray();
    }

    /**
     * @return Array Liste des comptes
     */
    public function get_all_compte(){
        return $this->db->query("SELECT cpt_id, cpt_mail, cpt_pseudo, cpt_nom, cpt_prenom, cpt_statut, cpt_role FROM T_COMPTE_CPT ORDER BY cpt_statut;")->getResultArray();
    }

    /**
     * @param String Le pseudo du compte a recuperer
     * @return Array Un compte
     */
    public function get_compte($pseudo){
        return $this->db->query("SELECT cpt_id, cpt_mail, cpt_pseudo, cpt_nom, cpt_prenom, cpt_statut, cpt_role FROM T_COMPTE_CPT WHERE cpt_pseudo = \"" . $pseudo . "\";")->getRowArray();
    }

    /**
     * @return int Nombre de comptes
     */
    public function count_compte(){
        return intval($this->db->query("SELECT COUNT(*) AS total FROM T_COMPTE_CPT;")->getRow()->total);
    }

    /**
     * @param Array données du nouveau compte validée
     * Crée un compte a partir des infos spécifiés
     */
    public function set_compte($data){
        if(isset($data['pseudo']) && isset($data['mdp']) && isset($data['statut']) && isset($data['role']) && isset($data['email']) && isset($data['prenom']) && isset($data['nom'])){
            $data['mdp'] = hash('sha256', $this->salt.$data['mdp']);
            $this->db->query("INSERT INTO T_COMPTE_CPT (cpt_nom, cpt_prenom, cpt_pseudo, cpt_mail, cpt_password, cpt_statut, cpt_role) VALUES (\"" . $data['nom'] . "\", \"" . $data['prenom'] . "\", \"" . $data['pseudo'] . "\", \"" . $data['email'] . "\", \"" . $data['mdp'] . "\", \"" . $data['statut'] . "\", \"" . $data['role'] . "\");");
        }
    }

    /**
     * @return Array Liste des scenariis publiés
     */
    public function get_scenarii(){
        $results = $this->db->query("SELECT * FROM T_SCENARIO_SCE JOIN T_COMPTE_CPT USING(cpt_id) LEFT JOIN T_RESSOURCE_RES USING(res_id) WHERE sce_statut = 'P';")->getResultArray();
        return $results;
    }

    /**
     * @param String Code du scenario
     * @param int Niveau de difficulté souhaité pour le choix de l'indice
     * @return Array Les infos du scénario de sa première étape et de l'indice associé si existant
     */
    public function get_first_step($code, $niveau) {
        $result = $this->db->query("SELECT * FROM T_SCENARIO_SCE AS sce LEFT JOIN T_ETAPE_ETA AS eta ON eta.sce_id=sce.sce_id AND eta.eta_id=sce.eta_id LEFT JOIN T_INDICE_IND AS ind ON ind.eta_id=eta.eta_id AND ind_niveau=$niveau WHERE sce_code='$code' AND sce_statut='P';")->getRowArray();
        return $result;
    }

    /**
     * @param String Pseudo de l'utilisateur a connecté
     * @param String Mot de passe en clair de l'utilisateur a connecté
     * @return bool Vrai si compte actif et identifiants correct, faux sinon
     */
    public function connect_compte($pseudo, $password) {
        $password = hash('sha256', $this->salt.$password);
        return $this->db->query("SELECT * FROM T_COMPTE_CPT WHERE cpt_pseudo = \"" . $pseudo . "\" AND cpt_password = \"" . $password . "\" AND cpt_statut = 'A';")->getNumRows() == 1;
    }

    /**
     * @param Array Données de l'utilisateur a mettre a jour
     * @return Statut de la requete
     */
    public function update_compte($data){
        $password = hash('sha256', $this->salt.$data['mdp_conf']);
        $pseudo = $data['pseudo'];
        $mail = $data['mail'];
        $prenom = $data['prenom'];
        $nom = $data['nom'];
        return $this->db->query("UPDATE T_COMPTE_CPT SET cpt_nom = \"".$nom. "\", cpt_prenom = \"".$prenom. "\", cpt_mail = '$mail', cpt_password = '$password' WHERE cpt_pseudo = \"$pseudo\"");
    }

    /**
     * @return Array Liste des scenariis publiés
     */
    public function get_scenarii_org($pseudo){
        $results = $this->db->query("SELECT * FROM T_SCENARIO_SCE JOIN T_COMPTE_CPT USING(cpt_id) LEFT JOIN T_RESSOURCE_RES USING(res_id) ORDER BY (cpt_pseudo = \"$pseudo\") DESC;")->getResultArray();
        return $results;
    }

    /**
     * @return Int Nombre d'etapes active selon l'id d'un scénario
     */
    public function get_nb_etapes($sceid){
        return intval($this->db->query("SELECT nbEtapeSce($sceid) AS count;")->getRow()->count);
    }

    /**
     * @param String code du scénario a recuperer
     * @return Scenario
     */
    public function get_scenario($code){
        $scenario = $this->db->query("SELECT * FROM T_SCENARIO_SCE JOIN T_COMPTE_CPT USING(cpt_id) JOIN T_RESSOURCE_RES USING(res_id) WHERE sce_code = '$code';")->getRowArray();
        if($scenario) $scenario['etapes'] = $this->db->query("SELECT * FROM T_ETAPE_ETA WHERE sce_id = " . $scenario['sce_id'] . ";")->getResultArray();
        return $scenario;
    }

    /**
     * @param String intitule du scenario a creer
     * @param char Statut du scenario a creer (P|C)
     * @param int ID du createur du scenario
     * @param String chemin de l'image du scenario sur le serveur
     */
    public function create_scenario($intitule, $statut, $uid, $filename){
        //Creer res -> Recup id res -> Insert scenario | -> Procedure SQL ?
        $this->db->query("INSERT INTO T_RESSOURCE_RES (res_type, res_chemin) VALUES ('Image', 'images/$filename')");
        $resid = $this->db->query("SELECT res_id FROM T_RESSOURCE_RES WHERE res_chemin = \"images/$filename\"")->getRowArray()['res_id'];
        $this->db->query("INSERT INTO T_SCENARIO_SCE (sce_intitule, sce_statut, cpt_id, res_id) VALUES (\"$intitule\", \"$statut\", $uid, $resid);");
    }

    /**
     * @param Int ID du scenario a supprimer
     * Supprime le scenario ses participations, indices et etapes
     */
    public function delete_scenario($id){
        //2e procedure ?
        $this->db->query("CALL suppressionScenario($id)");
    }

    /**
     * @param int ID de l'etape pour laquelle on veut le code de la suivante
     * @return String|null code de la prochaine etape ou null si il n'y en a pas
     */
    public function get_code_next_etape($id){
        $etape = $this->db->query("SELECT eta_code FROM T_ETAPE_ETA WHERE eta_id = $id;")->getRow();
        if($etape){
            return $etape->eta_code;
        } else {
            return $etape;
        }
    }

    /**
     * @param String code de l'etape a recuperer
     * @param int niveau dans lequel le particpant joue afin de recuperer le bon indice si il existe
     * @return Etape l'etape delande avec les infos de son scenario et de son indice 
     */
    public function get_etape($code, $niveau){
        return $this->db->query("SELECT * FROM T_ETAPE_ETA JOIN T_SCENARIO_SCE USING(sce_id) LEFT JOIN T_INDICE_IND ON ind_niveau = $niveau AND T_ETAPE_ETA.eta_id = T_INDICE_IND.eta_id WHERE eta_code = \"$code\" AND eta_statut = 'P'")->getRowArray();
    }

    /**
     * @param String code de l'etape pour laquelle on veut le code de la precedente
     * @return String|null code de l'etape precedente ou null si il n'y en a pas
     */
    public function get_code_prev_etape($code){
        $code = $this->db->query("SELECT eta_code FROM T_ETAPE_ETA WHERE eta_prochaine_id = (SELECT eta_id FROM T_ETAPE_ETA WHERE eta_code = \"$code\" AND eta_statut = 'P');")->getRow();
        if($code){
            return $code->eta_code;
        } else {
            return $code;
        }
    }

    /**
     * @param String mail du participant
     * @param int ID du scénario
     * @param int niveau de difficulté choisi par le participant
     * Crée un participant si necessaire puis ajoute/met a jour sa participation au scenario reçu en parametre.
     */
    public function set_participation($mail, $sce_id, $niveau){
        $participant = $this->db->query("SELECT  * FROM T_PARTICIPANT_PNT WHERE pnt_mail = \"$mail\";")->getRowArray();
        if(!$participant){
            //Creer participant puis ajouter participation
            $this->db->query("INSERT INTO T_PARTICIPANT_PNT (pnt_mail) VALUES (\"$mail\")");
            $participant = $this->db->query("SELECT * FROM T_PARTICIPANT_PNT WHERE pnt_mail = \"$mail\";")->getRowArray();
            $this->db->query("INSERT INTO T_PARTICIPATION_PON (pnt_id, sce_id, pon_date_reussite, pon_date_derniere_participation, pon_difficulte_max_reussie) VALUES (" . $participant['pnt_id'] .", $sce_id, NOW(), NOW(), $niveau);");
        } else {
            $participation = $this->db->query("SELECT * FROM T_PARTICIPATION_PON WHERE pnt_id = " . $participant['pnt_id'] . " AND sce_id = $sce_id;")->getRowArray();
            if($participation){
                //Mettre a jour participation
                if($niveau > $participation['pon_difficulte_max_reussie']){
                    $this->db->query("UPDATE T_PARTICIPATION_PON SET pon_difficulte_max_reussie = $niveau, pon_date_derniere_participation = NOW() WHERE pnt_id = " . $participant['pnt_id'] . " AND sce_id = $sce_id;");
                } else {
                    $this->db->query("UPDATE T_PARTICIPATION_PON SET pon_date_derniere_participation = NOW() WHERE pnt_id = " . $participant['pnt_id'] . " AND sce_id = $sce_id;");
                }
            } else {
                //Creer participation
                $this->db->query("INSERT INTO T_PARTICIPATION_PON (pnt_id, sce_id, pon_date_reussite, pon_date_derniere_participation, pon_difficulte_max_reussie) VALUES (" . $participant['pnt_id'] .", $sce_id, NOW(), NOW(), $niveau);");
            }
        }
    }

}
