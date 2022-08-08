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