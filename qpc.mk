#
# Makefile setup for QPC Framework
#

INC_QPC = \
	-Iqpc/include \
	-Iqpc/src \
	-Iqpc/ports/arm-cm/qxk/gnu

SRC_QPC = \
	qpc/src/qf/qep_hsm.c \
	qpc/src/qf/qep_msm.c \
	qpc/src/qf/qf_act.c \
	qpc/src/qf/qf_actq.c \
	qpc/src/qf/qf_defer.c \
	qpc/src/qf/qf_dyn.c \
	qpc/src/qf/qf_mem.c \
	qpc/src/qf/qf_ps.c \
	qpc/src/qf/qf_qact.c \
	qpc/src/qf/qf_qeq.c \
	qpc/src/qf/qf_qmact.c \
	qpc/src/qf/qf_time.c \
	qpc/src/qxk/qxk.c \
	qpc/src/qxk/qxk_xthr.c \
	qpc/src/qxk/qxk_sema.c \
	qpc/src/qxk/qxk_mutex.c \
	qpc/ports/arm-cm/qxk/gnu/qxk_port.c
