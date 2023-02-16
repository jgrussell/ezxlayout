# What?

These are the files and scripts that I am using to configure my X11 displays (various laptops connected to various external monitors) under XFCE.

I am guessing a similar, possibly exactly the same, approach would work on other desktops (KDE, GNOME, LXDE, LXQt, etc.) with a bit of script editing but be completely useless under Wayland.

This is currently only for my personal use; but, I will likely update/extend this project if bugs are discovered, my needs change, or this repository generates significant interest.

## This is early alpha software at best!!! You have been warned!!!

# Usage

1. Make sure you have all prerequisite software on your machine.
   
   - Cloned version of this repository (ideally in your `$HOME` directory)
   - [ARandR](https://christian.amsuess.com/tools/arandr/)
   - [xrandr](https://www.x.org/releases/X11R7.5/doc/man/man1/xrandr.1.html)
   - [xfce4-terminal](https://docs.xfce.org/apps/terminal/start) (or edit [ezxlayout](./ezxlayout) appropriately)

2. Disable the automatic XFCE display event by opening [`xfce4-display-settings`](https://docs.xfce.org/xfce/xfce4-settings/4.16/display) (or just open the Whisker menu and look for *Display*), then toggle *Configure new displays when connected* to off. (This option is on the *Advanced* tab of the *Display* window.)

3. Use [ARandR](https://christian.amsuess.com/tools/arandr/) (either from the menu or by running `arandr` at the command line) to arrange your screens and create the `xrandr` command to force this configuration.

4. Save the configuration file from the prior step with a unique name meaningful to you in the [layouts](./layouts) directory of your local version of this repository. 
   
   - This directory should contain only shell scrips to be executed by the [layout.sh](./layout.sh) script.
   
   - Menu options (these scripts) will be ordered in the same way `ls -1` orders them on your system.

5. Repeat steps three through five for each screen layout you are using regularly.

6. Optional steps to make this more useful:
   
   1. Set the execute bit of [ezxlayout](./ezxlayout) and [layout.sh](./layout.sh) only for the current or group of users who should have access.
      
      - This is not a requirement but may make your life easier; otherwise, you will need to edit the scripts.
      - I recommend only setting this bit for the user(s) who will actually be running this since these scripts could potentially be used for malicious purposes if open to all.
   
   2. Add the location of [ezxlayout](./ezxlayout) to the `$PATH` search path.
      
      - If you do this, you will not need to edit  [ezxlayout.desktop](./ezxlayout.desktop) nor use the full path to [ezxlayout](./ezxlayout) from the command line; but, you may still need to use the full path in an XFCE application shortcut definition, etc.
      
      - This is obviously not a requirement if you prefer keeping your `$PATH` more succinct. 
      
      - For my XFCE desktops, you can run this from a command line in this repository's directory:  
        
          `echo export PATH="${PWD}/ezxlayout:\$PATH" >> ~/.xsessionrc`
      
      - Personally, I generally restart my system after any such configuration change, take the opportunity to walk away from my desk for a few minutes, then test the change when I get back to my desk (usually with a fresh cup of coffee or tea).
   
   3. Add an application keyboard shortcut to [ezxlayout](./ezxlayout). 
      
      1. In XFCE, this can be done via the *Applications Shortcuts* tab of the [*Keyboard*](https://docs.xfce.org/xfce/xfce4-settings/4.16/keyboard) dialog.
      2. Note that absolute path must be used if this is not part of the `$PATH` search path since neither `$HOME` nor `~` are expanded when using application shortcuts in XFCE.
   
   4. Create soft links to the [ezxlayout.desktop](./ezxlayout.desktop) file to add this to your menu and/or startup groups.
      
      - For XFCE, you can do this by executing the following commands in the directory containing your local version of this repository:
        
        - `ln -s ${PWD}/ezxlayout.desktop ~/.local/share/applications/ezxlayout.desktop`
        - `ln -s ${PWD}/ezxlayout.desktop ~/.config/autostart/ezxlayout.desktop`
      
      - If you have not included this project's directory in your `$PATH` search path, you will need to edit the `Exec=` line of the [ezxlayout.desktop](./ezxlayout.desktop) file to include the absolute path to the [ezxlayout](./ezxlayout) file.
        5- Create your personal [10-ezxlayout.rules](./10-ezxlayout.rules) file to trigger this functionality when your system detects a monitor being plugged in or unplugged via [udev](https://opensource.com/article/18/11/udev). (Please only do this if your are comfortable editing and debugging these files; the current approach as a very high probability of creating orphan processes on your system; proceed with caution if at all. **You have been warned!!!**)
        1- Create the template by running the following from a command line in this repository's directory:  
        
         `sudo cp ${PWD}/10-ezxlayout.rules /etc/udev/rules.d/10-ezxlayout.rules`
        2- Make this script your own by updating it with a full, absolute path to the [ezxlayout](./ezxlayout) file since this will run as root:
        
         `sudo vi /etc/udev/rules.d/10-ezxlayout.rules`
        3- Load the new rule:  `sudo udevadm control --reload-rules`
        4- See if the rule will work:  `sudo udevadm trigger`

# Why?

- Essentially, I became frustrated with [`xfce4-display-settings`](https://docs.xfce.org/xfce/xfce4-settings/4.16/display) as [Ben Fedidat](https://fedidat.com/about/) was when he created [this blog post](https://fedidat.com/420-xfce-display-auto/) which was my inspiration for doing this.
  
  - I have moved to XFCE on most of my machines for various reasons but consider [`xfce4-display-settings`](https://docs.xfce.org/xfce/xfce4-settings/4.16/display) something between just not very robust to down right buggy.
  
  - No practical software solution would be able to completely automate my configuration since I connect my laptop to my external monitor (actually a 4K TV) via an HDMI cable and sometimes have this TV in traditional landscape orientation while other times I will manually rotate it to be a portrait mode monitor.

- In the long run, I think this will save me time and reduce my frustration level.

- Hopefully somebody else out there might find some of this useful.

- This also gave me a project to relearn POSIX compliant scripting and may turn into another Rust project eventually.

# How?

I took inspiration and direction from [this blog post](https://fedidat.com/420-xfce-display-auto/) (but not actual code since no licence was included) and used it as reference when creating this code to fit my system, work process, etc.

# Possible To Do Items

### Just a list of items that I might tackle if I ever get back to this project.

- [x] Add logging

- [ ] Clean up extra terminal windows/processes from udev events (this should only be an issues with multiple users running X11 displays)

- [ ] Limit to only run one instance of [layout.sh](./layout.sh) per logged in user

- [ ] Add example of changing audio output to external monitor to files in the [layouts](./layouts) directory

- [ ] Basic automated testing/QA

- [ ] Enhance [layout.sh](./layout.sh) and [ezxlayout](./ezxlayout) along with usage procedures to reduce/eliminate need for editing the scripts when moving to new hardware

- [ ] Re-implement this functionality via a rust program

- [ ] Expand this project to open various application windows in specific locations based on the monitor layout selected

- [ ] Display only menu choices valid for currently attached hardware
  
  - [ ] Add default actions with user defined delay(s)
  
  - [ ] Automatically run script if only one valid script found
  
  - [ ] Run default if nothing selected within allowed time 

- [ ] Support for more than one external display

- [ ] Support for multiple display adapters / graphics cards

- [ ] Support menu item names other than the actual file name

- [ ] Support sorting options other than file name

- [ ] Support Nvidia drivers

# Notes / Contributing / Requests / Bugs

- Please let me know if you find any errors in this repository or have ideas for making it more broadly useful via any of the following channels:
  
  - File an [Issue](https://github.com/jgrussell/ezxlayout/issues) (Please enable logging in both [layout.sh](./layout.sh) and [ezxlayout](./ezxlayout) and include resulting file if reporting an error, bug, etc.)
  
  - Log a [Pull request (PR)](https://github.com/jgrussell/ezxlayout/pulls)
  
  - Start a [Discussion](https://github.com/jgrussell/ezxlayout/discussions) 

- Note:  I am not likely to be interested refactoring this repository for performance, style, etc. at this time as I am considering this a functional prototype rather than polished software.
