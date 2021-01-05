package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Airport;
import com.app.repository.AirportRepository;
import com.app.service.AirportService;

@Service
public class AirportServiceImpl implements AirportService {
	
	@Autowired
	AirportRepository airportRepository;

	@Override
	public Airport save(Airport airport) {
		
		return airportRepository.save(airport);
	}

	@Override
	public Airport getById(Long id) {
		
		return airportRepository.getOne(id);
	}

	@Override
	public void delete(Long id) {

		airportRepository.deleteById(id);
	}

	@Override
	public Airport update(Airport airport) {
		
		return airportRepository.save(airport);
	}

	@Override
	public List<Airport> getAll() {
		
		return airportRepository.findAll();
	}

	@Override
	public Airport getByName(String name) {
		
		return airportRepository.getByName(name);
	}

}
