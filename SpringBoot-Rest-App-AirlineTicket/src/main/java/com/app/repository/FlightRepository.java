package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.entity.Flight;


@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {
	
	Flight getByName(String name);
	
	Flight getByCompanyId(Long id);

}
