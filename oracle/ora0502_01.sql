
select sysdate from dual;

--현재일에서 이 달의 최초일, 이 달의 마지막 날 출력
select trunc(sysdate,'month'), last_day(sysdate) from dual;

select * from stuscore;

select * from stuscore 
where avg>=80 and rownum<=5 order by avg desc;

select rownum,stuscore.* from stuscore where name like '%s%' and kor>=80;
-- rownum >> 현재 조건 출력에서 다시 매기는 번호?
-- rownum보다 정렬이 더 나중이므로 rownum을 매기려면 이중쿼리 사용 필요

-- 국-영 점수 차 큰 10명 출력 + rownum
select rownum,abs(kor-eng), stu.* from (select * from stuscore order by abs(kor-eng) desc) stu where rownum<=10 ;


-- 날짜함수
select sysdate from dual;
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss day') from dual;

select next_day(sysdate,'목요일') from dual;

--min / max : 가장 낮은 / 높은 값 검색
select min(salary),max(salary),avg(salary),sum(salary),count(salary) from employees;

-- 3일 전, 3달 전의 날짜 출력
select sysdate-3, add_months(sysdate,-3) from dual;


-- abc좋은나라DEF
-- 좋은나라만 출력
select substr('abs좋은나라DEF',4,4) from dual;

select mdate from member;
-- 월만 분리해서 출력, 05,06,07인 회원만 출력
select to_char(mdate,'mm'), m.* from member m where to_char(mdate,'mm') in (05,06,07) order by mdate;

-- char varchar2 number date clob ?

desc stuscore;

create table stuscore3(
sno number(4),
name varchar2(100),
KOR            NUMBER(3) ,   
ENG            NUMBER(3)  ,   
MATH           NUMBER(3)   ,  
TOTAL          NUMBER(3)    , 
AVG            NUMBER(5,2)   ,
RANK           NUMBER(3) 
);

select * from stuscore3;
-- insert로 다른 테이블 데이터 가져오기
insert into stuscore3 (select * from stuscore) ;

-- 테이블 생성 시, 복사해서 생성하기
create table stuscore4 as select * from stuscore;
select * from stuscore4;

-- 컬럼이 다른 경우에, 데이터 모두 복사하기
-- 컬럼 선택 후 insert
insert into stuscore5 select sno,name,kor,eng,math from stuscore ;


desc stuscore5;
select * from stuscore5;

create table stuscore5(
sno number(4),
name varchar2(100),
KOR            NUMBER(3) ,   
ENG            NUMBER(3)  ,   
MATH           NUMBER(3)  
);


-- alter table: add/modify/drop 컬럼 추가/수정/삭제
-- 롤백 안 됨.

-- 컬럼 추가/삭제
alter table stuscore5 add total number(2);
alter table stuscore5 drop column total;

-- 컬럼 변경: 타입 변경 ( modify )
alter table stuscore5 modify total number(3);
-- 기존에 들어간 데이터가 3자리인데 2자리로 변경하려고 하면 변경되지 않음;
--  기존에 문자가 들어가 있으면 숫자형으로 변경 안 됨.

-- 컬럼 변경: 이름 변경 ( rename )
alter table stuscore5 rename column total to tot;

-- 테이블명 변경
alter table stu2 rename to stuscore2;


desc stuscore5;
select * from stuscore;

-- 컬럼 순서 변경 ??
alter table stuscore5 modify name invisible;
alter table stuscore5 modify kor invisible;
alter table stuscore5 modify eng invisible;
alter table stuscore5 modify math invisible;
alter table stuscore5 modify sno invisible;

alter table stuscore5 modify name visible;
alter table stuscore5 modify kor visible;
alter table stuscore5 modify eng visible;
alter table stuscore5 modify math visible;
alter table stuscore5 modify name visible;


commit;



-- 제약 조건
create table mem(
    id varchar2(30) primary key,    -- 중복 x, null x
    name varchar2(100) not null,    -- null x
    phone varchar2(20) unique,      -- 중복 x
    gender nchar(2) check(gender in ('남성','여성')),    -- 값 직접 제한
    kor number(3) check(kor between 0 and 100)
    
);

desc mem;
select * from mem;

insert into mem values(
'aaa','홍길동','010-1111','남성','100' 
);

insert into mem values(
'bbb','유관순','010-1112','여성','100' 
);

insert into mem values(
'ddd','이순신',null,'남성',100 
);

insert into mem values(
'eee','이순신',010-2222,'남성',100
);


-- ## 외래 키 설정
-- 목적: 기본 키에 없는 데이터를 입력하면 입력되지 않게 함.

-- foreign key로 등록??
-- constraint 별칭:fk_테이블명_컬럼명    foreign key(현재테이블의 컬럼) references pk테이블(컬럼)
-- constraint fk_score_id            foreign key(id)             references mem(id)

create table score (
sno number(4) primary key,
id varchar2(30),
kor number(3),
constraint fk_score_id foreign key(id) references mem(id)
);

select * from mem;
select * from score;

insert into score values(1,'aaa',100);
insert into score values(2,'bbb',90);
insert into score values(2,'bb2',90);   --불가
-- foreign key (외래 키) 조건 삭제
alter table score drop constraint fk_score_id;
delete score where id='abc';
-- foreign key 조건 등록
alter table score add constraint fk_score_id foreign key(id) references mem(id);

delete mem where id='bbb'; -- 자식 레코드 삭제 후 삭제해야 함


-- ## primary key (기본 키) 설정
-- 테이블 생성 시 sno number(4) primary key;

-- 기본 키 삭제
alter table score drop constraint SYS_C008355;

-- 기본 키 등록
alter table score add constraint pk_score_sno primary key(sno);


desc employees;
desc departments;
------- 조인
select * from employees;
select department_id from employees;
-- cross join : 그냥 냅다 붙인 것
select * from employees,departments;
-- 13 + 6 = 19 개 컬럼
-- 107 * 27 = 2889 개의 행....


-- equi join: 값이 같은 컬럼을 가지고 조인함 (where a = b)
select emp_name, a.department_id, department_name ,salary from employees a,departments b
where a.department_id = b.department_id
order by a.department_id ;

select * from member;
select * from stuscore;

select id, gender, phone,m.name,total,avg, rank
from member m, stuscore s
where m.name = s.name
order by m.name;


select * from jobs;

select emp_name,salary,e.department_id,department_name,e.job_id,min_salary,max_salary
from jobs j,employees e,departments d
where j.job_id = e.job_id and e.department_id = d.department_id
;


select * from board;
desc board;
alter table board add bfile3 varchar2(100);
alter table board modify bdate invisible;
alter table board modify bdate visible;


create table bfile(
id varchar2(100), bno number(4), bfile varchar2(100)
);

alter table bfile drop column id;
select * from bfile;

insert into bfile values(
4,'d1.jpg'
);

select * from board a,bfile b
where a.bno = b.bno;

alter table board drop column bfile3;

--select count(*);
select * from board a, bfile b where a.bno=b.bno and a.bno=1;

select * from board where bno=1;
select * from bfile where bno=1;

select * from board;
--bno: board_seq.nextval
--bgorup: board_seq.currval
--bdate: sysdate

insert into board values (
board_seq.nextval,'2번째 게시글','파이썬에서 테스트','aaa',board_seq.currval,
0,0,0,sysdate
);


select * from stuscore;
select stuscore_seq.nextval from dual;

desc board;
desc bfile;


-- cross join >> equi join, non-equi join, inner join, outer join

-- non-equi join
create table scoreGrade(
grade char(1),
minscore number(3),
maxscore number(3)
);

insert into scoreGrade values ('F',0,59);
insert into scoreGrade values ('D',60,69);
insert into scoreGrade values ('C',70,79);
insert into scoreGrade values ('B',80,89);
insert into scoreGrade values ('A',90,100);

select * from scoreGrade;
commit;

select * from stuscore;
-- stuscore 테이블 avg로 scoregrade의 grade를 출력할 수 있게 구성
-- non-equi join
select sno,name,avg,grade from stuscore, scoregrade
where avg between minscore and maxscore;

-- 단일 컬럼과 함수 컬럼 같이 사용 불가 
-- group by 쓰면 가능
select department_id, sum(salary) from employees
group by department_id;

--28,17,15,30,45,49,37,35,32,12,19,27
--trunc를 사용하여 10대 20대 등 출력 가능
--10-19
--20-29
--30-39
--40-49
--50-59

-- 생일을 나이로 환산하여 출력, 몇 대인지도 출력
select hire_date from employees;
select age, trunc(age,-1) from (select trunc((trunc(sysdate - hire_date))/365) age from employees);

-- 부서 별 평균 월급 출력
select department_id, round(avg(salary),0) from employees
group by department_id order by department_id;

-- 부서명도 join해서 출력
select e.department_id, department_name, round(avg(salary),0) from employees e,departments d
where e.department_id = d.department_id
group by e.department_id,department_name order by e.department_id;




