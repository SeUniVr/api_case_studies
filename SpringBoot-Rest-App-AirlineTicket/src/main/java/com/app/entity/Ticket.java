package com.app.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Entity
@Data
@ApiModel(value = "Ticket Entity Object")
public class Ticket {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@ApiModelProperty(value = "Ticket Id")
	private Long id;
	
	@Column(name = "ticket_code")
	@NotNull
	@ApiModelProperty(value = "Code of Ticket", required = true)
	private String ticketCode;
	
	@JoinColumn(name = "ticket_flight_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Flight flight;
	
	@Column(name = "price")
	@ApiModelProperty(value = "Price of Ticket")
	private Integer price;
	
	@Column(name = "is_sold")
	@ApiModelProperty(value = "Is Ticket Sold")
	private Boolean isSold; //   0: Cancelled, 1: Sold
	
}
