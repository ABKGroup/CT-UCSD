sed -i -E 's/(horizontal_routes_per_micron: float = )[^,]+/\112.279/;
           s/(vertical_routes_per_micron: float = )[^,]+/\113.591/;
           s/(macro_horizontal_routing_allocation: float = )[^,]+/\19.824/;
           s/(macro_vertical_routing_allocation: float = )[^,]+/\18.133/' /workspace/circuit_training/environment/placement_util.py
echo "modified to ng45 successful"