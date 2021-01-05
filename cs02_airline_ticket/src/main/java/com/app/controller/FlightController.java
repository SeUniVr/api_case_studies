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

import com.app.entity.Flight;
import com.app.service.impl.FlightServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.FlightCtrl.PATH)
public class FlightController {

	@Autowired
	FlightServiceImpl flightServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Flight.class)
	public ResponseEntity<?> create(@Valid @RequestBody Flight flight) {
		if (flightServiceImpl.getByName(flight.getName()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		flight = flightServiceImpl.save(flight);
		return new ResponseEntity<>(flight, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Flight.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Flight flight = flightServiceImpl.getById(id);
		return new ResponseEntity<>(flight, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation")
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		flightServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping("/{id}")
	@ApiOperation(value = "Update Operation", response = Flight.class)
	public ResponseEntity<?> update(@Valid @RequestBody Flight flight) {

		flight = flightServiceImpl.update(flight);
		return new ResponseEntity<>(flight, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Flight.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Flight> flightList = flightServiceImpl.getAll();
		return new ResponseEntity<>(flightList, HttpStatus.OK);
	}

}
