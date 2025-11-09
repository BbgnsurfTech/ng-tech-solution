# AgroConnect360 Backend API

> Laravel/Livewire backend for the AgroConnect360 agricultural platform

## Overview

AgroConnect360 Backend is a comprehensive REST API built with Laravel 11 and Livewire 3, designed to power the AgroConnect360 mobile application. It provides a complete backend solution for managing farms, crops, marketplace transactions, financial services (loans and insurance), and weather advisories for farmers in Nigeria.

## Features

### Core Modules

- **Authentication & User Management** - Multi-role system with Laravel Sanctum
- **Farm Management** - Complete CRUD for farm operations
- **Crop Management** - Track crop cycles from planting to harvest
- **Digital Marketplace** - Buy/sell agricultural inputs and produce
- **Financial Services** - Wallet, loans, and crop insurance
- **Weather Advisory** - Location-based forecasts and alerts

## Tech Stack

- Laravel 11.x
- Livewire 3.x
- Laravel Sanctum
- MySQL
- PHP 8.2+

## Installation

```bash
# Install dependencies
composer install

# Setup environment
cp .env.example .env
php artisan key:generate

# Configure database in .env
DB_CONNECTION=mysql
DB_DATABASE=agroconnect360
DB_USERNAME=root
DB_PASSWORD=

# Run migrations
php artisan migrate

# Start server
php artisan serve
```

## API Endpoints

Base URL: `http://localhost:8000/api/v1`

### Authentication
- POST `/register` - Register new user
- POST `/login` - Login user
- GET `/profile` - Get user profile
- PUT `/profile` - Update profile
- POST `/logout` - Logout

### Farms
- GET `/farms` - List all farms
- POST `/farms` - Create farm
- GET `/farms/{id}` - Get farm details
- PUT `/farms/{id}` - Update farm
- DELETE `/farms/{id}` - Delete farm

### Crops
- GET `/farms/{farm_id}/crops` - List crops
- POST `/farms/{farm_id}/crops` - Add crop
- PUT `/crops/{id}` - Update crop
- DELETE `/crops/{id}` - Delete crop

### Marketplace
- GET `/marketplace` - Browse listings
- POST `/marketplace` - Create listing
- GET `/marketplace/{id}` - View listing
- PUT `/marketplace/{id}` - Update listing
- DELETE `/marketplace/{id}` - Delete listing

### Wallet
- GET `/wallet` - Get balance
- POST `/wallet/fund` - Fund wallet
- POST `/wallet/withdraw` - Withdraw
- GET `/transactions` - Transaction history

### Loans
- GET `/loans` - List loans
- POST `/loans` - Apply for loan
- POST `/loans/{id}/repay` - Repay loan

### Insurance
- GET `/insurance` - List policies
- POST `/insurance` - Purchase insurance
- POST `/insurance/{id}/claim` - File claim

### Weather
- GET `/weather/advisories` - Public advisories
- GET `/weather/my-advisories` - My advisories

## Database Schema

Core tables: users, farms, crops, categories, marketplace_items, wallets, transactions, loans, insurance_policies, weather_advisories

## User Roles

- Farmer, Buyer, Input Dealer, Service Provider, Admin

## License

Proprietary - All rights reserved

---

Built with ❤️ for Nigerian farmers
