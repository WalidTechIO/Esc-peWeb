<?php

namespace App\Controllers;

use CodeIgniter\Exceptions\PageNotFoundException;

class Actualites extends BaseController {

    public function lister($page = 1){
        if(!$page) $page = 1;

        $data['pages'] = ['max' => ceil($this->model->count_actualites_publiee()/10), "current" => $page];
        if($page > $data['pages']['max']){
            throw new PageNotFoundException("Cette page n'existe pas !");
        }

        $data['actualites'] = $this->model->get_actualites_publiee($page);
        return $this->render('actualite/listing_actualites', $data);
    }

    public function afficher($numero = 0){
        if($numero == 0){
            return redirect()->to('/');
        } else {
            $data['news'] = $this->model->get_actualite($numero);

            return $this->render('actualite/affichage_actualite', $data);
        }
    }

}