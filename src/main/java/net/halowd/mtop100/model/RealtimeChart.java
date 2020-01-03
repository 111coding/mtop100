package net.halowd.mtop100.model;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;

@Data //lombok
@Entity //JPA -> ORM
public class RealtimeChart {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; // 시퀀스
	private String ranking;
	private String jacket;
	private String title;
	private String artist;
	private String album;
	private String basetime;
	private String youtube;
	@CreationTimestamp // 자동으로 현재 시간이 세팅
	private Timestamp createDate;

}
