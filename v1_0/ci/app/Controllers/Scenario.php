<?php

namespace App\Controllers;

use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Scenario extends BaseController {

    public function afficher_scenarii(){
        $model = model(Db_model::class);

        $data['scenarii'] = $model->get_scenarii();

        return view('templates/haut', $data) . view('affichage_scenarii') . view('templates/bas');
    }

    public function premiere_etape($code, $niveau = 1) {
        $model = model(Db_model::class);
        if($niveau>3) $niveau = 3;
        if($niveau<1) $niveau = 1;
        $data['etape'] = $model->get_first_step(htmlentities($code), $niveau);
        if(!$data['etape']) throw new PageNotFoundException("Ce scénario n'existe pas ou sa première étape n'est pas configurée !");
        return view('templates/haut', $data) . view('affichage_etape') . view('templates/bas');
    }

}