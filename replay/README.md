# replay — 녹화 에피소드 재생 검증

녹화된 action을 로봇이 그대로 실행하는지 확인. **ACT 학습 전에 반드시 해볼 것** — 데이터 이상, 그리퍼 매핑 오류, 캘리 실수 등을 조기 발견.

## 실행

```bash
bash replay.sh                          # 기본: omx_garment_pick, episode 0
bash replay.sh omx_garment_pick 3       # episode 3
bash replay.sh omx_bag_open 0
```

## 주의

- `data_collection/`의 `--robot.port`와 **같은 포트** 사용 (다른 터미널에서 teleop/record 돌지 않도록)
- 사람 없는 상태에서 실행 (로봇이 자율로 움직임)
- Leader arm 불필요 (Follower만 재생)

## 관련 lerobot 소스

- 진입점: `~/lerobot/src/lerobot/replay.py`
- 데이터 로더: `~/lerobot/src/lerobot/datasets/lerobot_dataset.py`
