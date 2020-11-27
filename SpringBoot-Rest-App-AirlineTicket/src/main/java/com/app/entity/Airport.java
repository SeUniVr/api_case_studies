package com.app.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Entity
@Data
@ApiModel(value = "Airport Entity Object")
public class Airport {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@ApiModelProperty(value = "Airport Id")
	private Long id;
	
	@Column(name = "name", length = 50)
	@NotNull
	@ApiModelProperty(value = "Name of Airport", required = true)
	private String name;	
	
	@Column(name = "capacity")
	@ApiModelProperty(value = "Capacity of Airport")
	private Integer capacity;
	
	@Column(name = "location", length = 100)
	@ApiModelProperty(value = "Location of Airport")
	private String location;
	
	@JoinColumn(name = "departure_airport_id")
	@OneToMany(fetch = FetchType.LAZY)
	private List<Route> departureRoutes;
	
	@JoinColumn(name = "arrival_airport_id")
	@OneToMany(fetch = FetchType.LAZY)
	private List<Route> arrivalRoutes;

}
