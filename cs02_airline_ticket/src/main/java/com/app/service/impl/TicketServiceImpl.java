package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.entity.Flight;
import com.app.entity.Ticket;
import com.app.repository.FlightRepository;
import com.app.repository.TicketRepository;
import com.app.service.TicketService;

@Service
public class TicketServiceImpl implements TicketService {
	
	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	FlightRepository flightRepository;

	@Override
	public Ticket save(Ticket ticket) {
		
		return ticketRepository.save(ticket);
	}

	@Override
	public Ticket getById(Long id) {
		
		return ticketRepository.getOne(id);
	}

	@Override
	public List<Ticket> getAll() {
		
		return ticketRepository.findAll();
	}

	@Override
	public void delete(Long id) {
		ticketRepository.deleteById(id);
	}

	@Override
	public Ticket update(Ticket ticket) {
		if(ticket.getIsSold() == true) {
			// Get quota status
			Flight flight = flightRepository.getOne(ticket.getFlight().getId());
			Integer quota = flight.getQuota();
			Integer quotaFilled = flight.getQuotaFilled();
			
			if(quotaFilled < quota) {
				// Increase quota filled by 1 if it is not filled yet
				flight.setQuotaFilled(quotaFilled + 1);
				// Check percentage and perform price increase operations related to percentage
				int newPercentage = (quotaFilled / quota) * 100;
				int currentPercentage = flight.getQuotaFilledPercentage();
				int diffPercentage = (newPercentage % 10) - currentPercentage;
				if(diffPercentage > 0) {
					flight.setQuotaFilledPercentage(newPercentage % 10);
					int newPrice = ticket.getPrice() + ticket.getPrice() * (diffPercentage / 100);
					ticket.setPrice(newPrice);
				}
			}
			
		}
		
		return ticketRepository.save(ticket);
	}

	@Override
	public Ticket getByCode(String code) {
		
		return ticketRepository.getByTicketCode(code);
	}

}
