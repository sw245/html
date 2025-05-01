SELECT
    sysdate,
    next_day(sysdate, '수요일')
FROM
    dual;

SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    employees
WHERE
    emp_name LIKE '%n%'
ORDER BY
    emp_name;

SELECT
    COUNT(*)
FROM
    employees
WHERE
    emp_name LIKE '%n%';

SELECT
    *
FROM
    stuscore
ORDER BY
    rank;

SELECT
    *
FROM
    stuscore
ORDER BY
    kor DESC;


-- 입사일이 이른 사원 순으로 정렬
SELECT
    *
FROM
    employees
ORDER BY
    hire_date;

SELECT
    hire_date
FROM
    employees
ORDER BY
    hire_date;



-- 숫자 함수
-- abs : 절대값
-- round() : 반올림, ceil() : 올림, floor() : 버림, trunc(): 특정 자릿수를 잘라냄
-- mod(): 입력받은 수를 나눈 나머지 값 반환
-- power(m,n): 거듭제곱 (m의 n승 반환)

SELECT
    - 10
FROM
    dual;

SELECT
    - 10,
    abs(-10)
FROM
    dual;

SELECT
    kor,
    eng,
    kor - eng,
    abs(kor - eng)
FROM
    stuscore
ORDER BY
    abs(kor - eng) DESC;

-- rownum: 조회된 순서대로 순번 매김
SELECT
    ROWNUM,
    sno,
    name
FROM
    stuscore;

SELECT
    ROWNUM,
    sno,
    name,
    total
FROM
    stuscore
WHERE
        total >= 250
    AND ROWNUM <= 10;

-- stuscore에서 1-10등 학생을 출력
SELECT
    *
FROM
    stuscore
WHERE
    rank <= 10
ORDER BY
    rank;

SELECT
    ROWNUM,
    a.*
FROM
    stuscore a
WHERE
    rank <= 10
ORDER BY
    rank;
-- 조건이 출력된대로 rownum 붙이기
SELECT
    ROWNUM,
    a.*
FROM
    (
        SELECT
            *
        FROM
            stuscore
        WHERE
            rank <= 10
        ORDER BY
            rank
    ) a;


-- 국어점수 80점 이상인 학생 3명을 출력하시오.
SELECT
    ROWNUM,
    a.*
FROM
    (
        SELECT
            *
        FROM
            stuscore
        WHERE
            kor >= 80
        ORDER BY
            kor DESC
    ) a
WHERE
    ROWNUM <= 5;

SELECT
    ROWNUM,
    ko_80.*
FROM
    (
        SELECT
            *
        FROM
            stuscore
        WHERE
            kor >= 80
        ORDER BY
            kor DESC
    ) ko_80
WHERE
    ROWNUM <= 5;

SELECT
    sno,
    a.*
FROM
    stuscore a
WHERE
    sno <= 5;

-- 국어점수와 영어점수 차이가 가장 큰 10명의 학생을 출력하시오.
SELECT
    ROWNUM,
    ke.*
FROM
    (
        SELECT
            abs(kor - eng),
            a.*
        FROM
            stuscore a
        ORDER BY
            abs(kor - eng) DESC
    ) ke
WHERE
    ROWNUM <= 10;

-- floor() 버림, ceil() 올림, round() 반올림
SELECT
    12.5,
    floor(12.5)
FROM
    dual;

SELECT
    12.1,
    ceil(12.1)
FROM
    dual;

SELECT
    12.1257,
    round(12.1257, 3)
FROM
    dual;     -- 반올림해서 세 번째 자리까지 출력
-- round(m,3): m을 반올림해서 소수점 3자리까지 표시
SELECT
    34.5678,
    round(34.5678, -1)
FROM
    dual;    -- (-1)번째는 소수점 위 일의자리

-- trunc() 지정한 자리수까지만 남기고 버림 // floor() 소수점 제거
SELECT
    34.5678,
    trunc(34.5678, 2),
    trunc(34.5678, -1)
FROM
    dual;

-- mod() 나눈 나머지 / mod(5,2) == 1 >> 5%2
SELECT
    MOD(27, 2),
    MOD(27, 5),
    MOD(27, 7)
FROM
    dual;

-- stuscore sno에서 짝수만 출력.
SELECT
    *
FROM
    stuscore
WHERE
    MOD(sno, 2) = 0
ORDER BY
    sno;


---- 시퀀스
-- 번호 증가
SELECT
    stu_seq.NEXTVAL
FROM
    dual;
-- 번호 확인
SELECT
    stu_seq.CURRVAL
FROM
    dual;

CREATE SEQUENCE s_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999 NOCACHE NOCYCLE;

SELECT
    s_seq.NEXTVAL
FROM
    dual;

SELECT
    s_seq.CURRVAL
FROM
    dual;

CREATE TABLE board (
    bno      NUMBER(4) PRIMARY KEY,  -- 게시글 번호 // 기본 키: 중복 불가
    btitle   VARCHAR2(1000),      -- 제목 // varchar2 - 4000byte까지 가능
    bcontent CLOB,              -- 내용 // clob - 대용량 문자(varchar2(무한)라고 볼 수 있음): 4GB....까지 가능
    id       VARCHAR2(100),           -- 회원가입 id 연결
    bgroup   NUMBER(4),           -- 답변달기 부모그룹
    bstep    NUMBER(4),            -- 답변달기 순서
    bindent  NUMBER(4),          -- 답변달기 들여쓰기
    bhit     NUMBER(4),             -- 조회수
    bfile    VARCHAR2(100),        -- 파일첨부
    bdate    DATE                  -- 입력날짜
);  -- 총 10개 항목

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           '게시글을 등록합니다.',
                           '홈페이지를 오픈합니다. 많은 이용바랍니다.',
                           'aaa',
                           board_seq.CURRVAL,
                           0,
                           0,
                           0,
                           '',
                           sysdate );

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           '이벤트 등록',
                           '이벤트를 등록합니다.',
                           'bbb',
                           board_seq.CURRVAL,
                           0,
                           0,
                           0,
                           '',
                           sysdate    -- '' >> (null)
                            );

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           'ㅎㅇ',
                           'ㅎㅇㅎㅇ',
                           'ccc',
                           board_seq.CURRVAL,
                           0,
                           0,
                           0,
                           '',
                           sysdate );

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           'dd',
                           'ㅇㅇ',
                           'ddd',
                           board_seq.CURRVAL,
                           0,
                           0,
                           0,
                           '',
                           sysdate );

INSERT INTO board VALUES ( board_seq.NEXTVAL,
                           'ㅇㅋ',
                           'ㄴㄴㄴ',
                           'eee',
                           board_seq.CURRVAL,
                           0,
                           0,
                           0,
                           '',
                           sysdate );

SELECT
    *
FROM
    board;

COMMIT;

SELECT
    *
FROM
    stuscore;

SELECT
    stuscore_seq.CURRVAL
FROM
    dual;

INSERT INTO stuscore VALUES ( stuscore_seq.NEXTVAL,
                              '정',
                              100,
                              100,
                              99,
                              100 + 100 + 99,
                              ( 100 + 100 + 99 ) / 3,
                              0 );

COMMIT;


-- delete stuscore where sno in(101,102);

SELECT
    *
FROM
    stuscore
WHERE
    sno = 103;

UPDATE stuscore
SET
    kor = 100,
    total = 100 + eng + math,
    avg = ( 100 + eng + math ) / 3
WHERE
    sno = 103;

ROLLBACK;

-- 이름에 '김'이 들어간 학생 검색
SELECT
    *
FROM
    stuscore
WHERE
    name LIKE '%김%';


-- 형변환
-- number, varchar2, char, date
-- 사칙연산
SELECT
    1 + 2
FROM
    dual;

SELECT
    1 + '2'
FROM
    dual;     --문자열에 있는 숫자도 가능

-- ||, concat()으로 문자열 결합
SELECT
    1 + 'a'
FROM
    dual;     --불가
SELECT
    'a' + 'b'
FROM
    dual;   --불가

-- 날짜 +, - 가능
SELECT
    sysdate - 1
FROM
    dual;

SELECT
    hire_date
FROM
    employees;

SELECT
    sysdate - hire_date
FROM
    employees;

SELECT
    hire_date,
    round(hire_date),
    to_char(hire_date, 'yyyy-mm-dd hh:mi-ss')
FROM
    employees;

SELECT
    bdate,
    to_char(bdate, 'yyyy-mm-dd hh24:mi:ss')
FROM
    board;


--insert into board values (
--board_seq.nextval,'추가 게시글 등록
--);

-- select bdate,round(bdate,'day') from board;

-- select sdate;

-- 16일 기준 
SELECT
    mdate,
    to_char(mdate, 'yyyy-mm-dd hh:mi:ss'),
    trunc(mdate, 'month')
FROM
    member;

SELECT
    emp_name,
    hire_date,
    sysdate,
    months_between(sysdate, hire_date)
FROM
    employees;


-- 학생성적이 현재일부터, 등록되어 있는 기간이 4개월이 넘은 사람 찾기
SELECT
    *
FROM
    member
WHERE
    round(months_between(sysdate, mdate)) = 4;

SELECT
    mdate
FROM
    member;

-- substr()
SELECT
    mdate,
    substr(
        to_char(mdate),
        3
    )
FROM
    member;

-- 파이썬 substr() ?? a[3:7]

SELECT
    name
FROM
    stuscore;

SELECT
    emp_name
FROM
    employees;

-- emp_name 3,4 3번째부터 4개의 글자를 가져와서 출력
SELECT
    substr(emp_name)
FROM
    employees;

-- round(달을 기준으로) - 16일 이상이면 월 +1, 16일 미만 >> 1일
SELECT
    mdate
FROM
    member;

SELECT
    mdate,
    round(mdate, 'month')
FROM
    member;

SELECT
    1.5,
    round(1.5),
    trunc(1.5)
FROM
    dual;

-- trunc(달을 기준으로) 일을 절사
SELECT
    mdate,
    trunc(mdate, 'month')
FROM
    member;

-- round(연도 기준)
SELECT
    mdate,
    round(mdate, 'year')
FROM
    member;

-- months_between (두 날짜 사이의 달 수를 계산)
SELECT
    sysdate,
    mdate,
    sysdate - mdate
FROM
    member;     -- 일 수 차이 
SELECT
    sysdate,
    mdate,
    trunc(
        months_between(sysdate, mdate),
        1
    )
FROM
    member;     -- 달 수 차이


-- add_months (날짜에 달 더하기)
SELECT
    sysdate,
    mdate,
    add_months(mdate, 12) - 1
FROM
    member;

-- 다음 요일 찾기
SELECT
    sysdate,
    next_day(sysdate, '수요일')
FROM
    dual;

-- 마지막 날 찾기(그 달의 마지막 날)
SELECT
    sysdate,
    last_day(sysdate)
FROM
    dual;

SELECT
    mdate,
    last_day(mdate)
FROM
    member;

SELECT
    *
FROM
    employees;

SELECT
    hire_date,
    last_day(hire_date)
FROM
    employees;


-- 형 변환
-- to_numb <-> to_char <-> to_date
-- 날짜를 문자타입으로 변ㄴ경
SELECT
    sysdate,
    to_char(sysdate, 'yyyy')
FROM
    dual;

SELECT
    sysdate,
    TO_NUMBER(to_char(sysdate, 'mm'))
FROM
    dual;

-- member 테이블에서 5월에 가입한 회원 출력
SELECT
    *
FROM
    member;

SELECT
    *
FROM
    member
WHERE
    to_char(mdate, 'mm') = '05';
-- 5,6,7월 가입
SELECT
    *
FROM
    member
WHERE
    to_char(mdate, 'mm') IN ( '05', '06', '07' )
ORDER BY
    mdate;

--employees 테이블 5,6,7월 입사
SELECT
    hire_date,
    to_char(hire_date, 'mm') mm
FROM
    employees
WHERE
    to_char(hire_date, 'mm') IN ( '05', '06', '07' )
ORDER BY
    mm;

-- 월 수 출력
SELECT
    sysdate,
    to_char(sysdate, 'mon')
FROM
    dual;

SELECT
    mdate,
    to_char(mdate, 'mon')
FROM
    member;
-- 'day' > 요일
-- 일요일에 가입한 사람 출력
SELECT
    *
FROM
    member
WHERE
    to_char(mdate, 'day') = '일요일'
ORDER BY
    mdate;

-- am/pm: 오전/오후 표기 // hh24: 24시간 표기
SELECT
    bdate,
    to_char(bdate, 'yyyy-mm-dd pm hh:mi:ss')
FROM
    board;   --am이나 pm이나 상관없음


-- 숫자타입을 문자타입으로 변경
-- '999,999' >> 천 단위 표기, 빈 자리 공백
-- '000000' >> 빈 자리 0으로 채움
-- L 국가통화 표시, $ 달러표시
SELECT
    1230000000,
    to_char(1230000000, 'L999,999,999,999.99')
FROM
    dual;

--salary 달러표시, 1438원 곱해서 원화표시, 천 단위 표기, 소수점 2자리 넣어 출력

SELECT
    to_char(salary, '$99,999,999'),
    to_char(salary * 1438, 'L99,999,999,999'),
    to_char(salary * 1438, 'L999,999,999.99')
FROM
    employees;


--날짜형 타입 변환 to_date()
SELECT
    20221231,
    TO_DATE(20221231, 'yyyy-mm-dd')
FROM
    dual;

SELECT
    '20221231' - 1,
    TO_DATE('20221231', 'yyyy-mm-dd')
FROM
    dual;

SELECT
    '20221231' + 90,
    add_months(TO_DATE('20221231', 'yyyy-mm-dd'), 3)
FROM
    dual;

--'09/01/01' 날짜타입으로 변경해서, 현재날짜 기준으로 몇개월이 지났는지 출력하시오.
SELECT
    sysdate,
    '09/01/01',
    months_between(sysdate, '09/01/01')
    || '개월'
FROM
    dual;
-- 문자형이어도 날짜 모양이면 바로 연산 가능

-- 숫자형 변환 to_number()
SELECT
    '20,000' - 1
FROM
    dual;    -- 불가: 문자형이 숫자모양이 아니기 때문(,)
-- to_number가 정석적
SELECT
    TO_NUMBER('20,000', '999,999') - 1
FROM
    dual;

-- replace() 특정문자 대체
SELECT
    '***,111',
    replace('***,111', '*', '0')
FROM
    dual;

SELECT
    '20,000',
    replace('20,000', ',', '')
FROM
    dual;

SELECT
    '     1231111 111 11111  '
FROM
    dual;

SELECT
    TRIM('     1231111 111 11111  ') - 1
FROM
    dual;    --공백 때문에 연산 불가
SELECT
    replace('     1231111 111 11111  ', ' ', '') - 1
FROM
    dual;


---------
-- 그룹함수는 단일컬럼과 함께 사용할 수 없음.
SELECT
    *
FROM
    employees
WHERE
    salary >= (
        SELECT
            AVG(salary)
        FROM
            employees
    );

SELECT
    MAX(salary),
    MIN(salary),
    round(
        avg(salary),
        2
    ),
    COUNT(salary),
    SUM(salary)
FROM
    employees;    

-- 부서번호가 50번인 사원들의 합계를 출력
select sum(salary),count(salary),avg(salary) from employees
where department_id = 50;

-- 그룹함수 경우 - null 제외?
select count(*) from employees;
select count(manager_id) from employees;    -- null값 1개 빠짐


--문자열 함수
-- initcap, lower, upper
select emp_name from employees;
select emp_name, upper(emp_name),lower(emp_name) from employees;
select name from member;

--lpad, rpad: 글자의 나머지 자릿수만큼 특정문자로 대체
select kor,lpad(kor,10,'@') from stuscore;

--trim,ltrim,rtrim 빈공백 제거
select ltrim(a) from (select '     aa     bb     ' a from dual);

--substr() 해당하는 만큼 문자열을 분리해서 가져옴.
select name from stuscore;
select substr(name,2,2) from stuscore; --substr(에서,번째 글자부터,몇 개) 를 가져옴
select substr(name,0,1) from stuscore;

--translate 문자열 치환 >> replace로 대체?
select replace('111222333aabbbb','a','0') from dual;

--length: 문자열 길이
select kor from stuscore;
select length(kor) from stuscore;
select max(length(name)) from stuscore;
select name,length(name) from stuscore;

-- 이름의 마지막 글자만 제외 후 출력
select substr(name,0,length(name)-1) from stuscore;


create table test (
ch1 char(30),
ch2 varchar2(30)
);

insert into test values(
'1','1'
);

select * from test;
commit;

select length(ch1),length(ch2) from test;

-- 날짜함수 
-- 달의 첫일, mdate, 마지막 일을 출력하시오.
select * from member;
select trunc(mdate,'month'), mdate, last_day(mdate) from member;
-- 월 수만 출력
select name,mdate,to_char(mdate,'mm') from member where to_char(mdate,'mm')= '05' order by mdate;

-- 홍길동 가입일: 2024년 07월 14일 화요일

select name, to_char(mdate,'"가입일: "yyyy"년" mm"월" dd"일" day') from member;

