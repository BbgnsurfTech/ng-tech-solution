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
