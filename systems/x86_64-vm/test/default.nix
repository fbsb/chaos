{
  ...
}:
{

  imports = [
    ../../x86_64-linux/test
  ];

  virtualisation = {
    diskSize = 20 * 1024;
    memorySize = 8 * 1024;
    cores = 8;
    qemu.options = [
      "-vga virtio"
      "-device usb-host,vendorid=0x1050,productid=0x0407"
    ];
  };
}
