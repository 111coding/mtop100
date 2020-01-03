package net.halowd.mtop100.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import net.halowd.mtop100.model.RealtimeChart;
import net.halowd.mtop100.repository.RealtimeChartRepository;
import net.halowd.mtop100.utils.MyMelon;
import net.halowd.mtop100.utils.MyYoutube;

@Controller
public class TestController {

	@Autowired
	RealtimeChartRepository mRepo;


//	@GetMapping("/realtime")
//	public String Realtime(Model model) {
//		List<String> basetimes = mRepo.findBasetime();
//		model.addAttribute("basetimes", basetimes);
//		List<RealtimeChart> ranks = mRepo.findByBasetime(basetimes.get(0));
//		for (RealtimeChart r : ranks) {
//			r.setTitle(r.getTitle().replaceAll("\"", " "));
//			r.setAlbum(r.getAlbum().replaceAll("\"", " "));
//			r.setArtist(r.getArtist().replaceAll("\"", " "));
//			r.setTitle(r.getTitle().replaceAll("'", " "));
//			r.setAlbum(r.getAlbum().replaceAll("'", " "));
//			r.setArtist(r.getArtist().replaceAll("'", " "));
//		}
//		model.addAttribute("ranks", ranks);
//		return "realtime";
//	}

//	//이건레스트로 옮기자
//	@GetMapping("/real/{basetime}")
//	public @ResponseBody List<RealtimeChart> realRest(@PathVariable String basetime) {
//		List<RealtimeChart> ranks = mRepo.findByBasetime(basetime);
//		for (RealtimeChart r : ranks) {
//			r.setTitle(r.getTitle().replaceAll("\"", " "));
//			r.setAlbum(r.getAlbum().replaceAll("\"", " "));
//			r.setArtist(r.getArtist().replaceAll("\"", " "));
//			r.setTitle(r.getTitle().replaceAll("'", " "));
//			r.setAlbum(r.getAlbum().replaceAll("'", " "));
//			r.setArtist(r.getArtist().replaceAll("'", " "));
//		}
//		return ranks;
//	}

//	@GetMapping("/add/{basetime}")
//	public @ResponseBody List<RealtimeChart> add1(@PathVariable String basetime) throws InterruptedException {
//		List<RealtimeChart> rts = MyMelon.getRealtimeChart(basetime);
//		for (RealtimeChart rt : rts) {
//			String vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
//			while(vid==null || vid.equals("")) {
//				vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
//				Thread.sleep(1000);
//			}
//			rt.setYoutube(vid);
//			mRepo.save(rt);
//			Random r = new Random();
//			Thread.sleep(r.nextInt(2000)+1000);	
//		}
//		
//		return rts;
//	}
	
//	@GetMapping("/playlist")
//	public String playlist() {
//		return "playlist";
//	}

}
