# DB 생성
DROP DATABASE IF EXISTS YoriJori;
CREATE DATABASE YoriJori;
USE YoriJori;

# 레시피 테이블 생성
CREATE TABLE recipe (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

SHOW TABLES;
SELECT * FROM recipe;

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
email = 'admin@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
nickname = '몽룡',
cellphoneNo = '01078907890',
email = 'test1@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
nickname = '춘향',
cellphoneNo = '01096319631',
email = 'test2@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test3',
loginPw = 'test3',
nickname = '임꺽정',
cellphoneNo = '01034343434',
email = 'test3@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test4',
loginPw = 'test4',
nickname = '홍길동',
cellphoneNo = '01089895656',
email = 'test4@gmail.com';

SELECT * FROM `member`;

# 레시피 테이블에 회원정보 추가
ALTER TABLE recipe ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

# 기존 레시피의 작성자를 2번으로 지정
UPDATE recipe
SET memberId = 2
WHERE memberId = 0;

UPDATE recipe
SET memberId = 3
WHERE id = 3;

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
SELECT * FROM `member`;
SELECT * FROM scrapPoint;

## 내가 스크랩한 레시피 목록 가져오기
SELECT R.*
FROM (
    SELECT R.*,
    M.nickname AS extra__writerName
    FROM recipe AS R
    LEFT JOIN
    `member` AS M
    ON R.memberId = M.id
) AS R
LEFT JOIN scrapPoint AS SP
ON R.id = SP.relId
WHERE SP.memberId = 2
GROUP BY R.id
ORDER BY R.id DESC;

# 댓글 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `body` TEXT NOT NULL
);

# 댓글 테스트 데이터 생성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 1,
`body` = '간단한게 먹기 좋아요 맛있어요!';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'recipe',
relId = 2,
`body` = '오늘 저녁에 함 해봐야겠어요.';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 4,
relTypeCode = 'recipe',
relId = 3,
`body` = '특별한 날 기분낼 때 좋네요~';

INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 5,
relTypeCode = 'recipe',
relId = 3,
`body` = '불세기는 어느정도인가요?';

SELECT * FROM reply;

# 댓글 테이블에 인덱스 걸기
ALTER TABLE `reply` ADD INDEX (`relTypeCode`, `relId`);

# 로그인비밀번호 컬럼의 길이를 100으로 늘림
ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;

# 기존 회원의 비밀번호를 암호화 해서 저장
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

# board 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'sort,method,content,free...',
    `boardName` CHAR(50) NOT NULL UNIQUE COMMENT '종류,방법,재료,자유...',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)'
);

# board 데이터 생성
INSERT INTO board
SET regDate=NOW(),
updateDate=NOW(),
`code`='sort',
`boardName`='종류';

INSERT INTO board
SET regDate=NOW(),
updateDate=NOW(),
`code`='method',
`boardName`='방법';

INSERT INTO board
SET regDate=NOW(),
updateDate=NOW(),
`code`='content',
`boardName`='재료';

INSERT INTO board
SET regDate=NOW(),
updateDate=NOW(),
`code`='free',
`boardName`='자유';

SELECT * FROM board;

# category 테이블 생성
CREATE TABLE category (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    `name` CHAR(50) NOT NULL UNIQUE,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)'
);

# category 데이터 생성
INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 1,
`name`='밑반찬';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 2,
`name`='메인반찬';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 3,
`name`='국/탕/찌게';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 4,
`name`='밥/죽';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 5,
`name`='면/국수';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 6,
`name`='장류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 7,
`name`='소스/양념';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 8,
`name`='한식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 9,
`name`='중식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 10,
`name`='양식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 11,
`name`='동남아식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 12,
`name`='베이커리';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 1,
relId = 13,
`name`='음료/차';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 1,
`name`='볶기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 2,
`name`='굽기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 3,
`name`='끓이기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 4,
`name`='찜';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 5,
`name`='조림';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 6,
`name`='튀김';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 7,
`name`='삶기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 8,
`name`='데치기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 9,
`name`='무치기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 2,
relId = 10,
`name`='전/부침';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 1,
`name`='소고기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 2,
`name`='돼지고기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 3,
`name`='닭고기';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 4,
`name`='생선류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 5,
`name`='갑각류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 6,
`name`='해조류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 7,
`name`='건어물류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 8,
`name`='과일류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 9,
`name`='채소류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 10,
`name`='버섯류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 11,
`name`='견과류/곡류';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 12,
`name`='쌀/밀';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 13,
`name`='달걀/유제품';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 14,
`name`='구황작물';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 3,
relId = 15,
`name`='가공식품';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 1,
`name`='술안주';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 2,
`name`='해장';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 3,
`name`='야식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 4,
`name`='다이어트';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 5,
`name`='간편식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 6,
`name`='영양식';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 7,
`name`='도시락';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 8,
`name`='기념일';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 9,
`name`='집들이';

INSERT INTO category
SET regDate=NOW(),
updateDate=NOW(),
boardId = 4,
relId = 10,
`name`='기타';

## 카테고리의 상위분류 이름과 함께 보기
SELECT C.*, B.boardName
FROM category AS C
LEFT JOIN board AS B
ON C.boardId = B.id;

# guide 테이블 생성
CREATE TABLE guide (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    recipeId INT(10) UNSIGNED NOT NULL UNIQUE,
    sortId INT(10) UNSIGNED NOT NULL,
    methodId INT(10) UNSIGNED NOT NULL,
    contentId INT(10) UNSIGNED NOT NULL,
    freeId INT(10) UNSIGNED NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)'
);

## 레시피 테이블에 guide 추가
ALTER TABLE recipe ADD COLUMN guideId INT(10) UNSIGNED NOT NULL AFTER memberId;

## 기존 레시피데이터에 guide 속성부여
INSERT INTO guide
SET regDate = NOW(),
updateDate = NOW(),
recipeId = 1,
sortId = 1,
methodId = 1,
contentId = 13,
freeId = 5;
 
INSERT INTO guide
SET regDate = NOW(),
updateDate = NOW(),
recipeId = 2,
sortId = 8,
methodId = 4,
contentId = 1,
freeId = 6;

INSERT INTO guide
SET regDate = NOW(),
updateDate = NOW(),
recipeId = 3,
sortId = 5,
methodId = 1,
contentId = 12,
freeId = 5;

UPDATE recipe
SET guideId = recipe.id
WHERE guideId = 0;

SELECT * FROM board;
SELECT * FROM category;
SELECT * FROM guide;
SELECT * FROM recipe;

SELECT *
FROM category
GROUP BY boardId;

## 분류 페이지에서 선택한 레시피 목록 가져오기
SELECT R.*,
M.nickname AS extra__writerName
FROM recipe AS R
LEFT JOIN `member` AS M
ON R.memberId = M.id
LEFT JOIN guide AS G
ON G.id = R.guideId
WHERE 1
AND IF( 1 = 4, G.sortId = 5, 1)
AND IF( 2 = 4, G.methodId = 1, 1)
AND IF( 3 = 4, G.contentId = 12, 1)
AND IF( 4 = 4, G.freeId = 5, 1);