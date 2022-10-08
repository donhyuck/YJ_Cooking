<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>이미지 테스트</div>
	<input style="display: block;" type="file" id="input-multiple-image" multiple />
	<div id="multiple-container"></div>

	<style>
	#multiple-container {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
	}
	
	.image {
		display: block;
		width: 100%;
	}
	
	.image-label {
		position: relative;
		bottom: 22px;
		left: 5px;
		color: white;
		text-shadow: 2px 2px 2px black;
	}
	</style>

	<script type="text/javascript">
	function readMultipleImage(input) {
		const multipleContainer = document.getElementById("multiple-container");
	
		// 인풋 태그에 파일들이 있는 경우
		if (input.files) {
			// 이미지 파일 검사 (생략)
			console.log(input.files);
			// 유사배열을 배열로 변환 (forEach문으로 처리하기 위해)
			const fileArr = Array.from(input.files);
			const $colDiv1 = document.createElement("div");
			const $colDiv2 = document.createElement("div");
			$colDiv1.classList.add("column");
			$colDiv2.classList.add("column");
			
			fileArr.forEach((file, index) => {
				const reader = new FileReader();
				const $imgDiv = document.createElement("div");
				const $img = document.createElement("img");
				$img.classList.add("image");
				const $label = document.createElement("label");
				$label.classList.add("image-label");
				$label.textContent = file.name;
				$imgDiv.appendChild($img);
				$imgDiv.appendChild($label);
				
				reader.onload = e => {
					$img.src = e.target.result
	
					$imgDiv.style.width = ($img.naturalWidth) * 0.2 + "px";
					$imgDiv.style.height = ($img.naturalHeight) * 0.2 + "px";
				};
	
				// 파일확인 콘솔
				console.log(file.name)
				if (index % 2 == 0) {
					$colDiv1.appendChild($imgDiv);
				} else {
					$colDiv2.appendChild($imgDiv);
				};
	
				reader.readAsDataURL(file);
			});
			
			multipleContainer.appendChild($colDiv1);
			multipleContainer.appendChild($colDiv2);
		};
	};
	
	const inputMultipleImage = document.getElementById("input-multiple-image")
	inputMultipleImage.addEventListener("change", e => {
		readMultipleImage(e.target);
	});
	</script>

</body>
</html>