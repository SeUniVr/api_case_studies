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
@ApiModel(value = "Plane Entity Object")
public class Plane {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@ApiModelProperty(value = "Plane Id")
	private Long id;
	
	@Column(name = "name", length = 20)
	@NotNull
	@ApiModelProperty(value = "Name of Plane", required = true)
	private String name;
	
	@Column(name = "number_seat")
	@ApiModelProperty(value = "Number Of Seats")
	private Integer numberOfSeats;
	
	@JoinColumn(name = "company_plane_id")
	@ManyToOne(fetch = FetchType.LAZY)
	private Company company;

}
