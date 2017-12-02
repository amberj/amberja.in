## How to uninstall Android apps using TWRP custom recovery?

If you have a custom recovery (such as TWRP) installed on your Android device, you can use it to uninstall Android apps on your phone. You might ask:

> Why/when would one need such a *feature*?

One use case for this would be if your Android device is stuck in a bootloop (not uncommon if you are using a custom ROM) after you installed a new app.

### Notes
* The exact steps listed below would only work if you are using [TWRP custom recovery](https://twrp.me/) (i.e. *Team Win Recovery Project*).

* The exact version of TWRP on my device is *3.0.2-1*.

* I have tested these instructions with my [Xiaomi Redmi 1S](https://en.wikipedia.org/wiki/Redmi_1S) running custom ROM [MoKee](http://www.mokeedev.com/) (version MK51.1-armani-160420-HISTORY, based on Android 5.1.1):
<img src="./images/TWRP-1.png" alt="Android version" width="40%" height="40%" />

### Let's get started!

1. Reboot your Android device in "Recovery" mode. Depending on your device, you can do this either with your Android's "Reboot" menu:<br /><img src="./images/TWRP-2.png" alt="Android Reboot options" width="20%" height="20%" /><br />
or by holding `Power+VolumeUp` button as soon as your power on your device.
2. Once you are in TWRP, click `Advanced`. Then click `File Manager`:<br /><img src="./images/TWRP-3.jpg" alt="TWRP File Manager" width="45%" height="45%" />
3. In TWRP's File Manager, navigate to `/data/app`. Find the folder corresponding to the package name of app (for e.g. Uber's package name is `com-ubercab`, which can be found out from it's Play Store URL: https://play.google.com/store/apps/details?id=**com.ubercab**). Go inside this folder by clicking it's name in TWRP File Manager.
4. In the lower right corner, press the blue-colored “Select” button. Press "Delete" and slide to begin the process.
5. Press “Back” and now go to `/data/data`. Again find the folder with the package name of the app that you want to uninstall (e.g. `com.ubercab`) and go inside this folder. Press "Delete" and slide to begin the process.
6. Go back to the home menu of TWRP and press `Wipe`. Now press `Advanced Wipe` button. Select `Dalvik / ART Cache` and `Cache` checkboxes. Then swipe the `Swipe to Wipe` box.
7. Go back to TWRP's home menu and press `Reboot`,  then `System`.

That's it! Hopefully your device won't get stuck in bootloop this time (*fingers crossed*) and boot back into your Android OS.