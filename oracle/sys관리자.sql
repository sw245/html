-- 컨트롤 엔터 / f9 : 실행

alter session set "_ORACLE_SCRIPT"=true;
-- user id에 붙는 ##을 생략 가능하게 만듦.

create user ora_user identified by 1111; 
-- id: ora_user, pw: 1111 계정 생성

grant connect,resource, dba to ora_user; 
-- 접속권한, 자원할당, db명령어 사용권한 할당

create user ora_user2 identified by 1111;

grant connect,resource, dba to ora_user2;