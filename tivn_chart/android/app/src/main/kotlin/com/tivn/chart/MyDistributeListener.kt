// import android.R
// import android.app.Activity
// import android.app.AlertDialog
// import android.content.DialogInterface
// import android.net.Uri
// import android.widget.Toast
// import com.microsoft.appcenter.distribute.Distribute
// import com.microsoft.appcenter.distribute.DistributeListener
// import com.microsoft.appcenter.distribute.ReleaseDetails
// import com.microsoft.appcenter.distribute.UpdateAction

// class MyDistributeListener : DistributeListener  {
//   override  fun onReleaseAvailable(activity: Activity?, releaseDetails: ReleaseDetails): Boolean {

//         // Look at releaseDetails public methods to get version information, release notes text or release notes URL
//         // val versionName: String = releaseDetails.getShortVersion()
//         // val versionCode: Int = releaseDetails.getVersion()
//         // val releaseNotes: String = releaseDetails.getReleaseNotes()
//         // val releaseNotesUrl: Uri = releaseDetails.getReleaseNotesUrl()

//         // Build our own dialog title and message
//         // val dialogBuilder = AlertDialog.Builder(activity)
//         // dialogBuilder.setTitle("Version $versionName available!") // you should use a string resource instead, this is just a simple example
//         // dialogBuilder.setMessage(releaseNotes)

//         // // Mimic default SDK buttons
//         // dialogBuilder.setPositiveButton(com.microsoft.appcenter.distribute.R.string.appcenter_distribute_update_dialog_download,
//         //     DialogInterface.OnClickListener { dialog, which -> // This method is used to tell the SDK what button was clicked
//                 Distribute.notifyUpdateAction(UpdateAction.UPDATE)
//             // })

//         // We can postpone the release only if the update isn't mandatory
//         // if (!releaseDetails.isMandatoryUpdate()) {
//         //     dialogBuilder.setNegativeButton(com.microsoft.appcenter.distribute.R.string.appcenter_distribute_update_dialog_postpone,
//         //         DialogInterface.OnClickListener { dialog, which -> // This method is used to tell the SDK what button was clicked
//         //             Distribute.notifyUpdateAction(UpdateAction.POSTPONE)
//         //         })
//         // }
//         // dialogBuilder.setCancelable(false) // if it's cancelable you should map cancel to postpone, but only for optional updates
//         // dialogBuilder.create().show()

//         // Return true if you're using your own dialog, false otherwise
//         return true
//     }

//    override fun onNoReleaseAvailable(activity: Activity) {
//         Toast.makeText(
//             activity,
//             // activity.getString(R.string.no_updates_available),
//             "Updates available !",
//             Toast.LENGTH_LONG
//         ).show()
//     }
// }