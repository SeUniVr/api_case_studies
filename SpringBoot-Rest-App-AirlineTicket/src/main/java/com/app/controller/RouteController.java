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

import com.app.entity.Route;
import com.app.service.impl.RouteServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.RouteCtrl.PATH)
public class RouteController {

	@Autowired
	RouteServiceImpl routeServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Route.class)
	public ResponseEntity<?> create(@Valid @RequestBody Route route) {
		if (routeServiceImpl.getByName(route.getName()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		route = routeServiceImpl.save(route);
		return new ResponseEntity<>(route, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Route.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Route route = routeServiceImpl.getById(id);
		return new ResponseEntity<>(route, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation")
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		routeServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping("/{id}")
	@ApiOperation(value = "Update Operation", response = Route.class)
	public ResponseEntity<?> update(@Valid @RequestBody Route route) {

		route = routeServiceImpl.update(route);
		return new ResponseEntity<>(route, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Route.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Route> routeList = routeServiceImpl.getAll();
		return new ResponseEntity<>(routeList, HttpStatus.OK);
	}

}
