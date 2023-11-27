<?php

namespace App\Controllers;
use CodeIgniter\Exceptions\PageNotFoundException;

class Compte extends BaseController {

    public function __construct(){
        helper('form');
    }
    
    public function creer(){
        $data['title'] = 'Créer un compte';
        if($this->request->getMethod() == "post"){
            if(!$this->validate([
                'pseudo' => 'required|max_length[255]|min_length[2]',
                'mdp' => 'required|max_length[255]|min_length[8]',
                'mdp_conf' => 'required|matches[mdp]',
                'statut' => 'required|regex_match[/[AO]/]',
                'role' => 'required|regex_match[/[AD]/]',
                'email' => 'required|valid_email',
                'prenom' => 'required|min_length[2]|alpha_space',
                'nom' => 'required|min_length[2]|alpha_space'
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
                ],
                'prenom' => [
                    'required' => "Renseignez un prénom",
                    'alpha_space' => "Votre prénom doit contenir uniquement des lettres ou espace"
                ],
                'nom' => [
                    'required' => "Renseignez un prénom",
                    'alpha_space' => "Votre prénom doit contenir uniquement des lettres ou espace"
                ]
            ])){
                return $this->render('compte/creer', $data);
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
        return $this->render('compte/creer', $data);
    }

    public function lister(){
        if(session()->has('user') && session()->get('user')['role'] == 'A'){
            $data['title'] = "Liste de tous les comptes";
            $data['comptes'] = $this->model->get_all_compte();
            return $this->render('compte/affichage_comptes', $data);
        }
        return redirect()->to('/');
    }

    public function connecter(){
        $data['title'] = 'Connexion';
        if($this->request->getMethod() == "post"){
            if(!$this->validate([
                'pseudo' => 'required|min_length[2]|max_length[255]',
                'mdp' => 'required|min_length[8]|max_length[255]'
            ],
            [
                'pseudo' => [
                    'required' => 'Entrez un pseudo',
                    'min_length' => '2 caractères minimum'
                ],
                'mdp' => [
                    'required' => 'Entrez un mot de passe',
                    'min_length' => '8 caractères minimum'
                ]
            ])){
                return $this->render('compte/connecter', $data);
            }
            $pseudo = $this->request->getVar('pseudo');
            $mdp = $this->request->getVar('mdp');

            if($this->model->connect_compte($pseudo, $mdp)){
                session()->set('user', [
                    'pseudo' => $pseudo,
                    'role' => $this->model->get_compte($pseudo)['cpt_role']
                ]);
                return $this->render("compte/acceuil");
            } else {
                session()->setFlashdata('error', 'Vos identifiants sont incorrects ou votre compte est désactivé !');
                return redirect()->to(url_to('compte#connecter'));
            }
        }
        return $this->render("compte/connecter", $data);
    }

    public function deconnecter(){
        if(session()->has('user')){   
            session()->remove('user');
            session()->setFlashdata('success', 'Vous êtes bel et bien déconnecté !');
        } else {
            session()->setFlashdata('error', "Vous n'êtes pas connecté !");
        }
        return redirect()->to(url_to("compte#connecter"));
    }

    public function profil(){
        $data['title'] = "Mon profil";
        if(session()->has('user')){
            $data['compte'] = $this->model->get_compte(session()->get('user')['pseudo']);
            if($this->request->getMethod() == "post"){
                if(!$this->validate([
                    'mdp_conf' => 'matches[mdp]',
                    'mail' => 'required|valid_email',
                    'prenom' => 'required|min_length[2]|alpha_space',
                    'nom' => 'required|min_length[2]|alpha_space',
                    'mdp_last' => 'required|max_length[255]|min_length[8]'
                ],
                [
                    'mdp_last' => [
                        'required' => 'Veuillez entrer votre ancien mot de passe !',
                        'min_length' => 'Votre ancien mot de passe doit contenir 8 caractères au minimum !'
                    ],
                    'nom' => [
                        'required' => 'Veuillez renseigner un nom'
                    ],
                    'prenom' => [
                        'required' => 'Veuillez renseigner un prénom'
                    ],
                    'mail' => [
                        'required' => 'Veuillez renseigner un email',
                        'valid_email' => '  Veuillez renseigner un email valide !'
                    ],
                    'mdp_conf' => [
                        'matches' => 'Le nouveau mot de passe et sa confirmation ne correspondent pas !'
                    ]
                ])){
                    return $this->render("compte/profil", $data);
                }
                $formData = $this->validator->getValidated();
                $formData['pseudo'] = session()->get('user')['pseudo'];
                if($this->model->connect_compte($formData['pseudo'], $formData['mdp_last'])){
                    if($formData['mdp_conf'] == ""){
                        $formData['mdp_conf'] = $formData['mdp_last'];
                    }
                    if(strlen($formData['mdp_conf']) < 8){
                        $formData['mdp_conf'] = $formData['mdp_last'];
                        session()->setFlashdata('error', "Votre mot de passe n'a pas été modifié ! (trop court)");
                    }
                    if($this->model->update_compte($formData) == true){
                        session()->setFlashdata('success', "Votre profil a bien été modifié !");
                        return redirect()->to(url_to('compte#profil'));
                    } else {
                        session()->setFlashdata('error', "Votre profil n'a pas pu être modifié !");
                        return redirect()->to(url_to('compte#profil'));
                    }
                } else {
                    session()->setFlashdata('error', "Votre mot de passe actuel est incorrect !");
                    return redirect()->to(url_to('compte#profil'));
                }
            }
            return $this->render('compte/profil', $data);
        } else {
            session()->setFlashdata('error', "Vous n'êtes pas connecté !");
            return redirect()->to(url_to("compte#connecter"));
        }
    }
}