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

}