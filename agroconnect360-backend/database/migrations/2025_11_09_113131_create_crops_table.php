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
        Schema::create('crops', function (Blueprint $table) {
            $table->id();
            $table->foreignId('farm_id')->constrained()->onDelete('cascade');
            $table->string('crop_name');
            $table->string('crop_type'); // e.g., cocoa, cashew, rice, cassava
            $table->decimal('area_planted', 10, 2); // in hectares
            $table->date('planting_date');
            $table->date('expected_harvest_date')->nullable();
            $table->date('actual_harvest_date')->nullable();
            $table->decimal('expected_yield', 10, 2)->nullable(); // in tons/kg
            $table->decimal('actual_yield', 10, 2)->nullable();
            $table->enum('growth_stage', ['planting', 'germination', 'vegetative', 'flowering', 'fruiting', 'harvesting', 'harvested'])->default('planting');
            $table->enum('health_status', ['healthy', 'disease_detected', 'pest_infestation', 'drought_stress'])->default('healthy');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('crops');
    }
};
