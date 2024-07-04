function getDateString(date) {
	const year = date.getFullYear();
	const month = (date.getMonth() + 1).toString().padStart(2, '0');
	const day = date.getDate().toString().padStart(2, '0');
	return year + month + day;
}
		
function getAirCondition(type, value) {
	if(type == "PM25") {
		if (value <= 15){
			return "좋음";					
		} else if (value <= 35){
			return "보통";
		} else if (value <= 75){
			return "나쁨";
		} else {
			return "매우나쁨";
		}
	} else {
		if (value <= 30){
			return "좋음";					
		} else if (value <= 80){
			return "보통";
		} else if (value <= 150){
			return "나쁨";
		} else {
			return "매우나쁨";
		}
	}
}

function getWindDirection(value) {
	var result = parseInt((value + 22.5 * 0.5) / 22.5);
	
	var arr = ["북", "북북동", "북동", "동북동", "동", "동남동", "남동", "남남동", "남", "남남서", "남서", "서남서", "서", "서북서", "북서", "북북서", "북"];
	
	return arr[result];
	
}