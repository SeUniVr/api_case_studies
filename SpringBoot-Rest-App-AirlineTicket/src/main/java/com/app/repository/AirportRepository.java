package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.entity.Airport;

@Repository
public interface AirportRepository extends JpaRepository<Airport, Long> {
	
	Airport getByName(String name);

}
