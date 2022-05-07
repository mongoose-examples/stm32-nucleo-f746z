// Copyright (c) 2021 Cesanta Software Limited
// All rights reserved

#include "web_server.h"
#include "lwip/api.h"
#include "main.h"
#include "mongoose.h"

static struct mg_mgr mgr;
// NOTE: Set actual board IP addres in Inc/main.h
// Default address is 192.168.0.10
static const char *s_listening_address = "http://0.0.0.0:80";

// Reroute printf & Co to SWV ITM Data Console
int __io_putchar(int ch) {
  ITM_SendChar(ch);
  return ch;
}

static void cb(struct mg_connection *c, int ev, void *ev_data, void *fn_data) {
  if (ev == MG_EV_HTTP_MSG) {
    struct mg_http_message *hm = (struct mg_http_message *) ev_data;
    if (mg_http_match_uri(hm, "/api/stats")) {
      // Print some statistics about currently established connections
      mg_printf(c, "HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\n\r\n");
      mg_http_printf_chunk(c, "ID PROTO TYPE      LOCAL           REMOTE\n");
      for (struct mg_connection *t = c->mgr->conns; t != NULL; t = t->next) {
        char loc[40], rem[40];
        mg_http_printf_chunk(c, "%-3lu %4s %s %-15s %s\n", t->id,
                             t->is_udp ? "UDP" : "TCP",
                             t->is_listening  ? "LISTENING"
                             : t->is_accepted ? "ACCEPTED "
                                              : "CONNECTED",
                             mg_straddr(&t->loc, loc, sizeof(loc)),
                             mg_straddr(&t->rem, rem, sizeof(rem)));
      }
      mg_http_printf_chunk(c, "");  // Don't forget the last empty chunk
    } else {
      mg_http_reply(c, 200, "", "hello, %s!\n", "world");
    }
  }
  (void) fn_data;
  (void) ev_data;
}

static void server(void *args) {
  mg_mgr_init(&mgr);
  mg_log_set("4");
  MG_INFO(("Starting Mongoose v%s", MG_VERSION));  // Tell the world
  void *c =
      mg_http_listen(&mgr, s_listening_address, cb, &mgr);  // Web listener
  if (c == NULL) {
    BSP_LED_On(LED3);  // Turn on RED led to indicate an error
  }
  while (1) {
    BSP_LED_Toggle(LED2);     // Blink BLUE led
    mg_mgr_poll(&mgr, 1000);  // Infinite event loop
  }
  mg_mgr_free(&mgr);  // Unreachable
}

void start_mongoose() {
  sys_thread_new("MG", server, NULL, DEFAULT_THREAD_STACKSIZE,
                 osPriorityAboveNormal);
}
