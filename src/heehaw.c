#include "heehaw.h"

Q_DEFINE_THIS_FILE

int main() {
  static QEvt const *l_blinkyQSto[10]; /* Event queue storage for Blinky */

  QF_init();
  BSP_init();

  Blinky_ctor();
  QACTIVE_START(AO_Blinky,      /* AO pointer to start */
                1U,             /* unique QP priority of the AO */
                l_blinkyQSto,   /* storage for the AO's queue */
                Q_DIM(l_blinkyQSto), /* length of the queue [entries] */
                (void *)0,      /* stack storage (not used in QK) */
                0U,              /* stack size [bytes] (not used in QK) */
                (QEvt *)0);     /* initial event (or 0) */

  return QF_run();
}