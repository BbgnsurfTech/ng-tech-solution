<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InsurancePolicy extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'crop_id', 'policy_number', 'type', 'sum_insured',
        'premium_amount', 'premium_frequency', 'start_date', 'end_date',
        'status', 'coverage_details', 'claim_amount', 'claim_date', 'claim_status',
    ];

    protected function casts(): array
    {
        return [
            'sum_insured' => 'decimal:2',
            'premium_amount' => 'decimal:2',
            'claim_amount' => 'decimal:2',
            'coverage_details' => 'array',
            'start_date' => 'date',
            'end_date' => 'date',
            'claim_date' => 'date',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function crop(): BelongsTo
    {
        return $this->belongsTo(Crop::class);
    }
}
