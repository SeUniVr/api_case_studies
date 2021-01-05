﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using ToggleAPI.Models;

namespace ToggleAPI.Migrations
{
    [DbContext(typeof(ToggleAPIContext))]
    [Migration("20180829194630_AddServicesAndToggleRelationship")]
    partial class AddServicesAndToggleRelationship
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.1.2-rtm-30932")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("ToggleAPI.Models.Service", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("name");

                    b.Property<int>("version");

                    b.HasKey("Id");

                    b.ToTable("Services");
                });

            modelBuilder.Entity("ToggleAPI.Models.Toggle", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Name");

                    b.Property<bool>("State");

                    b.Property<int>("value");

                    b.HasKey("Id");

                    b.ToTable("Toggles");
                });

            modelBuilder.Entity("ToggleAPI.Models.TogglesServices", b =>
                {
                    b.Property<int>("TogglesServicesId")
                        .ValueGeneratedOnAdd();

                    b.Property<int?>("ServiceId");

                    b.Property<int?>("ToggleId");

                    b.HasKey("TogglesServicesId");

                    b.HasIndex("ServiceId");

                    b.HasIndex("ToggleId");

                    b.ToTable("TogglesServices");
                });

            modelBuilder.Entity("ToggleAPI.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("FirstName");

                    b.Property<string>("LastName");

                    b.Property<byte[]>("PasswordHash");

                    b.Property<byte[]>("PasswordSalt");

                    b.Property<string>("Username");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("ToggleAPI.Models.TogglesServices", b =>
                {
                    b.HasOne("ToggleAPI.Models.Service", "Service")
                        .WithMany()
                        .HasForeignKey("ServiceId");

                    b.HasOne("ToggleAPI.Models.Toggle", "Toggle")
                        .WithMany()
                        .HasForeignKey("ToggleId");
                });
#pragma warning restore 612, 618
        }
    }
}