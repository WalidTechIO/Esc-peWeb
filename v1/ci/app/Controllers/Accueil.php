<?php

namespace App\Controllers;

use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Accueil extends BaseController {

    public function afficher(){
        return view('templates/haut') . view('affichage_accueil') . view('templates/bas');
    }

}