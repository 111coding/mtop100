package net.halowd.mtop100.utils;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MyYoutube {
	
	//제목 + 가수 명으로 VID 가져옴. 슬립 2초이상 걸것!!
	public static String getVID(String q){
		String result = "";
		q = q.replace("\"", "");
		try {
			Document doc = Jsoup
					.connect("https://www.youtube.com/results?search_query=" + q)
					.get();
			Elements els = doc.select(".yt-lockup-thumbnail");
			for (Element e : els) {
				if(e.select("a").attr("href").contains("watch?v=")) {
					result=e.select("a").attr("href").split("v=")[1];
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
