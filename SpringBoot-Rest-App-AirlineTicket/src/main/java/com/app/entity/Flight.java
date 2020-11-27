package com.app.entity;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Entity
@Data
@ApiModel(value = "Flight Entity Object")
public class Flight {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@ApiModelProperty(value = "Flight Id")
	private Long id;
	
	@Column(name = "name", length = 50)
	@NotNull
	@ApiModelProperty(value = "Name of Flight", required = true)
	private String name;
	
	@Column(name = "departure_date")
	@Temporal(TemporalType.TIMESTAMP)
	@ApiModelProperty(value = "Departure Date and Time")
	private Date departureDateTime;
	
	@Column(name = "arrival_date")
	@Temporal(TemporalType.TIMESTAMP)
	@ApiModelProperty(value = "Arrival Date and Time")
	private Date arrivalDateTime;
	
	@Column(name = "duration")
	@ApiModelProperty(value = "Flight Duration")
	private Integer duration;
	
	@Column(name = "quota")
	@ApiModelProperty(value = "Flight Quota")
	private Integer quota;
	
	@Column(name = "quota_filled")
	@ApiModelProperty(value = "Flight Quota Filled")
	private Integer quotaFilled;
	
	@Column(name = "quota_filled_percentage")
	@ApiModelProperty(value = "Flight Quota Percentage")
	private Integer quotaFilledPercentage;
	
	@JoinColumn(name = "route_flight_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Route route;
	
	@JoinColumn(name = "flight_company_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Company company;
	
	@JoinColumn(name = "ticket_flight_id")
	@OneToMany(fetch = FetchType.LAZY)
	private List<Ticket> tickets;

}
