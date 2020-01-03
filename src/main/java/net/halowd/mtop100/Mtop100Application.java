package net.halowd.mtop100;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class Mtop100Application {

	public static void main(String[] args) {
		SpringApplication.run(Mtop100Application.class, args);
	}

}
