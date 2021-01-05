package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.entity.Plane;


@Repository
public interface PlaneRepository extends JpaRepository<Plane, Long> {
	
	Plane getByName(String name);

}
