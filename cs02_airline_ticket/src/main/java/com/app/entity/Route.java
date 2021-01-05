package com.app.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Entity
@Data
@ApiModel(value = "Route Entity Object")
public class Route {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@ApiModelProperty(value = "Route Id")
	private Long id;
	
	@Column(name="name", length= 50)
	@ApiModelProperty(value = "Name of Route", required = true)
	private String name;
	
	@JoinColumn(name = "departure_airport_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Airport departureAirport;
	
	@JoinColumn(name = "arrival_airport_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Airport arrivalAirport;	
	
	@JoinColumn(name = "route_flight_id")
	@OneToMany(fetch = FetchType.LAZY)
	private List<Flight> flights;


}
