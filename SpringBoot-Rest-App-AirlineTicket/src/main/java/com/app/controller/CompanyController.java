package com.app.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.app.entity.Company;
import com.app.service.impl.CompanyServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.CompanyCtrl.PATH)
public class CompanyController {

	@Autowired
	CompanyServiceImpl companyServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Company.class)
	public ResponseEntity<?> create(@Valid @RequestBody Company company) {
		if (companyServiceImpl.getByName(company.getName()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		company = companyServiceImpl.save(company);
		return new ResponseEntity<>(company, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Company.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Company company = companyServiceImpl.getById(id);
		return new ResponseEntity<>(company, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation", response = Boolean.class)
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		companyServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping("/{id}")
	@ApiOperation(value = "Update Operation", response = Company.class)
	public ResponseEntity<?> update(@Valid @RequestBody Company company) {

		company = companyServiceImpl.update(company);
		return new ResponseEntity<>(company, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Company.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Company> companyList = companyServiceImpl.getAll();
		return new ResponseEntity<>(companyList, HttpStatus.OK);
	}

}
