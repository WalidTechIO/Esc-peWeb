<?php

use CodeIgniter\Router\RouteCollection;
use App\Controllers\Accueil;
use App\Controllers\Actualites;

/**
 * @var RouteCollection $routes
 */
//$routes->get('/', 'Home::index');

$routes->get('/', [Accueil::class, 'afficher']);
$routes->get('actualites', [Actualites::class, 'listing'], ['as' => 'actualites#listing']); 
$routes->get('actualites/(:num)', [Actualites::class, 'listing'], ['as' => 'actualites#listing#page']); 
$routes->post('act/test/(:num)', [Actualites::class, 'update']);