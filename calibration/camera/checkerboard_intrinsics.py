"""
체커보드로 카메라 내부파라미터 K (3x3) 와 왜곡 dist 계산 → JSON 저장.

사용법:
    python checkerboard_intrinsics.py --pattern 9x6 --square 25mm

TODO:
    - argparse (체커보드 패턴 크기, 정사각형 실측 크기)
    - 여러 각도에서 20~30장 캡처 (다양한 pose 필요)
    - cv2.findChessboardCorners + cv2.cornerSubPix
    - cv2.calibrateCamera 로 K, dist 계산
    - 재투영 오차 리포트
    - intrinsics.json 저장
"""
