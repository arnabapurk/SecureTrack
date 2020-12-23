#include <Timer.h>
#include "SecureTrack.h"
#include "printf.h"

module SecureTrackC {
  uses interface Boot;
  uses interface Leds;
  uses interface Timer<TMilli> as Timer0;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
  uses interface Receive;
  uses interface SplitControl as AMControl;
  uses interface CC2420Packet;
}
implementation {

  message_t pkt;
  int node=0;
  signed int RSSI=0;
  signed int RSSI1=0;
  bool busy = FALSE;

  uint16_t getRssi(message_t *msg) // function to get the rssi value for the received packet from sending node
  {
    return (uint16_t) call CC2420Packet.getRssi(msg);
  }


  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
  }

  event void Timer0.fired() {
    if (!busy) {
      SecureTrackMsg* btrpkt = 
	(SecureTrackMsg*)(call Packet.getPayload(&pkt, sizeof(SecureTrackMsg)));
      if (btrpkt == NULL) {
	return;
      }
      btrpkt->nodeid =TOS_NODE_ID;
      if (call AMSend.send(AM_BROADCAST_ADDR, 
          &pkt, sizeof(SecureTrackMsg)) == SUCCESS) {
        busy = TRUE;
      }
    }
  }

  event void AMSend.sendDone(message_t* msg, error_t err) {
    if (&pkt == msg) {
      busy = FALSE;
      call Leds.led0Toggle();
    }
  }

  event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len){
    if (len == sizeof(SecureTrackMsg)) {
      SecureTrackMsg* btrpkt = (SecureTrackMsg*)payload;  
      call Leds.led1Toggle();
      RSSI=getRssi(msg); // stores RSSI value in RSSI variable 
      RSSI1=RSSI-45;     // to convert in dBm
      
      node=btrpkt->nodeid;

      if(RSSI>-25)
      {
        printf("\n Distance less than 6 feets between me and Node ID=%d. Hence storing Node ID=%d in database after encryption", node,node);
        call Leds.led2On();
      }
      else
      {
         //printf("\n Here RSSI: %d dBm\n", RSSI1);
         printf("\n Becon received from Node ID=%d. Both nodes at Safe Distance hence do not update database ", node);
         call Leds.led2Off();
      }
    }
    return msg;
  }
}
