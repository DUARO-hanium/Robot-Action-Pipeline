# Robot-Action-Pipeline

DUARO 프로젝트의 로봇 동작 파이프라인. 데이터 수집 → 캘리브레이션 → 모방학습(ACT) → 규칙기반 동작 → 검증(replay)의 각 단계 스크립트와 설정을 담는다.

## 선행 조건

셋업 전체 절차(conda·WSL 커널·usbipd·ROS2 등): [settings.md](settings.md) 참조.


## 폴더 구성

| 폴더 | 역할 | lerobot 기반? |
|---|---|---|
| `calibration/motor/` | Dynamixel 모터 pulse ↔ 관절각 매핑 (그리퍼 교체 시 재캘리) | `lerobot-calibrate` 래퍼 |
| `calibration/camera/` | 픽셀 (u,v) ↔ world 좌표 (Homography), 내부파라미터 | 직접 구현 (OpenCV) |
| `data_collection/` | Teleoperation 시연 녹화 (관절+카메라) | `lerobot-record` 래퍼 |
| `training/` | ACT 모방학습 | `lerobot-train` 래퍼 |
| `replay/` | 녹화한 에피소드를 로봇이 그대로 재생 (ACT 학습 전 검증 필수) | `lerobot-replay` 래퍼 |
| `rule_based/` | 봉지 열기, 회전, FSM 시퀀서 등 하드코딩 동작 | 직접 구현 (예정) |
| `common/` | 공용 유틸: pixel_to_world, USB attach, 포트 자동탐지 | 직접 구현 |
| `configs/` | 긴 CLI 옵션을 YAML/JSON 프리셋으로 정리 | — |
| `data/` | 수집된 데이터셋 (record 실행 시 자동 생성) — **git 커밋 안 됨**(.gitignore), 다른 위치는 `DUARO_DATA_ROOT`로 지정 | 자동 생성 |
| `outputs/` | 학습 결과물·체크포인트 (train 실행 시 자동 생성) — **git 커밋 안 됨** | 자동 생성 |


## 실행 순서 (시연 준비)

1. `calibration/motor/` — 그리퍼 교체 후 재캘리
2. `calibration/camera/` — H_table, H_bag 생성
3. `data_collection/` — 시연 데이터 녹화
4. `replay/` — 녹화 데이터로 로봇 재생 검증
5. `training/` — ACT 학습
6. `rule_based/` — 시퀀서로 전체 loop 조립

## 라이선스

Apache License 2.0. LeRobot(HuggingFace/ROBOTIS, Apache-2.0) 기반. 상세는 `LICENSE`, `NOTICE` 참조.
