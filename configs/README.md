# configs — 실행 프리셋

긴 CLI 옵션을 YAML로 정리. `data_collection/record.sh` 같은 래퍼가 여기 파일을 읽어 CLI로 전달.

## 규칙

- 파일명: `<stage>_<task>.yaml` — task는 **데이터셋 폴더명과 동일한 전체 이름** (`omx_` 포함)
  - `record_omx_garment_pick.yaml`
  - `record_omx_bag_open.yaml`
  - `train_omx_garment_pick.yaml`
- 같은 stage 내에서는 task만 다름 (episode 수·시간 등이 태스크별로 차이 남)

## TODO

- [ ] `record_omx_garment_pick.yaml` — 지금 `record.sh`에 하드코딩된 옵션 이전
- [ ] `record_omx_bag_open.yaml` — 봉지 태스크 (episode_time_s 짧게)
- [ ] `train_omx_garment_pick.yaml` — ACT 학습 하이퍼파라미터 (chunk_size, steps 등)
- [ ] `record.sh`가 YAML을 파싱해서 CLI로 전달하도록 개선
