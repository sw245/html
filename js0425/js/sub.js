$(function(){
    
    // $('#data_open4').click(function(){       정적 명령어 ?
    $(document).on("click","#data_open4",function(){
        $.ajax({
            url:"js/board.json",
            type:"get",
            data:{},
            dataType:"json",
            success:function(data){
                alert("성공");
                console.log(data);

                let hdata = ``;

                for(let i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i].bno}">`;
                    hdata += `<td>${data[i].bno}</td>`;
                    hdata += `<td>${data[i].title}</td>`;
                    hdata += `<td>${data[i].id}</td>`;
                    hdata += `<td>${data[i].bdate}</td>`;
                    hdata += `<td>${data[i].bhit}</td>`;
                    hdata += `<td><button type="button" id="mod">수정</button><button type="button" id="del">삭제</button></td></tr>`;
                }

                $("#tbody").html(hdata);
                
                    
                   
                    
                    
                    
                    
                

            },
            error:function(){

            }
        });//ajax

    });//#data_open4

});//jQuery