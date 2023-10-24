<?php

use CodeIgniter\Router\RouteCollection;
use App\Controllers\Accueil;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

$routes->get('accueil/afficher', [Accueil::class, 'afficher']);