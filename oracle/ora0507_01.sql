select * from employees;

select department_id from employees;

select department_name from departments;


--equi join
select e.*, department_name from employees e, departments d 
where e.department_id = d.department_id;


--employees 테이블에 department_name 컬럼 생성

desc departments;
desc employees;

create table emp1(
    EMP_NAME        VARCHAR2(80) NOT NULL,
    SALARY                  NUMBER(8,2) ,
    DEPARTMENT_ID           NUMBER(6),
    DEPARTMENT_NAME  VARCHAR2(80) NOT NULL
);

insert into emp1 values(
'홍길동',100,10,'총무기획부'
);


insert into emp1 values('유관순',200,20,'마케팅');
insert into emp1 values('이순신',200,30,'구매/생산부');

update emp1 set department_name = '전략기획부'
where department_id = 10;

create table depart1 (
    DEPARTMENT_ID           NUMBER(6),
    DEPARTMENT_NAME  VARCHAR2(80) NOT NULL
);

insert into depart1 values(10,'총무기획부');
insert into depart1 values(20,'마케팅');
insert into depart1 values(30,'구매/생산부');

select * from depart1;
select * from emp1;

commit;

select count(*) from board;
select * from board;
select * from bfile;
select * from member;

update member set id = 'aaa' where id = 'Flori';
update member set id = 'bbb' where id = 'Holt';
update member set id = 'ccc' where id = 'Byrom';
update member set id = 'eee' where id = 'Austin';
update member set id = 'fff' where id = 'Allard';

-- equi join
select bno,btitle,name from member m,board b 
where m.id = b.id;



--non equi join
-- 한 달 구매이력 기준으로 회원 등급 입력시킬 때 같은 경우 사용
select * from scoregrade;
select * from stuscore;

alter table stuscore add grade char(1) default 'C' not null;
alter table stuscore rename column grade to sgrade;

select sno,name,total,avg,rank,grade
from scoregrade a,stuscore b
where avg between minscore and maxscore -- avg를 기준으로 min/max에 따라 나누는 식으로 join
order by grade, rank asc;


select sum(salary),count(salary) ,e.department_id, department_name from employees e,departments d
where e.department_id = d.department_id
group by e.department_id, department_name
order by sum(salary) desc
;

-- quiz 
select * from stuscore;
select * from stuscore2 order by total desc;
select * from scoregrade;

update stuscore2 set rank = 0;
commit;

-- rank() 함수 사용, 등수 입력
update stuscore2 s 
set rank = ( select rank_over from ( select sno, rank() over(order by total desc) rank_over from stuscore2 ) r
where s.sno = r.sno )
;

select sno,name,total,avg,grade 
from stuscore2,scoregrade
where avg between minscore and maxscore;

update stuscore2 a set sgrade='A';

 alter table stuscore2 add sgrade char(1);

-- alter table scoregrade modify maxscore number(6,3);
-- update scoregrade set maxscore=59.999  where grade='F';


--select grade from (select avg,grade,sno from stuscore2 a,scoregrade b
--where avg between minscore and maxscore);
--select count(*) from stuscore2;

update stuscore2 a
set sgrade = 
( 
select grade from 
(
select sno,avg,grade
from stuscore2,scoregrade
where floor(avg) between minscore and maxscore
) b
where a.sno=b.sno
)
;

update stuscore2 set rank = 1;

update stuscore2 a set rank = 
( select rank_total from 
(select sno,rank() over(order by total desc) rank_total from stuscore2
 ) b
 where a.sno = b.sno );
 
 commit;
 
 
 
select * from stuscore;

select sno,grade from stuscore,scoregrade where floor(avg) between minscore and maxscore;

update stuscore s set sgrade = ( select grade from (
select sno,grade from stuscore,scoregrade where floor(avg) between minscore and maxscore
) g
where g.sno = s.sno );

rollback;


select * from stuscore2;

create table stuscore as select * from stuscore2;
create table stuscore3 as select * from stuscore where 1=2; -- 필드 없이 컬럼만 생성
select * from stuscore3;

-- alter table stuscore2 drop column rank;

select * from
(select a.*, rank() over(order by total desc) ranks from stuscore2 a)
order by sno;

select * from member;

alter table member add total number(3) default 0;

--update member a set a.total = (
--select b.total from stuscore2 b where );


--???

insert into member(total) select total from stuscore;

delete member where id is null;
commit;

alter table member add no number(3);
select rownum, no from member;

update member set no = (select rownum from member);

---

select * from stuscore;
update stuscore set sgrade = 'F';

-- orm으로는 못함~ 쿼리 외워~~
update stuscore s 
set sgrade = (
select grade from (
select sno,avg,grade from stuscore,scoregrade
where floor(avg) between minscore and maxscore) g
where s.sno=g.sno);


select * from (select grade from stuscore,scoregrade
where avg between minscore and maxscore);

select * from scoregrade;   -- grade,minscore,maxscore
select * from stuscore;     -- avg

desc stuscore;

select stuscore_seq.nextval from dual;

-- equi join: 서로 다른 2개의 테이블에서 같은 컬럼을 가지고 검색
-- non equi join: 서로 다른 2개의 테이블에서 같은 컬럼이 없는 경우 검색
-- self join: 같은 테이블 2개를 가지고 조인, 검색
------ 위 3: inner join
-- outer join: null값이 있을 때, null값도 포함하기?
------ 위 4: 플러스 조인?
-- ansi join
select * from employees;

select employee_id,emp_name,manager_id,job_id from employees;

select a.employee_id,a.job_id,a.emp_name,a.manager_id,b.job_id,b.emp_name 
from employees a, employees b
where a.manager_id = b.employee_id;

-- 1명 null 검색 안 됨.
-- outer join?
select sum(a.employee_id,a.emp_name,a.manager_id,b.emp_name)
from employees a, employees b
where a.manager_id = b.employee_id(+)
;

select * from employees where manager_id is null;

-- 기본 sql 구문 equi join
--select * from employees cross join department
select * from employees, d

-- ansi join, equi join
select * from employees a inner join departments b
on a.department_id = b.department_id
;

select department_id, department_name 
from employees join departments
using(department_id)
;

select department_id, department_name 
from employees inner join departments
using(department_id)
;

-- 기본 sql구문 : outer-join
select a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id(+)
;

-- ansi join구문: outer-join
select a.manager_id,b.emp_name from employees a
left outer join employees b
on a.manager_id(+) = b.employee_id
;


-- union: 2개의 검색결과에서 중복된 결과를 제외하고 출력해줌.

select * from departments;

select department_id, manager_id
from departments
where manager_id is not null
union
select department_id, manager_id
from employees
where department_id >80;

-- employees 테이블에서 부서번호 50 검색> d id, d name
-- employees 테이블에 없는 departments의 부서검색 2개를 union 하시오.> d id, d name

select distinct a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id and a.department_id>50
union
select department_id,department_name
from departments a
where not exists (select * from employees b where a.department_id = b.department_id);

union all -- > 중복도 모두 출력

select distinct department_id from employees order by department_id;
select distinct department_id,department_name from departments order by department_id;


select * from member;

-- view: 특정 정보에만 접근할 수 있게 만든 가상의 테이블
create or replace view emp
as select employee_id,emp_name,email,phone_number from employees;

-- 가상의 테이블이므로 데이터가 원래 테이블에 모두 종속됨 (원 테이블을 수정하면 뷰 테이블도 바뀜)
select * from emp;
select * from employees;
update employees set phone_number = '650.507.9834' where employee_id=198;

------
select * from stuscore;
select * from member;

select s.*,id,phone from stuscore s,member m
where s.name=m.name;