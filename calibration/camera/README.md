# calibration/camera — 픽셀 (u,v) ↔ world 좌표 변환

**목적:** RGB 카메라가 검출한 픽셀 좌표를 로봇이 이동 가능한 world 좌표(x, y)로 변환한다. **없으면 비전이 찾은 지점으로 로봇을 보낼 수 없음.**

**언제 필요:** rule-base 경로에서 vision → motion으로 연결할 때.

**RGB 단안**이라 depth 없음 → 타겟이 **고정된 평면**(작업대·봉투 거치대) 위에 있다고 가정하고 **Homography H (3×3)** 를 사전에 만든다.

## 필요한 파일 (계획)

| 파일 | 역할 |
|---|---|
| `aruco_homography.py` | ArUco 마커 4장 검출 → H 계산 → JSON 저장 |
| `robot_touch_homography.py` | 로봇 EE 터치 방식 → H 계산 (마커 대안) |
| `checkerboard_intrinsics.py` | 체커보드로 K(내부파라미터)·dist(왜곡) 측정 |
| `H_table.json` | 옷 grasp point용 (작업대 평면) |
| `H_bag.json` | 봉투 개구부 진입점용 (거치대 평면) |
| `intrinsics.json` | K, dist |

## Homography H 요약

이미지 평면 ↔ 작업 평면 대응 규칙, 3×3 행렬:

```
[x', y', w] = H @ [u, v, 1]     →     x = x'/w,  y = y'/w
```

- **미지수 8개** → 대응점 1쌍당 방정식 2개 → **최소 4쌍 마커 필요**. 더 많으면 최소제곱으로 정확도↑

## 두 가지 대응점 획득 방법

|  | ArUco 마커 | 로봇 터치 |
|---|---|---|
| 대응점 | 마커 4장 자동 검출 | EE 터치 + FK |
| world 좌표 출처 | 줄자 1회 측정 | FK (자 불필요) |
| 추가 필요 | 프린터 (마커 출력) | 그리퍼 TCP 오프셋 |
| 재캘리 | 스크립트 재실행만 | 터치 반복 |

## ArUco 방식 준비 사항

1. 마커 4장 인쇄 (ID 0~3, 한 변 5cm)
2. 작업 중 가려지지 않는 위치 (바깥 모서리)에 평평하게 부착
3. 각 마커 중심의 로봇 베이스 기준 (x, y) 실측 — 줄자 or EE 터치 1회
4. 작업대 높이 `TABLE_Z` 실측 (베이스 기준, m 단위)
5. `H_bag`용: 마커를 개구부 위치(거치대)에 세워 부착 후 동일 절차

## 실행 (계획)

```bash
python aruco_homography.py --output H_table.json --z 0.0
python aruco_homography.py --output H_bag.json  --z 0.15
```

## 사용처

이 폴더에서 만든 H·K·dist는 `common/pixel_to_world.py`에서 로드되어 `rule_based/`의 시퀀서에서 호출된다.

## 주의

- 마커 부착 위치가 바뀌거나, 카메라를 다시 장착하면 **재캘리 필수**
- 카메라 높이·각도 바뀌면 H도 다시
- z축 움직임은 옷을 들어 올릴 때만 사용하는 가정
