#!/bin/bash

# AuthController
cat > app/Http/Controllers/API/AuthController.php << 'EOF'
<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Wallet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|in:farmer,buyer,input_dealer,service_provider',
            'phone' => 'required|string',
            'state' => 'nullable|string',
            'lga' => 'nullable|string',
            'address' => 'nullable|string',
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'role' => $validated['role'],
            'phone' => $validated['phone'],
            'state' => $validated['state'] ?? null,
            'lga' => $validated['lga'] ?? null,
            'address' => $validated['address'] ?? null,
        ]);

        // Create wallet for user
        Wallet::create([
            'user_id' => $user->id,
            'balance' => 0,
            'pending_balance' => 0,
        ]);

        $token = $user->createToken('mobile-app')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Registration successful',
            'data' => [
                'user' => $user,
                'token' => $token,
            ],
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('mobile-app')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'data' => [
                'user' => $user,
                'token' => $token,
            ],
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logged out successfully',
        ]);
    }

    public function profile(Request $request)
    {
        return response()->json([
            'success' => true,
            'data' => $request->user()->load(['wallet', 'farms']),
        ]);
    }

    public function updateProfile(Request $request)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'phone' => 'sometimes|string',
            'state' => 'sometimes|string',
            'lga' => 'sometimes|string',
            'address' => 'sometimes|string',
            'profile_photo' => 'sometimes|string',
        ]);

        $request->user()->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Profile updated successfully',
            'data' => $request->user(),
        ]);
    }
}
EOF

# FarmController
cat > app/Http/Controllers/API/FarmController.php << 'EOF'
<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Farm;
use Illuminate\Http\Request;

class FarmController extends Controller
{
    public function index(Request $request)
    {
        $farms = $request->user()->farms()->with('crops')->get();

        return response()->json([
            'success' => true,
            'data' => $farms,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'size' => 'required|numeric|min:0',
            'location' => 'required|string',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'state' => 'required|string',
            'lga' => 'required|string',
            'description' => 'nullable|string',
            'soil_type' => 'nullable|string',
            'status' => 'sometimes|in:active,inactive,abandoned',
        ]);

        $farm = $request->user()->farms()->create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Farm created successfully',
            'data' => $farm,
        ], 201);
    }

    public function show(Farm $farm)
    {
        $this->authorize('view', $farm);

        return response()->json([
            'success' => true,
            'data' => $farm->load('crops'),
        ]);
    }

    public function update(Request $request, Farm $farm)
    {
        $this->authorize('update', $farm);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'size' => 'sometimes|numeric|min:0',
            'location' => 'sometimes|string',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'state' => 'sometimes|string',
            'lga' => 'sometimes|string',
            'description' => 'nullable|string',
            'soil_type' => 'nullable|string',
            'status' => 'sometimes|in:active,inactive,abandoned',
        ]);

        $farm->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Farm updated successfully',
            'data' => $farm,
        ]);
    }

    public function destroy(Farm $farm)
    {
        $this->authorize('delete', $farm);

        $farm->delete();

        return response()->json([
            'success' => true,
            'message' => 'Farm deleted successfully',
        ]);
    }
}
EOF

# CropController
cat > app/Http/Controllers/API/CropController.php << 'EOF'
<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Crop;
use App\Models\Farm;
use Illuminate\Http\Request;

class CropController extends Controller
{
    public function index(Request $request, Farm $farm)
    {
        $this->authorize('view', $farm);

        $crops = $farm->crops()->get();

        return response()->json([
            'success' => true,
            'data' => $crops,
        ]);
    }

    public function store(Request $request, Farm $farm)
    {
        $this->authorize('update', $farm);

        $validated = $request->validate([
            'crop_name' => 'required|string',
            'crop_type' => 'required|string',
            'area_planted' => 'required|numeric|min:0',
            'planting_date' => 'required|date',
            'expected_harvest_date' => 'nullable|date',
            'expected_yield' => 'nullable|numeric|min:0',
            'growth_stage' => 'sometimes|in:planting,germination,vegetative,flowering,fruiting,harvesting,harvested',
            'health_status' => 'sometimes|in:healthy,disease_detected,pest_infestation,drought_stress',
            'notes' => 'nullable|string',
        ]);

        $crop = $farm->crops()->create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Crop created successfully',
            'data' => $crop,
        ], 201);
    }

    public function show(Crop $crop)
    {
        return response()->json([
            'success' => true,
            'data' => $crop->load('farm'),
        ]);
    }

    public function update(Request $request, Crop $crop)
    {
        $validated = $request->validate([
            'crop_name' => 'sometimes|string',
            'crop_type' => 'sometimes|string',
            'area_planted' => 'sometimes|numeric|min:0',
            'planting_date' => 'sometimes|date',
            'expected_harvest_date' => 'nullable|date',
            'actual_harvest_date' => 'nullable|date',
            'expected_yield' => 'nullable|numeric|min:0',
            'actual_yield' => 'nullable|numeric|min:0',
            'growth_stage' => 'sometimes|in:planting,germination,vegetative,flowering,fruiting,harvesting,harvested',
            'health_status' => 'sometimes|in:healthy,disease_detected,pest_infestation,drought_stress',
            'notes' => 'nullable|string',
        ]);

        $crop->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Crop updated successfully',
            'data' => $crop,
        ]);
    }

    public function destroy(Crop $crop)
    {
        $crop->delete();

        return response()->json([
            'success' => true,
            'message' => 'Crop deleted successfully',
        ]);
    }
}
EOF

# MarketplaceController
cat > app/Http/Controllers/API/MarketplaceController.php << 'EOF'
<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\MarketplaceItem;
use Illuminate\Http\Request;

class MarketplaceController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketplaceItem::with(['user', 'category']);

        if ($request->has('type')) {
            $query->where('type', $request->type);
        }

        if ($request->has('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        if ($request->has('state')) {
            $query->where('state', $request->state);
        }

        if ($request->has('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }

        $items = $query->where('status', 'available')->latest()->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $items,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'category_id' => 'required|exists:categories,id',
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric|min:0',
            'quantity' => 'required|integer|min:1',
            'unit' => 'required|string',
            'type' => 'required|in:input,produce',
            'location' => 'required|string',
            'state' => 'required|string',
            'images' => 'nullable|array',
        ]);

        $item = $request->user()->marketplaceItems()->create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Item listed successfully',
            'data' => $item,
        ], 201);
    }

    public function show(MarketplaceItem $marketplace)
    {
        $marketplace->incrementViews();

        return response()->json([
            'success' => true,
            'data' => $marketplace->load(['user', 'category']),
        ]);
    }

    public function update(Request $request, MarketplaceItem $marketplace)
    {
        $this->authorize('update', $marketplace);

        $validated = $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'sometimes|string',
            'price' => 'sometimes|numeric|min:0',
            'quantity' => 'sometimes|integer|min:0',
            'status' => 'sometimes|in:available,sold,reserved,expired',
        ]);

        $marketplace->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Item updated successfully',
            'data' => $marketplace,
        ]);
    }

    public function destroy(MarketplaceItem $marketplace)
    {
        $this->authorize('delete', $marketplace);

        $marketplace->delete();

        return response()->json([
            'success' => true,
            'message' => 'Item deleted successfully',
        ]);
    }

    public function myListings(Request $request)
    {
        $items = $request->user()->marketplaceItems()->with('category')->latest()->get();

        return response()->json([
            'success' => true,
            'data' => $items,
        ]);
    }
}
EOF

echo "API Controllers created successfully!"
