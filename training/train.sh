#!/usr/bin/env bash
# lerobot-train (ACT) 래퍼
# 사용법: bash train.sh [task_name] [steps]

set -e

TASK="${1:-omx_garment_pick}"
STEPS="${2:-20000}"

DATASET_ROOT="/mnt/c/Users/kimyo/Desktop/university/2026 hanium/DUARO/data/${TASK}"

lerobot-train \
  --dataset.repo_id="duaro/${TASK}" \
  --dataset.root="${DATASET_ROOT}" \
  --policy.type=act \
  --output_dir="outputs/train/${TASK}" \
  --policy.device=cuda \
  --steps="${STEPS}"
