<?php

use CodeIgniter\Router\RouteCollection;
use App\Controllers\Accueil;
use App\Controllers\Actualites;
use App\Controllers\Compte;
use App\Controllers\Scenario;
use CodeIgniter\Exceptions\PageNotFoundException;

/**
 * @var RouteCollection $routes
 */

//e22000229

$routes->get('/', [Actualites::class, 'lister']);
$routes->get('actualites', [Actualites::class, 'lister'], ['as' => 'actualites#listing']); 
$routes->get('actualites/(:num)', [Actualites::class, 'lister'], ['as' => 'actualites#listing#page']); 
$routes->get('actualites/afficher/(:num)', [Actualites::class, 'afficher'], ['as' => 'actualite#afficher']);

$routes->get('compte/lister', [Compte::class , 'lister'], ['as' => 'compte#lister']);
$routes->match(["get", "post"], 'compte/creer', [Compte::class, 'creer'], ['as' => 'compte#creer']);
$routes->match(["get", "post"], 'compte/connecter', [Compte::class, 'connecter'], ['as' => 'compte#connecter']);
$routes->match(["get", "post"], 'compte/profil', [Compte::class, 'profil'], ['as' => 'compte#profil']);
$routes->get('compte/afficher_profil', [Compte::class, 'afficher_profil'], ['as' => 'compte#afficher_profil']);
$routes->get('compte/deconnecter', [Compte::class, 'deconnecter'], ['as' => 'compte#deconnecter']);

$routes->get('scenario/afficher', [Scenario::class, 'afficher_scenarii'], ['as' => 'scenarii#afficher']);
$routes->match(["get", "post"], 'scenario/afficher/([a-zA-Z0-9_]{8})', [Scenario::class, 'premiere_etape']);
$routes->match(["get","post"],'scenario/afficher/([a-zA-Z0-9_]{8})/([1-3])', [Scenario::class, 'premiere_etape'], ['as' => 'scenario#premiere_etape']);
$routes->get('scenario/recapitulatif', [Scenario::class, "recapituler_scenariis"], ['as' => 'scenario#recapitulatif']);
$routes->get('scenario/details/([a-zA-Z0-9_]{8})', [Scenario::class, 'afficher_scenario'], ['as' => 'scenario#detail']);
$routes->match(["get", "post"], 'scenario/creer', [Scenario::class, 'creer'], ['as' => 'scenario#creer']);
$routes->match(["get", "post"], 'scenario/supprimer/([a-zA-Z0-9_]{8})', [Scenario::class, 'supprimer_scenario'], ['as' => 'scenario#supprimer']);
$routes->match(["get", "post"], 'scenario/franchir_etape/([a-zA-Z0-9_]{8})', [Scenario::class, 'franchir_etape']);
$routes->match(["get", "post"], 'scenario/franchir_etape/([a-zA-Z0-9_]{8})/([1-3])', [Scenario::class, 'franchir_etape'], ['as' => 'scenario#franchir_etape']);
$routes->match(["get", "post"], 'scenario/valider_reussite/([a-zA-Z0-9_]{8})', [Scenario::class, 'valider_reussite']);
$routes->match(["get", "post"], 'scenario/valider_reussite/([a-zA-Z0-9_]{8})/([1-3])', [Scenario::class, 'valider_reussite'], ['as' => 'scenario#reussite']);

$routes->set404Override(function($message = null) {
    throw new PageNotFoundException("Cette page n'existe pas !");
});