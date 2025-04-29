
-- create table : 테이블 생성
-- select,insert,update,delete : data manipulation language

-- 명령어
-- tab: 현재 가지고 있는 테이블 출력
select * from tab;

select * from member;

select * from employees;

select * from member;


-- 테이블 구조 확인
desc member;

-- 오라클 data type (number, char, varchar2, nchar, nvarcharm, clob, blob, long)
create table mem1(
memNo number,     -- 용량을 많이 차지하는 단점이 있음. (자릿수 미지정)
memNo2 number(3), -- 0부터 999까지 입력 가능: (3자리 수)
memNo3 number(4,2) -- 4자리 숫자(소수점 밑 포함), 소수점 2자리까지(무조건 표현됨)

);
-- number: 숫자데이터, 소수점 표현 가능.
-- number(4,2):총 자릿수 4자리, 소수점 밑 자리수 


-- 명령어: 대소문자 구분 안함
insert into mem1 (memNo,memNo2,memNo3) values(
100000000, 999, 1.23
);

insert into mem1 values(
2,0,9.9
);

insert into mem1 (memNo2) values(
999
);

insert into mem1 (memNo3) values(
99.99
);

-- 자릿수가 4자리를 넘어가므로 오류 발생
insert into mem1 (memNo3) values(
999.99
);

-- 음수도 입력 가능
insert into mem1 (memNo3) values(
-99.99
);


-- (null) 넣지 않기
-- 실제 의미 있는 값, 확실한 값, 정확한 값 >> DB의 신빙성

select * from mem1;

-- column 수정 > where는 조건
update mem1 set memNo=222222222 where memNo3=99.99;
update mem1 set memNo=3333333   where memNo3=-99.99;

update mem1 set memNo = 20000 where memNo3 = 9.9;

-- 천 단위 표시
select memNo from mem1;
select to_char(memNo,'999,999,999') from mem1; -- 9로 콤마 표기하면 빈 공백 그대로 둠
select to_char(memNo,'000,000,000') from mem1; -- 0으로 콤마 표기하면 빈 공백을 0으로 표시해 줌

-- 여러 사용자가 같은 db 사용 시, 한 사용자가 commit 하지 않으면 다른 사용자 모두 대기 상태

commit;


----------------------------------------
-- date 세기, 년, 월, 일, 시, 분, 초 >> 데이터 입력 가능, default: '년-월-일'만 출력
-- timestamp: date + 밀리초

create table date1(
sdate date
);

insert into date1 values(
sysdate --현재시간을 저장
);

insert into date1 values(
'2025-04-01'    -- 시,분,초 미입력시 디폴트 값 - 12:00:00이 저장됨
);

select * from date1;

-- 날짜 포맷 변경 방법 >> char타입으로 변경해서 입력 가능?

select to_char(sdate,'yyyy-mm-dd hh:mi:ss') from date1;




----
-- char 타입, varchar2 타입
-- char: 고정형 문자형 타입 (데이터 공간)
-- varchar2: 가변형 문자형 타입 

create table mem2(
juminNo char(14), -- '880101-1111111' - 10자리만 입력해도 14자리를 차지함.
-- char: 속도가 빠르다
id varchar2(30),    -- 넣는 자릿수만큼만 자리를 차지함.
-- varchar2: 공간 활용에 좋음.
kor number(5,2),
eng number(5,2)

);

insert into mem2 values(
'880101-1111111', 'aaa1111', 99,90
);

insert into mem2 values(
'991231-2222222', 'bbb1234', 80,81
);

commit;

select * from mem2;

select kor,eng from mem2;

select kor,eng,kor+eng,(kor+eng)/2 from mem2;
-- 반올림:round, 올림:ceil, 버림:floor, 절댓값:abs, 최댓값:max, 최솟값:min



-- nchar 국제언어 고정형문자열 타입, nvarchar2 국제언어 가변형문자열 타입
create table mem3(
gender1 char(1),    -- 영문 1byte 사용, 한글 3byte 사용
gender2 char(2),
gender3 char(3),
gender4 nchar(1)    -- 어떤 언어이든 1개 글자를 저장 (모두 1바이트 취급?)

);

insert into mem3 values(
'M','m','m','m'
);

insert into mem3(gender1) values('남');
-- gender1의 최댓값이 1이므로 3byte인 한글은 입력 불가
insert into mem3(gender3) values('남');
insert into mem3(gender4) values('남');


select * from mem3;

commit;



-- select

-- distinct: 중복값 제외(1개만 출력)
select distinct job_id from employees;

select * from employees;

-- department_id 중복 없이 출력
select distinct department_id from employees order by department_id;
-- order by (column name) : 정렬 asc-순차, desc-역순 (순차정렬이 기본값)

-- salary 역순정렬
select * from employees order by salary desc;

select salary,salary*1438 from employees order by salary*1438 desc;

-- as 닉네임
-- to_char: 문자형으로 변환?
-- 숫자형 > 연산 가능(더하기 빼기 곱하기 나누기)
select to_char(salary*1438*12,'999,999,999') as annual from employees order by salary desc;

select * from departments;
select department_id,department_name from departments;

-------------------------
select * from employees;
-------------------------

-- 사원번호, 사원이름, 입사일 hire_date, 월급 출력
select employee_id,emp_name,hire_date,salary from employees order by hire_date;

-- 날짜도 더하기 빼기 가능, 등가비교 가능
select hire_date,hire_date+100,hire_date+1000 from employees order by hire_date;

-- dual 가상테이블, 임시테이블
select sysdate,sysdate-1000 from dual;
select to_char(sysdate,'yyyy-mm-dd hh-mi-ss') from dual;


-- 산술 연산자 + - * /
select salary from employees;
select salary,salary+1000,salary-100,salary*12,salary/4 from employees;

-- 별칭에 "" 사용하면 사이띄우기, 대소문자 구분 가능함
select salary,salary*12 as "annual salary" from employees;

-- 테이블 컬럼 타입 확인
desc employees;

-- null : 무한대 ?? null과 0은 다른 의미
-- null의 연산값은 null?
-- 0 아님. 빈 공간 아님. 연산,할당,비교 불가.

select manager_id from employees;
-- where>조건절: 조건에 맞는 것을 선택
select * from employees where manager_id=100; 
-- null 검색 시 is null, is not null 사용
select * from employees where manager_id is null;

select salary from employees where salary<6000 order by salary;


-- number 연산
select employee_id,salary from employees;
select employee_id,salary,salary*12 from employees;
-- null값에 연산하면 결과는 모두 null
-- 따라서 nvl(변경할 컬럼,변경될 값)으로 null값을 0으로 먼저 대체.

select employee_id,emp_name,salary,salary+(salary*commission_pct) as "실제월급" from employees;
-- null값 대체
select commission_pct,nvl(commission_pct,0) from employees;

-- null 값을 1로 변경해서 출력
select manager_id from employees;


select nvl(manager_id,1) from employees;
-- column의 데이터 타입을 바꾸고 ceo를 입력해야 함.
select nvl(to_char(manager_id),'ceo') from employees;

-- salary, salary*12, salary*commission_pct, salary+(salary*commission_pct) 출력? 선택?
-- salary*12*1438 천 단위 표시

--- ??
select nvl(commission_pct,0) from employees;
select salary,salary*12,salary*commission_pct as "comm" from employees;


-- concat 함수: 문자열 컬럼을 합쳐주는 함수

select * from member;
desc member;

-- select id+pw from member;
select id||','||pw from member;  -- >>  파이썬의 split 함수?
select concat(id,pw) from member;


-- where절

select employee_id,salary from employees where salary >= 5000 order by salary;

select count(*) from employees where  salary>=5000 order by salary;
select max(salary),min(salary),round(avg(salary),2) from employees;


-- 5000 이상 8000 이하 월급을 받는 사원을 출력하시오.

select emp_name,salary from employees where salary>=5000 and salary<=8000 order by salary;
select emp_name,salary from employees where salary between 5000 and 8000;


-- 월급이 평균 이상인 사원을 출력하시오...
select avg(salary) from employees;
select emp_name,salary from employees where salary>=( select avg(salary) from employees );  -- select 이중구문 


-- 부서번호가 50 이상인 부서를 출력하시오.
select * from departments;
select department_name,department_id from departments where department_id >=50;


select * from kor_loan_status;
-- 천만원
-- loan_jan_amt 원단위 환산 후 천단위 표시 출력

select to_char(loan_jan_amt*10000000,'999,999,999,999') from kor_loan_status;

commit;

--4000억 이상 역순정렬 출력 
--40000.0
select * from kor_loan_status where loan_jan_amt>=40000 order by loan_jan_amt desc;


-- salary 4000인 사원 출력
select * from employees where salary=4000;

-- 4000,6000,7000 중 하나
select * from employees where salary=4000 or salary=6000 or salary=7000;
select * from employees where salary in (4000,6000,7000);

-- 월급 6000 이하, 사원번호, 사원이름, 급여만 출력
select employee_id,emp_name,salary from employees where salary<=6000;
select count(*) from employees where salary<=6000;

select * from stuscore;
desc stuscore;


-- 테이블의 컬럼 타입 변경
alter table stuscore modify avg number(5,2);



-------stuscore
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (1, '홍길동', 50, 51, 59, 160, 53.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (2, '유관순', 95, 87, 53, 235, 78.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (3, '이순신', 94, 94, 83, 271, 90.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (4, '강감찬', 76, 56, 87, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (5, '김구', 81, 69, 87, 237, 79, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (6, '김유신', 95, 56, 86, 237, 79, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (7, '홍길순', 71, 77, 62, 210, 70, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (8, '홍길자', 56, 83, 95, 234, 78, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (9, '길동스', 84, 52, 77, 213, 71, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (10, '관순스', 87, 93, 69, 249, 83, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (11, '순신스', 90, 69, 77, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (12, '감찬스', 58, 81, 71, 210, 70, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (13, '구스', 72, 62, 88, 222, 74, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (14, '유신스', 96, 81, 89, 266, 88.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (15, '길순스', 90, 50, 54, 194, 64.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (16, 'Mauvin', 79, 72, 65, 216, 72, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (17, 'Freschi', 74, 66, 64, 204, 68, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (18, 'Ewbanck', 76, 69, 54, 199, 66.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (19, 'Kehoe', 95, 51, 85, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (20, 'MacNulty', 53, 68, 95, 216, 72, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (21, 'Renihan', 56, 96, 76, 228, 76, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (22, 'Petheridge', 71, 100, 96, 267, 89, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (23, 'Witson', 94, 83, 100, 277, 92.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (24, 'Norgan', 69, 93, 61, 223, 74.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (25, 'Ineson', 55, 72, 88, 215, 71.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (26, 'Giacobillo', 78, 77, 50, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (27, 'Domb', 92, 99, 68, 259, 86.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (28, 'Jentges', 75, 96, 85, 256, 85.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (29, 'McGuinley', 98, 56, 90, 244, 81.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (30, 'Pavkovic', 73, 97, 61, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (31, 'Pretious', 100, 63, 88, 251, 83.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (32, 'Elan', 50, 71, 86, 207, 69, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (33, 'Burnham', 57, 61, 59, 177, 59, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (34, 'Coldrick', 85, 53, 89, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (35, 'Befroy', 73, 68, 84, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (36, 'Blainey', 51, 54, 72, 177, 59, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (37, 'Haglington', 80, 89, 60, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (38, 'Foro', 60, 64, 77, 201, 67, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (39, 'Clemon', 73, 61, 93, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (40, 'Ruffler', 98, 58, 98, 254, 84.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (41, 'Sogg', 82, 68, 55, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (42, 'Rouse', 74, 78, 95, 247, 82.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (43, 'Kellitt', 67, 75, 97, 239, 79.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (44, 'Fishbourn', 71, 89, 82, 242, 80.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (45, 'Connock', 94, 70, 55, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (46, 'Hugonin', 88, 64, 77, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (47, 'Gossage', 72, 59, 66, 197, 65.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (48, 'Dicey', 80, 89, 62, 231, 77, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (49, 'Writer', 62, 56, 91, 209, 69.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (50, 'Jammes', 55, 54, 63, 172, 57.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (51, 'Lilburn', 74, 57, 53, 184, 61.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (52, 'Sealy', 93, 78, 94, 265, 88.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (53, 'Clarke-Williams', 50, 90, 85, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (54, 'Brecknall', 72, 100, 95, 267, 89, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (55, 'Davids', 55, 66, 87, 208, 69.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (56, 'Rix', 59, 75, 65, 199, 66.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (57, 'Saldler', 76, 76, 68, 220, 73.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (58, 'Degenhardt', 81, 67, 88, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (59, 'Hubbard', 55, 72, 91, 218, 72.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (60, 'Janczyk', 81, 50, 55, 186, 62, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (61, 'Deinert', 53, 58, 97, 208, 69.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (62, 'Simeoni', 73, 69, 67, 209, 69.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (63, 'Oloshkin', 100, 93, 57, 250, 83.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (64, 'Westlake', 99, 56, 74, 229, 76.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (65, 'Caris', 83, 100, 50, 233, 77.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (66, 'Kenwell', 64, 73, 91, 228, 76, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (67, 'Pallister', 72, 70, 91, 233, 77.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (68, 'Swalteridge', 71, 69, 78, 218, 72.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (69, 'Tolwood', 57, 71, 77, 205, 68.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (70, 'Hagart', 86, 64, 69, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (71, 'Blay', 70, 83, 90, 243, 81, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (72, 'Judkin', 66, 50, 77, 193, 64.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (73, 'Pavlovsky', 57, 77, 87, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (74, 'Guilbert', 84, 84, 53, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (75, 'Biasini', 57, 63, 58, 178, 59.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (76, 'Fitzsimmons', 62, 64, 94, 220, 73.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (77, 'Lamming', 87, 100, 72, 259, 86.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (78, 'Guilliatt', 71, 91, 93, 255, 85, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (79, 'Bendell', 75, 67, 98, 240, 80, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (80, 'Pickett', 79, 96, 75, 250, 83.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (81, 'Devey', 83, 96, 57, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (82, 'Bold', 100, 58, 65, 223, 74.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (83, 'Philpot', 85, 99, 77, 261, 87, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (84, 'Henrie', 92, 53, 80, 225, 75, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (85, 'Bentinck', 55, 88, 93, 236, 78.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (86, 'Kitchiner', 56, 72, 73, 201, 67, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (87, 'Appleton', 59, 64, 53, 176, 58.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (88, 'Kiefer', 74, 75, 55, 204, 68, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (89, 'Gosby', 86, 61, 79, 226, 75.3333333333, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (90, 'Reston', 56, 78, 73, 207, 69, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (91, 'Sale', 81, 75, 68, 224, 74.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (92, 'Dongles', 100, 56, 63, 219, 73, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (93, 'Edinboro', 77, 72, 72, 221, 73.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (94, 'Aers', 72, 85, 70, 227, 75.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (95, 'De Mars', 59, 66, 69, 194, 64.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (96, 'Bremmell', 93, 96, 90, 279, 93, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (97, 'Salmen', 64, 95, 95, 254, 84.6666666667, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (98, 'Hazell', 75, 56, 61, 192, 64, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (99, 'Skellen', 89, 87, 82, 258, 86, 0);
insert into stuscore (sno, name, kor, eng, math, total, avg, rank) values (100, 'Grief', 92, 73, 63, 228, 76, 0);

select * from stuscore;
commit;

-- 국어점수 역순정렬
select * from stuscore order by kor desc;
-- 이름으로 역순정렬, 순차정렬
select * from stuscore order by name asc;
select * from stuscore order by name desc;
-- 합계로 역순정렬, 순차정렬
select * from stuscore order by total asc;
select * from stuscore order by total desc;

-- 파이썬 성적정렬

-- 등수처리
select sno,name,total,rank() over(order by total desc) as ranks from stuscore;
select salary, rank() over(order by salary desc) as ranks from employees;

-- 등수처리 stuscore
select sno,rank() over (order by total desc) as ranks from stuscore;
select rank() over(order by total desc) as ranks from stuscore;
select sno,rank from stuscore order by total desc;


-- 검색할 때 사용되는 sno, 입력할 때 사용되는 ranks


-- 순위를 매기는 윈도우 함수?
-- rank() over(order by total desc)


-- update
update stuscore
set rank = 1 
where sno = 1
;


update stuscore a
set rank = (
select ranks from (select sno,rank() over(order by total desc) as ranks from stuscore) b
where a.sno = b.sno
); --?
---
select * from stuscore order by rank;
commit;
---

update stuscore a
set rank = select ranks from (select sno,rank() over(orderby total desc) as ranks from stuscore where sno=96) b
where a.sno=96;

----?????
select sno,rank() over(orderby total desc) as ranks from stuscore;

-- sno,rank() 2개 컬럼을 찾아서 rank() 컬럼만 출력하시오.
select ranks from (select sno,rank() over(orderby total desc) as ranks from stuscore) ;



--??
select sno,rank() over(order by total desc) as ranks from stuscore;
select ranks from (select sno,rank() over(order by total desc) as ranks from stuscore);







-------------------------

select sno,rank from stuscore;
-- sno 1, 1
update stuscore set rank=1 where sno=1;
-- sno 2, 5
update stuscore set rank=5 where sno=2;

-- 
select * from mem1;
desc mem1;
-- memno3 9.9 > memno 50000, memno2 1000
update mem1 set memno=50000, memno2=10 where memno3=9.9;
-- memno2 = 999에 memno=5000000, memno3=50.05
update mem1 set memno=5000000, memno3=50.05 where memno2 = 999;

--
desc mem2;
select * from mem2;
-- id: aaa1111을 찾아서, 주민번호 010101-2222222, 국어 88, 영어 95로 변경
update mem2 set juminno='010101-2222222', kor=88, eng=95 where id='aaa1111';





-- 테이블 복사
create table mem4(
no number(4)
);

-- (데이터 포함) 테이블 그대로 복사
create table stuscore2 as select * from stuscore;
select * from stuscore2;
desc stuscore2; --컬럼 8개

-- 컬럼 5개만 가져와서 테이블 복사
create table stuscore3 as select sno,name,kor,eng,math from stuscore;
select * from stuscore3;
desc stuscore3;

-- stuscore3 번호, 국어, 영어, 수학, 합계, 평균 출력
select sno,kor,eng,math,kor+eng+math as total ,round((kor+eng+math)/3,2) as average from stuscore3;
-- 등수 출력
select ;


-- total,avg,rank 컬럼 추가
alter table stuscore3 add total number(3);
alter table stuscore3 add avg number(5,2);
alter table stuscore3 add rank number(3);

desc stuscore3;
select *  from stuscore3;

-- 1번째 rank()를 rank 컬럼에 저장
-- 2번째 avg()를 avg 컬럼에 저장
update stuscore3 set total = kor+eng+math;
update stuscore3 set avg = (kor+eng+math)/3;



--- rank() over(): 등수를 어떤 형태로 등수를 출력할지 >> over() 괄호 안의 내용
select sno,rank() over(order by name asc) from stuscore3;


--update stuscore3
--set rank = 
--(select * from stuscore3 order by total desc)
--;

where (select * from stuscore3 order by total desc);