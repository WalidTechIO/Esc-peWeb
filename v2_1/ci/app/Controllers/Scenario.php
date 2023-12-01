<?php

namespace App\Controllers;

use CodeIgniter\Exceptions\PageNotFoundException;

class Scenario extends BaseController {

    public function afficher_scenarii(){
        $data['scenarii'] = $this->model->get_scenarii();
        return $this->render('scenario/affichage_scenarii', $data);
    }

    public function premiere_etape($code, $niveau = 1) {
        $data['etape'] = $this->model->get_first_step(htmlentities($code), $niveau);
        if(!$data['etape']){  
            return redirect()->to(url_to("scenarii#afficher")); 
        }
        return $this->render('etape/affichage_etape', $data);
    }

    public function recapituler_scenariis(){
        if(session()->has('user') && session()->get('user')['role'] == 'O'){
            $data['scenarii'] = $this->model->get_scenarii_org(session()->get('user')['pseudo']);
            foreach($data['scenarii'] as $k => $v){
                $data['scenarii'][$k]['nb_etapes'] = $this->model->get_nb_etapes($v['sce_id']);
            }
            return $this->render('scenario/recapituler', $data);
        }
        session()->setFlashdata('error', "Vous n'êtes pas connecté ou n'avez pas les droits !");
        return redirect()->to(url_to('compte#connecter'));
    }

}