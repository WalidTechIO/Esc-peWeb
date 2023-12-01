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
        $offset = ($page-1) * 10;
        $resultat = $this->db->query("SELECT * FROM T_ACTUALITE_ACT JOIN T_COMPTE_CPT USING(cpt_id) WHERE act_statut = 'P' ORDER BY act_date DESC LIMIT 10 OFFSET $offset;");
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
        //dd("SELECT nbEtapeSce($sceid);");
        return intval($this->db->query("SELECT nbEtapeSce($sceid) AS count;")->getRow()->count);
    }

}