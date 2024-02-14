package com.example.el_grocer

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("84874f5c-c8f2-4b9c-bf73-3ecac5aa8ae5") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}