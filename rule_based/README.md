# rule_based — 규칙기반 동작

시연 시나리오(①~⑰)의 정형 동작과 상위 시퀀서(FSM). **하드웨어 구성(그리퍼·Z축·카메라 배치)이 확정되기 전까지 구체 파일은 만들지 않음.** 폴더만 확보.

## 앞으로 들어갈 것 (계획)

| 파일 | 역할 |
|---|---|
| `primitives/rotate_pan.py` | shoulder_pan 180° 회전 (작업대↔봉투 방향 전환) — 이미 `progress_code/`에 초안 있음 |
| `primitives/bag_open.py` | 봉지 열기 하드코드 시퀀스 (Cartesian 경로 + 그리퍼 open/close) |
| `primitives/z_lift.py` | Z축 리프트 제어 (OpenRB-150 / Dynamixel), YOLO 의류 종류→높이 매핑 |
| `primitives/dual_grasp.py` | 양팔 동시 파지 동기화 (⑩ 옷 grasp) |
| `sequencer.py` | ①~⑰ FSM 상위 시퀀서 — 각 단계 전환 조건, 실패 시 복구, 전체 loop |
| `pixel_to_world_wrapper.py` | `common/pixel_to_world` 호출 + 태스크별 H 선택 |

## 원칙

- **"Rule-base로 해보고 안 되면 모방학습(ACT)."**
- 봉지 열기(①②) 좌표는 텔레옵으로 측정한 값을 하드코딩
- 옷 집기·펼침(⑩⑪)은 CPN 키포인트(→ Detection 레포)로 grasp point 검출 후 IK
- 모션 실행 방식은 **3안 비교 후 미확정**: MoveIt2 / LeRobot replay / ikpy
  - 상세: 프로젝트 루트의 `문서/데모_시연계획.md` 참조

## 시연 시나리오

`문서/데모_시연계획.md`의 ①~⑰ 표 참조. sequencer.py는 이 순서를 상태머신으로 구현한다.
