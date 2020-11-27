package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Plane;
import com.app.repository.PlaneRepository;
import com.app.service.PlaneService;

@Service
public class PlaneServiceImpl implements PlaneService {
	
	@Autowired
	PlaneRepository planeRepository;

	@Override
	public Plane save(Plane plane) {

		return planeRepository.save(plane);
	}

	@Override
	public Plane getById(Long id) {
		
		return planeRepository.getOne(id);
	}

	@Override
	public List<Plane> getAll() {

		return planeRepository.findAll();
	}

	@Override
	public void delete(Long id) {
		planeRepository.deleteById(id);
	
	}

	@Override
	public Plane update(Plane plane) {

		return planeRepository.save(plane);
	}

	@Override
	public Plane getByName(String name) {

		return planeRepository.getByName(name);
	}

}
