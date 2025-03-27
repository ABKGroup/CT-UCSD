tmux kill-session -t reverb
tmux kill-session -t train
tmux kill-session -t eval

for i in $(seq 1 256); do
    tmux kill-session -t collect_job_$(printf "%02d" $((i)))
done

pkill -f plc_
