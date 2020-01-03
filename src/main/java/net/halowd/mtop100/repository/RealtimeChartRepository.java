package net.halowd.mtop100.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import net.halowd.mtop100.model.RealtimeChart;

public interface RealtimeChartRepository extends JpaRepository<RealtimeChart, Integer>{
	List<RealtimeChart> findByBasetime(String basetime);
	
	@Query(value = "select DISTINCT basetime from realtime_chart", nativeQuery = true)
	List<String> findBasetime();
}
