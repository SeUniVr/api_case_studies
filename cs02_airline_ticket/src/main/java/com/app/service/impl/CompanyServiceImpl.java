package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Company;
import com.app.repository.CompanyRepository;
import com.app.service.CompanyService;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	CompanyRepository companyRepository;

	@Override
	public Company save(Company company) {
		
		return companyRepository.save(company);
	}

	@Override
	public Company getById(Long id) {

		return companyRepository.getOne(id);
	}

	@Override
	public List<Company> getAll() {

		return companyRepository.findAll();
	}

	@Override
	public void delete(Long id) {
		companyRepository.deleteById(id);
	}

	@Override
	public Company update(Company company) {

		return companyRepository.save(company);
	}

	@Override
	public Company getByName(String name) {
		
		return companyRepository.getByName(name);
	}

}
