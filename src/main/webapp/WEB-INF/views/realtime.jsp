<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap 4</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
p {
	margin: 20px 0px;
}

body {
	font-size: 12px;
}

.my_select_box {
	height: 100px;
	padding: 30px 20% 20px 20%;
}
.my_bt_box {
	height: 30px;
}
</style>




</head>

<body>

	<div class="my_select_box">
		<select class="form-control" style="font-size: 18px; color: #008523; font-weight: bold;" onchange="basetimeChanged()">
			<c:forEach var="basetime" items="${basetimes}">
				<option>${basetime}</option>
			</c:forEach>
		</select>

	</div>
	
	<div class="my_bt_box">
		<button class="button" onclick="playAll()">전체듣기</button>
		<button class="button" onclick="playSel()">선택듣기</button>
	</div>

	<div class="row">
		<table class="table">
			<thead>
				<th style="width: 1%;"></th>
				<th style="width: 1%;">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" id="jb-checkbox" class="custom-control-input" onclick="selectAll()"> <label class="custom-control-label" for="jb-checkbox" style="color: white;">.</label>
					</div>
				</th>
				<th style="width: 3%;">Rank</th>
				<th style="color: white;"><img src="" width="51px" height="3px" /></th>
				<th style="width: 25%; padding-left: 3%">곡정보(제목/아티스트)</th>
				<th style="width: 25%; padding-left: 3%">앨범명</th>
				<th style="width: 10%;"></th>
				<th style="width: 25%;"></th>
			</thead>
		</table>


		<div style="width: 100%; height: 80vh; overflow-y: auto; overflow-x: hidden;">
			<table class="table">
				<c:forEach var="rank" items="${ranks}">
					<tbody>

						<!-- 차트시작 -->

						<td style="width: 1%;"></td>
						<td style="width: 1%; vertical-align: middle;">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" id="jb-checkbox-${rank.ranking}" class="custom-control-input"> <label class="custom-control-label" for="jb-checkbox-${rank.ranking}" style="color: white;">.</label>
							</div>
						</td>
						<td style="width: 3%; text-align: center; vertical-align: middle;">${rank.ranking}</td>
						<td style="width: 60px;"><img src="${rank.jacket}" width="60px" id="jacket_${rank.ranking}"></td>
						<td id="musicinfo_${rank.ranking}" style="width: 25%; padding-left: 3%; vertical-align: middle;"><strong>${rank.title}</strong><br />${rank.artist}</td>
						<td id="album_${rank.ranking}" style="width: 25%; padding-left: 3%; vertical-align: middle;">${rank.album}</td>
						<td style="width: 10%;">
						<td style="width: 25%; vertical-align: middle;"><div class="table-data-feature" style="justify-content: flex-start;">
								<button onclick="addPlaylist('${rank.jacket}','${rank.title}','${rank.artist}','${rank.album}','${rank.youtube}')" title="재생" style="background: white; border: none;">
									<img src="/img/btn_play.png" width="20px">
								</button>
								<button onclick="justAdd('${rank.jacket}','${rank.title}','${rank.artist}','${rank.album}','${rank.youtube}')" title="재생목록추가" style="background: white; border: none;">
									<img src="/img/btn_add.png" width="20px">
								</button>
							</div></td>

						<!-- 차트끝 -->
					</tbody>
				</c:forEach>

			</table>
		</div>


	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>






	<script>
		function basetimeChanged() {
			var tem = document.querySelector('.form-control');
			var sel = tem[tem.selectedIndex];
			sel = sel.text;
			alert(sel);
			fetch("http://localhost:8080/real/"+sel, {
				method : "GET"
			}).then(function(data) {
				//return data.text();
				return data.json();
			}).then(function(data) {
				data.forEach(function(rank){
						document.querySelector('#jacket_' + rank.ranking).src= rank.jacket;
						document.querySelector('#musicinfo_' + rank.ranking).innerHTML = "<strong>"+rank.title+"</strong><br/>"+rank.artist;
						document.querySelector('#album_' + rank.ranking).innerHTML = rank.album;
						document.querySelector('#album_' + rank.ranking).parentElement.querySelectorAll('button')[0].setAttribute("onclick","addPlaylist('"+rank.jacket+"','"+rank.title+"','"+rank.artist+"','"+rank.album+"','"+rank.youtube+"')");
						document.querySelector('#album_' + rank.ranking).parentElement.querySelectorAll('button')[1].setAttribute("onclick","justAdd('"+rank.jacket+"','"+rank.title+"','"+rank.artist+"','"+rank.album+"','"+rank.youtube+"')");
					})				
			})
		}
		function addPlaylist(jacket,title,artist,album,youtube){
			rm_overlap(youtube);
			
			time = new Date();
			time = time.getTime();		
			
			var pl = document.createElement('tbody');
			pl.setAttribute('id','now_'+time);			
			tem = '<tbody id='+time+'><td style="width: 1%;">.</td>';
			tem = tem + '<td style="width: 1%; vertical-align: middle;">';
			tem = tem + '<div class="custom-control custom-checkbox">';
			tem = tem + '<input type="checkbox" id="jb-checkbox-'+time+'" class="custom-control-input"> <label class="custom-control-label" for="jb-checkbox-'+time+'" style="color: white;">.</label>';
			tem = tem + '</div></td><td style="width: 3%; text-align: center; vertical-align: middle;color:white;">.</td>';
			tem = tem + '<td style="width: 60px;"><img src='+jacket+' width="60px" id="jacket_${rank.ranking}"></td>';
			tem = tem + '<td style="width: 25%; padding-left: 3%; vertical-align: middle;"><strong>'+title+'</strong><br />'+artist+'</td>';
			tem = tem + '<td style="width: 25%; padding-left: 3%; vertical-align: middle;">'+album+'</td>';
			tem = tem + '<td style="width: 10%;"><td style="width: 25%; vertical-align: middle;"><div class="table-data-feature" style="justify-content: flex-start;">';
			tem = tem + '<button onclick="playNow(\''+youtube+'\')" title="재생" style="background: white; border: none;"><img src="/img/btn_play.png" width="20px"></button>';
			tem = tem + '<button onclick="deleteNow(\'now_'+time+'\')" title="재생목록에서제거" style="background: white; border: none;"><img src="/img/btn_minus.png" width="20px"></button>';
			tem = tem + '</div></td></tbody>';
			pl.innerHTML = tem;
			parent.document.querySelector('#Playlist').querySelector('iframe').contentDocument.querySelector('#playlist_items').append(pl);
			parent.document.querySelector('#Playlist').querySelector('iframe').contentWindow.player.cueVideoById(youtube);
			parent.document.querySelector('#Playlist').querySelector('iframe').contentWindow.player.playVideo();
			}
		

		function justAdd(jacket,title,artist,album,youtube){
			rm_overlap(youtube);
			
			
			time = new Date();
			time = time.getTime();		
			
			var pl = document.createElement('tbody');
			pl.setAttribute('id','now_'+time);			
			tem = '<tbody id='+time+'><td style="width: 1%;">.</td>';
			tem = tem + '<td style="width: 1%; vertical-align: middle;">';
			tem = tem + '<div class="custom-control custom-checkbox">';
			tem = tem + '<input type="checkbox" id="jb-checkbox-'+time+'" class="custom-control-input"> <label class="custom-control-label" for="jb-checkbox-'+time+'" style="color: white;">.</label>';
			tem = tem + '</div></td><td style="width: 3%; text-align: center; vertical-align: middle;color:white;">.</td>';
			tem = tem + '<td style="width: 60px;"><img src='+jacket+' width="60px" id="jacket_${rank.ranking}"></td>';
			tem = tem + '<td style="width: 25%; padding-left: 3%; vertical-align: middle;"><strong>'+title+'</strong><br />'+artist+'</td>';
			tem = tem + '<td style="width: 25%; padding-left: 3%; vertical-align: middle;">'+album+'</td>';
			tem = tem + '<td style="width: 10%;"><td style="width: 25%; vertical-align: middle;"><div class="table-data-feature" style="justify-content: flex-start;">';
			tem = tem + '<button onclick="playNow(\''+youtube+'\')" title="재생" style="background: white; border: none;"><img src="/img/btn_play.png" width="20px"></button>';
			tem = tem + '<button onclick="deleteNow(\'now_'+time+'\')" title="재생목록에서제거" style="background: white; border: none;"><img src="/img/btn_minus.png" width="20px"></button>';
			tem = tem + '</div></td></tbody>';
			pl.innerHTML = tem;
			parent.document.querySelector('#Playlist').querySelector('iframe').contentDocument.querySelector('#playlist_items').append(pl);
			}


		function rm_overlap(youtube){
				pls = parent.document.querySelector('#Playlist').querySelector('iframe').contentDocument.querySelectorAll('tbody');
				if(pls.length===0)return;
				for(i=0;i<pls.length;i++){
						plVID = pls[i].querySelector('button').getAttribute('onclick').split("'")[1];
						if(plVID===youtube){
								pls[i].remove();
							}
					}
			}

		function playAll(){
			var i=0;
				while(i<100){
						tem = document.querySelectorAll('tbody')[i].querySelectorAll('button')[1].getAttribute('onclick');
						eval(tem);
						i++;
					}
			}
		
		function playSel(){
			var tbodys = document.querySelectorAll('tbody');
			for(i=0;i<tbodys.length;i++){
					if(tbodys[i].querySelector('input').checked){
							tem = tbodys[i].querySelectorAll('button')[1].getAttribute('onclick');
							eval(tem);
						}
				}
		}

		function selectAll(){
			var tbodys = document.querySelectorAll('tbody');
			if(document.querySelector('#jb-checkbox').checked){
				for(i=0;i<tbodys.length;i++){
					tbodys[i].querySelector('input').checked = true;
					}
				}else{
					for(i=0;i<tbodys.length;i++){
						tbodys[i].querySelector('input').checked = false;
						}
					}
		}
	

	</script>

</body>

</html>