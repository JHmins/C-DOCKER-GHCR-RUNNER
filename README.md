## ? C-Calculator CI/CD Project

본 프로젝트는 GitHub Actions와 Windows Self-hosted Runner를 활용하여 C 프로그램의 빌드, 테스트, 그리고 Docker 컨테이너 배포까지의 전 과정을 자동화합니다.

---
### ? 핵심 개념 요약
- Self-hosted Runner: 사용자가 직접 관리하는 시스템(Windows 등)에서 작업을 실행하며, 서비스 형태로 상시 가동할 수 있습니다.

- Workflow & Job: GitHub의 이벤트(Push, PR 등)에 의해 워크플로가 트리거되고, 실제 작업(Job)은 연결된 러너에서 수행됩니다.

- Docker Compose: 단일 및 다중 컨테이너 운영을 지원하며, docker compose up 명령을 통해 이미지 빌드, 컨테이너 재생성 및 시작을 한 번에 처리합니다.

---
### ?? 전체 시스템 구성도
```text

[개발자 PC]
    │
    │ git push
    ▼
[GitHub Repository]
    │
    │ GitHub Actions Workflow
    ▼
[Windows Self-hosted Runner]
    ├─ Git
    ├─ Docker Desktop 또는 Docker Engine
    ├─ GHCR 로그인
    ├─ Docker image build
    ├─ C 프로그램 테스트
    ├─ GHCR push
    └─ docker compose up -d 로 운영 컨테이너 재배포
            │
            ▼
[운영 컨테이너]
    └─ C 실행 파일 포함 이미지

```
---
### ?? 상세 프로세스
 푸시개발자가 main 브랜치로 코드를 Push하면 자동화 시작워크플로 실행GitHub Actions가 이벤트를 감지하고 Windows 러너에 Job 할당빌드 및 테스트러너 PC의 GCC를 통해 C 코드를 컴파일하고 make test 수행도커 빌드 & 푸시생성된 바이너리를 포함하여 Docker 이미지를 생성하고 GHCR에 저장자동 배포docker compose를 사용해 기존 컨테이너를 내리고 최신 이미지로 재배포

| 단계 | 설명 | 
| -------- | -------- | 
|코드 푸시 | 개발자가 main 브랜치로 코드를 Push하면 자동화 시작 | 
|워크플로 실행 | GitHub Actions가 이벤트를 감지하고 Windows 러너에 Job 할당 | 
|빌드 및 테스트 | 러너 PC의 GCC를 통해 C 코드를 컴파일하고 make test 수행|
|도커 빌드 & 푸시 | 생성된 바이너리를 포함하여 Docker 이미지를 생성하고 GHCR에 저장 |
|자동 배포 | docker compose를 사용해 기존 컨테이너를 내리고 최신 이미지로 재배포 |
