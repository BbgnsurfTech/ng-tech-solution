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
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('transaction_ref')->unique();
            $table->enum('type', ['credit', 'debit']);
            $table->enum('category', ['marketplace_sale', 'marketplace_purchase', 'loan_disbursement', 'loan_repayment', 'wallet_funding', 'withdrawal', 'insurance_premium', 'insurance_payout']);
            $table->decimal('amount', 15, 2);
            $table->string('currency', 3)->default('NGN');
            $table->text('description')->nullable();
            $table->string('payment_method')->nullable(); // card, bank_transfer, mobile_money
            $table->enum('status', ['pending', 'completed', 'failed', 'cancelled'])->default('pending');
            $table->foreignId('related_id')->nullable(); // ID of related model (marketplace_item, loan, etc.)
            $table->string('related_type')->nullable(); // morphs type
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
