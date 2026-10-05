## < OAuth 로그인 구현을 위한 추가 설정 > 
### 1-1. Google Cloud OAuth 클라이언트 등록   
   Google Cloud에서 OAuth 클라이언트를 등록하고 발급받은 client-id, client-secret을 application-oauth.properties에서 별도로 관리합니다.   
   OAuth 인증이 완료된 후 Google이 사용자를 애플리케이션으로 리다이렉트할 승인된 리디렉션 URI는 다음과 같습니다.
   현재는 개발 단계이므로 로컬 환경 주소만 등록하며, AWS 배포 이후에는 배포된 서버의 리디렉션 URI를 추가로 등록해야 합니다.
   > http://localhost/login/oauth2/code/google

### 1-2. Google OAuth 인증정보 설정     
   src/main/resources/ 디렉토리에 application-oauth.properties 파일을 생성하고, 
   Google Cloud에서 발급받은 OAuth 클라이언트 ID와 클라이언트 보안 비밀을 등록합니다.    
   OAuth 인증정보는 보안상의 이유로 Git에 커밋하지 않으며, application-oauth.properties는 .gitignore에 등록되어 있습니다.   
   Google OAuth의 기본 scope에는 openid, profile, email이 포함되지만, OpenID Provider와 OpenID를 사용하지 않는 OAuth Provider를 동일한 OAuthService에서 처리하기 위해 openid scope는 제외하고 등록합니다.    
   application-oauth.properties에 필요한 OAuth 인증정보는 다음과 같습니다.
   ~~~
   spring.security.oauth2.client.registration.google.client-id=클라이언트ID
   spring.security.oauth2.client.registration.google.client-secret=클라이언트Secret
   spring.security.oauth2.client.registration.google.scope=profile,email
   ~~~

### 2-1. 네이버 오픈 API OAuth 클라이언트 등록
네이버 오픈 API에서 OAuth 클라이언트를 등록하고 발급받은 client-id, client-secret을 application-oauth.properties에서 별도로 관리합니다.   
OAuth 인증이 완료된 후 네이버가 사용자를 애플리케이션으로 리다이렉트할 승인된 리디렉션 URI는 다음과 같습니다.
현재는 개발 단계이므로 로컬 환경 주소만 등록하며, AWS 배포 이후에는 배포된 서버의 리디렉션 URI를 추가로 등록해야 합니다.
> http://localhost:8080/login/oauth2/code/naver

### 2-2. 네이버 OAuth 인증정보 설정
src/main/resources/ 디렉토리에 application-oauth.properties 파일을 생성하고,
네이버 오픈 API에서 발급받은 OAuth 클라이언트 ID와 클라이언트 보안 비밀을 등록합니다.    
추가적으로 네이버에서는 스프링 시큐리티를 공식 지원하지 않기 때문에 Common-OAuthProvider에서 제공해주던 값들도 전부 수동으로 입력이 필요합니다.
OAuth 인증정보는 보안상의 이유로 Git에 커밋하지 않으며, application-oauth.properties는 .gitignore에 등록되어 있습니다.   
application-oauth.properties에 필요한 OAuth 인증정보 및 Provider 정보는 다음과 같습니다.
~~~
## oauth2 naver registration
spring.security.oauth2.client.registration.naver.client-id=클라이언트ID
spring.security.oauth2.client.registration.naver.client-secret=클라이언트Secret
spring.security.oauth2.client.registration.naver.redirect-uri={baseUrl}/{action}/oauth2/code/{registrationId}
spring.security.oauth2.client.registration.naver.authorization_grant_type=authorization_code
spring.security.oauth2.client.registration.naver.scope=name,email,profile_image
spring.security.oauth2.client.registration.naver.client-name=Naver
~~~
~~~
## oauth2 naver provider
spring.security.oauth2.client.provider.naver.authorization_uri=https://nid.naver.com/oauth2.0/authorize
spring.security.oauth2.client.provider.naver.token_uri=https://nid.naver.com/oauth2.0/token
spring.security.oauth2.client.provider.naver.user-info-uri=https://openapi.naver.com/v1/nid/me
spring.security.oauth2.client.provider.naver.user_name_attribute=response
~~~
---
