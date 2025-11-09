<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Crop extends Model
{
    use HasFactory;

    protected $fillable = [
        'farm_id', 'crop_name', 'crop_type', 'area_planted', 'planting_date',
        'expected_harvest_date', 'actual_harvest_date', 'expected_yield',
        'actual_yield', 'growth_stage', 'health_status', 'notes',
    ];

    protected function casts(): array
    {
        return [
            'area_planted' => 'decimal:2',
            'expected_yield' => 'decimal:2',
            'actual_yield' => 'decimal:2',
            'planting_date' => 'date',
            'expected_harvest_date' => 'date',
            'actual_harvest_date' => 'date',
        ];
    }

    public function farm(): BelongsTo
    {
        return $this->belongsTo(Farm::class);
    }

    public function insurancePolicies(): HasMany
    {
        return $this->hasMany(InsurancePolicy::class);
    }
}
