TARGET := iphone:clang:14.5:latest
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ActionSoundsNP
$(TWEAK_NAME)_FILES = $(wildcard *.xm *.m)
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics AVFoundation AudioToolbox LocalAuthentication
$(TWEAK_NAME)_CFLAGS = -Wno-error -Wno-return-type -Wno-objc-method-access -Wno-objc-property-no-attribute -Wno-deprecated -Wno-deprecated-declarations -Wno-incomplete-umbrella

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
include $(THEOS_MAKE_PATH)/aggregate.mk

