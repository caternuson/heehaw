#ifndef __BSP_H__
#define __BSP_H__

#include "qpc.h"
#include <hal_gpio.h>
#include <peripheral_clk_config.h>
#include <utils.h>
#include <hal_init.h>
#include <hpl_gclk_base.h>
#include <hpl_pm_base.h>
#include <hal_delay.h>

#define BSP_TICKS_PER_SEC    1000U
//#define BSP_TICKS_PER_SEC 48000000U

void BSP_init(void);
void BSP_ledOff(void);
void BSP_ledOn(void);

#endif