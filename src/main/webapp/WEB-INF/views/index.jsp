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
</style>
</head>

<body>




	<div class="container">
		<div class="row">
			<div class="col">
				<img src="/img/logo.png" / style="margin: 10px;">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#RealTime">RealTime</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Rising">Rising</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Day">Day</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Week">Week</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Month">Month</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Playlist" style="color: #00cd3c">Playlist</a></li>
				</ul>
				<div class="tab-content">
					<!-- 실시간 -->
					<div class="tab-pane fade show active" id="RealTime">
						<iframe src="/realtime" width="100%" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" scrolling="no" vspace="0" style="height: 80vh;"></iframe>
					</div>
					<!-- 급상승 -->
					<div class="tab-pane fade" id="Rising">
						<p>급상승</p>
					</div>
					<!-- 일간 -->
					<div class="tab-pane fade" id="Day">
						<p>일간</p>
					</div>
					<!-- 주간 -->
					<div class="tab-pane fade" id="Week">
						<p>주간</p>
					</div>
					<!-- 월간 -->
					<div class="tab-pane fade" id="Month">
						<p>월간</p>
					</div>
					<!-- 월간 -->
					<div class="tab-pane fade" id="Playlist">
						<iframe src="/playlist" width="100%" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" scrolling="no" vspace="0" style="height: 80vh;"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
	

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>

</html>