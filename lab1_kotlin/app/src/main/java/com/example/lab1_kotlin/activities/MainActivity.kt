package com.example.lab1_kotlin.activities

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.*
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.lab1_kotlin.Constants
import com.example.lab1_kotlin.DummyContent
import com.example.lab1_kotlin.R
import com.example.lab1_kotlin.model.Passenger
import com.example.lab1_kotlin.showToast
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.list_item.view.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // to use the custom menu_main resource as the menu
        menuInflater.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // set what happens when clicking on the menu item (add button)
        when (item.itemId) { // switch
            R.id.addPassenger -> {
                val intent = Intent(this, CrudActivity::class.java)
                startActivity(intent)
            }
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onResume() {
        super.onResume()
        loadDummyContent()
    }


    private fun loadDummyContent() {
        val layoutManager = LinearLayoutManager(this)
        layoutManager.orientation = LinearLayoutManager.VERTICAL
        passengersRecyclerView.layoutManager = layoutManager

        val adapter = DummyPassengersAdapter(this, DummyContent.passengers)
        passengersRecyclerView.adapter = adapter
    }

    private fun startPassengerUpdateActivity(passanger: Passenger) {
        val intent = Intent(this, CrudActivity::class.java)
        intent.putExtra(Constants.MAIN_PASSENGER_ID, passanger.id)
        intent.putExtra(Constants.MAIN_PASSENGER_NAME, passanger.name)
        intent.putExtra(Constants.MAIN_PASSENGER_EMAIL, passanger.email)

        val airplane = passanger.airplane
        intent.putExtra(Constants.MAIN_PASSENGER_AIRPLANE, airplane)
        val seatPosition = passanger.seatPosition
        intent.putExtra(Constants.MAIN_PASSENGER_SEATPOSITION, seatPosition)
        startActivity(intent)
    }


    inner class DummyPassengersAdapter(
        context: Context,
        private var passengers: ArrayList<Passenger>
    ) : RecyclerView.Adapter<DummyPassengersAdapter.MyViewHolder>() {

        private var context: Context? = context

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
            val view = LayoutInflater.from(context).inflate(R.layout.list_item, parent, false)
            return MyViewHolder(view)
        }

        override fun getItemCount(): Int {
            return passengers.size
        }

        override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
            val passenger = passengers[position]
            holder.setData(passenger, position)
        }


        inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
            var currentPassenger: Passenger? = null
            var currentPosition: Int = 0

            init {
                itemView.setOnClickListener {
                    currentPassenger?.let {
                        context!!.showToast("Email: " + currentPassenger!!.email + "\nAirplane: " + currentPassenger!!.airplane)
                    }
                }

                itemView.deletePassengerImageView.setOnClickListener {
                    DummyContent.passengers.removeAt(currentPosition)
                    loadDummyContent()
                }

                itemView.updatePassengerImageView.setOnClickListener {
                    startPassengerUpdateActivity(currentPassenger!!)
                }
            }

            fun setData(passenger: Passenger?, pos: Int) {
                passenger?.let {
                    val name = passenger.name
                    itemView.nameTextView.text = "Name: $name"
                    val totalCostEstimation = passenger.seatPosition
                    itemView.seatPositionTextView.text =
                        "Seat Position: $totalCostEstimation"
                }
                this.currentPassenger = passenger
                this.currentPosition = pos
            }

        }

    }
}
