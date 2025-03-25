sed -i -E 's/(horizontal_routes_per_micron: float = )[^,]+/\170.330/;
           s/(vertical_routes_per_micron: float = )[^,]+/\174.510/;
           s/(macro_horizontal_routing_allocation: float = )[^,]+/\151.790/;
           s/(macro_vertical_routing_allocation: float = )[^,]+/\151.790/' /workspace/circuit_training/environment/placement_util.py
echo "modified to tsmc7 successful"