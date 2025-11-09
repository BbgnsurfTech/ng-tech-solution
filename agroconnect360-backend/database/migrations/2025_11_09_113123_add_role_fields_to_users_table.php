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
        Schema::table('users', function (Blueprint $table) {
            $table->enum('role', ['farmer', 'buyer', 'input_dealer', 'service_provider', 'admin'])->default('farmer')->after('email');
            $table->string('phone')->nullable()->after('role');
            $table->string('state')->nullable()->after('phone');
            $table->string('lga')->nullable()->after('state');
            $table->text('address')->nullable()->after('lga');
            $table->string('profile_photo')->nullable()->after('address');
            $table->boolean('is_verified')->default(false)->after('profile_photo');
            $table->timestamp('verified_at')->nullable()->after('is_verified');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['role', 'phone', 'state', 'lga', 'address', 'profile_photo', 'is_verified', 'verified_at']);
        });
    }
};
