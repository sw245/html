-- rownum / row_number()
-- rownum: 순차 번호 매기기 - order 명령어보다 먼저 적용

select * from employees;

select rownum,emp_name from employees;

select rownum, a.* from employees a
order by emp_name;

--테이블로 사용 가능
( select * from employees order by emp_name );

select rownum,a.* from (select * from employees order by emp_name) a;

-- salary 4800 이상, manager_id 103, 이름에 a가 들어감 ;
select * from (
select * from employees where emp_name like '%a%' )
where salary >= 4800 and manager_id=103;

select * from employees where emp_name like '%a%' and salary >= 4800 and manager_id=103;

select rownum,a.* from member a
order by id;

-- 순차적인 번호를 다시 매겨서 출력하시오.
select * from ( select rownum rnum, a.* from (select * from member order by upper(id)) a ) b 
where rnum between 11 and 20;


-- rnum 붙이지 않고 직접 rownum으로 출력하면 같은 문제 발생
select * from ( select rownum rnum,a.* from member a ) where rnum between 3 and 11;


select row_number() over(order by id asc) rnum,a.* from member a;
-- 위 아래는 결과가 같음
select rownum,a.* from ( select * from member order by id asc ) a;


select * from stuscore;
select rank() over(order by total desc),s.* from stuscore s;

-- 공동 등수 다음에도 무조건 +1 등
select dense_rank() over(order by total desc), total from stuscore;


--

select * from stuscore order by total desc;
update stuscore set rank=0, sgrade='F';
commit;

select * from scoregrade;

--rank와 sgrade를 값에 맞게 입력
--rank() over() / non-equi join
update stuscore s set rank = 
( select r from ( select sno,rank() over(order by total desc) r from stuscore ) a
where s.sno=a.sno );

update stuscore set rank = ( select rank() over(order by total desc) from stuscore );

select rank() over(order by total desc) from stuscore s;

update stuscore set sgrade = ( select grade from scoregrade
where floor(avg) between minscore and maxscore );

select s.*,grade from scoregrade, stuscore s
where floor(avg) between minscore and maxscore;


---

select mdate,substr(mdate,4,2) from member;

select mdate from member where substr(mdate,4,2) between 03 and 08;
select mdate from member where substr(mdate,4,2) in (03,04,05,06,07,08);

-- 뒤에 있는 3글자를 출력
select emp_name from employees;
select emp_name,substr(emp_name,-3,3) from employees; -- 마이너스 인덱스도 똑같이 오른쪽으로 순차 출력

select replace(emp_name,' ') from employees;    -- 홑따옴표 사용해야 함...
select trim(emp_name) from employees;   -- 양 사이드의 문자 제거??

desc member;
select phone_number from employees;
select rpad(phone,17,'*') from member;

-- 전화번호 뒤 네 자리를 *로 출력
select replace(phone,substr(phone,-5),'****') from member;
select rpad(substr(phone,1,8),12,'*') from member;

-- 뒤의 한 글자를 *로 표시해서 출력 (name from member)
select replace(name,substr(name,-1),'*') from member; -- 그 글자를 전부 '*'로 교체
select rpad(substr(name,1,length(name)-1),length(name),'*') from member;    -- 한글은 byte 문제 때문에 좀 다르게 출력?

select name,length(name) from member;

-- 뒤 두 글자를 * 표시
select emp_name from employees;
select id from member;

select emp_name,rpad(substr(emp_name,1,length(emp_name)-2),length(emp_name),'*') from employees;
select id,rpad(substr(id,1,length(id)-2),length(id),'*') from member;

select id,pw,rpad(substr(pw,1,2),4,'*')  from member;

-- id 모두 *표시
select id,rpad('*',length(id),'*') from member;

-- 전화번호 중간 부분을 *으로 표시
select replace(phone,substr(phone,5,3),'***') from member;
select rpad(substr(phone,1,4),7,'*')||substr(phone,-6) from member;

select concat(phone,name) from member;

-- 달의 첫째 날과 마지막 날을 출력
select mdate from member;
select trunc(mdate,'month'),mdate,last_day(mdate) from member;

-- 날짜를 yyyy-mm-dd hh:mi:ss 형태로 출력
select to_char(mdate,'yyyy-mm-dd hh24:mi:ss') from member;


-- decode 함수 : 같은지만 비교함? 같으면 특정 값 출력
select emp_name, department_id from employees;
select * from employees;
select emp_name,department_id, 
decode(department_id,
10,'총무기획부',
20,'마케팅',
30,'구매/생산부') as department_name from employees;

-- member 테이블의 mdate 컬럼으로 계절구분 출력
select mdate,decode(to_char(mdate,'mm'),
'12','겨울',
'01','겨울',
'02','겨울',
'03','봄',
'04','봄',
'05','봄',
'06','여름',
'07','여름',
'08','여름',
'09','가을',
'10','가을',
'11','가을') as season from member order by to_char(mdate,'mm');

select mdate, to_char(mdate,'mm'), 
case 
when to_char(mdate,'mm') in (3,4,5) then '봄'
when to_char(mdate,'mm') in (6,7,8) then '여름'
when to_char(mdate,'mm') in (9,10,11) then '가을'
when to_char(mdate,'mm') in (12,1,2) then '겨울'
end as season 
from member;

select avg, 
case 
when avg>=90 then 'VVIP'
when avg>=80 then 'VIP'
when avg>=70 then 'GOLD'
when avg>=60 then 'SILVER'
else 'BRONZE'
end as grade from stuscore order by avg desc;


--having: 그룹함수에
select department_id, avg(salary) from employees
where department_id<50
group by department_id
having avg(salary)>5000;

-- ?? 
select employee_id, emp_name, a.department_id, department_name, salary from employees a, departments c
where salary = some (  --  = some / in 둘 다 결과는 같음
select max(salary) from employees b where a.department_id = b.department_id group by department_id )
 and a.department_id = c.department_id;

select department_id, max(salary) from employees 
group by department_id;

--
select * from employees ( select department_id, max(salary) from employees 
group by department_id ) max;


select * from stuscore;

alter table stuscore add sclass number(2) ;
-- 1~10 1반, 11~20 2반 ...

update stuscore set sclass = 1;

update stuscore a set sclass = case
when sno<=10 then 1
when sno<=20 then 2
when sno<=30 then 3
when sno<=40 then 4
when sno<=50 then 5
when sno<=60 then 6
when sno<=70 then 7
when sno<=80 then 8
when sno<=90 then 9
when sno<=100 then 10
when sno<=110 then 11
end;


rollback;

commit;

-- sclass 반 별로 가장 성적이 높은 학생 출력
select * from stuscore s, (select sclass,max(total) max from stuscore group by sclass) c
where s.sclass=c.sclass and s.total=max order by total desc;

-- 부서 별 가장 월급이 높은 사원 출력
select * from employees a, ( select department_id,max(salary) max from employees group by department_id ) b
where a.department_id = b.department_id and a.salary=max;

select * from employees 
where (department_id,salary) in (select department_id,max(salary) from employees group by department_id);

-- 각 반의 1등/최하등 출력

-- 부서 12개
select distinct department_id from employees
order by department_id;

-- 부서 27개
select department_id from departments;

-- employees에 없는 부서 출력.
select department_id from departments a
where not exists (
select * from employees b where a.department_id = b.department_id
);

select * from member;
select * from stuscore;
-- member테이블에 이름이 존재하는 stuscore 학생성적 출력
select * from stuscore s
where exists ( select * from member m where m.name = s.name ); -- 서브쿼리를 쓰기 위해 exists 사용?


create table stuscore3 as select * from stuscore;
-- 테이블 생성 및 데이터 복사
create table stuscore3 as select * from stuscore where 1=2;
-- 테이블만 복사해서 생성

insert into stuscore3(sno,kor) select sno,kor from stuscore;
select * from stuscore2;

create table stuscore2 as select * from stuscore;

update stuscore2 set sclass=0;
commit;

-- 반 별 일등
select * from stuscore;
select * from stuscore s,(select sclass,max(total) max from stuscore group by sclass) m
where s.sclass=m.sclass and s.total=max order by s.sclass;

select * from stuscore
where (sclass,total) in (select sclass,max(total) from stuscore group by sclass)
order by sclass;

select * from stuscore2;
-- stuscore2 반 부여
update stuscore2 set sclass = case
when sno<=10 then 1
when sno<=20 then 2
when sno<=30 then 3
--...--
when sno<=110 then 11
end;

rollback;

update stuscore2 set sclass = case when sno between 0 and 10 then 1 end 
where sno between 0 and 10;

-- rownum 11-20 member table
select * from (select rownum rnum,m.* from member m)
where rnum between 11 and 20;

select rownum,m.* from member m;

-- 반 별 최하등 학생 출력
select * from stuscore
where (sclass,total) in (select sclass,min(total) from stuscore group by sclass) ;
select sclass,min(total) from stuscore group by sclass;