#!/bin/bash

# Farm Model
cat > app/Models/Farm.php << 'EOF'
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
EOF

# Crop Model
cat > app/Models/Crop.php << 'EOF'
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
EOF

# Category Model
cat > app/Models/Category.php << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'slug', 'type', 'description', 'icon'];

    public function marketplaceItems(): HasMany
    {
        return $this->hasMany(MarketplaceItem::class);
    }
}
EOF

# MarketplaceItem Model
cat > app/Models/MarketplaceItem.php << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MarketplaceItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'category_id', 'title', 'description', 'price',
        'quantity', 'unit', 'type', 'location', 'state', 'images', 'status', 'views',
    ];

    protected function casts(): array
    {
        return [
            'price' => 'decimal:2',
            'images' => 'array',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }
}
EOF

# Transaction Model
cat > app/Models/Transaction.php << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'transaction_ref', 'type', 'category', 'amount',
        'currency', 'description', 'payment_method', 'status', 'related_id', 'related_type',
    ];

    protected function casts(): array
    {
        return ['amount' => 'decimal:2'];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
EOF

# Wallet Model
cat > app/Models/Wallet.php << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Wallet extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'balance', 'pending_balance', 'currency', 'is_active',
    ];

    protected function casts(): array
    {
        return [
            'balance' => 'decimal:2',
            'pending_balance' => 'decimal:2',
            'is_active' => 'boolean',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
EOF

# Loan Model
cat > app/Models/Loan.php << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Loan extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'loan_ref', 'amount', 'interest_rate', 'duration_months',
        'monthly_payment', 'total_repayment', 'amount_paid', 'balance',
        'purpose', 'status', 'disbursement_date', 'next_payment_date', 'reject_reason',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'interest_rate' => 'decimal:2',
            'monthly_payment' => 'decimal:2',
            'total_repayment' => 'decimal:2',
            'amount_paid' => 'decimal:2',
            'balance' => 'decimal:2',
            'disbursement_date' => 'date',
            'next_payment_date' => 'date',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
EOF

# InsurancePolicy Model
cat > app/Models/InsurancePolicy.php << 'EOF'
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
EOF

# WeatherAdvisory Model
cat > app/Models/WeatherAdvisory.php << 'EOF'
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
EOF

echo "All models updated successfully!"
