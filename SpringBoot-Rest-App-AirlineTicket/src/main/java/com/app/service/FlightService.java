package com.app.service;

import java.util.List;

import com.app.entity.Flight;

public interface FlightService {
	
    Flight save(Flight flight);

    Flight getById(Long id);
    
    Flight getByName(String name);
    
    List<Flight> getAll();

    void delete(Long id);

    Flight update(Flight flight);

}
