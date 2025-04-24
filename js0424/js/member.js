// 다음주소 함수 (에러)
function zipCodeBtn(){
    new daum.Postcode({
        oncomplete: function(data) {
            alert("다음주소api");
            
            document.querySelector("#postZip").value = data.zonecode;
            document.querySelector("#addr1").value = data.address;
            document.querySelector("#addr2").focus();
            
        }
    }).open();

}

// input Box >> .value
// 그 외 html 텍스트 >> .innerText
// document.querySelector("#pw")
// class > . / id > #


// 비밀번호 확인
function pwConfirm(){
    let pw1 = document.querySelector("#pw").value;
    let pw2 = document.querySelector("#pw2").value;
    if (pw2 == ""){
        document.querySelector("#pwCheck").style.color = "#555"
        document.querySelector("#pwCheck").innerText = "비밀번호를 다시 한 번 입력해 주세요."
    }else if (pw2 == pw1){
        document.querySelector("#pwCheck").style.color = "green"
        document.querySelector("#pwCheck").innerText = "비밀번호가 일치합니다."
    }else{
        document.querySelector("#pwCheck").style.color = "red"
        document.querySelector("#pwCheck").innerText = "비밀번호가 다릅니다."
    };

}
