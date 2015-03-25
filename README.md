# _RPICode
Hear.Here (Everyone is Watching) 


Currently On Repo:

1) Email RasbPi IP to Gmail (startup_mailer.py)
	Instructions: http://elinux.org/RPi_Email_IP_On_Boot_Debian

2)Video of blinking eye plays at startup on a continuous loop
	Via: OMXPLAYER
	Instructions: http://www.cenolan.com/2013/03/looping-video-playlist-omxplayer-raspberry-pi/
	Unedited code: http://pastebin.com/a3zUYkrF
	Screen Size Modifier: http://pastebin.com/CjygREws

	On Repo Code: videoplayer.sh
	- Shell script is running on /etc/rc.local 
	---- Repo Code: rc.local_configuration.txt
	

/////////////////////////////////////////////////////////////////////////

Whishlist:
	
	1. At Startup Email Raspberry Pi IP Address to Gmail √
		---- Repo Code: startup_mailer.py



	2. Get Raspberry Pi to play audio via speakers
		Info: http://www.raspberrypi-spy.co.uk/2012/06/raspberry-pi-speakers-analog-sound-test/
		"sudo amixer cset numid=3 <n>"
		0 = auto,
		1 = analog,
		2 = hdmi
		Force Raspberry Pi to play sound via Speakers via command line
		"sudo amixer cset numid=3 1"



	3. Play Video on smooth loop
		https://web.archive.org/web/20150205091701/http://curioustechnologist.com/post/104242571716/rpilooper-v2-b-seamless-video-looper-for

		https://web.archive.org/web/20150205081233/http://curioustechnologist.com/post/90061671996/rpilooper-v2-seamless-video-looper-step-by-step



	4. Blink an LED when Video is playing √
		---- Repo Code: blinkLED.py



	3. Shutdown RPI properly at the press of a button


/////////////////////////////////////////////////////////////////////////

	 CODE_DRAFT. 

		# This script aims to play video on loop
		# While on loop - play the audio through the speakers
		# If the video is playing then blink LED
		# If the video is not playing then dont blink the LED
		# Get the RPI to wait for a button to be pressed and then properly shutdown
		# The button is to be connected on header 5 between pins 6 and 8.

		# http://kampis-elektroecke.de/?page_id=3740
		# http://raspi.tv/2013/how-to-use-interrupts-with-python-on-the-raspberry-pi-and-rpi-gpio
		# https://pypi.python.org/pypi/RPi.GPIO
		# http://www.raspberrypi.org/forums/viewtopic.php?f=28&t=55410

		import RPi.GPIO as GPIO
		import time
		import os

		#System, Set Sound Output to Speakers
		define sound_On:
		os.system("modprobe snd_bcm2835")
		os.system("amixer cset numid=3 1")

		# Use Raspberry Pi board pin numbers
		GPIO.setmode(GPIO.BOARD)

		def Int_shutdown(channel):  
	    # shutdown our Raspberry Pi when this is pressed
	    os.system("sudo shutdown -h now")

	    # Now we are programming pin 31 as an interrupt input
		# it will react on a falling edge and call our interrupt routine "Int_shutdown"
		GPIO.add_event_detect(31, GPIO.FALLING, callback = Int_shutdown, bouncetime = 2000)

		# do nothing while waiting for button to be pressed
		# while 1:
        # time.sleep(1)   

		#Define blinking pattern for LED
		def blink(pin):
        GPIO.output(pin,GPIO.HIGH)
        time.sleep(2)
        GPIO.output(pin,GPIO.LOW)
        time.sleep(1)
        return

			while playingVid= true
				sound_On
			if playingVid = true
				blinkLED
			else
				playingVide = false
				stopLED
				sound_Off



/////////////////////////////////////////////////////////////////////////

	OTHER RASPI RESOURCES

/////////////////////////////////////////////////////////////////////////

	Useful Commands:
	http://www.raspberrypi.org/documentation/linux/usage/commands.md

	SSH Raspberry Pi
	http://hertaville.com/2012/09/27/raspbian-raspberry-pi/

	Man in the Middle - SSH Alert
	http://raspberryalphaomega.org.uk/2013/07/10/a-solution-to-multiple-raspberry-pi-ssh-key-woes/

	Auto-log in Pi
	http://www.opentechguides.com/how-to/article/raspberry-pi/5/raspberry-pi-auto-start.html

		Step 1:
		terminal //  sudo nano /etc/inittab
		Step 2:
		Find the line 1:2345:respawn:/sbin/getty 115200 tty1
		and comment out so it can be #1:2345:respawn:/sbin/getty 115200 tty1
		Step 3:
		Add the line 1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1
		right below the line you just commented out
		Step4:
		Control + X > Yes > Enter  - Reboot

	Troubleshooting the IP Address of the Pi
	http://www.raspberrypi.org/documentation/troubleshooting/hardware/networking/ip-address.md

	Run a command at start-up 
	http://www.opentechguides.com/how-to/article/raspberry-pi/5/raspberry-pi-auto-start.html

		Step 1:
		terminal //  sudo nano /etc/profile
		Step 2:
		Add the line below (with the script's location) to the end of that file
		. /home/pi/**your_script_name.sh**
		Step 3:
		Control + X > Yes > Enter  - Reboot

	Sudo Command to get the start set up again
	sudo raspi-config

	wiringPi - LED Tutorial:
	https://projects.drogon.net/raspberry-pi/gpio-examples/tux-crossing/gpio-examples-1-a-single-led/
