// jQuery 선언
$(function(){

    $("#data_open").click(function(){
        alert("게시글 데이터를 가져옵니다.");

        
        // html 서버 통신 X / 웹프로그래밍 또는 ajax방법
        // ajax: html 일부 데이터를 전체 페이지 로드 없이 변경 가능
        $.ajax({
            url:"js/board.json",             // 서버로 전송하는 페이지
            type:"get",         // 데이터 전송 방식: get - url에 노출, post - 헤더에 숨김
            data:{"bno":1,"bhit":50},   // 서버로 전송하는 데이터
            dataType:"json",    // html, xml, json, text
            success:function(data){     // 서버와 통신 성공하면 data변수로 데이터를 전송
                /*
                alert("서버 연결 성공");
                console.log(data);
                console.log("1번째 : ",data[0]);
                console.log("총 개수 : ",data.length);
                */
                let hdata = ``;

                for(let i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i].bno}">`;
                    hdata += `<td>${data[i].bno}</td>`;
                    hdata += `<td>${data[i].title}</td>`;
                    hdata += `<td>${data[i].id}</td>`;
                    hdata += `<td>${data[i].bdate}</td>`;
                    hdata += `<td>${data[i].bhit}</td>`;
                    hdata += `<td><button type="button" id="modBtn">수정</button><button type="button" id="delBtn">삭제</button></td>`;
                    hdata += `</tr>`;

                };//for

                $('#tbody').html(hdata);

            },//success
            error:function(){
                alert("서버 연결 실패");
            }       
        
        });//ajax_01
    
    });//#data_open
    
    $(document).on("click","#data_open2",function(){
        
        $.ajax({
            url:"js/students.json",
            type:"get",
            data:{"request":"student.json 요청"},
            dataType:"json",
            success:function(data){
                alert('서버 연결 성공');
                let hdata = ``;
                let kor, eng, math = null;

                for(let i=0;i<data.length;i++){
                    kor = data[i].kor;
                    eng = data[i].eng;
                    math = data[i].math;
                    hdata += `<tr id="${data[i].sno}"><td>${data[i].sno}</td>`;
                    hdata += `<td>${data[i].sname}</td>`;
                    hdata += `<td>${kor}</td><td>${eng}</td><td>${math}</td>`;
                    hdata += `<td>${kor+eng+math}</td><td>${((kor+eng+math)/3).toFixed(2)}</td>`;
                    hdata += `<td>${data[i].sdate}</td>`;
                    hdata += `<td><button type="button" id="mod">수정</button><button type="button" id="del">삭제</button></td></tr>`;

                }

                $("#tbody").html(hdata);
                console.log(data);

            },
            error:function(){
                alert("서버 연결 실패");
            }
    
        })//ajax_02

    });//#data_open2


});//jQuery