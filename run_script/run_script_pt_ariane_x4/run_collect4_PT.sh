# TODO: Modify the collect_job_#. Align init_placement and netlist_file. Update netlist_index.
# 16 jobs
for i in $(seq 153 168); do
    tmux new-session -d -s collect_job_$(printf "%02d" $((i)))
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "export CUDA_VISIBLE_DEVICES=-1" Enter
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "python3.9 -m circuit_training.learning.ppo_collect --root_dir=${ROOT_DIR} --std_cell_placer_mode=fd --replay_buffer_server_address=${REVERB_COLLECT_SERVER} --variable_container_server_address=${REVERB_COLLECT_SERVER} --task_id=$(printf "%02d" $((i))) --max_sequence_length=${MAX_MACRO_COUNT} --netlist_file=${NETLIST_FILE_3} --global_seed=${GLOBAL_SEED} --init_placement=${INIT_PLACEMENT_3} --netlist_index=3 --logtostderr 2>&1 | tee ${ROOT_DIR}/collect_job_$(printf "%02d" $((i))).log" Enter
done

# 34 jobs
for i in $(seq 169 202); do
    tmux new-session -d -s collect_job_$(printf "%02d" $((i)))
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "export CUDA_VISIBLE_DEVICES=-1" Enter
    tmux send-keys -t collect_job_$(printf "%02d" $((i))) "python3.9 -m circuit_training.learning.ppo_collect --root_dir=${ROOT_DIR} --std_cell_placer_mode=fd --replay_buffer_server_address=${REVERB_COLLECT_SERVER} --variable_container_server_address=${REVERB_COLLECT_SERVER} --task_id=$(printf "%02d" $((i))) --max_sequence_length=${MAX_MACRO_COUNT} --netlist_file=${NETLIST_FILE_4} --global_seed=${GLOBAL_SEED} --init_placement=${INIT_PLACEMENT_4} --netlist_index=4 --logtostderr 2>&1 | tee ${ROOT_DIR}/collect_job_$(printf "%02d" $((i))).log" Enter
done

echo "You just launched 50 tmux sessions for data collection."

tmux attach-session -t collect_job_200
