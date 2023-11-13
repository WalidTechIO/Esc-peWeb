<?php

use CodeIgniter\Router\RouteCollection;
use App\Controllers\Accueil;
use App\Controllers\Actualites;
use App\Controllers\Compte;
use App\Controllers\Scenario;

/**
 * @var RouteCollection $routes
 */

$routes->get('/', [Actualites::class, 'listing']);
$routes->get('actualites', [Actualites::class, 'listing'], ['as' => 'actualites#listing']); 
$routes->get('actualites/(:num)', [Actualites::class, 'listing'], ['as' => 'actualites#listing#page']); 
$routes->get('actualites/afficher/(:num)', [Actualites::class, 'afficher'], ['as' => 'actualite#afficher']);

$routes->get('compte/lister', [Compte::class , 'lister']);

$routes->get('scenarii', [Scenario::class, 'afficher_scenarii'], ['as' => 'scenarii#afficher']);
$routes->get('scenarii/(:segment)', [Scenario::class, 'premiere_etape']);
$routes->get('scenarii/(:segment)/(:num)', [Scenario::class, 'premiere_etape'], ['as' => 'scenarii#premiere_etape']);