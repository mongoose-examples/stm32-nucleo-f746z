#ifndef __ETHERNETIF_H__
#define __ETHERNETIF_H__

#include "cmsis_os.h"
#include "lwip/dhcp.h"
#include "lwip/err.h"
#include "lwip/netif.h"

/* Exported types ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
err_t ethernetif_init(struct netif *netif);
#endif
