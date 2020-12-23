# SecureTrack
SecureTrack application and framework repository


<img src="https://github.com/arnabapurk/SecureTrack/blob/main/img/SecureTrackimg.PNG" width="350" height="130"/>

This is an implementation of a prototype of a novel application SecureTrack to aid in faster reopening of institutions during the COVID-19 pandemic. This work is under consideration at a journal. We have open sourced a part of our project for privacy purposes. Please get in touch with the authors for more information.


# Description:

The SecureTrack application.  
- A radio message is sent whenever a timer fires (every 10secs).
- The messgage contains only the NodeID of the device that is set while uploading the code in the device.
- When the message is recevied, the device calculate its RSSI value.
- Depending on RSSI value distance is calculated.
- If the distance between two communicating devices is less 6feet then the node id from the received packet is encrypted and stored in the memory.

# Running/ Uploading the code:
- Install TinyOS 
- To build and upload the code use:
make micaz, install,N <name_of_programmer_board>,<serial_port>

N is the device ID.


# Tools:

  None

# Known bugs/limitations:

  None.



# Citation
Citation information will be updated shortly

# License
This work is licensed under Copyright (C) 2020 [Shobhit Aggarwal]. For more information please refer [LICENSE](https://github.com/arnabapurk/SecureTrack/blob/main/LICENSE.txt)


# Author/Contact:

  Shobhit Aggarwal- shobhuagg@gmail.com 
  Arnab Purkayastha- arnabap@gmail.com


