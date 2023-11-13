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

$routes->get('/', [Actualites::class, 'lister']);
$routes->get('actualites', [Actualites::class, 'lister'], ['as' => 'actualites#listing']); 
$routes->get('actualites/(:num)', [Actualites::class, 'lister'], ['as' => 'actualites#listing#page']); 
$routes->get('actualites/afficher/(:num)', [Actualites::class, 'afficher'], ['as' => 'actualite#afficher']);

$routes->get('compte/lister', [Compte::class , 'lister']);

$routes->get('scenario/afficher', [Scenario::class, 'afficher_scenarii'], ['as' => 'scenarii#afficher']);
$routes->get('scenario/afficher/([a-zA-Z0-9-_]+)', [Scenario::class, 'premiere_etape']);
$routes->get('scenario/afficher/([a-zA-Z0-9-_]+)/([1-3])', [Scenario::class, 'premiere_etape'], ['as' => 'scenario#premiere_etape']);

$routes->set404Override(function($message = null) {
    throw new PageNotFoundException("Cette page n'existe pas !");
});