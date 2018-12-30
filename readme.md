# Simple Survey

## Introduction
This program is a simple mobile app that works with works with NMEA GPS data
sources to allow simply surveying.  With a suitably accurate RTK GPS source,
it's designed to replace a tape measure and transit for simple surveying tasks,
such as measuring out a square plan for constructing a building, or making a
flat pad to pour concrete onto. To that end, this program allows for making
relative measurements in three dimensions from a starting point.

## License
Simple Survey is licensed under the terms of the GNU GPLv3.

## Requirements
Simple Survey requires the following:

* QtQuick from Qt v5.9 or later
* V-Play from vplay.net
* Android SDK if targeting Android

## How to use
You'll need an RTK GPS receiver capable of transmitting NMEA sentences by
bluetooth or TCP/IP connection to the phone.  An app called LeFebure NTRIP Client can make external GPS sources act as the primary location source for all android apps.  Otherwise you'll have to go to settings and tell the app to connect to your RTK GPS receiver's TCP/IP socket service (telnet server).  For Reach RTK, this is usually port 9001.

If your GPS receiver is mounted on a tripod, a plumb bob hanging from the underside can help you accurately measure a position.

Start the app and optionally configure it to use a socket GPS source.  You should see latitude and longitude data.  Click "Start" to mark a beginning position.  Now as you move the receiver, you will get measurements relative to that starting position.  If you need subsequent relative measurements, you can click "Mark" to mark a point to measure from, while still seeing measurements against the original start position also.

The relative measurements are given in north and south offsets from the
starting position, as well as the total distance and bearing from start. To
make the math simpler, Simple Survey turns latitude and longitude into a pseudo
UTM coordinate, with the pseudo zone centered on the start longitude. This way
we can avoid UTM grid distortion away.

A "Pause" button allows you to pause the GPS data, freezing the display for easier noting of position.

## Limitations
To minimize grid distortion, relative distances being measured are really
intended to be no more than hundreds of feet.

Height or elevation displayed by Simple Survey is GPS height above the
ellipsoid, not orthographic height above sea level. But for relative measuring
it will be as accurate as your GPS source.  As near as I can tell Android and QML don't have a means of exposing the ellipsoid height data to programs, so it does not appear possible to calculate the orthometric height, which is what survey maps would use.

## Future
A means of storing marked points and displaying them on a map would be nice.
