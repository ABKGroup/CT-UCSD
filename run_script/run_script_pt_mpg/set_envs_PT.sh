# unset previous environment variables
unset TF_GPU_ALLOCATOR
unset TF_FORCE_GPU_ALLOW_GROWTH
unset TF_USE_LEGACY_KERAS
unset TF_CPP_MIN_LOG_LEVEL

unset ITERATION
unset PER_REPLICA_BATCH_SIZE
unset NUM_EPISODES_PER_ITERATION
unset NUM_EPOCHS

unset DESIGN_NAME
unset DESIGN_NAME_0
unset DESIGN_NAME_1
unset DESIGN_NAME_2
unset DESIGN_NAME_3
unset DESIGN_NAME_4
unset DESIGN_NAME_5
unset DESIGN_NAME_6
unset DESIGN_NAME_E
unset CHECKPOINT_DIR
unset ROOT_DIR
unset REVERB_PORT
unset REVERB_SERVER
unset REVERB_COLLECT_SERVER
unset MACRO_COUNT
unset NETLIST_FILE
unset NETLIST_FILE_0
unset NETLIST_FILE_1
unset NETLIST_FILE_2
unset NETLIST_FILE_3
unset NETLIST_FILE_4
unset NETLIST_FILE_5
unset NETLIST_FILE_6
unset NETLIST_FILE_E
unset INIT_PLACEMENT
unset INIT_PLACEMENT_0
unset INIT_PLACEMENT_1
unset INIT_PLACEMENT_2
unset INIT_PLACEMENT_3
unset INIT_PLACEMENT_4
unset INIT_PLACEMENT_5
unset INIT_PLACEMENT_6
unset INIT_PLACEMENT_E
unset USE_GPU
unset GLOBAL_SEED

# export TF_USE_LEGACY_KERAS=1
export TF_GPU_ALLOCATOR=cuda_malloc_async
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TF_CPP_MIN_LOG_LEVEL=0

export ITERATION=200
export PER_REPLICA_BATCH_SIZE=128       # irrelevant for PT
export NUM_EPISODES_PER_ITERATION=256   # irrelevant for PT
export NUM_EPOCHS=4                     # irrelevant for PT
export STDCELL_PLACER="fd"

echo "ITERATION: ${ITERATION} PER_REPLICA_BATCH_SIZE: ${PER_REPLICA_BATCH_SIZE} NUM_EPISODES_PER_ITERATION: ${NUM_EPISODES_PER_ITERATION} NUM_EPOCHS: ${NUM_EPOCHS} STDCELL_PLACER: ${STDCELL_PLACER}"

export NUM_NETLISTS=7
export MAX_MACRO_COUNT=325
export DESIGN_NAME_0=mempool_group_ng45
export DESIGN_NAME_1=mempool_group_ng45
export DESIGN_NAME_2=mempool_group_ng45
export DESIGN_NAME_3=mempool_group_ng45
export DESIGN_NAME_4=mempool_group_ng45
export DESIGN_NAME_5=mempool_group_ng45
export DESIGN_NAME_6=mempool_group_ng45
export DESIGN_NAME_E=mempool_group_ng45
bash /workspace/run_script/cong_ng45.sh

export NETLIST_FILE_0=/workspace/Testcases/${DESIGN_NAME_0}/shift.pb.txt
export NETLIST_FILE_1=/workspace/Testcases/${DESIGN_NAME_1}/x_flip.pb.txt
export NETLIST_FILE_2=/workspace/Testcases/${DESIGN_NAME_2}/y_flip.pb.txt
export NETLIST_FILE_3=/workspace/Testcases/${DESIGN_NAME_3}/xy_flip.pb.txt
export NETLIST_FILE_4=/workspace/Testcases/${DESIGN_NAME_4}/shift_x_flip.pb.txt
export NETLIST_FILE_5=/workspace/Testcases/${DESIGN_NAME_5}/shift_y_flip.pb.txt
export NETLIST_FILE_6=/workspace/Testcases/${DESIGN_NAME_6}/shift_xy_flip.pb.txt
export NETLIST_FILE_E=/workspace/Testcases/${DESIGN_NAME_E}/netlist.pb.txt

export INIT_PLACEMENT_0=/workspace/Testcases/${DESIGN_NAME_0}/shift_fixed.plc
export INIT_PLACEMENT_1=/workspace/Testcases/${DESIGN_NAME_1}/x_flip_fixed.plc
export INIT_PLACEMENT_2=/workspace/Testcases/${DESIGN_NAME_2}/y_flip_fixed.plc
export INIT_PLACEMENT_3=/workspace/Testcases/${DESIGN_NAME_3}/xy_flip_fixed.plc
export INIT_PLACEMENT_4=/workspace/Testcases/${DESIGN_NAME_4}/shift_x_flip_fixed.plc
export INIT_PLACEMENT_5=/workspace/Testcases/${DESIGN_NAME_5}/shift_y_flip_fixed.plc
export INIT_PLACEMENT_6=/workspace/Testcases/${DESIGN_NAME_6}/shift_xy_flip_fixed.plc   
export INIT_PLACEMENT_E=/workspace/Testcases/${DESIGN_NAME_E}/initial.plc

# export CHECKPOINT_DIR="" # !!! change the directory name accordingly
# export CHECKPOINT_DIR=/workspace/tpu_checkpoint
export CURRENT_TIME=$(date +%Y%m%d_%H%M%S)
export ROOT_DIR=/workspace/logs/run_${DESIGN_NAME_E}_${CURRENT_TIME}_ITER${ITERATION}_PRBS${PER_REPLICA_BATCH_SIZE}_NEPI${NUM_EPISODES_PER_ITERATION}_NE${NUM_EPOCHS}_PLCR${STDCELL_PLACER}_PT # !!! change suffix

echo "ROOT_DIR: ${ROOT_DIR}"
mkdir -p ${ROOT_DIR}
export REVERB_PORT=8008
export REVERB_SERVER="127.0.0.1:${REVERB_PORT}" # !!! this should not be changed
## The following is not used in the REVER, TRAIN and EVAL Jobs.
export REVERB_COLLECT_SERVER="xxxxxx:${REVERB_PORT}" # !!! change this to hostmachine's IP address

export USE_GPU=True
export GLOBAL_SEED=333
