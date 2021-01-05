package com.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.entity.Company;
@Repository
public interface CompanyRepository extends JpaRepository<Company, Long> {
	
	Company getByName(String name);
		
}
