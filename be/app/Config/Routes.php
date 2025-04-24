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
    $routes->post('products/(:num)/toggle-status', 'ProductController::toggleStatus/$1');

    $routes->resource('categories', ['controller' => 'CategoryController']);
    $routes->resource('businesses', ['controller' => 'BusinessController']);
    $routes->resource('persons', ['controller' => 'PersonController']);
    $routes->resource('events', ['controller' => 'EventController']);
    $routes->resource('stores', ['controller' => 'StoreController']); // Thêm route cho stores

    $routes->post('upload', 'UploadController::upload');

    // Route phân quyền (nên đặt ngoài nhóm 'api' nếu bạn dùng giao diện truyền thống)

    $routes->get('roles', 'RoleController::index'); // <- thêm dòng này

    $routes->get('permissions', 'PermissionController::index');
    $routes->post('permissions/save', 'PermissionController::save');

    // (Tuỳ chọn) Quản lý vai trò nếu bạn cần
    $routes->get('roles', 'RoleController::index');
    $routes->post('roles/create', 'RoleController::create');
    $routes->post('roles/update/(:num)', 'RoleController::update/$1');
    $routes->post('roles/delete/(:num)', 'RoleController::delete/$1');

    $routes->get('permissions/matrix', 'PermissionController::matrix');


});
