# TODO: Modify the collect_job_#. Align init_placement and netlist_file. Update netlist_index.
# 36 tmux sessions for data collection.
for i in $(seq 1 36); do
    tmux new-session -d -s collect_job_$(printf "%02d" $((i)))
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "export CUDA_VISIBLE_DEVICES=-1" Enter
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "python3.9 -m circuit_training.learning.ppo_collect --root_dir=${ROOT_DIR} --std_cell_placer_mode=fd --replay_buffer_server_address=${REVERB_COLLECT_SERVER} --variable_container_server_address=${REVERB_COLLECT_SERVER} --task_id=$(printf "%02d" $((i))) --max_sequence_length=${MAX_MACRO_COUNT} --netlist_file=${NETLIST_FILE_0} --global_seed=${GLOBAL_SEED} --init_placement=${INIT_PLACEMENT_0} --netlist_index=0 --logtostderr 2>&1 | tee ${ROOT_DIR}/collect_job_$(printf "%02d" $((i))).log" Enter
done

# 15 tmux sessions for data collection.
for i in $(seq 37 51); do
    tmux new-session -d -s collect_job_$(printf "%02d" $((i)))
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "export CUDA_VISIBLE_DEVICES=-1" Enter
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "python3.9 -m circuit_training.learning.ppo_collect --root_dir=${ROOT_DIR} --std_cell_placer_mode=fd --replay_buffer_server_address=${REVERB_COLLECT_SERVER} --variable_container_server_address=${REVERB_COLLECT_SERVER} --task_id=$(printf "%02d" $((i))) --max_sequence_length=${MAX_MACRO_COUNT} --netlist_file=${NETLIST_FILE_1} --global_seed=${GLOBAL_SEED} --init_placement=${INIT_PLACEMENT_1} --netlist_index=1 --logtostderr 2>&1 | tee ${ROOT_DIR}/collect_job_$(printf "%02d" $((i))).log" Enter
done

echo "You just launched 51 tmux sessions for data collection."

tmux attach-session -t collect_job_50
