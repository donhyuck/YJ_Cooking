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
    loginPw CHAR(100) NOT NULL,
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

# 부가정보테이블
# 부가정보테이블 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    `relId` INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

DESC attr;
SELECT * FROM attr;

# 레시피 테이블에 요리정보(인원, 소요시간, 난이도) 추가
ALTER TABLE recipe ADD COLUMN amount INT(10) UNSIGNED NOT NULL DEFAULT 1;
ALTER TABLE recipe ADD COLUMN `time` INT(10) UNSIGNED NOT NULL DEFAULT 5;
ALTER TABLE recipe ADD COLUMN `level` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '(1=누구나, 2=초급, 3=중급, 4=고급)';

# 기존 데이터에 요리정보 넣기
UPDATE recipe
SET `amount` = 3,
`time` = 15,
`level` = '1'
WHERE id = 1;

UPDATE recipe
SET `amount` = 4,
`time` = 120,
`level` = '4'
WHERE id = 2;

UPDATE recipe
SET `amount` = 2,
`time` = 20,
`level` = '3'
WHERE id = 3;

SELECT * FROM recipe;

# 레시피 테이블에 조회수 추가
ALTER TABLE recipe ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 레시피 테이블에 팁/주의사항 추가
ALTER TABLE recipe ADD COLUMN tip TEXT;

UPDATE recipe
SET tip = '핏물 뺄 시간이 부족하다면 끓는 물에 5분 정도 넣었다 빼시돼요.'
WHERE id = 2;

# 리액션포인트 테이블 생성
CREATE TABLE reactionPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `point` SMALLINT(2) NOT NULL
);

# 리액션포인트 테스트 데이터
## 1번 회원이 1번 recipe 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 1,
`point` = 1;

## 1번 회원이 2번 recipe 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 2,
`point` = 1;

## 2번 회원이 1번 recipe 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'recipe',
relId = 1,
`point` = 1;

## 2번 회원이 3번 recipe 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'recipe',
relId = 3,
`point` = 1;

## 3번 회원이 1번 recipe 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'recipe',
relId = 1,
`point` = 1;

SELECT * FROM reactionPoint;

## 레시피 목록 가져오는 쿼리에 관련 리액션 포인트도 같이 가져오게 하기
SELECT R.*,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)), 0) AS extra__goodRP
FROM (
    SELECT R.*,
    M.nickname AS extra__writerName
    FROM recipe AS R
    LEFT JOIN
    `member` AS M
    ON R.memberId = M.id
    WHERE 1
) AS R
LEFT JOIN reactionPoint AS RP
ON RP.relTypeCode = 'recipe'
AND R.id = RP.relId
GROUP BY R.id
ORDER BY R.id DESC;

## 댓글 상세정보 가져오는 쿼리에 관련 리액션 포인트도 같이 가져오게 하기
SELECT R.*,
M.nickname AS extra__writerName,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)), 0) AS extra__goodRP
FROM recipe AS R
LEFT JOIN `member` AS M
ON R.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON RP.relTypeCode = 'recipe'
AND R.id = RP.relId
WHERE R.id = 1;

# 레시피 테이블 goodRP 컬럼을 추가
ALTER TABLE recipe ADD COLUMN goodRP INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER hitCount;

UPDATE recipe AS R
INNER JOIN (
	SELECT RP.relId,
	SUM(IF(RP.point > 0, RP.point, 0)) AS goodRP
	FROM reactionPoint AS RP
	WHERE relTypeCode = 'recipe'
	GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON R.id = RP_SUM.relId
SET R.goodRP = RP_SUM.goodRP;

SELECT * FROM recipe;
SELECT * FROM reactionPoint;

# 스크랩포인트 테이블 생성
CREATE TABLE scrapPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `point` SMALLINT(2) NOT NULL
);

# 스크랩포인트 테스트 데이터
## 1번 회원이 1번 recipe 저장
INSERT INTO scrapPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 1,
`point` = 1;

## 1번 회원이 2번 recipe 저장
INSERT INTO scrapPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 2,
`point` = 1;

## 2번 회원이 1번 recipe 저장
INSERT INTO scrapPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'recipe',
relId = 1,
`point` = 1;

## 3번 회원이 3번 recipe 저장
INSERT INTO scrapPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'recipe',
relId = 3,
`point` = 1;

# 레시피 테이블 scrap 컬럼을 추가
ALTER TABLE recipe ADD COLUMN scrap INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER goodRP;

UPDATE recipe AS R
INNER JOIN (
	SELECT SP.relId,
	SUM(IF(SP.point > 0, SP.point, 0)) AS scrap
	FROM scrapPoint AS SP
	WHERE relTypeCode = 'recipe'
	GROUP BY SP.relTypeCode, SP.relId
) AS SP_SUM
ON R.id = SP_SUM.relId
SET R.scrap = SP_SUM.scrap;

SELECT * FROM recipe;
SELECT * FROM scrapPoint;