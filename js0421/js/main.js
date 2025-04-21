// 함수 선언
function chBtn(){
    alert("색상을 빨간색으로 변경합니다.");
    //id로 찾는 방법 >> 1개만 찾음
    // let color1 = document.getElementById("color1");  // document에서 element를 id로 찾아 가져옴
    // class로 찾는 방법 >> 여러 개(리스트로 가져옴) 찾음 > 인덱스 지정해야 함
    // let color2 = document.getElementsByClassName("color2");  // document에서 element를 id로 찾아 가져옴


    // 쿼리 셀렉터 사용 권장
    // querySelector - id
    /*
    let color3 = document.querySelector("#color3");
    console.log(color3);
    color3.style.color = "red";
    color3.innerText = "회원수정";
    */

    // querySelector - class중 첫번째 1개만 검색
    // querySelectorAll() - class 중 여러 개 검색: 리스트로 검색됨.
    
    let color4 = document.querySelector(".color4");
    console.log(color4);
    color4.style.color = "red";
    color4.innerText = "회원수정";


    let color5 = document.querySelectorAll(".color4");
    console.log(color5);
}