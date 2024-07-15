package com.example.volumelevel

import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.example.dev/volume"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "getVolumeLevel") {
                val volumeLevel = getVolumeLevel()
                result.success(volumeLevel)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getVolumeLevel(): Double {

        val am = getSystemService(AUDIO_SERVICE) as AudioManager
        val volumeLevel: Double = am.getStreamVolume(AudioManager.STREAM_MUSIC).toDouble()
        val maxVolumeLevel: Int = am.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val volumePercent = ((volumeLevel.toFloat() / maxVolumeLevel)).toDouble()

        return volumePercent
    }
}
