package com.example.lab1_kotlin

import android.content.Context
import android.util.Log
import android.widget.Toast
import java.util.*


fun Any.logd(message: Any? = "no message!") {
    Log.d(this.javaClass.simpleName, message.toString())
}

fun Context.showToast(message: String, duration: Int = Toast.LENGTH_SHORT) {
    Toast.makeText(this, message, duration).show()
}