<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('insurance_policies', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('crop_id')->nullable()->constrained()->onDelete('set null');
            $table->string('policy_number')->unique();
            $table->enum('type', ['crop_insurance', 'livestock_insurance', 'equipment_insurance']);
            $table->decimal('sum_insured', 15, 2);
            $table->decimal('premium_amount', 15, 2);
            $table->enum('premium_frequency', ['monthly', 'quarterly', 'annually'])->default('annually');
            $table->date('start_date');
            $table->date('end_date');
            $table->enum('status', ['pending', 'active', 'expired', 'claimed', 'cancelled'])->default('pending');
            $table->json('coverage_details')->nullable();
            $table->decimal('claim_amount', 15, 2)->nullable();
            $table->date('claim_date')->nullable();
            $table->enum('claim_status', ['none', 'pending', 'approved', 'rejected', 'paid'])->default('none');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('insurance_policies');
    }
};
