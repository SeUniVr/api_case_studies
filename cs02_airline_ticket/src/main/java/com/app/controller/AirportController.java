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

import com.app.entity.Airport;
import com.app.service.impl.AirportServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.AirportCtrl.PATH)
@Api(value = ApiPaths.AirportCtrl.PATH)
public class AirportController {

	@Autowired
	AirportServiceImpl airportServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Airport.class)
	public ResponseEntity<?> create(@Valid @RequestBody Airport airport) {
		if (airportServiceImpl.getByName(airport.getName()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		airport = airportServiceImpl.save(airport);
		return new ResponseEntity<>(airport, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Airport.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Airport airport = airportServiceImpl.getById(id);
		return new ResponseEntity<>(airport, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation")
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		airportServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping
	@ApiOperation(value = "Update Operation", response = Airport.class)
	public ResponseEntity<?> update(@Valid @RequestBody Airport airport) {

		airport = airportServiceImpl.update(airport);
		return new ResponseEntity<>(airport, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Airport.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Airport> airportList = airportServiceImpl.getAll();
		return new ResponseEntity<>(airportList, HttpStatus.OK);
	}

}
