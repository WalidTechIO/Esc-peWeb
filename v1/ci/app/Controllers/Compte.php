<?php

namespace App\Controllers;
use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Compte extends BaseController {

    public function lister(){
        $model = model(Db_model::class);

        $data['titre'] = "Liste de tous les comptes";
        $data['logins'] = $model->get_all_compte();

        return view('templates/haut', $data) . view('affichage_comptes') . view('templates/bas');
    }
}