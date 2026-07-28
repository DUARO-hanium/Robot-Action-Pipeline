# data_collection — Teleoperation 시연 녹화

Leader arm으로 Follower arm을 조종하며 관절값+카메라를 녹화한다. ACT 학습용 데이터셋 생성 단계.

## 사전 준비 (매번)

**T0 (Windows PowerShell, 관리자):**
```powershell
usbipd list
usbipd attach --wsl --busid <Follower_BUSID>
usbipd attach --wsl --busid <Leader_BUSID>
usbipd attach --wsl --busid <카메라_BUSID>   # 카메라 개수만큼
```

**T1 (WSL, `conda activate lerobot`):**
```bash
ls /dev/ttyACM*             # Leader/Follower 2개 확인
ls /dev/video*              # 카메라 확인
lerobot-find-port           # 포트 식별 (뺐다 꽂으며)
lerobot-find-cameras opencv # 카메라 인덱스 (front/wrist 확인)
```

## 실행

```bash
bash record.sh              # 프리셋 사용
```

또는 태스크 지정:
```bash
bash record.sh garment_pick
bash record.sh bag_open
```

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
