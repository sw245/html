$(function(){

    $("#data_open3").click(function(){
        // alert("확인");
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=%2FjAVLJGJZwHZGVorf%2Fajiyz7RdhV3oK%2Fblc9UUxnyUtQHw6smo%2B%2BPq4zUs4viIvtUAxG6Zj3YNu%2Bnt6xQ8WnZw%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json", 
            //"https://jsonplaceholder.typicode.com/users",
            type:"get",
            data:{},
            dataType:"json",
            success:function(data){
                alert("성공");
                console.log(data.response.body.items.item);
                console.log(data.response.body.items.item[0].galWebImageUrl);
                
                let img_data = data.response.body.items.item[0].galWebImageUrl;
                let hdata2 = `<img id="img" src="${img_data}">`;
                $("#txt").html(hdata2);
                

                let hdata = ``;
                for(let i=0;i<data.response.body.items.item.length;i++){
                    hdata += `<tr id="${data.response.body.items.item[i].galContentId}">`;
                    hdata += `<td>${data.response.body.items.item[i].galContentId}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galCreatedtime}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galPhotographer}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galPhotographyLocation}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galSearchKeyword}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galTitle}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galWebImageUrl}</td>`;
                    hdata += `<td><button type="button" id="mod">수정</button><button type="button" id="del">삭제</button></td></tr>`;

                }

                $("#tbody").html(hdata);

                /*
                let hdata = ``;
                for(i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i].id}"><td>${data[i].id}</td>`;
                    hdata += `<td>${data[i].name}</td><td>${data[i].username}</td>`;
                    hdata += `<td>${data[i].email}</td>`;
                    hdata += `<td>${data[i].address.city}</td><td>${data[i].address.zipcode}</td>`;
                    hdata += `<td>${data[i].phone}</td>`;
                    hdata += `<td>${data[i].company.name}</td>`;
                    hdata += `<td><button type="button" id="mod">수정</button><button type="button" id="del">삭제</button></td>`;
                }

                $("#tbody").html(hdata);
                */
            },
            error:function(){
                alert("실패");
            }
        });


    });//#data_open3

});//jQuery

