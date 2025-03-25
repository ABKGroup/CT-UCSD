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
unset CHECKPOINT_DIR
unset ROOT_DIR
unset REVERB_PORT
unset REVERB_SERVER
unset REVERB_COLLECT_SERVER
unset MACRO_COUNT
unset NETLIST_FILE
unset INIT_PLACEMENT
unset USE_GPU
unset GLOBAL_SEED

# export TF_USE_LEGACY_KERAS=1
export TF_GPU_ALLOCATOR=cuda_malloc_async
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TF_CPP_MIN_LOG_LEVEL=0

export ITERATION=400
export PER_REPLICA_BATCH_SIZE=128
export NUM_EPISODES_PER_ITERATION=256
export NUM_EPOCHS=4
export STDCELL_PLACER="fd"

echo "ITERATION: ${ITERATION} PER_REPLICA_BATCH_SIZE: ${PER_REPLICA_BATCH_SIZE} NUM_EPISODES_PER_ITERATION: ${NUM_EPISODES_PER_ITERATION} NUM_EPOCHS: ${NUM_EPOCHS} STDCELL_PLACER: ${STDCELL_PLACER}"

export DESIGN_NAME=ariane_X4
export MACRO_COUNT=533
bash /workspace/run_script/cong_tsmc7.sh

export NETLIST_FILE=/workspace/Testcases/${DESIGN_NAME}/netlist.pb.txt
export INIT_PLACEMENT=/workspace/Testcases/${DESIGN_NAME}/initial.plc

# !!! change the following paths to the paths of the pre-trained model. Below is an example.
export CHECKPOINT_DIR="/workspace/logs/run_YOUR_PRETRAIN_MODEL/333/policies/checkpoints/policy_checkpoint_STEPNUMBER"
export SAVED_MODEL_DIR="/workspace/logs/run_YOUR_PRETRAIN_MODEL/333/policies/policy"

export CURRENT_TIME=$(date +%Y%m%d_%H%M%S)
export ROOT_DIR=/workspace/logs/run_${DESIGN_NAME}_${CURRENT_TIME}_ITER${ITERATION}_PRBS${PER_REPLICA_BATCH_SIZE}_NEPI${NUM_EPISODES_PER_ITERATION}_NE${NUM_EPOCHS}_PLCR${STDCELL_PLACER}_CKPT

echo "ROOT_DIR: ${ROOT_DIR}"
mkdir -p ${ROOT_DIR}
export REVERB_PORT=8008
export REVERB_SERVER="127.0.0.1:${REVERB_PORT}" # !!! this should not be changed
## In the present (CT-AC-5834) repo, in this file, we removed the following line that was present in this same file in the previous (CT-AC-3491) repo, because REVERB_COLLECT_SERVER is not used in the training job.
# export REVERB_COLLECT_SERVER="xxxxxx:${REVERB_PORT}" # !!! change this to hostmachine's IP address

export USE_GPU=True
export GLOBAL_SEED=333
