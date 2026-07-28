# training — ACT 모방학습

수집한 데이터셋(`data/omx_<task>/`)으로 ACT 정책을 학습한다. **NVIDIA GPU 필요.**

## 사전 조건

- `data_collection/`으로 최소 50 에피소드 수집 완료 (ACT 권장치)
- `replay/`로 데이터 이상 여부 검증 완료

## 실행

```bash
bash train.sh                       # 기본: omx_garment_pick, 20000 steps
bash train.sh omx_bag_open 50000    # 태스크·스텝 지정
```

## 결과물

`--output_dir`에 지정된 경로. 기본: `outputs/train/omx_<task>/`

```
outputs/train/omx_<task>/
├── checkpoints/
│   ├── 010000/model.safetensors
│   └── 020000/model.safetensors
└── config.yaml
```

**`outputs/`는 `.gitignore` 대상.** 가중치는 별도 백업 위치 사용.

## 자율 실행 (Rollout)

Leader 없이 카메라만으로 학습된 정책 실행:

```bash
lerobot-rollout \
  --strategy.type=base \
  --robot.type=omx_follower --robot.port=/dev/ttyACM0 --robot.id=omx_follower_arm \
  --robot.cameras="{ front: {type: opencv, index_or_path: 0, width: 640, height: 480, fps: 30}}" \
  --policy.path=outputs/train/omx_garment_pick
```

## 관련 lerobot 소스

- 진입점: `~/lerobot/src/lerobot/scripts/train.py`
- ACT 모델: `~/lerobot/src/lerobot/policies/act/modeling_act.py`
- ACT 하이퍼파라미터: `~/lerobot/src/lerobot/policies/act/configuration_act.py` (chunk_size 등 기본값)
