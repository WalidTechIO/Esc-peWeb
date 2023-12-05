<?php

namespace App\Controllers;

use CodeIgniter\Exceptions\PageNotFoundException;

class Scenario extends BaseController {

    public function __construct(){
        helper('form');
    }

    public function afficher_scenarii(){
        $data['scenarii'] = $this->model->get_scenarii();
        return $this->render('scenario/affichage_scenarii', $data);
    }

    public function premiere_etape($code, $niveau = 1) {
        $data['etape'] = $this->model->get_first_step(htmlentities($code), $niveau);
        if(!$data['etape']){  
            return redirect()->to(url_to("scenarii#afficher")); 
        }
        $data['action'] = url_to('scenario#premiere_etape', $data['etape']['sce_code'], $niveau);
        $data['niveau'] = $niveau;
        if($data['etape']['eta_question']) $data['etape']['prochain_code'] = $this->model->get_code_next_etape($data['etape']['eta_prochaine_id']);
        if($this->request->getMethod() == "get"){
            return $this->render('etape/affichage_etape', $data);
        }
        if(!$this->validate([
            'reponse' => 'required',
            'hide' => 'required'
        ],[
            'reponse' => [
                "required" => "La réponse est requise",
            ],
            'hide' => [
                "required" => "Une erreur est survenue",
            ]
        ])){
            return $this->render('etape/affichage_etape', $data);
        }
        $reponse = $this->request->getVar('reponse');
        $controlKey = $this->request->getVar('hide');
        if($reponse == $data['etape']['eta_reponse']){
            session()->setFlashdata('success', "Bonne réponse !");
            return redirect()->to(url_to("scenario#franchir_etape", $data['etape']['prochain_code'], $niveau));
        }
        session()->setFlashdata('error', "Mauvaise réponse. Réessayez !");
        return redirect()->to(url_to("scenario#premiere_etape", $data['etape']['sce_code'], $niveau));
    }

    public function recapituler_scenariis(){
        if(session()->has('user') && session()->get('user')['role'] == 'O'){
            $data['scenarii'] = $this->model->get_scenarii_org(session()->get('user')['pseudo']);
            foreach($data['scenarii'] as $k => $v){
                $data['scenarii'][$k]['nb_etapes'] = $this->model->get_nb_etapes($v['sce_id']);
            }
            return $this->render('scenario/recapituler', $data);
        }
        session()->setFlashdata('error', "Vous n'êtes pas connecté ou n'avez pas les droits !");
        return redirect()->to(url_to('compte#connecter'));
    }

    public function afficher_scenario($code){
        if(!session()->has('user') || session()->get('user')['role'] != 'O'){
            session()->setFlashdata('error', "Vous n'êtes pas connecté ou n'avez pas les droits !");
            return redirect()->to(url_to('compte#connecter'));
        }
        $data['scenario'] = $this->model->get_scenario($code);
        if($data['scenario']){
            return $this->render('scenario/afficher_scenario', $data);
        } else {
            session()->setFlashdata('error', "Le scenario n'existe pas !");
            return redirect()->to(url_to("scenario#recapitulatif"));
        }
    }

    public function creer(){
        $data['title'] = 'Creer un scénario';
        if(!session()->has('user') || session()->get('user')['role'] != 'O'){
            session()->setFlashdata('error', "Vous n'êtes pas connecté ou n'avez pas les droits !");
            return redirect()->to(url_to('compte#connecter'));
        }
        if($this->request->getMethod() == "post"){
            if(!$this->validate(
                [
                    'intitule' => 'required|max_length[255]|min_length[2]|alpha_space',
                    'statut' => 'required|regex_match[/[PC]/]',
                    'image' => 'uploaded[image]|is_image[image]|max_size[image,2048]'
                ],
                [
                    'intitule' => [
                        'required' => 'Renseignez un intitulé pour le scénario',
                        'min_length' => 'L\'intitule du scénario ne peut pas faire moins de 2 caractères.',
                        'alpha_space' => 'Caractères de l\'alphabet ou espace uniquement'
                    ],
                    'statut' => [
                        'required' => 'Renseignez un statut pour le scénario',
                        'regex_match' => 'Le statut est incorrect !'
                    ],
                    'image' => [
                        'uploaded' => 'Vous devez ajouter une image pour le scénario',
                        'is_image' => 'Le fichier uploadé n\'est pas une image',
                        'max_size' => 'L\'image ne doit pas excéder 2Mo'
                    ]
                ]
            )){
                return $this->render('scenario/creer_scenario', $data);
            }
            $intitule = $this->request->getVar('intitule');
            $statut = $this->request->getVar('statut');
            $image = $this->request->getFile('image');
            $uid = $this->model->get_compte(session()->get('user')['pseudo'])['cpt_id'];
            if(!empty($image)){
                $nom_image = $image->getRandomName();
                if($image->move('images', $nom_image)){
                    $this->model->create_scenario($intitule, $statut, $uid, $nom_image);
                    return redirect()->to(url_to("scenario#recapitulatif"));
                } else {
                    session()->setFlashdata('error', "Un problème a eu lieu lors de l'upload de l'image !");
                    return redirect()->to(url_to("scenario#creer"));
                }
            }
        }
        return $this->render('scenario/creer_scenario', $data);
    }

    public function supprimer_scenario($code){
              
        if(!session()->has('user')){
            session()->setFlashdata('error', "Vous n'êtes pas connecté ou n'avez pas les droits !");
            return redirect()->to(url_to('compte#connecter'));
        }
        $data['scenario'] = $this->model->get_scenario($code);
        if($data['scenario'] == null){
            session()->setFlashdata('error', "Ce scénario n'existe pas !");
            return redirect()->to(url_to('scenario#recapitulatif'));
        }
        $compte = $this->model->get_compte(session()->get('user')['pseudo']);
        if($compte['cpt_id'] != $data['scenario']['cpt_id']){
            session()->setFlashdata('error', "Vous ne pouvez pas supprimer ce scénario !");
            return redirect()->to(url_to('scenario#recapitulatif'));
        }
        if($this->request->getMethod() == "get"){
            return $this->render("scenario/supprimer_scenario", $data);
        }
        $action = $this->request->getVar('action');
        if($action == "Supprimer"){
            $this->model->delete_scenario($data['scenario']['sce_id']);
        }
        return redirect()->to(url_to('scenario#recapitulatif'));
    }

    public function franchir_etape($code, $niveau = 1){
        $data['etape'] = $this->model->get_etape($code, $niveau);
        if(!$data['etape']){
            return redirect()->to('/');
        }
        if($data['etape']['eta_prochaine_id'] != null){
            $data['etape']['prochain_code'] = $this->model->get_code_next_etape($data['etape']['eta_prochaine_id']);
        } else {
            $data['etape']['prochain_code'] = null;
        }
        $data['action'] = url_to('scenario#franchir_etape', $data['etape']['eta_code'], $niveau);
        $data['niveau'] = $niveau;
        if($this->request->getMethod() == "get"){
            $controlKey = session()->getFlashdata('controlKey');
            $prev_code = $this->model->get_code_prev_etape($data['etape']['eta_code']);
            if(!$controlKey || $controlKey != $data['etape']['sce_intitule'].$prev_code.$niveau){
                session()->setFlashdata('error', "La triche n'est pas autorisée :)");
                return redirect()->to(url_to('scenario#premiere_etape', $data['etape']['sce_code'], $niveau));
            }
            return $this->render('etape/affichage_etape', $data);
        }
        if(!$this->validate([
            'reponse' => 'required',
            'hide' => 'required'
        ],[
            'reponse' => [
                "required" => "La réponse est requise",
            ],
            'hide' => [
                "required" => "Une erreur est survenue",
            ]
        ])){
            return $this->render('etape/affichage_etape', $data);
        }
        $reponse = $this->request->getVar('reponse');
        $controlKey = $this->request->getVar('hide');
        if($reponse == $data['etape']['eta_reponse']){
            session()->setFlashdata('success', "Bonne réponse !");
            session()->setFlashdata('controlKey', $controlKey);
            if($data['etape']['prochain_code']){
                return redirect()->to(url_to("scenario#franchir_etape", $data['etape']['prochain_code'], $niveau));
            } else {
                session()->setFlashdata('validation', $data['etape']['sce_id']);
                return redirect()->to(url_to('scenario#reussite', $data['etape']['sce_code'], $niveau));
            }
        }
        session()->setFlashdata('error', "Mauvaise réponse. Réessayez !");
        return $this->render('etape/affichage_etape', $data);
    }

    public function valider_reussite($code, $niveau = 1){
        $data['scenario'] = $this->model->get_scenario($code);
        $data['niveau'] = $niveau;
        if($data['scenario']){
            if($data['scenario']['sce_id'] != session()->getFlashdata('validation')){
                session()->setFlashdata('error', "La triche n'est pas autorisée :)");
                return redirect()->to(url_to('scenario#premiere_etape', $data['scenario']['sce_code'], $niveau));
            }
            if($this->request->getMethod() == "get"){
                session()->keepFlashdata('validation');
                return $this->render("participation/creer", $data);
            }
            if(!$this->validate([
                "email" => 'required|valid_email'
            ],[
                'email' => [
                    'required' => 'Vous devez entrez votre adresse e-mail !',
                    'valid_email' => 'Votre adresse e-mail doit être dans un format valide !'
                ]
            ])){
                session()->keepFlashdata('validation');
                return $this->render('participation/creer', $data);
            }
            $this->model->set_participation($this->request->getVar('email'), session()->getFlashdata('validation'), $niveau);
            session()->setFlashdata('success', 'Votre participation a bien été enregistré !');
            return redirect()->to('/');
        } else {
            return redirect()->to('/');
        }
    }

    public function passer_etape($code, $niveau = 1){
        $data['etape'] = $this->model->get_etape($code, $niveau);
        if(!$data['etape']){
            return redirect()->to('/');
        }
        if($data['etape']['eta_prochaine_id'] != null){
            $data['etape']['prochain_code'] = $this->model->get_code_next_etape($data['etape']['eta_prochaine_id']);
        } else {
            $data['etape']['prochain_code'] = null;
        }
        $data['action'] = url_to('scenario#franchir_etape', $data['etape']['eta_code'], $niveau);
        $data['niveau'] = $niveau;
        if($this->request->getMethod() == "get"){
            return $this->render('etape/affichage_etape', $data);
        }
        if(!$this->validate([
            'reponse' => 'required',
            'hide' => 'required'
        ],[
            'reponse' => [
                "required" => "La réponse est requise",
            ],
            'hide' => [
                "required" => "Une erreur est survenue",
            ]
        ])){
            return $this->render('etape/affichage_etape', $data);
        }
        $reponse = $this->request->getVar('reponse');
        $controlKey = $this->request->getVar('hide');
        if($reponse == $data['etape']['eta_reponse'] && $controlKey == $data['etape']['sce_intitule'].$data['etape']['eta_code'].$niveau){
            session()->setFlashdata('success', "Bonne réponse !");
            if($data['etape']['prochain_code']){
                return redirect()->to(url_to("scenario#franchir_etape", $data['etape']['prochain_code'], $niveau));
            } else {
                $premiereEtape = $this->model->get_first_step($data['etape']['sce_code'], $niveau);
                return redirect()->to(url_to('scenario#reussite', $data['etape']['sce_code'], $niveau, $premiereEtape['sce_code'].$premiereEtape['eta_code'].".".$niveau));
            }
        }
        session()->setFlashdata('error', "Mauvaise réponse. Réessayez !");
        return $this->render('etape/affichage_etape', $data);
    }

    public function validation_reussite($code, $niveau, $controlKey){
        $data['scenario'] = $this->model->get_scenario($code);
        $data['niveau'] = $niveau;
        if(!$data['scenario']){
            return redirect()->to(url_to("scenarii#afficher"));
        }
        $premiereEtape = $this->model->get_first_step($code, $niveau);
        if($controlKey != $premiereEtape['sce_code'].$premiereEtape['eta_code'].".".$niveau){
            return redirect()->to(url_to('scenario#premiere_etape', $code, $niveau));
        }
        $data['controlKey'] = $controlKey;
        if($this->request->getMethod() == "get"){
            return $this->render("participation/creer", $data);
        }
        if(!$this->validate([
            "email" => 'required|valid_email',
            "controlKey" => 'required'
        ],[
            'email' => [
                'required' => 'Vous devez entrez votre adresse e-mail !',
                'valid_email' => 'Votre adresse e-mail doit être dans un format valide !'
            ],
            'controlKey' => [
                'required' => 'Une erreur est survenue.'
            ]
        ])){
            return $this->render('participation/creer', $data);
        }
        if($this->request->getVar('controlKey') == $premiereEtape['sce_code'].$premiereEtape['eta_code'].".".$niveau){
            $this->model->set_participation($this->request->getVar('email'), $premiereEtape['sce_id'], $niveau);
            session()->setFlashdata('success', 'Votre participation a bien été enregistré !');
            return redirect()->to('/');
        }
        return redirect()->to(url_to('scenario#premiere_etape', $code, $niveau));
    }

}