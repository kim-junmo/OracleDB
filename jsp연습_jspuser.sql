--회원테이블 생성

CREATE TABLE t_MEMBER (
    id VARCHAR2(10) PRIMARY KEY,
    pwd VARCHAR2(10) NOT NULL,
    Name VARCHAR2(50) NOT NULL,
    Email VARCHAR2(50) NOT NULL,
    joinDate DATE   DEFAULT SYSDATE
);

--데이터 3개
INSERT INTO T_MEMBER VALUES('USER01', '1234', '손흥민', 'SON@NATE.COM', SYSDATE);
INSERT INTO T_MEMBER VALUES('USER02', '1234', '이강인', 'LEE@NATE.COM', SYSDATE);
INSERT INTO T_MEMBER VALUES('USER03', '1234', '황희찬', 'HWA@NATE.COM', SYSDATE);

COMMIT;

SELECT * FROM T_MEMBER;