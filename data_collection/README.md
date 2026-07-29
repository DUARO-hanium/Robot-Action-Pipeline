# data_collection — Teleoperation 시연 녹화

Leader arm으로 Follower arm을 조종하며 관절값+카메라를 녹화한다. ACT 학습용 데이터셋 생성 단계.

## 사전 준비 (매번)

공통 절차 — **레포 루트 [settings.md](../settings.md)의 "2. 매번 하는 것"** 수행:
usbipd attach(T0, Windows 관리자 PowerShell) → 장치 확인·포트/카메라 인덱스 식별(T1, WSL `conda activate lerobot`).

record 특이사항: `lerobot-find-cameras opencv` 캡처 이미지로 **front/wrist 인덱스를 반드시 구분**해둘 것 — 아래 `--robot.cameras` 옵션에 그대로 들어감.

## Teleoperation 동작 확인 (record 전 권장)

카메라·녹화 없이 Leader→Follower 미러링만 먼저 확인:

```bash
lerobot-teleoperate \
  --robot.type=omx_follower \
  --robot.port=/dev/ttyACM0 \
  --robot.id=omx_follower_arm \
  --teleop.type=omx_leader \
  --teleop.port=/dev/ttyACM1 \
  --teleop.id=omx_leader_arm
```

- 관절값이 터미널에 실시간 표시되고 Follower가 Leader를 따라 움직이면 정상
- ⚠️ **id는 매번 동일하게** (`omx_follower_arm`/`omx_leader_arm`) — 바꾸면 새 캘리브레이션 요구됨
- ⚠️ 포트(ACM0/1)는 뺐다 꽂으면 바뀔 수 있음 — `lerobot-find-port`로 매번 확인
- (선택) `--log_csv=teleop_log.csv` 붙이면 관절값이 CSV로 저장됨 

## 실행

```bash
bash record.sh              # 프리셋 사용
```

또는 태스크 지정 (데이터셋 폴더명과 동일한 전체 이름):
```bash
bash record.sh omx_garment_pick
bash record.sh omx_bag_open
```

- 데이터셋 위치는 기본으로 **레포 안 `data/`**에 저장 (`.gitignore` 대상이라 커밋 안 됨) — 다른 곳이면 `export DUARO_DATA_ROOT=/path/to/data`

## 녹화 중 키보드

| 키 | 동작 |
|---|---|
| → | 현재 에피소드 조기 종료, 다음으로 |
| ← 현재 에피소드 취소하고 재녹화 |
| ESC | 전체 중단 |

## 결과물 위치

`--dataset.root`에 지정된 경로. 기본: `/mnt/c/Users/kimyo/Desktop/university/2026 hanium/DUARO/data/<task>/`

```
data/<task>/
├── meta/{info.json, episodes.jsonl, tasks.jsonl, stats.json}
├── data/chunk-000/episode_00000N.parquet       # 관절 시계열 (6-dim)
└── videos/chunk-000/observation.images.{front,wrist}/episode_00000N.mp4
```

## Trouble Shooting

| 오류 | 해결 |
|---|---|
| `Missing motor IDs: 11, 12, 13` | 케이블 전부 뽑고 **12V → 5V → USB 순서**로 재연결. baud 1,000,000 유지 |
| 포트 안 보임 | `usbipd attach` 풀렸는지 확인 |
| ACM0/1 뒤바뀜 | `lerobot-find-port` 재확인 or `/dev/serial/by-id/`로 구분 |
| fps 불안정 | `--dataset.num_image_writer_processes=1` 추가 |
| 폴더 이미 있음 에러 | `rm -rf data/<task>` 또는 `--resume=true` |

## 관련 lerobot 소스

- 진입점: `~/lerobot/src/lerobot/record.py`
- 데이터셋 스키마: `~/lerobot/src/lerobot/datasets/lerobot_dataset.py`
- 카메라 dict 문법: `~/lerobot/src/lerobot/cameras/opencv/configuration_opencv.py`
