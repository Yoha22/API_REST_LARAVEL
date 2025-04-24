<?php

use Illuminate\Support\Facades\Route;
use \Illuminate\Support\Facades\Artisan;
use App\Http\Controllers\studentController;

Route::get('/migrar', function () {
    Artisan::call('migrate', ['--force' => true]);
    return 'Migración ejecutada';
});

Route::get('/students', [studentController::class, 'index']);

Route::get('/students/{id}', [studentController::class, 'show']);

Route::post('/students', [studentController::class, 'store']);

Route::put('/students/{id}', [studentController::class, 'update']);

Route::patch('/students/{id}', [studentController::class, 'updatePartial']);

Route::delete('/students/{id}', [studentController::class, 'destroy']);

