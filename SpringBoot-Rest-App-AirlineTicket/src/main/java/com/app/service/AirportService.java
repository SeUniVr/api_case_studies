package com.app.service;

import java.util.List;

import com.app.entity.Airport;



public interface AirportService {
	
    Airport save(Airport airport);

    Airport getById(Long id);
    
    Airport getByName(String name);
    
    List<Airport> getAll();

    void delete(Long id);

    Airport update(Airport airport);

}
