#include "qpc.h"
#include "bsp.h"

// heehaw
#define LED0 GPIO(GPIO_PORTB, 22)
// heehaw10
//#define LED0 GPIO(GPIO_PORTA, 27)

/* ISRs defined in this BSP ------------------------------------------------*/
void SysTick_Handler(void);


void SysTick_Handler(void) {
  QXK_ISR_ENTRY();
  QF_TICK_X(0U, (void *)0);
  QXK_ISR_EXIT();
}

/* BSP functions ===========================================================*/
void BSP_init(void) {
  init_mcu();
  delay_init(SysTick);

  // config GPIO
  gpio_set_pin_level(LED0, false);
  gpio_set_pin_direction(LED0, GPIO_DIRECTION_OUT);
  gpio_set_pin_function(LED0, GPIO_PIN_FUNCTION_OFF);
}

void BSP_ledOff(void) {
  gpio_set_pin_level(LED0, false);
}

void BSP_ledOn(void) {
  gpio_set_pin_level(LED0, true);
}

/* QF callbacks ============================================================*/
void QF_onStartup(void) {
    //SysTick_Config(SystemCoreClock / BSP_TICKS_PER_SEC);
    SysTick_Config(48000000U / BSP_TICKS_PER_SEC);
    NVIC_SetPriority(SysTick_IRQn,   QF_AWARE_ISR_CMSIS_PRI + 1);
}

void QF_onCleanup(void) {
}

#ifdef QXK_ON_CONTEXT_SW
/* NOTE: the context-switch callback is called with interrupts DISABLED */
void QXK_onContextSw(QActive *prev, QActive *next) {
    (void)prev;
    if (next != (QActive *)0) {
        //_impure_ptr = next->thread; /* switch to next TLS */
    }
}
#endif /* QXK_ON_CONTEXT_SW */


void QXK_onIdle(void) {
}

Q_NORETURN Q_onAssert(char_t const * const module, int_t const loc) {
    NVIC_SystemReset();
}
