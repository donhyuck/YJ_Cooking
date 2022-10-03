// 입력데이터 검사 스크립트 시작

let RecipeModify_submitFormDone = false;

function RecipeModify_submitForm(form) {
	if (RecipeModify_submitFormDone) {
		alert('처리중입니다.');
		return;
	}

	form.title.value = form.title.value.trim();
	if (form.title.value.length == 0) {
		alert('제목을 입력해주세요.');
		form.title.focus();
		return;
	}

	form.body.value = form.body.value.trim();
	if (form.body.value.length == 0) {
		alert('요리소개를 입력해주세요.');
		form.body.focus();
		return;
	}

	form.amount.value = form.amount.value.trim();
	if (form.amount.value.length == 0) {
		alert('인원을 선택 또는 입력해주세요.');
		form.amount.focus();
		return;
	}

	form.time.value = form.time.value.trim();
	if (form.time.value.length == 0) {
		alert('소요시간을 선택 또는 입력해주세요.');
		form.time.focus();
		return;
	}

	form.level.value = form.level.value.trim();
	if (form.level.value.length == 0) {
		alert('난이도를 선택해주세요.');
		form.level.focus();
		return;
	}
	
	// 조리순서 데이터 처리
	const editor = $(form).find('.toast-ui-editor').data(
		'data-toast-editor');
	const markdown = editor.getMarkdown().trim();
	if (markdown.length == 0) {
		alert('조리순서를 입력해주세요.');
		editor.focus();
		return;
	}
	form.orderBody.value = markdown;

	// 재료양념 데이터 배열처리 스크립트 시작
	var rowArrCnt = 0;
	var rowValueArrCnt = 0;
	var sauceArrCnt = 0;
	var sauceValueArrCnt = 0;
	var rowArr = $('[name="row"]');
	var rowValueArr = $('[name="rowValue"]');
	var sauceArr = $('[name="sauce"]');
	var sauceValueArr = $('[name="sauceValue"]');

	// 재료 항목
	var param = [];
	for (var i = 0; i < rowArr.length; i++) {
		rowArr[i].value = rowArr[i].value.trim();
		param.push(rowArr[i].value);
	}

	var rowStr = '';
	param.map(function(item) {
		if (item != '' && item.length - 1) {
			rowStr += item + ',';
			rowArrCnt++;
		}
	});

	// 재료 값
	param = [];
	for (var i = 0; i < rowValueArr.length; i++) {
		rowValueArr[i].value = rowValueArr[i].value.trim();
		param.push(rowValueArr[i].value);
	}

	var rowValueStr = '';
	param.map(function(item) {
		if (item != '' && item.length - 1) {
			rowValueStr += item + ',';
			rowValueArrCnt++;
		}
	});

	// 양념 항목
	param = [];
	for (var i = 0; i < sauceArr.length; i++) {
		sauceArr[i].value = sauceArr[i].value.trim();
		param.push(sauceArr[i].value);
	}

	var sauceStr = '';
	param.map(function(item) {
		if (item != '' && item.length - 1) {
			sauceStr += item + ',';
			sauceArrCnt++;
		}
	});

	// 양념 값
	param = [];
	for (var i = 0; i < sauceValueArr.length; i++) {
		sauceValueArr[i].value = sauceValueArr[i].value.trim();
		param.push(sauceValueArr[i].value);
	}

	var sauceValueStr = '';
	param.map(function(item) {
		if (item != '' && item.length - 1) {
			sauceValueStr += item + ',';
			sauceValueArrCnt++;
		}
	});

	// 항목과 값 미입력 확인
	if (rowArrCnt != rowValueArrCnt) {
		alert('[재료]의 항목 또는 수량을 확인하시고, 빈칸을 채워주세요.');
		$("#rowBox").attr("tabindex", -1).focus();
		return;
	}

	if (sauceArrCnt != sauceValueArrCnt) {
		alert('[양념]의 항목 또는 수량을 확인하시고, 빈칸을 채워주세요.');
		$("#rowBox").attr("tabindex", -1).focus();
		return;
	}

	// 마지막 구분자(,)제거
	rowStr = rowStr.substr(0, rowStr.lastIndexOf(','));
	rowValueStr = rowValueStr.substr(0, rowValueStr.lastIndexOf(','));
	sauceStr = sauceStr.substr(0, sauceStr.lastIndexOf(','));

	sauceValueStr = sauceValueStr.substr(0, sauceValueStr.lastIndexOf(','));

	// 구성된 문자열을 input테그 값으로
	document['do-modify-recipe-form'].rowArr.value = rowStr;
	document['do-modify-recipe-form'].rowValueArr.value = rowValueStr;
	document['do-modify-recipe-form'].sauceArr.value = sauceStr;
	document['do-modify-recipe-form'].sauceValueArr.value = sauceValueStr;

	form.rowArr.value = form.rowArr.value.trim();
	form.rowValueArr.value = form.rowValueArr.value.trim();
	form.sauceArr.value = form.sauceArr.value.trim();
	form.sauceValueArr.value = form.sauceValueArr.value.trim();
	// 재료양념 데이터 배열처리 스크립트 끝

	if (form.rowArr.value == 0) {
		alert('최소 1개 이상의 재료는 입력해주세요.');
		$("#rowBox").attr("tabindex", -1).focus();
		return;
	}

	// 대표사진 용량 제한
	const maxSizeMb = 10;
	const maxSize = maxSizeMb * 1204 * 1204;

	const mainRecipeImgFileInput = form["file__recipe__0__extra__mainRecipeImg__1"];

	if (mainRecipeImgFileInput.value) {
		if (mainRecipeImgFileInput.files[0].size > maxSize) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			mainRecipeImgFileInput.focus();

			return;
		}
	}

	RecipeModify_submitFormDone = true;
	form.submit();
}
// 입력데이터 검사 스크립트 끝