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
public class AppController {

	@Autowired
	RealtimeChartRepository mRepo;
	

	
	@GetMapping("/realtime")
	public String Realtime(Model model) {
		List<String> basetimes = mRepo.findBasetime();
		model.addAttribute("basetimes", basetimes);
		List<RealtimeChart> ranks = mRepo.findByBasetime(basetimes.get(0));
		for (RealtimeChart r : ranks) {
			r.setTitle(r.getTitle().replaceAll("\"", " "));
			r.setAlbum(r.getAlbum().replaceAll("\"", " "));
			r.setArtist(r.getArtist().replaceAll("\"", " "));
			r.setTitle(r.getTitle().replaceAll("'", " "));
			r.setAlbum(r.getAlbum().replaceAll("'", " "));
			r.setArtist(r.getArtist().replaceAll("'", " "));
		}
		model.addAttribute("ranks", ranks);
		return "realtime";
	}
	
	@GetMapping("/playlist")
	public String playlist() {
		return "playlist";
	}
	
	@GetMapping("/add/{basetime}")
	public @ResponseBody List<RealtimeChart> add(@PathVariable String basetime) throws InterruptedException {
		List<RealtimeChart> rts = MyMelon.getRealtimeChart(basetime);
		for (RealtimeChart rt : rts) {
			String vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
			while(vid==null || vid.equals("")) {
				vid = MyYoutube.getVID(rt.getTitle() + " " + rt.getArtist());
				Thread.sleep(1000);
			}
			rt.setYoutube(vid);			
			Random r = new Random();
			Thread.sleep(r.nextInt(2000)+1000);	
		}
		for (RealtimeChart rt : rts) {
			mRepo.save(rt);
		}
		
		return rts;
	}

}
