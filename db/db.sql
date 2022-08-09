# DB 생성
DROP DATABASE IF EXISTS YoriJori;
CREATE DATABASE YoriJori;
USE YoriJori;

# 레시피 테이블 생성
CREATE TABLE recipe (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100),
    `body` TEXT NOT NULL
);

# 레시피 테스트 데이터 생성
INSERT INTO recipe
SET regDate = NOW(),
updateDate = NOW(),
title = '감자볶음',
`body` = '손쉽게 만들어요.';

INSERT INTO recipe
SET regDate = NOW(),
updateDate = NOW(),
title = '소갈비찜',
`body` = '온가족 든든하게 즐겨요.';

INSERT INTO recipe
SET regDate = NOW(),
updateDate = NOW(),
title = '로제파스타',
`body` = '한번만 먹어본 사람은 없다.';

SELECT * FROM recipe;

# 회원 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(30) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    authLevel SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '(3=일반, 7=관리자)',
    nickname CHAR(20) NOT NULL,
    cellphoneNo CHAR(30) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부(0=탈퇴전, 1=탈퇴)',
    delDate DATETIME COMMENT '탈퇴날짜'
);

# 회원 테스트 데이터 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
authLevel = 7,
nickname = '관리자',
cellphoneNo = '01012341234',
email = 'admin01@test.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
nickname = '몽룡',
cellphoneNo = '01078907890',
email = 'tester01@test.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
nickname = '춘향',
cellphoneNo = '01096319631',
email = 'tester02@test.com';

SELECT * FROM `member`;

# 레시피 테이블에 회원정보 추가
ALTER TABLE recipe ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 기존 레시피의 작성자를 2번으로 지정
UPDATE recipe
SET memberId = 2
WHERE memberId = 0;

SELECT * FROM recipe;