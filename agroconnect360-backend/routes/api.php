<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\CropController;
use App\Http\Controllers\API\FarmController;
use App\Http\Controllers\API\InsuranceController;
use App\Http\Controllers\API\LoanController;
use App\Http\Controllers\API\MarketplaceController;
use App\Http\Controllers\API\WalletController;
use App\Http\Controllers\API\WeatherController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application.
| These routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group.
|
*/

// Public routes
Route::prefix('v1')->group(function () {
    // Authentication
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);

    // Public marketplace listings
    Route::get('/marketplace', [MarketplaceController::class, 'index']);
    Route::get('/marketplace/{marketplace}', [MarketplaceController::class, 'show']);

    // Weather advisories (public)
    Route::get('/weather/advisories', [WeatherController::class, 'index']);
});

// Protected routes
Route::prefix('v1')->middleware('auth:sanctum')->group(function () {
    // Auth & Profile
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);
    Route::put('/profile', [AuthController::class, 'updateProfile']);

    // Farms
    Route::apiResource('farms', FarmController::class);

    // Crops (nested under farms)
    Route::prefix('farms/{farm}')->group(function () {
        Route::get('/crops', [CropController::class, 'index']);
        Route::post('/crops', [CropController::class, 'store']);
    });
    Route::apiResource('crops', CropController::class)->except(['index', 'store']);

    // Marketplace
    Route::post('/marketplace', [MarketplaceController::class, 'store']);
    Route::put('/marketplace/{marketplace}', [MarketplaceController::class, 'update']);
    Route::delete('/marketplace/{marketplace}', [MarketplaceController::class, 'destroy']);
    Route::get('/my-listings', [MarketplaceController::class, 'myListings']);

    // Wallet & Transactions
    Route::get('/wallet', [WalletController::class, 'show']);
    Route::post('/wallet/fund', [WalletController::class, 'fund']);
    Route::post('/wallet/withdraw', [WalletController::class, 'withdraw']);
    Route::get('/transactions', [WalletController::class, 'transactions']);

    // Loans
    Route::apiResource('loans', LoanController::class);
    Route::post('/loans/{loan}/repay', [LoanController::class, 'repay']);

    // Insurance
    Route::apiResource('insurance', InsuranceController::class);
    Route::post('/insurance/{insurance}/claim', [InsuranceController::class, 'claim']);

    // Weather
    Route::get('/weather/my-advisories', [WeatherController::class, 'myAdvisories']);
});
