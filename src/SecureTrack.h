#ifndef SecureTrack_H
#define SecureTrack_H

enum {
  TIMER_PERIOD_MILLI = 10000
};

typedef nx_struct SecureTrackMsg {
  nx_uint16_t nodeid;
  nx_uint16_t RSSI;
} SecureTrack;

#endif
