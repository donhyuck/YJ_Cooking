## 래시피 대량 생성
INSERT INTO recipe ( regDate, updateDate, memberId, title, `body`)
SELECT NOW(), NOW(), FLOOR(RAND() * 5)+1, "", "";

DELIMITER $$
DROP PROCEDURE IF EXISTS dataRecipeInsert$$
CREATE PROCEDURE dataRecipeInsert() ## 함수 생성
BEGIN ## 시작    
DECLARE i INT DEFAULT 1; ## 시작값        
WHILE(i<=300) DO ## 반복문         
INSERT INTO recipe ( regDate, updateDate, memberId, title, `body`) VALUE (NOW(), NOW(), FLOOR(RAND() * 5)+1, "", "");
SET i=i+1;        
END WHILE; ## 반복 종료         
END $$

## 함수 호출
CALL dataRecipeInsert(); $$

## 대량 데이터 생성
INSERT INTO guide ( regDate, updateDate, sortId, methodId, contentId, freeId )
SELECT NOW(), NOW(),
FLOOR(RAND() * 14),
FLOOR(RAND() * 11),
FLOOR(RAND() * 16),
FLOOR(RAND() * 10);

DELIMITER $$
DROP PROCEDURE IF EXISTS dataGuideInsert$$
CREATE PROCEDURE dataGuideInsert() ## 함수 생성
BEGIN ## 시작    
DECLARE i INT DEFAULT 1; ## 시작값        
WHILE(i<=300) DO ## 반복문         
INSERT INTO guide ( regDate, updateDate, sortId, methodId, contentId, freeId )
VALUE (NOW(), NOW(), FLOOR(RAND() * 14), FLOOR(RAND() * 11), FLOOR(RAND() * 16), FLOOR(RAND() * 10));       
SET i=i+1;        
END WHILE; ## 반복 종료         
END $$

## 함수 호출
CALL dataGuideInsert(); $$

## 대량 데이터 생성
INSERT INTO ingredient ( regDate, updateDate )
SELECT NOW(), NOW();

DELIMITER $$
DROP PROCEDURE IF EXISTS dataIngredientInsert$$
CREATE PROCEDURE dataIngredientInsert() ## 함수 생성
BEGIN ## 시작    
DECLARE i INT DEFAULT 1; ## 시작값        
WHILE(i<=300) DO ## 반복문         
INSERT INTO ingredient ( regDate, updateDate )
VALUE (NOW(), NOW());       
SET i=i+1;        
END WHILE; ## 반복 종료         
END $$

## 함수 호출
CALL dataIngredientInsert(); $$

## 대량 데이터 생성 후 업데이트 시작
## 레시피 guideId 업데이트
UPDATE recipe
SET guideId = id
WHERE guideId = 0;

UPDATE guide
SET recipeId = id;

## 레시피 ingredient 업데이트
UPDATE recipe
SET ingredientId = id
WHERE ingredientId = 0;

UPDATE ingredient
SET recipeId = id;

UPDATE recipe R, guide G,category C
SET R.title = C.name
WHERE G.contentId = C.relId
AND C.boardId = 3
AND G.id = guideId;

## 요리재료 항목 갱신
UPDATE ingredient I, recipe R
SET I.rowArr = R.title
WHERE I.id = R.ingredientId;

UPDATE ingredient
SET rowArr = '재료 A'
WHERE rowArr = '';

UPDATE ingredient
SET rowValueArr = '1개'
WHERE rowValueArr = '';

UPDATE ingredient
SET sauceArr = '양념 B'
WHERE sauceArr = '';

UPDATE ingredient
SET sauceValueArr = '1T'
WHERE sauceValueArr = '';

## 레시피 제목 설정 시작
UPDATE recipe R, guide G,category C
SET R.title = C.name
WHERE G.sortId = C.relId
AND C.boardId = 1
AND G.id = guideId;

UPDATE recipe R, guide G,category C
SET R.title = CONCAT(R.title,"/",C.name)
WHERE G.contentId = C.relId
AND C.boardId = 3
AND G.id = guideId;

UPDATE recipe R, guide G,category C
SET R.title = CONCAT(R.title,C.name)
WHERE G.methodId = C.relId
AND C.boardId = 2
AND G.id = guideId;

UPDATE recipe R, guide G,category C
SET R.title = CONCAT(R.title,"/",C.name)
WHERE G.freeId = C.relId
AND C.boardId = 4
AND G.id = guideId;

## 레시피 내용 설정
UPDATE recipe
SET `body` = REPLACE(title, "/","");

# 레시피 테스트 데이터 재등록
UPDATE recipe
SET title = '감자볶음',
`body` = '손쉽게 만들어요.'
WHERE id =1;

UPDATE recipe
SET title = '소갈비찜',
`body` = '온가족 든든하게 즐겨요.'
WHERE id = 2;

UPDATE recipe
SET title = '로제파스타',
`body` = '한번만 먹어본 사람은 없다.'
WHERE id = 3;

# 기존 데이터 조회수, 하트수, 스크랩 설정
UPDATE recipe
SET goodRP = FLOOR(RAND() * 200)+1,
scrap = FLOOR(RAND() * 350)+1
WHERE goodRP = 0
AND scrap = 0;

UPDATE recipe
SET hitCount = goodRP + FLOOR(RAND() * 500)+1
WHERE hitCount = 0;

## 재료양념 데이터 구성
UPDATE ingredient
SET rowArr='감자,당근,양파',
rowValueArr='3개,1/3개,1/2개',
sauceArr='굴소스(선택),소금,후추',
sauceValueArr='1T,약간,약간'
WHERE recipeId=1;

UPDATE ingredient
SET rowArr='갈비대,밤,표고버섯',
rowValueArr='2kg,1컵,4개',
sauceArr='간배,간양파,간장,물,설탕,참기름,다진마늘,대파',
sauceValueArr='1/2개,1/2개,3/4컵,1컵,1/2컵,1/2컵,3큰술,1개'
WHERE recipeId=2;

UPDATE ingredient
SET rowArr='파스타면,마늘,베이컨 또는 새우,양파',
rowValueArr='500원크기,4개,1줌,1/3개',
sauceArr='토마토소스,생크림,치즈',
sauceValueArr='120ml,170ml,1장'
WHERE recipeId=3;

SELECT * FROM recipe;
SELECT * FROM ingredient;
SELECT * FROM guide;
## 대량 데이터 생성 후 업데이트 끝