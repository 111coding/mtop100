package net.halowd.mtop100.service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import net.halowd.mtop100.model.RealtimeChart;
import net.halowd.mtop100.repository.RealtimeChartRepository;
import net.halowd.mtop100.utils.MyMelon;
import net.halowd.mtop100.utils.MyYoutube;

@Component
public class Scheduled01 {

	@Autowired
	RealtimeChartRepository mRepo;

	// 애플리케이션 시작 후 5초 후에 첫 실행, 그 후 매 60초마다 주기적으로 실행한다.
	@Scheduled(initialDelay = 5000, fixedDelay = 1200000)
	public void otherJob() throws InterruptedException {
		//DB의 최근값 가져오기
		List<String> basetimes = mRepo.findBasetime();
		String recent = "";
		if(basetimes.size() != 0) {
			recent = basetimes.get(0);
			for (int i = 1; i < basetimes.size(); i++) {
				if (Integer.parseInt(recent) < Integer.parseInt(basetimes.get(i))) {
					recent = basetimes.get(i);
				}
			}
		}else {
			recent = "2019010101";
		}
		
		
		//현재시간
		LocalDateTime t = LocalDateTime.now();
		String tem = t.toString().replaceAll("-", "");
		tem = tem.replaceAll("T", "");
		String nowtime = tem.split(":")[0];
		
		//DB의 값과 비교해서 다르면
		if(!nowtime.equals(recent)) {
			int status = MyMelon.getStatus(nowtime);
			//갱신이 됐으면
			if(status == 1) {
				List<RealtimeChart> rts = MyMelon.getRealtimeChart(nowtime);
				for (RealtimeChart rt : rts) {
					String vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
					while(vid==null || vid.equals("")) {
						vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
						Thread.sleep(1000);
					}
					rt.setYoutube(vid);
					System.out.println(rt.getTitle() + " " + rt.getArtist() + " " + rt.getYoutube() + " Load");
					Random r = new Random();
					Thread.sleep(r.nextInt(2000)+1000);
				}
				for (RealtimeChart rt : rts) {
					mRepo.save(rt);
				}
			}
		}
	}

}
