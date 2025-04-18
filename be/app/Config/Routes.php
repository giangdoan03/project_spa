<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->post('/login', 'Auth::login');
$routes->get('/check', 'Auth::check');
$routes->get('/logout', 'Auth::logout');

$routes->group('api', function ($routes) {
    $routes->resource('products', ['controller' => 'ProductController']);
    $routes->post('products-import', 'ProductController::import');
    $routes->get('products-export-excel', 'ProductController::exportExcel');
    $routes->get('products-export-pdf', 'ProductController::exportPdf');
    $routes->post('products-restore/(:num)', 'ProductController::restore/$1');
    $routes->post('products-export-selected', 'ProductController::exportSelected');
    $routes->resource('categories', ['controller' => 'CategoryController']);
    $routes->post('upload', 'UploadController::upload');
    $routes->resource('businesses', ['controller' => 'BusinessController']);
});
