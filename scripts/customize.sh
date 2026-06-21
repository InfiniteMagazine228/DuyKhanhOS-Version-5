mkdir -p rootfs/usr/share/backgrounds

cp config/wallpapers/cy.jpg \
rootfs/usr/share/backgrounds/cy.jpg

mkdir -p rootfs/home/live/.config/xfce4/xfconf/xfce-perchannel-xml

cp overlay/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml \
rootfs/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/

chown -R 1000:1000 rootfs/home/live
