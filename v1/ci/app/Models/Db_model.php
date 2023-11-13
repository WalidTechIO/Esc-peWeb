<?php
namespace App\Models;

use CodeIgniter\Model;

use CodeIgniter\Database\ConnectionInterface;

class Db_model extends Model {

    protected $db;
    
    public function __construct() {
        $this->db = db_connect();
    }

    /**
     * @param int $page Le numéro de la page a spécifier dans la requête
     * @return Array Tableau contenant les 10 dernieres actualites puis offset de 10 via $page
     */
    public function get_actualites_publiee($page){
        $offset = ($page-1) * 10;
        $resultat = $this->db->query("SELECT * FROM T_ACTUALITE_ACT WHERE act_statut = 'P' ORDER BY act_date DESC LIMIT 10 OFFSET $offset;");
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
     * @param $params Actualite avec infos mis a jour
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
        return $this->db->query("SELECT * FROM T_ACTUALITE_ACT WHERE act_id = $id")->getRowArray();
    }

    public function get_all_compte(){
        return $this->db->query("SELECT cpt_pseudo FROM T_COMPTE_CPT;")->getResultArray();
    }

    public function count_compte(){
        return intval($this->db->query("SELECT COUNT(*) AS total FROM T_COMPTE_CPT;")->getRow()->total);
    }

    public function get_scenarii(){
        $results = $this->db->query("SELECT * FROM T_SCENARIO_SCE JOIN T_COMPTE_CPT USING(cpt_id) LEFT JOIN T_RESSOURCE_RES USING(res_id) WHERE sce_statut = 'P';")->getResultArray();
        return $results;
    }

    public function get_first_step($code, $niveau) {
        $result = $this->db->query("SELECT * FROM T_ETAPE_ETA LEFT JOIN T_RESSOURCE_RES USING(res_id) WHERE eta_id = (SELECT eta_id FROM T_SCENARIO_SCE WHERE sce_code = '$code') AND eta_statut = 'P'")->getRowArray();
        $result['indice'] = $this->db->query("SELECT * FROM T_INDICE_IND WHERE eta_id = " . $result['eta_id'] . " AND ind_niveau = $niveau")->getRowArray();
        return $result;
    }

}