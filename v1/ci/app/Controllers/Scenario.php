<?php

namespace App\Controllers;

use App\Models\Db_model;

class Scenario extends BaseController {

    public function afficher_scenarii(){
        $model = model(Db_model::class);

        $data['scenarii'] = $model->get_scenarii();

        return view('templates/haut', $data) . view('affichage_scenarii') . view('templates/bas');
    }

}