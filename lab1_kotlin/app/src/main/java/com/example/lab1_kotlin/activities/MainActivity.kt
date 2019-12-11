package com.example.lab1_kotlin.activities

import android.app.Activity
import android.app.AlertDialog
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.*
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.example.lab1_kotlin.R
import com.example.lab1_kotlin.model.Passenger
import com.example.myapplication.DatabaseHelper
import kotlinx.android.synthetic.main.activity_main.*
import okhttp3.*
import org.json.JSONArray
import org.json.JSONObject
import java.io.IOException
import java.util.concurrent.Executors


class MainActivity : AppCompatActivity() {

    private var passengerList = ArrayList<Passenger>()
    private var passengersToAddWhenOnline = ArrayList<RequestBody>()

    var passengersAdapter = PassengersAdapter(this, passengerList)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        loadQueryAll()

        passengersLv.adapter = passengersAdapter
    }

    override fun onResume() {
        super.onResume()
        if(isConnectedToNetwork()) {
            var beforeSize = passengerList.size
            for (x in 0..passengersToAddWhenOnline.size - 1) {
                Executors.newSingleThreadExecutor().execute {
                    POST("http://10.0.2.2:3000/passengers", passengersToAddWhenOnline[x])
                }
            }
            println(passengersToAddWhenOnline.size)
            if (passengerList.size == passengersToAddWhenOnline.size + beforeSize)
            {
                passengersToAddWhenOnline.clear()
            }
            loadQueryAll()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // to use the custom menu_main resource as the menu
        menuInflater.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // set what happens when clicking on the menu item (add button)
        if (item != null) {
            when (item.itemId) {
                R.id.addPassenger -> {
                    val intent = Intent(this, CrudActivity::class.java)
                    startActivityForResult(intent, 2)
                }
//                R.id.refresh -> {
//                    onResume()
//                }
            }
        }
        return super.onOptionsItemSelected(item)
    }


    fun loadQueryAll() {
        Executors.newSingleThreadExecutor().execute {
            GET("http://10.0.2.2:3000/passengers")
        }
    }

    fun GET(url: String) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .url(url)
            .get()
            .build()

        val response = client.newCall(request).execute()
        val jsonDataString = response.body()?.string()

        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                val json = JSONArray(jsonDataString)
                var errors = json.join(", ")
                throw Exception(errors)
            }

            override fun onResponse(call: Call, response: Response) {
                this@MainActivity.runOnUiThread(object : Runnable {
                    override fun run() {
                        passengerList.clear()
                        val json = JSONArray(jsonDataString)
                        for (i in 0..json.length() - 1) {
                            var passenger = Passenger(
                                json.getJSONObject(i)["id"].toString().toInt(),
                                json.getJSONObject(i)["name"].toString(),
                                json.getJSONObject(i)["email"].toString(),
                                json.getJSONObject(i)["airplaneName"].toString(),
                                json.getJSONObject(i)["seatPosition"].toString(),
                                json.getJSONObject(i)["_id"].toString()
                            )
                            passengerList.add(passenger)
                        }
                        print(passengerList)
                        passengersAdapter.notifyDataSetChanged()
                    }
                })
            }
        })
    }

    fun POST(url: String, requestBody: RequestBody?) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .method("POST", requestBody)
            .url(url)
            .build()

        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                print("Oh no! It failed, binch\n")
            }

            override fun onResponse(call: Call, response: Response) {
                this@MainActivity.runOnUiThread(object : Runnable {
                    override fun run() {
                        var dbManager = DatabaseHelper(this@MainActivity)
                        val jsonDataString = response.body()?.string()
                        val json = JSONObject(jsonDataString)
                        var passenger = Passenger(
                            json["id"].toString().toInt(),
                            json["name"].toString(),
                            json["email"].toString(),
                            json["airplaneName"].toString(),
                            json["seatPosition"].toString(),
                            json["_id"].toString()
                        )
                        passengerList.add(passenger)
                        var selectionArgs = arrayOf(passenger.id.toString())
                        var values = ContentValues()
                        values.put("NAME", passenger.name)
                        values.put("EMAIL", passenger.email)
                        values.put("AIRPLANE", passenger.airplane)
                        values.put("SEATPOSITION", passenger.seatPosition)
                        values.put("SERVERID", passenger.serverId)
                        val id = dbManager.update(values, "Id=?", selectionArgs)
                        passengersAdapter.notifyDataSetChanged()
                    }
                }
                )
            }
        })
    }

    fun PUT(url: String, requestBody: RequestBody?) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .method("PUT", requestBody)
            .url(url)
            .build()

        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                print("Oh no! It failed, binch2\n")
            }

            override fun onResponse(call: Call, response: Response) {
                this@MainActivity.runOnUiThread(object : Runnable {
                    override fun run() {
                        var dbManager = DatabaseHelper(this@MainActivity)
                        val jsonDataString = response.body()?.string()
                        println(jsonDataString)
                        val json = JSONObject(jsonDataString)
                        var passenger = Passenger(
                            json["id"].toString().toInt(),
                            json["name"].toString(),
                            json["email"].toString(),
                            json["airplaneName"].toString(),
                            json["seatPosition"].toString(),
                            json["_id"].toString()
                        )
                        var index = 0
                        for (x in 0..passengerList.size - 1) {
                            if (passengerList[x].id == passenger.id)
                                index = x
                        }
                        passengerList.set(index, passenger)
                        var selectionArgs = arrayOf(passenger.id.toString())
                        var values = ContentValues()
                        values.put("NAME", passenger.name)
                        values.put("EMAIL", passenger.email)
                        values.put("AIRPLANE", passenger.airplane)
                        values.put("SEATPOSITION", passenger.seatPosition)
                        values.put("SERVERID", passenger.serverId)
                        val id = dbManager.update(values, "Id=?", selectionArgs)
                        passengersAdapter.notifyDataSetChanged()
                    }
                })
            }
        })
    }

    fun DELETE(url: String) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .url(url)
            .delete()
            .build()

        val response = client.newCall(request).execute()
    }

    inner class PassengersAdapter : BaseAdapter {
        private var passengersList = ArrayList<Passenger>()
        private var context: Context? = null

        constructor(context: Context, passengersList: ArrayList<Passenger>) : super() {
            this.passengersList = passengersList
            this.context = context
        }

        override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View? {
            val view: View?
            val viewHolder: ViewHolder

            if (convertView == null) {
                view = layoutInflater.inflate(R.layout.list_item, parent, false)
                viewHolder = ViewHolder(view)
                view.tag = viewHolder
            } else {
                view = convertView
                viewHolder = view.tag as ViewHolder
            }

            var passenger = passengersList[position]
            viewHolder.tvName.text = passenger.name
//            viewHolder.tvDescription.text = passenger.description

            viewHolder.ivEdit.setOnClickListener {
                if (isConnectedToNetwork()) {
                    updatePassenger(passenger)
                } else {
                    val builder = AlertDialog.Builder(this@MainActivity)
                    builder.setMessage("No internet")
                    val dialog: AlertDialog = builder.create()
                    dialog.show()
                }
            }

            viewHolder.ivDelete.setOnClickListener {
                if (isConnectedToNetwork()) {
                    var dbManager = DatabaseHelper(this.context!!)
                    val selectionArgs = arrayOf(passenger.id.toString())
                    dbManager.delete("Id=?", selectionArgs)
                    passengersList.remove(passenger)

                    Executors.newSingleThreadExecutor().execute {
                        DELETE("http://10.0.2.2:3000/passengers/${passenger.serverId}")
                    }
                    this.notifyDataSetChanged()
//                loadQueryAll()
                } else {
                    val builder = AlertDialog.Builder(this@MainActivity)
                    builder.setMessage("No internet")
                    val dialog: AlertDialog = builder.create()
                    dialog.show()
                }
            }
            return view
        }

        override fun getItem(position: Int): Any {
            return passengersList[position]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getCount(): Int {
            return passengersList.size
        }
    }

    private fun updatePassenger(passenger: Passenger) {
        var intent = Intent(this, CrudActivity::class.java)
        intent.putExtra("MainActID", passenger.id)
        intent.putExtra("MainActNAME", passenger.name)
        intent.putExtra("MainActEMAIL", passenger.email)
        intent.putExtra("MainActAIRPLANE", passenger.airplane)
        intent.putExtra("MainActSEATPOSITION", passenger.seatPosition)
        startActivityForResult(intent, 1)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 1) {
            if (resultCode == Activity.RESULT_OK) {
                var id = data!!.getStringExtra("ID").toInt()
                var name = data!!.getStringExtra("NAME")
                var email = data!!.getStringExtra("EMAIL")
                var airplane = data!!.getStringExtra("AIRPLANE")
                var seatPosition = data!!.getStringExtra("SEATPOSITION")
                var serverId = ""

                for (x in 0..passengerList.size - 1) {
                    if (passengerList[x].id == id) {
                        serverId = passengerList[x].serverId
                    }
                }

                val jsonPassenger = """
                        {
                        "id": $id,
                        "name":"$name",
                        "email":"$email",
                        "airplaneName": "$airplane",
                        "seatPosition": "$seatPosition"
                        }
                    """.trimIndent()
                val requestBody = RequestBody.create(
                    MediaType.parse("application/json; charset=utf-8"),
                    jsonPassenger
                )
                println(jsonPassenger)

                Executors.newSingleThreadExecutor().execute {
                    PUT("http://10.0.2.2:3000/passengers/$serverId", requestBody)
                }
            }
        } else if (requestCode == 2) {
            if (resultCode == Activity.RESULT_OK) {
                var id = data!!.getStringExtra("ID").toInt()
                var name = data!!.getStringExtra("NAME")
                var email = data!!.getStringExtra("EMAIL")
                var airplane = data!!.getStringExtra("AIRPLANE")
                var seatPosition = data!!.getStringExtra("SEATPOSITION")

                val jsonPassenger = """
                        {
                        "id": $id,
                        "name":"$name",
                        "email":"$email",
                        "airplaneName": "$airplane",
                        "seatPosition": "$seatPosition"
                        }
                    """.trimIndent()
                val requestBody = RequestBody.create(
                    MediaType.parse("application/json; charset=utf-8"),
                    jsonPassenger
                )
                println(jsonPassenger)
                if (isConnectedToNetwork()) {
                    Executors.newSingleThreadExecutor().execute {
                        POST("http://10.0.2.2:3000/passengers", requestBody)
                    }
                } else {
                    passengersToAddWhenOnline.add(requestBody)
                    var dbManager = DatabaseHelper(this@MainActivity)
                    var passenger = Passenger(id, name, email, airplane, seatPosition, "")
                    passengerList.add(passenger)
                    var selectionArgs = arrayOf(passenger.id.toString())
                    var values = ContentValues()
                    values.put("NAME", passenger.name)
                    values.put("EMAIL", passenger.email)
                    values.put("AIRPLANE", passenger.airplane)
                    values.put("SEATPOSITION", passenger.seatPosition)
                    values.put("SERVERID", passenger.serverId)
                    val id = dbManager.update(values, "ID=?", selectionArgs)
                    passengersAdapter.notifyDataSetChanged()
                }
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }

    fun Context.isConnectedToNetwork(): Boolean {
        val connectivityManager =
            this.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager?
        return connectivityManager?.activeNetworkInfo?.isConnectedOrConnecting() ?: false
    }

    private class ViewHolder(view: View?) {
        val tvName: TextView
        val tvSeatPosition: TextView
        val ivEdit: ImageView
        val ivDelete: ImageView

        init {
            this.tvName = view?.findViewById(R.id.nameTextView) as TextView
            this.tvSeatPosition = view?.findViewById(R.id.seatPositionTextView)  as TextView
            this.ivEdit = view?.findViewById(R.id.updatePassengerImageView) as ImageView
            this.ivDelete = view?.findViewById(R.id.deletePassengerImageView) as ImageView
        }
    }
}