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

.my_video_box {
	height: 320px;
	text-align: center;
}

.my_video_box iframe {
	margin: auto;
}
.my_bt_box {
	height: 30px;
}
</style>




</head>

<body>
	<!-- https://www.youtube.com/embed/동영상아이디 -->
	<div class="my_video_box">
		<div id="playerLayer"></div>

	</div>
	<div class="my_bt_box">
		<button class="button" onclick="removeSel()">선택삭제</button>
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
				<th style="width: 3%; color: white;">.</th>
				<th style="color: white;"><img src="" width="51px" height="3px" /></th>
				<th style="width: 25%; padding-left: 3%">곡정보(제목/아티스트)</th>
				<th style="width: 25%; padding-left: 3%">앨범명</th>
				<th style="width: 10%;"></th>
				<th style="width: 25%;"></th>
			</thead>
		</table>


		<div style="width: 100%; height: 45vh; overflow-y: auto; overflow-x: hidden;">
			<table class="table" id="playlist_items">
				<!-- 여기에 동적으로 추가 -->

			</table>
		</div>


	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


	<script src="http://www.youtube.com/player_api"></script>

	<script type="text/javascript">
		var player;

		// 유튜브 플레이어를 생성한다.
		function onYouTubePlayerAPIReady() {
			try {
				player = new YT.Player('playerLayer', {
					height : '300',
					width : '500',
					videoId : '유튜브의 동영상 아이디',
					playerVars : {
						'autoplay' : 1, // 자동실행여부
						'controls' : 1, // 재생컨트롤 노출여부
						'autohide' : 0, // 재생컨트롤이 자동으로 사라질지의 여부
						'rel' : 0, // 동영상 재생완료 후 유사동영상 노출여부
						'wmode' : 'transparent'
					},
					events : {
						'onReady' : onPlayerReady,
						'onStateChange' : onPlayerStateChange
					}
				});
			} catch (e) {
			}
		}

		// 유튜브 플레이어가 다 만들어지면 호출됨
		function onPlayerReady(event) {
			// 자동으로 플레이하는 코드로 위에서 autoplay: 0으로 하였으므로 주석처리
			//event.target.playVideo();
		}

		// 동영상의 재생이 완료되었을 때 호출됨
		function onPlayerStateChange(event) {
			if (event.data === 0) {
				// 종료 후 작업을 여기에 코딩
				plist = document.querySelectorAll('tbody');
				if (plist.length === 1) {
					player.playVideo();
				} else {
					if (plist.length === 1) {
						playNow(plist[i].querySelector('button').getAttribute(
								'onclick').split("'")[1]);
					} else {
						for (var i = 0; i < plist.length; i++) {
							now_id = player.getVideoData().video_id;
							list_id = plist[i].querySelector('button')
									.getAttribute('onclick').split("'")[1]; //이게 유튜브 ID 중복제거해야지 이로직으로 사용가능 ㅠㅠ
							if (now_id === list_id) {
								if (i === plist.length - 1) {
									//마지막일때
									playNow(plist[0].querySelector('button')
											.getAttribute('onclick').split("'")[1]);
								} else {
									playNow(plist[i+1].querySelector('button')
											.getAttribute('onclick').split("'")[1]);
								}
							}
						}
					}
				}
			}
		}
	</script>

	<script>
		function playNow(youtube) {
			player.cueVideoById(youtube);
			player.playVideo();
		}

		function deleteNow(id) {
			document.querySelector('#' + id).remove();
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

		function removeSel(){
			var tbodys = document.querySelectorAll('tbody');
			for(i=0;i<tbodys.length;i++){
					if(tbodys[i].querySelector('input').checked){
							tbodys[i].remove();
						}
				}
		}
	</script>


</body>

</html>