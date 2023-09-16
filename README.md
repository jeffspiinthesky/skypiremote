# skypiremote

## Purpose
Python Flask application for providing a virtual remote control that can be used to drive a Sky Set-Top Box on the local network.

## How does it work
The pyskyq library is used to generate the remote signals to the target Sky box. The IP address of the Sky box is defined via the SKYQ 
environment variable. 

Within the templates folder, the following files exist:
* channels.html
  * This contains the layout for channel shortcuts. Each of these trigger the menu button, followed by exit, followed by the identified button sequence to be issued.
  * For example, the signals for '1', '0', '1' are triggered by
    ```<button class="btn remote-button btn-primary" name="{{RCMD.one.value}},{{RCMD.zero.value}},{{RCMD.one.value}}">BBC 1</button>```
* remote.html
  * This contains the traditional remote layout

A menu in the webapp allows either the traditional remote layout (default) or the channels remote layout to be displayed and used.

## Build
docker build --rm -t <TAG> -f Dockerfile .

## Run
docker run --rm --name SkyRemote -d -e SKYQ <Sky STB IP> -p 80:80 <TAG>

Then open a browser and navigate to:
http://<IP running Docker container>
