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
        Schema::create('weather_advisories', function (Blueprint $table) {
            $table->id();
            $table->string('state');
            $table->string('lga')->nullable();
            $table->string('title');
            $table->text('description');
            $table->enum('type', ['forecast', 'warning', 'advisory', 'alert']);
            $table->enum('severity', ['low', 'medium', 'high', 'critical'])->default('medium');
            $table->date('valid_from');
            $table->date('valid_to');
            $table->decimal('temperature_min', 5, 2)->nullable();
            $table->decimal('temperature_max', 5, 2)->nullable();
            $table->integer('humidity')->nullable(); // percentage
            $table->decimal('rainfall', 8, 2)->nullable(); // in mm
            $table->string('wind_speed')->nullable();
            $table->json('recommendations')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('weather_advisories');
    }
};
