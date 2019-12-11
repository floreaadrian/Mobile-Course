package com.example.lab1_kotlin.activities

import android.content.ContentValues
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.lab1_kotlin.R
import com.example.myapplication.DatabaseHelper
import kotlinx.android.synthetic.main.activity_add_passenger.*
import org.json.JSONObject
import java.io.IOException
import java.lang.Exception

class CrudActivity : AppCompatActivity() {
    private var passengerID = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_passenger)

        try {
            val bundle: Bundle? = intent.extras
            passengerID = bundle?.getInt("MainActID") ?: 0
            if (passengerID != 0) {
                nameEt.setText(bundle?.getString("MainActNAME"))
                emailEt.setText(bundle?.getString("MainActEMAIL"))
                seatPositionEt.setText(bundle?.getString("MainActSEATPOSITION"))
                airplaneEt.setText(bundle?.getString("MainActAIRPLANE"))
            }
        } catch (ex: Exception) {
            print("Oh no! A wild Exception has appeared!")
        }

        addUpdatePassengerButton.setOnClickListener {
            var dbManager = DatabaseHelper(this)

            var values = ContentValues()
            values.put("NAME", nameEt.text.toString())
            values.put("EMAIL", emailEt.text.toString())
            values.put("SEATPOSITION", seatPositionEt.text.toString())
            values.put("AIRPLANE", airplaneEt.text.toString())

            if (passengerID == 0) {
                val id = dbManager.insertData(values)
                if (id > 0) {
                    Toast.makeText(this, "Added passenger successfully", Toast.LENGTH_LONG).show()
                    var intent = Intent()
                    intent.putExtra("ID", id.toString())
                    intent.putExtra("NAME", nameEt.text.toString())
                    intent.putExtra("EMAIL", emailEt.text.toString())
                    intent.putExtra("SEATPOSITION", seatPositionEt.text.toString())
                    intent.putExtra("AIRPLANE", airplaneEt.text.toString())
                    setResult(RESULT_OK, intent)
                    finish()
                } else {
                    Toast.makeText(this, "Failed to add passenger", Toast.LENGTH_LONG).show()
                }
            } else {
                var selectionArgs = arrayOf(passengerID.toString())
                val id = dbManager.update(values, "ID=?", selectionArgs)

                if (id > 0) {
                    Toast.makeText(this, "Updated passenger successfully", Toast.LENGTH_LONG).show()
                    var intent = Intent()
                    intent.putExtra("ID", id.toString())
                    intent.putExtra("NAME", nameEt.text.toString())
                    intent.putExtra("EMAIL", emailEt.text.toString())
                    intent.putExtra("SEATPOSITION", seatPositionEt.text.toString())
                    intent.putExtra("AIRPLANE", airplaneEt.text.toString())
                    setResult(RESULT_OK, intent)
                    finish()
                } else {
                    Toast.makeText(this, "Failed to update passenger", Toast.LENGTH_LONG).show()
                }
            }
        }
    }
}