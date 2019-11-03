package com.example.lab1_kotlin.activities

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.lab1_kotlin.Constants
import com.example.lab1_kotlin.DummyContent
import com.example.lab1_kotlin.R
import com.example.lab1_kotlin.model.Passenger
import com.example.lab1_kotlin.showToast
import kotlinx.android.synthetic.main.activity_add_passenger.*

class CrudActivity : AppCompatActivity() {
    private var passengerId = -1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_passenger)

        val bundle: Bundle? = intent.extras
        if (bundle != null) {
            passengerId = bundle.getInt(Constants.MAIN_PASSENGER_ID, -1)
            if (passengerId != -1) {
                initializeEditTextWithPassengerDetails(bundle)
            }
        }

        addUpdatePassengerButton.setOnClickListener {

            val errors: ArrayList<String> = arrayListOf()
            val ok = checkUserInput(errors)

            if (ok) {
                if (passengerId == -1) {
                    val newPassenger = createNewPassenger()
                    DummyContent.passengers.add(newPassenger)
                    showToast("Add note successfully!")

                } else {
                    for (passenger in DummyContent.passengers)
                        if (passenger.id == passengerId) {
                            updatePassenger(passenger)
                            break
                        }
                    showToast("Update note successfully!")
                }
                finish()

            } else {
                val errorMsg = createErrorMsg(errors)
                showToast(errorMsg)
            }
        }
    }

    private fun initializeEditTextWithPassengerDetails(bundle: Bundle) {
        nameEt.setText(bundle.getString(Constants.MAIN_PASSENGER_NAME))
        emailEt.setText(bundle.getString(Constants.MAIN_PASSENGER_EMAIL))
        airplaneEt.setText(bundle.getString(Constants.MAIN_PASSENGER_AIRPLANE))
        seatPositionEt.setText(bundle.getString(Constants.MAIN_PASSENGER_SEATPOSITION))
    }


    private fun createNewPassenger(): Passenger {
        DummyContent.passengerId++
        val id = DummyContent.passengerId
        return Passenger(
            id,
            nameEt.text.toString(),
            emailEt.text.toString(),
            airplaneEt.text.toString(),
            seatPositionEt.text.toString()
        )
    }

    private fun updatePassenger(passenger: Passenger) {
        passenger.name = nameEt.text.toString()
        passenger.email = emailEt.text.toString()
        passenger.airplane = airplaneEt.text.toString()
        passenger.seatPosition = seatPositionEt.text.toString()
    }

    private fun checkUserInput(errors: ArrayList<String>): Boolean {
        var ok = true
        if (nameEt.text.toString().trim().isEmpty()) {
            ok = false
            errors.add("name, ")
        }
        if (emailEt.text.toString().trim().isEmpty()) {
            ok = false
            errors.add("email, ")
        }
        if (airplaneEt.text.toString().trim().isEmpty()) {
            ok = false
            errors.add("year of fabrication, ")
        }
        if (seatPositionEt.text.toString().trim().isEmpty()) {
            ok = false
            errors.add("total cost estimation, ")
        }
        return ok
    }

    private fun createErrorMsg(errors: ArrayList<String>): String {
        var errorMsg = "Please insert the "
        for (error in errors)
            errorMsg += error
        errorMsg = errorMsg.dropLast(2)
        return errorMsg
    }


}