package com.app.service;

import java.util.List;

import com.app.entity.Route;

public interface RouteService {
	
    Route save(Route route);

    Route getById(Long id);
    
    Route getByName(String name);
    
    List<Route> getAll();

    void delete(Long id);

    Route update(Route route);

}
