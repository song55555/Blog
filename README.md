# 블로그 프로젝트 🚀

## 👋 소개

이 프로젝트는 **Ruby on Rails**를 백엔드로, **Vue.js**와 **Tailwind CSS**를 프론트엔드로 사용하여 개발된 블로그 웹 애플리케이션입니다. 사용자는 기사를 작성, 편집, 삭제하고, 카테고리 및 태그별로 필터링하거나 검색할 수 있습니다. 또한, 간단한 사용자 인증 기능을 제공하며 모바일 환경에서도 최적화된 디자인을 경험할 수 있습니다.

## 🛠️ 기술 스택

*   **백엔드:** Ruby on Rails
*   **프론트엔드:** Vue.js (Vite), Tailwind CSS
*   **데이터베이스:** PostgreSQL

## ✨ 주요 기능

### 📝 블로그 기사 관리

*   기사 투고, 편집, 삭제 기능 (Rails)
*   기사 카테고리 및 태그 연동 (Rails)

### 🔍 검색 및 필터링

*   Vue.js를 이용한 카테고리별 필터링 및 검색 기능

### 🔑 사용자 인증

*   Rails 기반의 간단한 로그인/로그아웃 기능

### 📱 리스폰시브 디자인

*   Tailwind CSS 미디어 쿼리를 이용한 모바일 지원 디자인

### ➕ 추가 요소

*   **유닛 테스트 (RSpec):**
    *   User 모델 유효성 검증 테스트
    *   PostsController 액션 테스트
    *   `api/users/sign_in` API 엔드포인트 테스트
*   **디플로이 절차 문서화:** (추후 디플로이 절차를 추가할 예정입니다.)

## ⚙️ 특이 사항

*   프론트엔드 개발 시 Vite 사용
*   백엔드 API 엔드포인트와 프론트엔드 개발 서버 간의 CORS 문제 해결

## 🚀 프로그램 셋업 절차

### 1. 📦 프로젝트 클론

```bash
git clone https://github.com/song55555/Blog.git
cd Blog
```

### 2. ⚙️ 백엔드 의존성 설치 및 환경 설정

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
```
⚠️ 참고: rails db:seed 명령은 샘플 데이터를 데이터베이스에 추가합니다.

### 3. 🚄 백엔드 서버 실행

```bash
rails s
```
백엔드 서버는 기본적으로 http://localhost:3000 주소에서 실행됩니다.

### 4. ⚛️ 프론트엔드 의존성 설치 및 서버 실행

```bash
cd frontend
npm install
npm run dev
```
프론트엔드 개발 서버는 기본적으로 http://localhost:5173 주소에서 실행됩니다.

### 5. ✅ 애플리케이션 확인

웹 브라우저에서 `http://localhost:5173` 주소로 접속하여 애플리케이션을 확인합니다.
