## 래시피 대량 생성
INSERT INTO recipe ( regDate, updateDate, memberId, guideId, title, `body`)
SELECT NOW(), NOW(), FLOOR(RAND() * 5)+1, 0, "", "";

DELIMITER $$
DROP PROCEDURE IF EXISTS dataRecipeInsert$$
CREATE PROCEDURE dataRecipeInsert() ## 함수 생성
BEGIN ## 시작    
DECLARE i INT DEFAULT 1; ## 시작값        
WHILE(i<=300) DO ## 반복문         
INSERT INTO recipe ( regDate, updateDate, memberId, guideId, title, `body`) VALUE (NOW(), NOW(), FLOOR(RAND() * 5)+1, 0, "", "");       
SET i=i+1;        
END WHILE; ## 반복 종료         
END $$

## 함수 호출
CALL dataRecipeInsert(); $$

## 대량 데이터 생성
INSERT INTO guide ( regDate, updateDate, recipeId, sortId, methodId, contentId, freeId )
SELECT NOW(), NOW(), 
FLOOR(RAND() * 1000)+1,
FLOOR(RAND() * 13)+1,
FLOOR(RAND() * 10)+1,
FLOOR(RAND() * 15)+1,
FLOOR(RAND() * 10)+1;

DELIMITER $$
DROP PROCEDURE IF EXISTS dataGuideInsert$$
CREATE PROCEDURE dataGuideInsert() ## 함수 생성
BEGIN ## 시작    
DECLARE i INT DEFAULT 1; ## 시작값        
WHILE(i<=300) DO ## 반복문         
INSERT INTO guide ( regDate, updateDate, recipeId, sortId, methodId, contentId, freeId )
VALUE (NOW(), NOW(), FLOOR(RAND() * 1000)+1, FLOOR(RAND() * 13)+1, FLOOR(RAND() * 10)+1, FLOOR(RAND() * 15)+1, FLOOR(RAND() * 10)+1);       
SET i=i+1;        
END WHILE; ## 반복 종료         
END $$

## 함수 호출
CALL dataGuideInsert(); $$