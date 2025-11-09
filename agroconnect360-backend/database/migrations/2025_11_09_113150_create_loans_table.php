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
        Schema::create('loans', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('loan_ref')->unique();
            $table->decimal('amount', 15, 2);
            $table->decimal('interest_rate', 5, 2); // percentage
            $table->integer('duration_months');
            $table->decimal('monthly_payment', 15, 2);
            $table->decimal('total_repayment', 15, 2);
            $table->decimal('amount_paid', 15, 2)->default(0);
            $table->decimal('balance', 15, 2);
            $table->enum('purpose', ['input_purchase', 'equipment', 'land_expansion', 'working_capital', 'other']);
            $table->enum('status', ['pending', 'approved', 'active', 'completed', 'defaulted', 'rejected'])->default('pending');
            $table->date('disbursement_date')->nullable();
            $table->date('next_payment_date')->nullable();
            $table->text('reject_reason')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('loans');
    }
};
