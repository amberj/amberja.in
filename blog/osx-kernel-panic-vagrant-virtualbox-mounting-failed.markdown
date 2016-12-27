## How to solve Virtualbox's mounting failed error after Mac OS X Kernel Panic

While using Mac OS X El Capitan v10.11.3 on my Macbook Pro, my [OS X restarted spontaneously and displayed "Your computer restarted because of a problem"](https://support.apple.com/en-in/HT200553). This is OS X lingo for what is more commonly known as "Kernel Panic".

When my Macbook restarted, I tried to load my development environment in Vagrant (with OS X as host and Ubuntu 14.04 as guest). And I got this error:

<blockquote>
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:<br /><br />

mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant<br /><br />

The error output from the command was:<br /><br />

/sbin/mount.vboxsf: mounting failed with the error: No such device
</blockquote>

I restarted OS X and virtual machine, but all in vain. As you can see in the screenshot below, the virtual machine had booted fine, I could `vagrant ssh` into it, but shared folders had failed to mount:

<div class="row">
    <div class="col-md-2">
    </div>
    <div class="col-md-8">
        <img src="./images/virtualbox-osx-error.png" width="768" height="768" />
    </div>
    <div class="col-md-2">
    </div>
</div>

[Most](http://stackoverflow.com/questions/28328775/virtualbox-mount-vboxsf-mounting-failed-with-the-error-no-such-device) [of](http://unix.stackexchange.com/questions/231849/debian-virtualbox-auto-mount-fails-on-startup-but-works-after-login-mounting-fa) [the](https://bbs.archlinux.org/viewtopic.php?id=70780) [solutions](http://askubuntu.com/questions/103069/shared-folder-in-virtualbox-ubuntu-and-windows-7) at the top of [Google search results](https://www.google.co.in/search?q=%22%2Fsbin%2Fmount.vboxsf%3A%20mounting%20failed%20with%20the%20error%3A%20No%20such%20device) were targeted for Linux-based hosts. But in the very [few](http://stackoverflow.com/a/37706087) [threads](https://github.com/aidanns/vagrant-reload/issues/4#issuecomment-230134083) I could find for OS X as host, all of them pointed to the same solution to install `vagrant-vbguest` plugin. I `vagrant halt`ed my VM, and then ran:

<pre>
vagrant plugin install vagrant-vbguest
</pre>

Then I ran `vagrant up` and voila, the shared folders were mounted this time. Here are the boring logs of `vagrant up` in case you have too much spare time to kill:

<pre>
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 8000 (guest) => 8000 (host) (adapter 1)
    default: 8001 (guest) => 8001 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
[default] GuestAdditions versions on your host (5.1.4) and guest (4.3.36) do not match.
stdin: is not a tty
 * Stopping VirtualBox Additions
   ...done.
rmmod: ERROR: Module vboxsf is not currently loaded
stdin: is not a tty
Reading package lists...
Building dependency tree...
Reading state information...
The following packages were automatically installed and are no longer required:
  acl at-spi2-core colord dconf-gsettings-backend dconf-service dkms
  libasound2 libasound2-data libatk-bridge2.0-0 libatspi2.0-0
  libcairo-gobject2 libcanberra-gtk3-0 libcanberra-gtk3-module libcanberra0
  libcolord1 libcolorhug1 libdconf1 libexif12 libgd3 libgphoto2-6
  libgphoto2-l10n libgphoto2-port10 libgtk-3-0 libgtk-3-bin libgtk-3-common
  libgudev-1.0-0 libgusb2 libieee1284-3 libnotify-bin libnotify4 libsane
  libsane-common libtdb1 libv4l-0 libv4lconvert0 libvorbisfile3 libvpx1
  libwayland-client0 libwayland-cursor0 libxfont1 libxkbcommon0 libxkbfile1
  notification-daemon sound-theme-freedesktop x11-xkb-utils xfonts-base
  xfonts-encodings xfonts-utils xserver-common xserver-xorg-core
Use 'apt-get autoremove' to remove them.
The following packages will be REMOVED:
  virtualbox-guest-dkms* virtualbox-guest-utils* virtualbox-guest-x11*
0 upgraded, 0 newly installed, 3 to remove and 5 not upgraded.
After this operation, 12.1 MB disk space will be freed.
(Reading database ... 76711 files and directories currently installed.)
Removing virtualbox-guest-dkms (4.3.36-dfsg-1+deb8u1ubuntu1.14.04.1) ...

-------- Uninstall Beginning --------
Module:  virtualbox-guest
Version: 4.3.36
Kernel:  3.13.0-105-generic (x86_64)
-------------------------------------

Status: Before uninstall, this module version was ACTIVE on this kernel.

vboxguest.ko:
 - Uninstallation
   - Deleting from: /lib/modules/3.13.0-105-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


vboxsf.ko:
 - Uninstallation
   - Deleting from: /lib/modules/3.13.0-105-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


vboxvideo.ko:
 - Uninstallation
   - Deleting from: /lib/modules/3.13.0-105-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.

depmod....

DKMS: uninstall completed.

------------------------------
Deleting module version: 4.3.36
completely from the DKMS tree.
------------------------------
Done.
Removing virtualbox-guest-x11 (4.3.36-dfsg-1+deb8u1ubuntu1.14.04.1) ...
Purging configuration files for virtualbox-guest-x11 (4.3.36-dfsg-1+deb8u1ubuntu1.14.04.1) ...
Removing virtualbox-guest-utils (4.3.36-dfsg-1+deb8u1ubuntu1.14.04.1) ...
Purging configuration files for virtualbox-guest-utils (4.3.36-dfsg-1+deb8u1ubuntu1.14.04.1) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
stdin: is not a tty
Reading package lists...
Building dependency tree...
Reading state information...
dkms is already the newest version.
dkms set to manually installed.
linux-headers-3.13.0-105-generic is already the newest version.
linux-headers-3.13.0-105-generic set to manually installed.
The following packages were automatically installed and are no longer required:
  acl at-spi2-core colord dconf-gsettings-backend dconf-service libasound2
  libasound2-data libatk-bridge2.0-0 libatspi2.0-0 libcairo-gobject2
  libcanberra-gtk3-0 libcanberra-gtk3-module libcanberra0 libcolord1
  libcolorhug1 libdconf1 libexif12 libgd3 libgphoto2-6 libgphoto2-l10n
  libgphoto2-port10 libgtk-3-0 libgtk-3-bin libgtk-3-common libgudev-1.0-0
  libgusb2 libieee1284-3 libnotify-bin libnotify4 libsane libsane-common
  libtdb1 libv4l-0 libv4lconvert0 libvorbisfile3 libvpx1 libwayland-client0
  libwayland-cursor0 libxfont1 libxkbcommon0 libxkbfile1 notification-daemon
  sound-theme-freedesktop x11-xkb-utils xfonts-base xfonts-encodings
  xfonts-utils xserver-common xserver-xorg-core
Use 'apt-get autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 5 not upgraded.
Copy iso file /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso into the box /tmp/VBoxGuestAdditions.iso
stdin: is not a tty
mount: block device /tmp/VBoxGuestAdditions.iso is write-protected, mounting read-only
Installing Virtualbox Guest Additions 5.1.4 - guest version is 4.3.36
stdin: is not a tty
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.1.4 Guest Additions for Linux...........
VirtualBox Guest Additions installer
Copying additional installer modules ...
Installing additional modules ...
vboxadd.sh: Building Guest Additions kernel modules.
vboxadd.sh: Starting the VirtualBox Guest Additions.

Could not find the X.Org or XFree86 Window System, skipping.
stdin: is not a tty

Got different reports about installed GuestAdditions version:
Virtualbox on your host claims:   4.3.36
VBoxService inside the vm claims: 5.1.4
Going on, assuming VBoxService is correct...
Got different reports about installed GuestAdditions version:
Virtualbox on your host claims:   4.3.36
VBoxService inside the vm claims: 5.1.4
Going on, assuming VBoxService is correct...
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default: 
    default: Guest Additions Version: 4.3.36
    default: VirtualBox Version: 5.1
==> default: Mounting shared folders...
    default: /vagrant => /Users/dobby/Dropbox/projects/hashgrowth-everything/REPOS/hashgrowth
    default: /hashapis => /Users/dobby/Dropbox/projects/hashgrowth-everything/REPOS/hashapis
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
$
</pre>

Hasta la vista!