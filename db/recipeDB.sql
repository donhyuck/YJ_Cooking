# DB 생성
DROP DATABASE IF EXISTS recipeTest;
CREATE DATABASE recipeTest;
USE recipeTest;

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
    recipeId INT(10) NOT NULL UNIQUE,
    sortId INT(10) UNSIGNED NOT NULL,
    methodId INT(10) UNSIGNED NOT NULL,
    contentId INT(10) UNSIGNED NOT NULL,
    freeId INT(10) UNSIGNED NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)'
);

## 대량 데이터 생성
INSERT INTO guide
(
    regDate, updateDate, recipeId, sortId, methodId, contentId, freeId
)
SELECT NOW(), NOW(), FLOOR(RAND() * 1000)+1, FLOOR(RAND() * 13)+1, FLOOR(RAND() * 10)+1, FLOOR(RAND() * 13)+1, FLOOR(RAND() * 8)+1;

# 1개 검색할 때
# boardId = 1, relId = 7
# boardId = 2, relId = 2
# boardId = 3, relId = 5
# boardId = 4, relId = 3
# category boardId relId
# guide    recipeId sortId methodId contentId freeId

SELECT G.*, C.name
FROM category AS C
LEFT JOIN guide AS G
ON G.sortId
AND G.methodId
AND G.contentId
AND G.freeId
WHERE G.sortId = 5
AND G.methodId = 6
AND G.contentId = 11
AND G.freeId = 5;

SELECT * FROM board;
SELECT * FROM category;
SELECT * FROM guide;
SELECT COUNT(*) FROM guide;

SELECT COUNT(*)
FROM category
GROUP BY boardId;
