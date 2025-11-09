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
