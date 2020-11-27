package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Route;
import com.app.repository.RouteRepository;
import com.app.service.RouteService;

@Service
public class RouteServiceImpl implements RouteService {
	
	@Autowired
	RouteRepository routeRepository; 

	@Override
	public Route save(Route route) {

		return routeRepository.save(route);
	}

	@Override
	public Route getById(Long id) {

		return routeRepository.getOne(id);
	}

	@Override
	public List<Route> getAll() {

		return routeRepository.findAll();
	}

	@Override
	public void delete(Long id) {
		routeRepository.deleteById(id);
	
	}

	@Override
	public Route update(Route route) {
		
		return routeRepository.save(route);
	}

	@Override
	public Route getByName(String name) {

		return routeRepository.getByName(name);
	}

}
