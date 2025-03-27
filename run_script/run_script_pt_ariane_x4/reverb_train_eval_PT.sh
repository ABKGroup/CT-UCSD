tmux new-session -d -s reverb_server
tmux send-keys -t reverb_server "export CUDA_VISIBLE_DEVICES=-1" Enter
tmux send-keys -t reverb_server "python3.9 -m circuit_training.learning.ppo_reverb_server --num_netlists=${NUM_NETLISTS} --root_dir=${ROOT_DIR} --port=${REVERB_PORT} --global_seed=${GLOBAL_SEED} 2>&1 | tee ${ROOT_DIR}/reverb_server.log" Enter

tmux new-session -d -s train_job
tmux send-keys -t train_job "python3.9 -m circuit_training.learning.train_ppo\
 --netlist_file=${NETLIST_FILE_0}\
 --init_placement=${INIT_PLACEMENT_0}\
 --netlist_file=${NETLIST_FILE_1}\
 --init_placement=${INIT_PLACEMENT_1}\
 --netlist_file=${NETLIST_FILE_2}\
 --init_placement=${INIT_PLACEMENT_2}\
 --netlist_file=${NETLIST_FILE_3}\
 --init_placement=${INIT_PLACEMENT_3}\
 --netlist_file=${NETLIST_FILE_4}\
 --init_placement=${INIT_PLACEMENT_4}\
 --netlist_file=${NETLIST_FILE_5}\
 --init_placement=${INIT_PLACEMENT_5}\
 --root_dir=${ROOT_DIR}\
 --replay_buffer_server_address=${REVERB_SERVER}\
 --variable_container_server_address=${REVERB_SERVER}\
 --std_cell_placer_mode=${STDCELL_PLACER}\
 --sequence_length=${MAX_MACRO_COUNT}\
 --gin_bindings='train.num_iterations=${ITERATION}'\
 --global_seed=${GLOBAL_SEED}\
 --use_gpu=${USE_GPU}\
 --gin_bindings='CircuittrainingPPOLearner.allow_variable_length_episodes=True' 2>&1 | tee ${ROOT_DIR}/train_job.log" Enter
# tmux attach -t train_job

tmux new-session -d -s eval_job
tmux send-keys -t eval_job "export CUDA_VISIBLE_DEVICES=-1" Enter
tmux send-keys -t eval_job "python3.9 -m circuit_training.learning.eval --root_dir=${ROOT_DIR} --std_cell_placer_mode=fd --variable_container_server_address=${REVERB_SERVER} --netlist_file=${NETLIST_FILE_E} --init_placement=${INIT_PLACEMENT_E} --global_seed=${GLOBAL_SEED} --output_placement_save_dir=${ROOT_DIR} 2>&1 | tee ${ROOT_DIR}/eval_job.log" Enter

