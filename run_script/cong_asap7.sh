sed -i -E 's/(horizontal_routes_per_micron: float = )[^,]+/\169.80/;
           s/(vertical_routes_per_micron: float = )[^,]+/\168.07/;
           s/(macro_horizontal_routing_allocation: float = )[^,]+/\141.20/;
           s/(macro_vertical_routing_allocation: float = )[^,]+/\140.78/' /workspace/circuit_training/environment/placement_util.py
echo "modified to asap7 successful"