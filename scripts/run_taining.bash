#!/bin/bash
#SBATCH --job-name=train-2_5_7B
#SBATCH --partition=Teaching #Check Edinburgh's specific GPU partition name
#SBATCH --nodes=1                  # We are running a single-node, multi-GPU setup
#SBATCH --gres=gpu:8               # Requesting 8 GPUs 
#SBATCH --mem=128G                 # Request sufficient RAM for model offloading
#SBATCH --output=logs/slurm-%j.out # Standard output log
#SBATCH --error=logs/slurm-%j.err  # Standard error log

# --- Environment Setup ---
cd  /home/s2412780/MLP-CW3/VL-Rethinker
source /home/s2412780/MLP-CW3/activate-rethinker.sh


# --- NFS & Ray Safeguards (CRITICAL) ---
# Ray creates a massive number of temporary files and object stores. 
# Writing these to an NFS will cause severe I/O bottlenecks and file lock crashes.
# Force Ray to use the compute node's local storage (e.g., /tmp) instead of the shared drive.
export RAY_TMPDIR=/tmp/ray_${SLURM_JOB_ID}
mkdir -p $RAY_TMPDIR

# Prevent tokenizer parallelism deadlocks in Ray workers
export TOKENIZERS_PARALLELISM=false

# --- Execution ---
echo "Starting training on $(hostname) with 4 GPUs..."
bash scripts/train_vlm_multi.sh

ray stop  # Clean up Ray processes after training completes
echo "Training completed."
