package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Flight;
import com.app.repository.FlightRepository;
import com.app.service.FlightService;

@Service
public class FlightServiceImpl implements FlightService {
	
	@Autowired
	FlightRepository flightRepository;

	@Override
	public Flight save(Flight flight) {
		
		return flightRepository.save(flight);
	}

	@Override
	public Flight getById(Long id) {
		
		return flightRepository.getOne(id);
	}

	@Override
	public List<Flight> getAll() {

		return flightRepository.findAll();
	}

	@Override
	public void delete(Long id) {
		
		flightRepository.deleteById(id);
	}

	@Override
	public Flight update(Flight flight) {
		
		return flightRepository.save(flight);
	}

	@Override
	public Flight getByName(String name) {

		return flightRepository.getByName(name);
	}

}
