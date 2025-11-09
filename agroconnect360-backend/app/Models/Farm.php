<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Farm extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'name', 'size', 'location', 'latitude', 'longitude',
        'state', 'lga', 'description', 'soil_type', 'status',
    ];

    protected function casts(): array
    {
        return [
            'size' => 'decimal:2',
            'latitude' => 'decimal:7',
            'longitude' => 'decimal:7',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function crops(): HasMany
    {
        return $this->hasMany(Crop::class);
    }
}
