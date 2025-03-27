This repository provides the scripts and test cases used to run [Circuit Training](https://github.com/google-research/circuit_training)
at UCSD. We copied the original Circuit Training (CT) repository and made the necessary modifications to run our experiments. To run CT on our test cases, follow the instructions below.

### **Building the Docker Environment**  
To build the Docker environment, use the following commands:  
```bash
cd tools_ours
./docker_image_build.sh
```

---

### **Starting the Docker Container**  
To start the Docker container, use the command below:  
```bash
## You may need to update the user ID or run as root.
docker run --gpus all -u 1031:1032 --network=host -it --rm -v $(pwd):/workspace --workdir /workspace circuit_training:corepy39cu12 bash
```

---

### **Training From Scratch**  
To launch the training from scratch, execute the following commands:  
```bash
## Update set_envs.sh (Lines: 38, 39 and 41)
source ./run_script/set_envs.sh
./run_script/reverb_train_eval.sh

## Collector Server 1
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect1.sh

## Collector Server 2
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect2.sh

## Collector Server 3
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect3.sh

## Collector Server 4
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect4.sh

## Collector Server 5
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect5.sh
```

The above example runs 256 collector jobs across five different servers, each with 96 CPU threads, and runs one training job, one evaluation job, and a reverb server on the main server. The main server is equipped with eight NVIDIA-V100 GPUs and 96 CPU threads.

---

### **Fine-tuning the Pre-trained Model**
First download the pre-trained model released by Circuit Training authors from [here](https://github.com/google-research/circuit_training?tab=readme-ov-file#how-to-use-the-checkpoint).
To fine-tune the pre-trained "AlphaChip" model, execute the following commands:  
```bash
## Update set_envs_FT.sh (Lines: 38, 39, 41, 47 and 48)
source ./run_script/set_envs_FT.sh
./run_script/reverb_train_eval_FT.sh

## Collector Server 1
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect1.sh

## Collector Server 2
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect2.sh

## Collector Server 3
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect3.sh

## Collector Server 4
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect4.sh

## Collector Server 5
## Update ./run_script/set_envs_collect.sh (Lines: 38, 39, 41 and 54)
source ./run_script/set_envs_collect.sh
./run_script/run_collect5.sh
```
The above example runs 256 collector jobs across five different servers, each with 96 CPU threads, and runs one training job, one evaluation job, and a reverb server on the main server. The main server is equipped with eight NVIDIA-V100 GPUs and 96 CPU threads.

---
### **Pre-training Model with MemPoolGroup NG45**
The following example shows pre-training the model with seven variants of MemPoolGroup NG45: x-flip, y-flip, xy-flip, shift, shift-x-flip, shift-y-flip, shift-xy-flip. 

```bash
## Update ./run_script/run_script_pt_mpg/set_evs_PT.sh (Lines: 61-89 and 101)
source ./run_script/run_script_pt_mpg/set_evs_PT.sh
./run_script/run_script_pt_mpg/reverb_train_eval_PT.sh

## Collector Server 1
## Update ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh (Lines: 61-89 and 100)
source ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh
./run_script/run_script_pt_mpg/run_collect1_PT.sh

## Collector Server 2
## Update ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh (Lines: 61-89 and 100)
source ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh
./run_script/run_script_pt_mpg/run_collect2_PT.sh

## Collector Server 3
## Update ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh (Lines: 61-89 and 100)
source ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh
./run_script/run_script_pt_mpg/run_collect3_PT.sh

## Collector Server 4
## Update ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh (Lines: 61-89 and 100)
source ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh
./run_script/run_script_pt_mpg/run_collect4_PT.sh

## Collector Server 5
## Update ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh (Lines: 61-89 and 100)
source ./run_script/run_script_pt_mpg/set_evs_collect_PT.sh
./run_script/run_script_pt_mpg/run_collect5_PT.sh

```

The above example runs 252 collector jobs (36 for each variant of MemPoolGroup-NG45) across five different servers, each with 96 CPU threads. In addition, it runs one training job, one evaluation job, and a reverb server on the main server, which is equipped with eight NVIDIA V100 GPUs and 96 CPU threads.

Once pre-training is complete, you can use the checkpoint and policy from the `/workspace/logs/run_YOUR_PRETRAIN_MODEL/<seed>/policies` directory to fine-tune the model on the target design.

---

### **Pre-training Model with Scaled Versions of CT-Ariane**
The following example demonstrates pre-training the model using both x-flip and y-flip variants of CT-Ariane, CT-Ariane-X2, and CT-Ariane-X4 (i.e., six netlists).

```bash 
## Update ./run_script/run_script_pt_ariane_x4/set_evs_PT.sh (Lines: 61-86 and 98)
source ./run_script/run_script_pt_ariane_x4/set_evs_PT.sh
./run_script/run_script_pt_ariane_x4/reverb_train_eval_PT.sh

## Collector Server 1
## Update ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh (Lines: 61-86 and 97)
source ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh
./run_script/run_script_pt_ariane_x4/run_collect1_PT.sh

## Collector Server 2
## Update ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh (Lines: 61-86 and 97)
source ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh
./run_script/run_script_pt_ariane_x4/run_collect2_PT.sh

## Collector Server 3
## Update ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh (Lines: 61-86 and 97)
source ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh
./run_script/run_script_pt_ariane_x4/run_collect3_PT.sh 

## Collector Server 4
## Update ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh (Lines: 61-86 and 97)
source ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh
./run_script/run_script_pt_ariane_x4/run_collect4_PT.sh

## Collector Server 5
## Update ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh (Lines: 61-86 and 97)
source ./run_script/run_script_pt_ariane_x4/set_evs_collect_PT.sh
./run_script/run_script_pt_ariane_x4/run_collect5_PT.sh
```

The above example runs 252 collector jobs (42 for each variant of CT-Ariane-X4) across five different servers, each with 96 CPU threads. In addition, it runs one training job, one evaluation job, and a reverb server on the main server, which is equipped with eight NVIDIA V100 GPUs and 96 CPU threads.

Once pre-training is complete, you can use the checkpoint and policy from the `/workspace/logs/run_YOUR_PRETRAIN_MODEL/<seed>/policies` directory to fine-tune the model on the target design.

---

### **Testcases**  
Here are the open test cases on which we ran CT from scratch and fine-tuned 
the pre-trained model released by the authors of the Circuit Training paper.
Note that we set "MACRO\_COUNT" to the number of macros in the design plus one.

1. [CT-Ariane](./Testcase/ariane/):
    - **DESIGN_NAME**: ariane
    - **MACRO_COUNT**: 134
    - Use ./run_scripts/cong_tsmc7.sh to update the routing resource.

2. [CT-Ariane-X2](./Testcase/ariane_X2/):
    - **DESIGN_NAME**: ariane_X2
    - **MACRO_COUNT**: 267
    - Use ./run_scripts/cong_tsmc7.sh to update the routing resource.

3. [CT-Ariane-X4](./Testcase/ariane_X4_xflip_yflip/):
    - **DESIGN_NAME**: ariane_X4_xflip_yflip
    - **MACRO_COUNT**: 533
    - Use ./run_scripts/cong_tsmc7.sh to update the routing resource.

4. [Ariane-NG45](./Testcase/ariane133_ng45):
    - **DESIGN_NAME**: ariane133_ng45
    - **MACRO_COUNT**: 134
    - Use ./run_scripts/cong_ng45.sh to update the routing resource.

5. [Ariane-ASAP7](./Testcase/ariane_asap7)
    - **DESIGN_NAME**: ariane_asap7
    - **MACRO_COUNT**: 134
    - Use ./run_scripts/cong_asap7.sh to update the routing resource.

6. [BlackParrot-NG45](./Testcase/bp_ng45/)
    - **DESIGN_NAME**: bp_ng45
    - **MACRO_COUNT**: 221
    - Use ./run_scripts/cong_ng45.sh to update the routing resource.

7. [BlackParrot-ASAP7](./Testcase/bp_asap7/)
    - **DESIGN_NAME**: bp_asap7
    - **MACRO_COUNT**: 221
    - Use ./run_scripts/cong_asap7.sh to update the routing resource.

8. [MemPoolGroup-NG45](./Testcase/mempool_group_ng45/)
    - **DESIGN_NAME**: mempool_group_ng45
    - **MACRO_COUNT**: 325
    - Use ./run_scripts/cong_ng45.sh to update the routing resource.

9. [MemPoolGroup-ASAP7](./Testcase/mempool_group_asap7/)
    - **DESIGN_NAME**: mempool_group_asap7
    - **MACRO_COUNT**: 325
    - Use ./run_scripts/cong_asap7.sh to update the routing resource.

If you want to generate these test cases, please refer to the MacroPlacement repository [here](https://github.com/TILOS-AI-Institute/MacroPlacement).


---

