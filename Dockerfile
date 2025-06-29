# 使用 consol/ubuntu-xfce-vnc 作为基础镜像
FROM consol/ubuntu-xfce-vnc:1.4.0

# 设置中文环境
ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8
USER root
# 安装中文字体和常用工具




# 暴露 VNC 端口
EXPOSE 5901 6901

# 设置默认环境变量
ENV VNC_PW=password \
    VNC_RESOLUTION=1920x1080 \
    VNC_COL_DEPTH=24