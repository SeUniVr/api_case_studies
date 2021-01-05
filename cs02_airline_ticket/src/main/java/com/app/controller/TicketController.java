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

import com.app.entity.Ticket;
import com.app.service.impl.TicketServiceImpl;
import com.app.util.ApiPaths;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping(ApiPaths.TicketCtrl.PATH)
public class TicketController {

	@Autowired
	TicketServiceImpl ticketServiceImpl;

	@PostMapping
	@ApiOperation(value = "Create Operation", response = Ticket.class)
	public ResponseEntity<?> create(@Valid @RequestBody Ticket ticket) {
		if (ticketServiceImpl.getByCode(ticket.getTicketCode()) != null) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		ticket = ticketServiceImpl.save(ticket);
		return new ResponseEntity<>(ticket, HttpStatus.CREATED);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "Get By Id Operation", response = Ticket.class)
	public ResponseEntity<?> getById(@PathVariable(value = "id", required = true) Long id) {
		Ticket ticket = ticketServiceImpl.getById(id);
		return new ResponseEntity<>(ticket, HttpStatus.OK);
	}

	@DeleteMapping("/{id}")
	@ApiOperation(value = "Delete Operation")
	public ResponseEntity<?> delete(@PathVariable(value = "id", required = true) Long id) {
		ticketServiceImpl.delete(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@PutMapping("/{id}")
	@ApiOperation(value = "Update Operation", response = Ticket.class)
	public ResponseEntity<?> update(@Valid @RequestBody Ticket ticket) {
		ticket = ticketServiceImpl.update(ticket);
		return new ResponseEntity<>(ticket, HttpStatus.OK);
	}

	@GetMapping
	@ApiOperation(value = "Get All Operation", response = Ticket.class, responseContainer = "List")
	public ResponseEntity<?> getAll() {
		List<Ticket> ticketList = ticketServiceImpl.getAll();
		return new ResponseEntity<>(ticketList, HttpStatus.OK);
	}

}
