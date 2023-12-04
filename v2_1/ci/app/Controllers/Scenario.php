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
        $data['etape']['prochain_code'] = $this->model->get_code_etape($data['etape']['eta_prochaine_id']);
        if($this->request->getMethod() == "get"){
            return $this->render('etape/affichage_etape', $data);
        }
        //dd($data['etape']['prochain_code']);
        /*if(!$this->validate([
            'reponse'
        ],[

        ])){

        }*/
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

}