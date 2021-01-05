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

import com.app.entity.Plane;
import com.app.service.impl.PlaneServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.PlaneCtrl.PATH)
public class PlaneController {

	@Autowired
	PlaneServiceImpl planeServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Plane.class)
	public ResponseEntity<?> create(@Valid @RequestBody Plane plane) {
		if (planeServiceImpl.getByName(plane.getName()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		plane = planeServiceImpl.save(plane);
		return new ResponseEntity<>(plane, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Plane.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Plane plane = planeServiceImpl.getById(id);
		return new ResponseEntity<>(plane, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation")
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		planeServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping("/{id}")
	@ApiOperation(value = "Update Operation", response = Plane.class)
	public ResponseEntity<?> update(@Valid @RequestBody Plane plane) {

		plane = planeServiceImpl.update(plane);
		return new ResponseEntity<>(plane, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Plane.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Plane> planeList = planeServiceImpl.getAll();
		return new ResponseEntity<>(planeList, HttpStatus.OK);
	}

}
