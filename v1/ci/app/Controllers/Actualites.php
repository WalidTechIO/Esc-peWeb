<?php

namespace App\Controllers;

use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Actualites extends BaseController {

    public function listing($page = 1){

        if(!$page) $page = 1;

        $model = model(Db_model::class);

        if($page > ceil($model->count_actualites_publiee()/10)){
            throw new PageNotFoundException("Cette page n'existe pas !");
        }

        $data['actualites'] = $model->get_actualites_publiee($page);
        return view('templates/haut', $data) . view('listing_actualites') . view('templates/bas');
    }

    public function afficher($numero = 0){
        $model = model(Db_model::class);
        if($numero == 0){
            return redirect()->to('/');
        } else {
            $data['titre'] = 'Actualité :';
            $data['news'] = $model->get_actualite($numero);

            return view('templates/haut', $data) . view('affichage_actualite') . view('templates/bas');
        }
    }

}