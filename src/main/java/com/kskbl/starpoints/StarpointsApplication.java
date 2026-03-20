package com.kskbl.starpoints;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StarpointsApplication {

	public static void main(String[] args) {
		SpringApplication.run(StarpointsApplication.class, args);
		System.out.println("打开 http://localhost:8080/swagger-ui/index.html#/user-controller/ 以进行测试");
	}

}
