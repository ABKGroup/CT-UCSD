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

The above example runs 256 collector jobs in five different servers.

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
The above example runs 256 collector jobs in five different servers.

### **Job Configuration**  
- Again, the given example will use **256 collector jobs** and **1 training job** for the runs.

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

