<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->post('/login', 'Auth::login');
$routes->get('/check', 'Auth::check');
$routes->get('/logout', 'Auth::logout');

