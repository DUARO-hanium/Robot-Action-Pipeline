# common — 공용 유틸

여러 stage에서 공유하는 헬퍼. 두 군데 이상에서 같은 코드가 필요해질 때만 추가.

## 앞으로 들어갈 것 (계획)

| 파일 | 역할 | 쓰는 곳 |
|---|---|---|
| `pixel_to_world.py` | Homography H를 로드해서 픽셀 (u,v) → world (x,y) 변환 | `calibration/camera/`에서 만들고 `rule_based/`에서 씀 |
| `port_finder.py` | 시리얼 번호로 Leader/Follower 자동 구분 (매번 `lerobot-find-port` 치기 귀찮음 해소) | 모든 sh 스크립트 |
| `usb_attach.sh` | Windows PowerShell에서 `usbipd attach` 자동화 | 셋업 자동화 |
| `frame_transform.py` | 좌표계 변환 (camera ↔ EE ↔ base) | `rule_based/` |

## 사용

```python
# 예: rule_based/sequencer.py 안에서
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
from common.pixel_to_world import pixel_to_world

x, y = pixel_to_world(u=320, v=240, H_path='../calibration/camera/H_table.json')
```

패키지화(setup.py) 안 하고 sys.path로 처리 — 대회 규모에선 충분.
