$(function(){

    $.ajax({
        url:"http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
        type:"get",
        data:{"key":"6c5ddcf429f5f5c5f3cd05571911c14e","targetDt":"20140130"},
        dataType:"json",
        success:function(data){
            //alert("연결 성공");
            console.log(data);
            
        },
        error:function(){
            alert("연결 실패");
        }
    })
})