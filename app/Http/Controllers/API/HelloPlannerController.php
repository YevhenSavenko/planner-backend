<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;

/**
 * Controller of testing works.
 */
class HelloPlannerController extends Controller
{
    /**
     * Action for testing
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        return response()->json('Hello Planner App!');
    }
}
