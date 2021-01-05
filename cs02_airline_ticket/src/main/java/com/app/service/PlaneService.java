package com.app.service;

import java.util.List;

import com.app.entity.Plane;

public interface PlaneService {
	
    Plane save(Plane plane);

    Plane getById(Long id);
    
    Plane getByName(String name);
    
    List<Plane> getAll();

    void delete(Long id);

    Plane update(Plane plane);

}
