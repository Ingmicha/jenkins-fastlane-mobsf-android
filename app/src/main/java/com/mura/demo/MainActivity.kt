package com.mura.demo

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.mura.demo.BuildConfig.VERSION_CODE
import com.mura.demo.BuildConfig.VERSION_NAME

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val message = "$VERSION_CODE $VERSION_NAME"
        Toast.makeText(this,message,Toast.LENGTH_LONG).show()
    }
}
