package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.entity.Route;

@Repository
public interface RouteRepository extends JpaRepository<Route, Long> {
	
	Route getByName(String name);
}
