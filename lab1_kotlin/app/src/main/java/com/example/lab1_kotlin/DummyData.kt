package com.example.lab1_kotlin

import com.example.lab1_kotlin.model.Passenger


object DummyContent {
    var passengerId = 0

    val passengers = arrayListOf(
        Passenger(++passengerId, "Nume1","ceva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","ceva@l.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","cva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","cva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","cva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","ceva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume1gfd","ceva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume154","ceva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume16","c@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume4","ceva@al.com","clj","C2S3"),
        Passenger(++passengerId, "Nume3","cea@al.co","clj","C2S3"),
        Passenger(++passengerId, "Nume2","ceva@al.cm","clj","C2S3")
    )
}
