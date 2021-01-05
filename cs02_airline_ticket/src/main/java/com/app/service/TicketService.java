package com.app.service;

import java.util.List;

import com.app.entity.Ticket;

public interface TicketService {
	
    Ticket save(Ticket ticket);

    Ticket getById(Long id);
    
    Ticket getByCode(String code);
    
    List<Ticket> getAll();

    void delete(Long id);

    Ticket update(Ticket ticket);

}
