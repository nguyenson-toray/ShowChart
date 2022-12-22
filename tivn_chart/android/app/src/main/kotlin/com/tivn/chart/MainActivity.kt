package com.tivn.chart
// package com.rouninlabs.another_tv_remote_example
import io.flutter.embedding.android.FlutterActivity
import android.view.KeyEvent // Son add
class MainActivity: FlutterActivity() {
    override fun dispatchKeyEvent(event: KeyEvent?): Boolean { 
        //  val newEvent : KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_ENTER) ;
        // newEvent.keyCode =  KeyEvent.KEYCODE_ENTER
        if (event?.keyCode  == KeyEvent.KEYCODE_BUTTON_SELECT || event?.keyCode  == KeyEvent. KEYCODE_DPAD_CENTER) 
      
         return super.dispatchKeyEvent(KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_ENTER))
         else return super.dispatchKeyEvent(event)
        }
   
}
 
