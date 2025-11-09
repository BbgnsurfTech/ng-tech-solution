<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WeatherAdvisory extends Model
{
    use HasFactory;

    protected $fillable = [
        'state', 'lga', 'title', 'description', 'type', 'severity',
        'valid_from', 'valid_to', 'temperature_min', 'temperature_max',
        'humidity', 'rainfall', 'wind_speed', 'recommendations', 'is_active',
    ];

    protected function casts(): array
    {
        return [
            'temperature_min' => 'decimal:2',
            'temperature_max' => 'decimal:2',
            'rainfall' => 'decimal:2',
            'recommendations' => 'array',
            'is_active' => 'boolean',
            'valid_from' => 'date',
            'valid_to' => 'date',
        ];
    }
}
