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

### **Launching Training and Collector Jobs**  
To launch the training and collector jobs, execute the following commands:  
```bash
## Update set_envs.sh as needed (reverb server IP, netlist, etc.)
source ./run_script/set_envs.sh
./run_script/reverb_train_eval.sh

## Adjust the collector job index (you may want to run multiple collectors across different machines)
## Collector Server 1
## Update reverb server IP in ./run_script/set_envs_collect.sh
source ./run_script/set_envs_collect.sh
./run_script/run_collect1.sh

## Collector Server 2
## Update reverb server IP in ./run_script/set_envs_collect.sh
source ./run_script/set_envs_collect.sh
./run_script/run_collect2.sh

## Collector Server 3
## Update reverb server IP in ./run_script/set_envs_collect.sh
source ./run_script/set_envs_collect.sh
./run_script/run_collect3.sh

## Collector Server 4
## Update reverb server IP in ./run_script/set_envs_collect.sh
source ./run_script/set_envs_collect.sh
./run_script/run_collect4.sh

## Collector Server 5
## Update reverb server IP in ./run_script/set_envs_collect.sh
source ./run_script/set_envs_collect.sh
./run_script/run_collect5.sh
```

The above example runs 256 collector jobs in five different servers.

---

### **Job Configuration**  
- We are using **256 collector jobs** and **1 training job** for the runs.

---

### **Verification Checklist**  
Please verify the following tasks:  

1. **Training from Scratch:** [This GitHub is only for this item.]
   - Train the [CT-Ariane-X4](./Testcases/ariane_X4) testcase from scratch.


---

