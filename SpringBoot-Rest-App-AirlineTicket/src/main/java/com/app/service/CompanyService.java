package com.app.service;

import java.util.List;

import com.app.entity.Company;

public interface CompanyService {
	
    Company save(Company company);

    Company getById(Long id);
    
    Company getByName(String name);
    
    List<Company> getAll();

    void delete(Long id);

    Company update(Company company);

}
