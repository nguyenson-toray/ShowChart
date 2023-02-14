package com.tivn.chart
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import android.view.KeyEvent // Son add
// import com.microsoft.appcenter.AppCenter
// import com.microsoft.appcenter.analytics.Analytics
// import com.microsoft.appcenter.crashes.Crashes
// import com.microsoft.appcenter.distribute.Distribute
// import com.microsoft.appcenter.distribute.DistributeListener
// import com.microsoft.appcenter.distribute.ReleaseDetails
// import com.microsoft.appcenter.distribute.UpdateAction
import android.os.Bundle 
class MainActivity: FlutterActivity() {
    // override fun onCreate(savedInstanceState: Bundle?) {
    //     super.onCreate(savedInstanceState)
    //     AppCenter.start(
    //         getApplication(), "f908ab38-87df-4341-b722-838dbeae9108",
    //         Analytics::class.java, Crashes::class.java, Distribute::class.java
    //     )
    // }
   
    override fun dispatchKeyEvent(event: KeyEvent?): Boolean { 
        Log.d("KeyEvent","******************************KeyEvent = ${event?.keyCode}")
        // if (event?.keyCode  == KeyEvent.KEYCODE_BUTTON_SELECT || event?.keyCode  == KeyEvent. KEYCODE_DPAD_CENTER)       
        //     return super.dispatchKeyEvent(KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_ENTER))
        // else 
            return  super.dispatchKeyEvent(event)  
        }
    
}
 
