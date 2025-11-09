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
