"""
ArUco 4장 검출 → Homography H (3x3) 계산 → JSON 저장.

사용법:
    python aruco_homography.py --output H_table.json

TODO:
    - argparse (output path, camera index, marker size, ID 매핑)
    - cv2.aruco.DICT_4X4_50 로 마커 검출
    - 각 마커 중심 픽셀 좌표 (u, v) 추출
    - 사용자 입력 or 설정 파일에서 각 마커의 world 좌표 (x, y) 로드
    - cv2.findHomography() 로 H 계산 (RANSAC 옵션)
    - H를 JSON으로 저장 (numpy array → list 변환)
    - 시각화: 검출된 마커 + 재투영 오차 표시
"""
