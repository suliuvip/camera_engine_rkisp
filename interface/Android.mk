LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES +=\
	rkisp_control_loop_impl.cpp \
	settings_processor.cpp \
	CameraWindow.cpp \
	rkisp_dev_manager.cpp

ifeq ($(IS_ANDROID_OS),false)
LOCAL_SRC_FILES +=\
	mediactl.c \
	media-controller.c
endif

#LOCAL_CFLAGS += -Wno-error=unused-function -Wno-array-bounds -Wno-error
#LOCAL_CFLAGS += -DLINUX  -D_FILE_OFFSET_BITS=64 -DHAS_STDINT_H -DENABLE_ASSERT
LOCAL_CPPFLAGS += -std=c++11 -Wno-error -frtti
LOCAL_CPPFLAGS += -DLINUX
LOCAL_CPPFLAGS += $(PRJ_CPPFLAGS)
# LOCAL_CPPFLAGS += -v

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/../ \
	$(LOCAL_PATH)/../xcore \
	$(LOCAL_PATH)/../xcore/base \
	$(LOCAL_PATH)/../xcore/ia \
	$(LOCAL_PATH)/../ext/rkisp \
	$(LOCAL_PATH)/../plugins/3a/rkiq \
	$(LOCAL_PATH)/../modules/isp \
	$(LOCAL_PATH)/../rkisp/ia-engine \
	$(LOCAL_PATH)/../rkisp/ia-engine/include \
    $(LOCAL_PATH)/../rkisp/ia-engine/include/linux \
    $(LOCAL_PATH)/../rkisp/ia-engine/include/linux/media \
	$(LOCAL_PATH)/../rkisp/isp-engine

LOCAL_STATIC_LIBRARIES := \
	librkisp_analyzer \
	librkisp_isp_engine \
	libisp_ia_engine \
	librkisp_ctrlloop

LOCAL_STATIC_LIBRARIES += \
	libisp_aaa_adpf \
	libisp_aaa_awdr \
	libisp_cam_calibdb \
	libisp_calibdb \
	libtinyxml2 \
	libisp_oslayer \
	libisp_ebase

LOCAL_SHARED_LIBRARIES += \
	libdrm

ifeq ($(IS_ANDROID_OS),false)
LOCAL_SHARED_LIBRARIES += \
	libglib-2.0
endif

ifeq ($(IS_ANDROID_OS),true)
LOCAL_C_INCLUDES += \
    system/media/camera/include \
    frameworks/av/include
LOCAL_SHARED_LIBRARIES += \
	libcamera_metadata \
	libcamera_client
else
LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../metadata/libcamera_client/include \
	$(LOCAL_PATH)/../metadata/libcamera_metadata/include \
	$(LOCAL_PATH)/../metadata/header_files/include/system/core/include
LOCAL_STATIC_LIBRARIES += \
	librkisp_metadata
endif

ifeq ($(IS_ANDROID_OS),true)
LOCAL_SHARED_LIBRARIES += libutils libcutils
endif

LOCAL_MODULE:= librkisp

include $(BUILD_SHARED_LIBRARY)
