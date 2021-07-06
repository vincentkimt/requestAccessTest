function onBtnClick(){
	
	alert("From btn click");
	var inputNumber = prompt("Please enter your number", "10");
	
	if(inputNumber%2==0){
		document.getElementById("divForDisplay").innerHTML= inputNumber + "an even number";
	}
	else{
		document.getElementById("divForDisplay").innerHTML= inputNumber + "an odd number";

	}
	
	
	
}
function onMyClick(){

alert(getString);


}