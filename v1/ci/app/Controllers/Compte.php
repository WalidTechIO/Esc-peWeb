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
                'mdp_conf' => 'required|max_length[255]|min_length[8]',
                'statut' => 'required',
                'role' => 'required',
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
                    'min_length' => 'La confirmation du mot de passe est trop courte ! (8 caractères minimum)'
                ],
                'statut' => [
                    'required' => 'Renseignez un statut valide !'
                ],
                'role' => [
                    'required' => 'Renseignez un rôle valide !'
                ],
                'email' => [
                    'required' => 'Renseignez une adresse email !',
                    'valid_email' => 'Renseignez une adresse email valide !'
                ]
            ])){
                return view('templates/haut') . view('compte/creer') . view('templates/bas');
            }

            $recuperation = $this->validator->getValidated();

            if($recuperation['mdp'] != $recuperation['mdp_conf']){
                session()->setFlashdata('errorPassConfirmation', 'Le mot de passe et la confirmation du mot de passe ne correspondent pas !');
                return view('templates/haut') . view('compte/creer') . view('templates/bas');
            }
            //try {
                $this->model->set_compte($recuperation);
            /*} catch(mysqli_sql_exception $e) {
                if($e->getCode() == 1062){
                    session()->setFlashdata('error', 'Ce pseudo ou cette adresse email est déjà utilisé !');
                    return view('templates/haut') . view('compte/creer') . view('templates/bas');
                }
            }*/
            $data['pseudo'] = $recuperation['pseudo'];
            return view('templates/haut', $data) . view('compte/creer_succes') . view('templates/bas');
        }

        return view('templates/haut') . view('compte/creer') . view('templates/bas');
    }

    public function lister(){

        $data['titre'] = "Liste de tous les comptes";
        $data['logins'] = $this->model->get_all_compte();

        return view('templates/haut', $data) . view('compte/affichage_comptes') . view('templates/bas');
    }
}