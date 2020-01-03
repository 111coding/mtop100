package net.halowd.mtop100.utils;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import net.halowd.mtop100.model.RealtimeChart;

public class MyMelon {
	public static List<RealtimeChart> getRealtimeChart(String basetime){
		List<RealtimeChart> rts = new ArrayList<>();
		Document doc = null;
		try {
			doc = Jsoup.connect("https://www.melon.com/chart/index.htm?dayTime=" + basetime).get();
			Elements ets50 = doc.select("#lst50");
			Elements ets100 = doc.select("#lst100");
			for (Element et : ets50) {
				RealtimeChart rt = new RealtimeChart();
				rt.setRanking(et.select(".rank").text());
				rt.setJacket(et.select("img").attr("src"));
				rt.setTitle(et.select(".rank01").select("a").text());
				rt.setArtist(et.select(".rank02").select("span").text());
				rt.setAlbum(et.select(".rank03").select("a").text());
				rt.setBasetime(basetime);
				rts.add(rt);
			}

			for (Element et : ets100) {
				RealtimeChart rt = new RealtimeChart();
				rt.setRanking(et.select(".rank").text());
				rt.setJacket(et.select("img").attr("src"));
				rt.setTitle(et.select(".rank01").select("a").text());
				rt.setArtist(et.select(".rank02").select("span").text());
				rt.setAlbum(et.select(".rank03").select("a").text());
				rt.setBasetime(basetime);
				rts.add(rt);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return rts;
	}
	
	public static int getStatus(String basetime) {
		Document doc = null;
		try {
			doc = Jsoup.connect("https://www.melon.com/chart/index.htm?dayTime=" + basetime).get();
			return 1;

		} catch (Exception e) {
			return -1;
		}
	}
}
