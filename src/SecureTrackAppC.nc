#include <Timer.h>
#include "SecureTrack.h"

configuration SecureTrackAppC {
}
implementation {
  components MainC;
  components LedsC;
  components SecureTrackC as App;
  components new TimerMilliC() as Timer0;
  components ActiveMessageC;
  components new AMSenderC(6);
  components new AMReceiverC(6);
  components PrintfC, SerialStartC;
  components CC2420ActiveMessageC;

  App.Boot -> MainC;
  App.Leds -> LedsC;
  App.Timer0 -> Timer0;
  App.Packet -> AMSenderC;
  App.AMPacket -> AMSenderC;
  App.AMControl -> ActiveMessageC;
  App.AMSend -> AMSenderC;
  App.Receive -> AMReceiverC;
  App -> CC2420ActiveMessageC.CC2420Packet;
}
