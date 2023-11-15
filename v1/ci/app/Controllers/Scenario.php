<?php

namespace App\Controllers;

use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Scenario extends BaseController {

    public function __construct(){
        $this->model = model(Db_model::class);
    }

    public function afficher_scenarii(){
        $data['scenarii'] = $this->model->get_scenarii();
        return view('templates/haut', $data) . view('affichage_scenarii') . view('templates/bas');
    }

    public function premiere_etape($code, $niveau = 1) {
        $data['etape'] = $this->model->get_first_step(htmlentities($code), $niveau);
        if(!$data['etape']) throw new PageNotFoundException("Ce scénario n'existe pas !");
        if(!$data['etape']['eta_question']) throw new PageNotFoundException("Ce scénario n'a pas de première étape !");
        return view('templates/haut', $data) . view('affichage_etape') . view('templates/bas');
    }

}