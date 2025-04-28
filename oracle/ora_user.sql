--테이블 생성: create
create table member(
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
phone varchar2(20)

);

-- 입력 명령어 insert : 1필드 입력, 임시저장
insert into member (id,pw,name,phone) values(
'aaa','1111','홍길동','010-1111-1111'
);

insert into member values( -- 모든 column 넣을 경우 괄호 생략 가능
'bbb','1111','유관순','010-2222-2222'
);

insert into member (id,pw,name) values (
'ccc','1111','이순신'
);

-- ddd,강감찬,3333
-- eee,김구,4444
-- fff,김유신,5555

insert into member values (
'ddd','1111','강감찬','010-3333-3333'

);

insert into member values ( 
'eee','1111','김구','010-4444-4444'
);

insert into member values (
'fff','1111','김유신','010-5555-5555'
);

-- 수정: update
update member set phone='010-1234-1234' where id='ccc';

update member set phone='010-3333-3333', pw='1111' where id='ddd';

update member set phone='010-4444-4444', pw='1111' where id='eee';

rollback;

-- 삭제: delete
drop table member;  -- 되돌리기 불가

delete member;
delete member where id='aaa';
delete member where name='유관순';
delete member where name like '%김%';

select * from member;

-- create member 5명 입력

create table member (
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
phone varchar2(20)
);

insert into member values (
'aaa','1111','홍길동','010-1111-1111'
);

insert into member values (
'bbb', '1111','유관순','010-2222-2222');

insert into member values (
'ccc','1111','강감찬','010-3333-3333');

insert into member values (
'ddd','1111','김구','010-4444-4444');

insert into member values (
'eee','1111','김유신','010-5555-5555');

insert into member (id,pw,phone) VALUES (
'fff','11111','010-5555-5555');

update member set phone='010-6666-6666' where id='fff';

select * from member;

commit;


-- 검색
select id,pw,name,phone from member;

select * from member;

select id,name from member;


commit; -- 커밋을 해야 저장 완료됨.


create table stuscore(
sno number(4) primary key,
name varchar2(100),
kor number(3),
eng number(3),
math number(3),
total number(3),
avg number(4),
rank number(3)

);