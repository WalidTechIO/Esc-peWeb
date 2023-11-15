<?php

namespace App\Controllers;
use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Compte extends BaseController {

    public function __construct(){
        helper('form');
        $this->model = model(Db_model::class);
    }

    public function creer(){
        if($this->request->getMethod() == "post"){
            if(!$this->validate([
                'pseudo' => 'required|max_length[255]|min_length[2]',
                'mdp' => 'required|max_length[255]|min_length[8]',
                'mdp_conf' => 'required|matches[mdp]',
                'statut' => 'required|regex_match[/([AO])/]',
                'role' => 'required|regex_match[/([AD])/]',
                'email' => 'required|valid_email'
            ],
            [
                'pseudo' => [
                    'required' => 'Renseignez un nom d\'utilisateur !'
                ],
                'mdp' => [
                    'required' => 'Renseignez un mot de passe !',
                    'min_length' => 'Le mot de passe est trop court ! (8 caractères minimum)'
                ],
                'mdp_conf' => [
                    'required' => 'Confirmer votre mot de passe !',
                    'matches' => 'La confirmation du mot de passe est incorrecte !'
                ],
                'statut' => [
                    'required' => 'Renseignez un statut valide !',
                    'regex_match' => 'Le statut n\'est pas valide !'
                ],
                'role' => [
                    'required' => 'Renseignez un rôle valide !',
                    'regex_match' => 'Le rôle n\'est pas valide !'
                ],
                'email' => [
                    'required' => 'Renseignez une adresse email !',
                    'valid_email' => 'Renseignez une adresse email valide !'
                ]
            ])){
                return view('templates/haut') . view('compte/creer') . view('templates/bas');
            }

            $recuperation = $this->validator->getValidated();
            try {
                $this->model->set_compte($recuperation);
            } catch (\CodeIgniter\Database\Exceptions\DatabaseException $e){
                if($e->getCode() == 1062){
                    session()->setFlashdata('error', "Ce pseudo ou cet adresse e-mail sont déjà utilisés !");
                    return redirect()->to(url_to("compte#creer"));
                }
            }
            
            return redirect()->to(url_to('compte#lister'));
        }

        return view('templates/haut') . view('compte/creer') . view('templates/bas');
    }

    public function lister(){

        $data['titre'] = "Liste de tous les comptes";
        $data['comptes'] = $this->model->get_all_compte();

        return view('templates/haut', $data) . view('compte/affichage_comptes') . view('templates/bas');
    }
}