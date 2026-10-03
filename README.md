## < OAuth 로그인 구현을 위한 추가 설정 > 
### 1. Google Cloud OAuth 클라이언트 등록   
   Google Cloud에서 OAuth 클라이언트를 등록하고 발급받은 client-id, client-secret을 application-oauth.properties에서 별도로 관리합니다.   
   OAuth 인증이 완료된 후 Google이 사용자를 애플리케이션으로 리다이렉트할 승인된 리디렉션 URI는 다음과 같습니다.
   현재는 개발 단계이므로 로컬 환경 주소만 등록하며, AWS 배포 이후에는 배포된 서버의 리디렉션 URI를 추가로 등록해야 합니다.
   > http://localhost/login/oauth2/code/google

### 2. OAuth 인증정보 설정     
   src/main/resources/ 디렉토리에 application-oauth.properties 파일을 생성하고, 
   Google Cloud에서 발급받은 OAuth 클라이언트 ID와 클라이언트 보안 비밀을 등록합니다.    
   OAuth 인증정보는 보안상의 이유로 Git에 커밋하지 않으며, application-oauth.properties는 .gitignore에 등록되어 있습니다.   
   Google OAuth의 기본 scope에는 openid, profile, email이 포함되지만, OpenID Provider와 OpenID를 사용하지 않는 OAuth Provider를 동일한 OAuthService에서 처리하기 위해 openid scope는 제외하고 등록합니다.    
   application-oauth.properties에 필요한 OAuth 인증정보는 다음과 같습니다.
   > spring.security.oauth2.client.registration.google.client-id=클라이언트ID
     spring.security.oauth2.client.registration.google.client-secret=클라이언트Secret
     spring.security.oauth2.client.registration.google.scope=profile,email

---
