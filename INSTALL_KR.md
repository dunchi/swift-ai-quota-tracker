# CodexBar 커스텀 버전 설치 가이드

이 저장소는 [CodexBar](https://github.com/steipete/CodexBar)의 커스텀 버전으로, 메뉴바에 더 많은 정보를 표시하도록 개선되었습니다.

## 주요 변경사항

### 새로운 표시 모드 4종 추가

1. **Session Detail** - `S:94% (3h 36m) W:82% (2d 21h)`
   - 세션과 주간 정보를 자세하게 표시

2. **Compact** - `94% 3h36m | 82% 2d21h`
   - 간결한 형식으로 표시

3. **Compact with Label** - `S 94% 3h36m W 82% 2d21h`
   - 라벨과 함께 간결하게 표시

4. **Minimal** ✨ (기본값) - `91 02:58 / 82 2:02`
   - 최소한의 정보만 표시
   - 세션: 퍼센트 + 시:분
   - 주간: 퍼센트 + 일:시간

### 폰트 개선

- 등폭 숫자 폰트 적용 (`monospacedDigitSystemFont`)
- 크기: 13pt
- 숫자가 깔끔하게 정렬되어 가독성 향상

## 요구사항

- macOS 14+ (Sonoma)
- Xcode 또는 Swift 빌드 환경

## 설치 방법

### 1. 저장소 클론

```bash
git clone https://github.com/dunchi/swift-ai-quota-tracker.git
cd swift-ai-quota-tracker
```

### 2. 빌드 및 패키징

```bash
# ad-hoc 서명으로 빌드 (Apple Developer 계정 불필요)
CODEXBAR_SIGNING=adhoc ./Scripts/package_app.sh
```

빌드가 완료되면 `CodexBar.app`이 생성됩니다.

### 3. 애플리케이션 설치

```bash
# Applications 폴더로 이동
mv CodexBar.app /Applications/

# 실행
open /Applications/CodexBar.app
```

### 4. 보안 경고 해결 (첫 실행 시)

macOS가 "확인되지 않은 개발자" 경고를 표시할 수 있습니다.

**방법 1: 시스템 설정에서 허용**
1. **시스템 설정** → **개인정보 보호 및 보안**
2. 하단의 "CodexBar.app이 차단되었습니다" 옆 **"확인 없이 열기"** 클릭

**방법 2: 우클릭으로 열기**
1. Applications 폴더에서 CodexBar.app 우클릭
2. **열기** 선택
3. 경고창에서 **열기** 클릭

### 5. 기존 CodexBar 제거 (선택사항)

Homebrew로 설치한 원본 CodexBar를 사용 중이라면:

```bash
# 기존 버전 종료
killall CodexBar

# Homebrew 버전 제거
brew uninstall codexbar
```

## 설정 변경

앱을 실행한 후:

1. 메뉴바의 CodexBar 아이콘 클릭
2. **Settings...** 선택
3. **Display** 탭에서 원하는 표시 모드 선택
   - Minimal (기본값)
   - Session Detail
   - Compact
   - Compact with Label
   - 기타 기존 모드들

## 업데이트

```bash
cd swift-ai-quota-tracker
git pull
CODEXBAR_SIGNING=adhoc ./Scripts/package_app.sh
mv CodexBar.app /Applications/
```

## 트러블슈팅

### 빌드 오류

**의존성 문제**:
```bash
swift package resolve
swift build -c release
```

**캐시 정리**:
```bash
rm -rf .build
swift build -c release
```

### 실행 오류

**권한 문제**:
- 시스템 설정 → 개인정보 보호 및 보안에서 CodexBar 허용

**중복 실행**:
```bash
# 기존 프로세스 종료
killall CodexBar
```

### 데이터가 표시되지 않음

1. Settings → Providers에서 사용하는 AI 서비스 활성화
2. 각 서비스의 인증 정보 설정 (CLI, 브라우저 쿠키, OAuth 등)

## 원본 프로젝트

이 커스텀 버전은 다음 프로젝트를 기반으로 합니다:
- [CodexBar](https://github.com/steipete/CodexBar) by Peter Steinberger

## 라이선스

MIT License - 원본 프로젝트와 동일

## 지원

문제가 발생하면 이 저장소의 Issues에 보고해주세요.
