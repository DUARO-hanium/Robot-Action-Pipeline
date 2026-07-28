#!/usr/bin/env bash
# lerobot-replay 래퍼
# 사용법: bash replay.sh [task_name] [episode]

set -e

TASK="${1:-omx_garment_pick}"
EPISODE="${2:-0}"

DATASET_ROOT="/mnt/c/Users/kimyo/Desktop/university/2026 hanium/DUARO/data/${TASK}"

lerobot-replay \
  --robot.type=omx_follower \
  --robot.port=/dev/ttyACM0 \
  --robot.id=omx_follower_arm \
  --dataset.repo_id="duaro/${TASK}" \
  --dataset.root="${DATASET_ROOT}" \
  --dataset.episode="${EPISODE}"
