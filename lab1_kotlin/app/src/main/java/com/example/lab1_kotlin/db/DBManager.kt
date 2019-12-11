package com.example.myapplication

import android.content.Context
import android.database.sqlite.SQLiteOpenHelper
import android.content.ContentValues
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase

class DatabaseHelper(context: Context) :
    SQLiteOpenHelper(context, DATABASE_NAME, null, 1) {

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL("CREATE TABLE $TABLE_NAME (ID INTEGER PRIMARY KEY " +
                "AUTOINCREMENT,NAME TEXT,EMAIL TEXT, AIRPLANE TEXT, SEATPOSITION TEXT, SERVERID TEXT)")
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME)
        onCreate(db)
    }


    fun insertData(contentValues: ContentValues): Long {
        val db = this.writableDatabase
        val id =  db.insert(TABLE_NAME, null, contentValues)
        return id
    }


    fun update(values: ContentValues, selection: String, selectionArgs: Array<String>): Int {
        val db = this.writableDatabase
        val count = db!!.update(TABLE_NAME, values, selection, selectionArgs)
        return count
    }


    fun delete(selection: String, selectionArgs: Array<String>): Int {
        val db = this.writableDatabase
        val number = db!!.delete(TABLE_NAME, selection, selectionArgs)
        return number
    }

    val allData : Cursor
        get() {
            val db = this.writableDatabase
            val res = db.rawQuery("SELECT * FROM " + TABLE_NAME, null)
            return res
        }

    companion object {
        val DATABASE_NAME = "passenger_db.db"
        val TABLE_NAME = "PASSENGER"
        val COL_1 = "ID"
        val COL_2 = "NAME"
        val COL_3 = "EMAIL"
        val COL_4 = "AIRPLANE"
        val COL_5 = "SEATPOSITION"
        val COL_6 = "SERVERID"
    }
}