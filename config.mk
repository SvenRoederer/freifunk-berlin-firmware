# default parameters for Makefile
SHELL:=$(shell which bash)
TARGET=ar71xx-generic
PACKAGES_LIST_DEFAULT=notunnel tunnel-berlin-tunneldigger manual
OPENWRT_SRC=https://git.openwrt.org/openwrt/openwrt.git
OPENWRT_COMMIT=607809dcdc69b1ce90b6eab70222a01b43cedfd4
SET_BUILDBOT=env
MAKE_ARGS=V=s
