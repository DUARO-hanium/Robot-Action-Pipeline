#!/usr/bin/env bash
# lerobot-record 래퍼
# 사용법: bash record.sh [task_name]
#   task_name 생략 시 default = garment_pick

set -e

TASK="${1:-garment_pick}"
CONFIG="../configs/record_${TASK}.yaml"

if [ ! -f "$CONFIG" ]; then
    echo "config 없음: $CONFIG"
    echo "사용 가능한 task:"
    ls ../configs/record_*.yaml 2>/dev/null | sed 's|.*record_||;s|\.yaml||'
    exit 1
fi

# TODO: YAML을 파싱해 CLI로 전달하거나, 아래 옵션을 config에서 읽도록 개선
# 지금은 하드코드된 예시:

DATASET_ROOT="/mnt/c/Users/kimyo/Desktop/university/2026 hanium/DUARO/data/omx_${TASK}"

lerobot-record \
  --robot.type=omx_follower \
  --robot.port=/dev/ttyACM1 \
  --robot.id=omx_follower_arm \
  --robot.cameras="{ front: {type: opencv, index_or_path: 0, width: 640, height: 480, fps: 30}, wrist: {type: opencv, index_or_path: 2, width: 640, height: 480, fps: 30}}" \
  --teleop.type=omx_leader \
  --teleop.port=/dev/ttyACM0 \
  --teleop.id=omx_leader_arm \
  --display_data=true \
  --dataset.repo_id=duaro/omx_${TASK} \
  --dataset.root="${DATASET_ROOT}" \
  --dataset.single_task="Pick up the garment from the table and place it flat" \
  --dataset.num_episodes=5 \
  --dataset.episode_time_s=100 \
  --dataset.reset_time_s=10 \
  --dataset.push_to_hub=false \
  --resume=true
