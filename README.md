```
                                   __   _
                                  / /  (_)__  __ ____ __
                                 / /__/ / _ \/ // /\ \ /
                                /____/_/_//_/\_,_//_\_\
                                      / _ \/ _ \
                      __   _ __      _\___/_//_/ __             _
                     / /  (_) /____ | |/_/__| | / /____ __ ____(_)__ _____  __
                    / /__/ / __/ -_)>  </___/ |/ / -_) \ // __/ (_-</ __/ |/ /
                   /____/_/\__/\__/_/|_|    |___/\__/_\_\/_/ /_/___/\__/|___/

                   Copyright (c) 2019-2024, Linux-on-LiteX-VexRiscv Developers
```
[![](https://github.com/litex-hub/linux-on-litex-vexriscv/workflows/ci/badge.svg)](https://github.com/litex-hub/linux-on-litex-vexriscv/actions) ![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)
> **Note:** Tested on Ubuntu 18.04/20.04 LTS.


# Obsidian specific notes
  * To build the .bit file, run `./build_obsidian.sh --build`, which will build a SoC with
    2 RISC-V 32 bit CPU cores without FPU.
  * This CPU variant comes pre-generated with litex, so one doesn't have to install
    the SpinalHDL development environment to generate a custom VexRiscv
  * Use `./build_obsidian.sh --load` to configure the FPGA
  * Use `./build_obsidian.sh --flash` to upload the FPGA configuration to the Obsidians SPI flash, so it boots automatically on power-up

## SD card
  * Connect a Digilent Pmod MicroSD to `J14`
  * Format a SD card with 2 partitions as such:
    * FAT32, 200 MB, for kernel, bootloader and rootfs. The litex bios will copy the content of these files to RAM and then boot linux. In linux this partition is normally not used but mounted under /boot for convenience
    * EXT4, 1 GB or more, used as persistent storage, will be mounted as /root, which is the home directory of the root user

Copy these files from the `linux-on-litex-vexriscv/images` directory to the BOOT partition

```
/media/BOOT/
├── boot.json
├── Image
├── opensbi.bin
└── rv32.dtb
└── rootfs.cpio
```

That's it, this SD card should boot the Obsidian into linux.

__Initial user and password is root / root.__

```
$ pyserial-miniterm /dev/ttyUSB1 115200 --raw --eol LF

--- Miniterm on /dev/ttyUSB1  115200,8,N,1 ---
--- Quit: Ctrl+] | Menu: Ctrl+T | Help: Ctrl+T followed by Ctrl+H ---

        __   _ __      _  __
       / /  (_) /____ | |/_/
      / /__/ / __/ -_)>  <
     /____/_/\__/\__/_/|_|
   Build your hardware, easily!

 (c) Copyright 2012-2025 Enjoy-Digital
 (c) Copyright 2007-2015 M-Labs

 BIOS CRC passed (ee25fcc2)

 LiteX git sha1: f98b288e9

--=============== SoC ==================--
CPU:    VexRiscv SMP-LINUX @ 125MHz
BUS:    wishbone 32-bit @ 4GiB
CSR:    32-bit data
ROM:    64.0KiB
SRAM:   6.0KiB
SDRAM:    8.0GiB 16-bit @ 1000MT/s (CL-8 CWL-6)
MAIN-RAM: 512.0MiB

--========== Initialization ============--
Ethernet init...
Local IP: 192.168.1.50

Initializing SDRAM @0x40000000...
Switching SDRAM to software control.
Read leveling:
  m0, b00: |00000000000000000000000000000000| delays: -
  m0, b01: |00000000000000000000000000000000| delays: -
  m0, b02: |11100000000000000000000000000000| delays: 01+-01
  m0, b03: |00000111111111100000000000000000| delays: 09+-04
  m0, b04: |00000000000000000011111111100000| delays: 22+-04
  m0, b05: |00000000000000000000000000000001| delays: -
  m0, b06: |00000000000000000000000000000000| delays: -
  m0, b07: |00000000000000000000000000000000| delays: -
  best: m0, b03 delays: 09+-04
  m1, b00: |00000000000000000000000000000000| delays: -
  m1, b01: |00000000000000000000000000000000| delays: -
  m1, b02: |11100000000000000000000000000000| delays: 01+-01
  m1, b03: |00000011111111110000000000000000| delays: 10+-04
  m1, b04: |00000000000000000001111111110000| delays: 23+-04
  m1, b05: |00000000000000000000000000000000| delays: -
  m1, b06: |00000000000000000000000000000000| delays: -
  m1, b07: |00000000000000000000000000000000| delays: -
  best: m1, b03 delays: 10+-04
Switching SDRAM to hardware control.
Memtest at 0x40000000 (2.0MiB)...
  Write: 0x40000000-0x40200000 2.0MiB
   Read: 0x40000000-0x40200000 2.0MiB
Memtest OK
Memspeed at 0x40000000 (Sequential, 2.0MiB)...
  Write speed: 207.4MiB/s
   Read speed: 109.0MiB/s

--============== Boot ==================--
Booting from serial...
Press Q or ESC to abort boot completely.
sL5DdSMmkekro
Timeout
Booting from SDCard in SD-Mode...
Booting from boot.json...
Copying Image to 0x40000000 (8764048 bytes)...
[########################################]
Copying rv32.dtb to 0x40ef0000 (3711 bytes)...
[########################################]
Copying opensbi.bin to 0x40f00000 (263652 bytes)...
[########################################]
Executing booted program at 0x40f00000

--============= Liftoff! ===============--

OpenSBI v1.3
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : LiteX / VexRiscv-SMP
Platform Features         : medeleg
Platform HART Count       : 8
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 100000000Hz
Platform Console Device   : litex_uart
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : ---
Platform Shutdown Device  : ---
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x40f00000
Firmware Size             : 376 KB
Firmware RW Offset        : 0x40000
Firmware RW Size          : 120 KB
Firmware Heap Offset      : 0x52000
Firmware Heap Size        : 48 KB (total), 3 KB (reserved), 8 KB (used), 36 KB (free)
Firmware Scratch Size     : 4096 B (total), 452 B (used), 3644 B (free)
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*,1*,2*,3*,4*,5*,6*,7*
Domain0 Region00          : 0xf0018000-0xf001bfff M: (I,R,W) S/U: ()
Domain0 Region01          : 0xf0010000-0xf0017fff M: (I,R,W) S/U: ()
Domain0 Region02          : 0x40f40000-0x40f5ffff M: (R,W) S/U: ()
Domain0 Region03          : 0x40f00000-0x40f3ffff M: (R,X) S/U: ()
Domain0 Region04          : 0x00000000-0xffffffff M: (R,W,X) S/U: (R,W,X)
Domain0 Next Address      : 0x40000000
Domain0 Next Arg1         : 0x40ef0000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : unknown
Boot HART Base ISA        : rv32ima
Boot HART ISA Extensions  : zicntr
Boot HART PMP Count       : 0
Boot HART PMP Granularity : 0
Boot HART PMP Address Bits: 0
Boot HART MHPM Count      : 0
Boot HART MIDELEG         : 0x00000222
Boot HART MEDELEG         : 0x0000b101
[    0.000000] Linux version 6.9.0 (michael@kebab) (riscv32-buildroot-linux-gnu-gcc.br_real (Buildroot 2025.08-rc2-9-gc53f5e78fc) 13.4.0, GNU ld (GNU Binutils) 2.43.1) #1 SMP Sat Aug 30 17:58:47 CEST 2025
[    0.000000] Machine model: berkeleylab_obsidian
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10003
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] earlycon: liteuart0 at I/O port 0x0 (options '')
[    0.000000] Malformed early option 'console'
[    0.000000] earlycon: liteuart0 at MMIO 0xf0001000 (options '')
[    0.000000] printk: legacy bootconsole [liteuart0] enabled
[    0.000000] OF: reserved mem: OVERLAP DETECTED!
[    0.000000] mmode_resv1@40f00000 (0x40f00000--0x40f40000) overlaps with opensbi@40f00000 (0x40f00000--0x40f80000)
[    0.000000] OF: reserved mem: OVERLAP DETECTED!
[    0.000000] opensbi@40f00000 (0x40f00000--0x40f80000) overlaps with mmode_resv0@40f40000 (0x40f40000--0x40f60000)
[    0.000000] OF: reserved mem: 0x40f00000..0x40f3ffff (256 KiB) nomap non-reusable mmode_resv1@40f00000
[    0.000000] OF: reserved mem: 0x40f00000..0x40f7ffff (512 KiB) map non-reusable opensbi@40f00000
[    0.000000] OF: reserved mem: 0x40f40000..0x40f5ffff (128 KiB) nomap non-reusable mmode_resv0@40f40000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000040efffff]
[    0.000000]   node   0: [mem 0x0000000040f00000-0x0000000040f5ffff]
[    0.000000]   node   0: [mem 0x0000000040f60000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions aim
[    0.000000] riscv: ELF capabilities aim
[    0.000000] percpu: Embedded 11 pages/cpu s22932 r0 d22124 u45056
[    0.000000] Kernel command line: console=liteuart earlycon=liteuart,0xf0001000 rootwait root=/dev/mmcblk0p2
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] Memory: 509860K/524288K available (6676K kernel code, 579K rwdata, 1040K rodata, 258K init, 249K bss, 14428K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:   RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 32 local interrupts mapped
[    0.000000] riscv: providing IPIs using SBI IPI extension
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x39a85c4118, max_idle_ns: 881590405314 ns
[    0.000016] sched_clock: 64 bits at 125MHz, resolution 8ns, wraps every 4398046511100ns
[    0.009649] Console: colour dummy device 80x25
[    0.013185] Calibrating delay loop (skipped), value calculated using timer frequency.. 250.00 BogoMIPS (lpj=1250000)
[    0.023672] pid_max: default: 32768 minimum: 301
[    0.030352] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.036789] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.070357] ASID allocator using 9 bits (512 entries)
[    0.076636] rcu: Hierarchical SRCU implementation.
[    0.080470] rcu:   Max phase no-delay instances is 1000.
[    0.096329] smp: Bringing up secondary CPUs ...
[    0.112853] smp: Brought up 1 node, 2 CPUs
[    0.127451] devtmpfs: initialized
[    0.164604] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.173671] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.197631] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.209045] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.296782] cpu1: Ratio of byte access time to unaligned word access is 0.00, unaligned accesses are slow
[    0.389028] cpu0: Ratio of byte access time to unaligned word access is 0.00, unaligned accesses are slow
[    0.411633] platform soc: Fixed dependency cycle(s) with /soc/interrupt-controller@f0c00000
[    0.425596] platform soc: Fixed dependency cycle(s) with /soc/interrupt-controller@f0c00000
[    0.475294] pps_core: LinuxPPS API ver. 1 registered
[    0.479024] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.488818] PTP clock support registered
[    0.495209] FPGA manager framework
[    0.509346] clocksource: Switched to clocksource riscv_clocksource
[    0.732896] NET: Registered PF_INET protocol family
[    0.739527] IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.760277] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.767582] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.775539] TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.783714] TCP bind hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.791223] TCP: Hash tables configured (established 4096 bind 4096)
[    0.797050] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.803319] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.825001] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.836142] io scheduler mq-deadline registered
[    0.839737] io scheduler kyber registered
[    0.843734] io scheduler bfq registered
[    0.854866] riscv-plic f0c00000.interrupt-controller: mapped 32 interrupts with 2 handlers for 4 contexts.
[    0.881862] LiteX SoC Controller driver initialized
[    2.188579] f0001000.serial: ttyLXU0 at MMIO 0x0 (irq = 12, base_baud = 0) is a liteuart
[    2.200950] printk: legacy console [liteuart0] enabled
[    2.200950] printk: legacy console [liteuart0] enabled
[    2.210869] printk: legacy bootconsole [liteuart0] disabled
[    2.210869] printk: legacy bootconsole [liteuart0] disabled
[    2.253073] liteeth f0002000.mac eth0: irq 13 slots: tx 2 rx 2 size 2048
[    2.261916] i2c_dev: i2c /dev entries driver
[    2.286208] NET: Registered PF_INET6 protocol family
[    2.307321] Segment Routing with IPv6
[    2.311456] In-situ OAM (IOAM) with IPv6
[    2.315245] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.319778] litex-mmc f0004800.mmc: LiteX MMC controller initialized.
[    2.330547] NET: Registered PF_PACKET protocol family
[    2.573489] clk: Disabling unused clocks
[    2.582812] Waiting for root device /dev/mmcblk0p2...
[    2.629711] mmc0: new SDHC card at address e624
[    2.641982] mmcblk0: mmc0:e624 SS16G 14.8 GiB
[    2.664809]  mmcblk0: p1 p2 p3
[    3.179639] EXT4-fs (mmcblk0p2): orphan cleanup on readonly fs
[    3.185424] EXT4-fs (mmcblk0p2): mounted filesystem 4faeae9e-89e3-4fc6-a016-b3226365a9f3 ro with ordered data mode. Quota mode: disabled.
[    3.197492] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    3.210392] devtmpfs: mounted
[    3.213800] Freeing unused kernel image (initmem) memory: 252K
[    3.218437] Kernel memory protection not selected by kernel config.
[    3.225146] Run /sbin/init as init process
[    9.492156] EXT4-fs (mmcblk0p2): re-mounted 4faeae9e-89e3-4fc6-a016-b3226365a9f3 r/w. Quota mode: disabled.
[   14.862908] EXT4-fs (mmcblk0p3): recovery complete
[   14.880100] EXT4-fs (mmcblk0p3): mounted filesystem 8ec2d4cf-11c8-48fd-89dc-2a062890a55e r/w with ordered data mode. Quota mode: disabled.
Saving 256 bits of non-creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting network: OK
Starting crond: OK
crond[94]: crond (busybox 1.37.0) started, log level 8

Starting dropbear sshd: OK

Welcome to Buildroot
buildroot login:

```

## Customizing the linux image
The linux image has been slightly customized from the litex initial configuration

  * Include dropbear ssh server
  * Include `micropython` and the `dhrystone-opt` benchmark
  * Initialize network interface with static IP: 192.168.1.50/24
  * Mounting options and IP settings are customized under:
    `linux-on-litex-vexriscv/buildroot/board/litex_vexriscv/rootfs_overlay`. Look at
    the `fstab` and `network/interfaces` config files in this directory
  * Mount the `mmcblk0p1` partition under `/boot` and the `mmcblk0p2` partition under `/root`.
    This is also the home directory of the root user

to customize the linux image, install buildroot, then:

```
cd buildroot
make BR2_EXTERNAL=../linux-on-litex-vexriscv/buildroot/ obsidian_a35_defconfig

make menuconfig

# customize buildroot (packages, system settings, etc)

make

# if the build succeeds, a new rootfs.cpio image appears, which can be copied on the SD card:

ll output/images/rootfs.cpio
  5.9M Aug 31 00:35 rootfs.cpio
```


[> Intro
--------

This project is an experiment to run Linux with [VexRiscv-SMP](https://github.com/SpinalHDL/VexRiscv) CPU, a 32-bits Linux Capable RISC-V CPU written in [Spinal HDL](https://github.com/SpinalHDL/SpinalHDL).  [LiteX](https://github.com/enjoy-digital/litex) is used to create the SoC around the VexRiscv-SMP CPU and provides the infrastructure and peripherals (LiteDRAM, LiteEth, LiteSDCard, etc...). All the components used to create the SoC are open-source and the flexibility of Spinal HDL/LiteX allow targeting easily very various FPGA devices/boards: Xilinx, Intel, Lattice, Microsemi, Efinix FPGAs are tested with very various configuration: SDRAM/DDR/DDR2/DDR3/DDR4 or HyperRAM RAMs, RMII/MII/RGMII/1000BASE-X Ethernet PHYs,  SDCard (in SPI or SD mode), SATA, PCIe, etc...

On Lattice ECP5 FPGAs, the [open source toolchain](https://github.com/SymbiFlow/prjtrellis) even allows creating full open-source SoC with open-source cores **and** toolchain!

This project demonstrates **how high level HDLs framework like Spinal HDL, LiteX can enable new possibilities and complement each other**. Results shown here are the results of a productive collaboration between various open-source communities.

[> Demo
----------

<p align="center"><img src="https://user-images.githubusercontent.com/1450143/156186177-ea06bddc-87b2-4d27-af60-d6d7f3f2929b.png" width="800"></p>

https://user-images.githubusercontent.com/1450143/156186677-87c40a39-2cf5-4ae0-9138-9d2aa0693ab6.mp4

[> Supported boards
-------------------
All boards supported in [LiteX-Boards](https://github.com/litex-hub/litex-boards) with...:

 - Enough FPGA logic to fit VexRiscv-SMP + LiteX SoC.
 - 32MB of RAM (Reduced to 8MB when rootfs can be put on a SDCard).
 - A UART.

... could run this project.

The board support is directly imported from LiteX-Boards and the configuration is just adapted for the project in `make.py`.

The current list of boards that have been tested and are supported can be obtained by running `./make.py --help`:

    ├── acorn
    ├── acorn_pcie
    ├── aesku40
    ├── alveo_u250
    ├── alveo_u280
    ├── arty
    ├── arty_a7
    ├── arty_s7
    |── ax7020
    ├── butter_stick
    ├── cam_link4k
    ├── colorlight_i5
    ├── de0nano
    ├── de10nano
    ├── de1so_c
    ├── decklink_quad_hdmirecorder
    ├── ecpix5
    ├── genesys2
    ├── hadbadge
    ├── hseda_xc7a35t
    ├── icesugar_pro
    ├── kc705
    ├── kcu105
    ├── konfekt
    ├── mini_spartan6
    ├── mnt_rkx7
    ├── ne_tv2
    ├── nexys4ddr
    ├── nexys_video
    ├── noir
    ├── orange_crab
    ├── pipistrello
    ├── qmtech_5cefa2
    ├── qmtech_ep4ce15
    ├── qmtech_ep4ce55
    ├── qmtech_wu_kong
    ├── schoko
    ├── sds1104xe
    ├── sipeed_tang_nano_20k
    ├── sipeed_tang_primer_20k
    ├── stlv7325
    ├── stlv7325_v2
    ├── titanium_ti60f225dev_kit
    ├── trellis_board
    ├── trion_t120bga576dev_kit
    ├── ulx3s
    ├── ulx4m_ld_v2
    ├── vc707
    ├── versa_ecp5
    ├── xcu1525
    ├── zcu104


Adding support for another board from LiteX-Boards satisfying the requirements should only be a matter of adding a few lines to `make.py`.

> **Note:** Avalanche support can be found in [RISC-V - Getting Started Guide](https://risc-v-getting-started-guide.readthedocs.io/en/latest/linux-avalanche.html) thanks to [Antmicro](https://antmicro.com).

> **Note:** On FPGA without distributed ram (as Cyclone IV), consider using the --without-out-of-order-decoder option to reduce area.

[> Prerequisites
----------------
```sh
$ sudo apt install build-essential device-tree-compiler wget git python3-setuptools
$ git clone https://github.com/litex-hub/linux-on-litex-vexriscv
$ cd linux-on-litex-vexriscv
```

[> Pre-built Bitstreams and Linux/OpenSBI images
------------------------------------------------

Pre-built bistreams for the common boards and pre-built Linux images can be found [here](https://github.com/litex-hub/linux-on-litex-vexriscv/issues/164) and will get you started quickly and easily without the need to compile anything.

[> Installing LiteX
-------------------
```sh
$ wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
$ chmod +x litex_setup.py
$ ./litex_setup.py --init --install --user (--user to install to user directory)
```
For more information, please visit: https://github.com/enjoy-digital/litex/wiki/Installation

[> Installing a RISC-V toolchain
--------------------------------
```sh
$ wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
$ tar -xvf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
$ export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
```

[> Installing SBT (Only required for custom CPU configs)
--------------------------------
Some regular VexRiscv-smp configuration are already pregenerated,
but for others, it need to run som SpinalHDL hardware generation, which require sbt.

Please visit: https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html#Installing+sbt+on+Linux

[> Installing Verilator (only needed for simulation)
----------------------------------------------------
```sh
$ sudo apt install verilator
$ sudo apt install libevent-dev libjson-c-dev
```

Check that the installed verilator version is >= 4.2xx. If not, you will have to compile it from sources.

[> Installing OpenOCD (only needed for hardware test)
-----------------------------------------------------
```sh
$ sudo apt install libtool automake pkg-config libusb-1.0-0-dev
$ git clone https://github.com/ntfreak/openocd.git
$ cd openocd
$ ./bootstrap
$ ./configure --enable-ftdi
$ make
$ sudo make install
```

[> Running the LiteX simulation
-------------------------------
You need to extract linux_???.zip from https://github.com/litex-hub/linux-on-litex-vexriscv/issues/164 into the images folder first, then :
```sh
$ ./sim.py
```
You should see Linux booting and be able to interact with it:
```
        __   _ __      _  __
       / /  (_) /____ | |/_/
      / /__/ / __/ -_)>  <
     /____/_/\__/\__/_/|_|

 (c) Copyright 2012-2019 Enjoy-Digital
 (c) Copyright 2012-2015 M-Labs Ltd

 BIOS built on May  2 2019 18:58:54
 BIOS CRC passed (97ea247b)

--============ SoC info ================--
CPU:       VexRiscv @ 1MHz
ROM:       32KB
SRAM:      4KB
MAIN-RAM:  131072KB

--========= Peripherals init ===========--

--========== Boot sequence =============--
Booting from serial...
Press Q or ESC to abort boot completely.
sL5DdSMmkekro
Timeout
Executing booted program at 0x20000000
--============= Liftoff! ===============--
VexRiscv Machine Mode software built May  3 2019 19:33:43
--========== Booting Linux =============--
[    0.000000] No DTB passed to the kernel
[    0.000000] Linux version 5.0.9 (florent@lab) (gcc version 8.3.0 (Buildroot 2019.05-git-00938-g75f9fcd0c9)) #1 Thu May 2 17:43:30 CEST 2019
[    0.000000] Initial ramdisk at: 0x(ptrval) (8388608 bytes)
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000c0000000-0x00000000c7ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000c0000000-0x00000000c7ffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000c0000000-0x00000000c7ffffff]
[    0.000000] elf_hwcap is 0x1100
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: mem=128M@0x40000000 rootwait console=hvc0 root=/dev/ram0 init=/sbin/init swiotlb=32
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 119052K/131072K available (1957K kernel code, 92K rwdata, 317K rodata, 104K init, 184K bss, 12020K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x114c1bade8, max_idle_ns: 440795203839 ns
[    0.000155] sched_clock: 64 bits at 75MHz, resolution 13ns, wraps every 2199023255546ns
[    0.001515] Console: colour dummy device 80x25
[    0.008297] printk: console [hvc0] enabled
[    0.009219] Calibrating delay loop (skipped), value calculated using timer frequency.. 150.00 BogoMIPS (lpj=300000)
[    0.009919] pid_max: default: 32768 minimum: 301
[    0.016255] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.016802] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.044297] devtmpfs: initialized
[    0.061343] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.061981] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.117611] clocksource: Switched to clocksource riscv_clocksource
[    0.251970] Unpacking initramfs...
[    2.005474] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    2.178440] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    2.178909] io scheduler mq-deadline registered
[    2.179271] io scheduler kyber registered
[    3.031140] random: get_random_bytes called from init_oops_id+0x4c/0x60 with crng_init=0
[    3.043743] Freeing unused kernel memory: 104K
[    3.044070] This architecture does not have kernel memory protection.
[    3.044472] Run /init as init process
mount: mounting tmpfs on /dev/shm failed: Invalid argument
mount: mounting tmpfs on /tmp failed: Invalid argument
mount: mounting tmpfs on /run failed: Invalid argument
Starting syslogd: OK
Starting klogd: OK
Initializing random number generator... [    4.374589] random: dd: uninitialized urandom read (512 bytes read)
done.
Starting network: ip: socket: Function not implemented
ip: socket: Function not implemented
FAIL


Welcome to Buildroot
buildroot login: root
login[48]: root login on 'hvc0'
# help
Built-in commands:
------------------
  . : [ [[ alias bg break cd chdir command continue echo eval exec
  exit export false fg getopts hash help history jobs kill let
  local printf pwd read readonly return set shift source test times
  trap true type ulimit umask unalias unset wait
#
```

[> Running on hardware
----------------------
### Build the FPGA bitstream (optional)
**The prebuilt bitstreams for the supported boards are provided**, so you can just use them for quick testing, if you want to rebuild the bitstreams you will need to install the toolchain for your FPGA:

| FPGA family       |      Toolchain        |
|-------------------|-----------------------|
| Xilinx Ultrascale |      Vivado           |
| Xilinx 7-Series   |   Vivado/SymbiFlow*   |
| Xilinx Spartan6   |        ISE            |
| Lattice ECP5      | Yosys+Trellis+Nextpnr |
| Altera Cyclone4   |    Quartus Prime      |

Once installed, build the bitstream with:
```sh
$ ./make.py --board=XXYY --cpu-count=X --build
```

> **Note:** \*=to select a different toolchain use the `--toolchain` option, i.e.:
> ```
> ./make.py --board=arty --toolchain=symbiflow --build
> ```

### Load the FPGA bitstream
To load the bitstream to you board, run:
```sh
$ ./make.py --board=XXYY --cpu-count=X --load
```
> **Note**: If you are using a Versa board, you will need to change J50 to bypass the iSPclock. Re-arrange the jumpers to connect pins 1-2 and 3-5 (leaving one jumper spare). See p19 of the Versa Board user guide.

### Load the Linux images over Serial
All the boards support Serial loading of the Linux images and this is the only way to load them when the board does not have others communications interfaces or storage capability.

To load the Linux images over Serial, use the [litex_term](https://github.com/enjoy-digital/litex/blob/master/litex/tools/litex_term.py) terminal/tool provided by LiteX and run:
```sh
$ litex_term --images=images/boot.json /dev/ttyUSBX (--safe : In case of CRC Error, slower but should always work)
```
The images should load and you should see Linux booting :)

> **Note**: litex_term is automatically installed with LiteX.

> **Note**: By default baudrate is set to 115200 bauds. You can use `--uart-baudrate` argument of `make.py` to increase it on the board and use `--speed` argument of `litex_term` to reflect the change. This is useful to increase upload speed when binaries can only be uploaded over Serial.

> **Note:** Since on some boards JTAG/Serial is shared, when you will run litex_term after loading the board, the BIOS serialboot will already have timed out. You will need to press Enter, see if you have the BIOS prompt and type *reboot*.

Since loading over Serial is working for all boards, **this is the recommended way to do initial tests** even if your board has more capabilities.

### Load the Linux images over Ethernet
For boards with Ethernet support, the Linux images can be loaded over TFTP. You need to copy the files from *images* directory to your TFTP root directory. The default Local IP/Remote IP are 192.168.1.50/192.168.1.100 but you can change it with the *--local-ip* and *--remote-ip* arguments.

Once the bistream is loaded, the board you try to retrieve the files on the TFTP server. If not successful or if the boot already timed out when you see the BIOS prompt, you can retry with the *netboot* command.

The images will be loaded to RAM and you should see Linux booting :)

### Load the Linux images to SDCard
For boards with SDCard support, the Linux images can be loaded from it. You need to copy the files from *images* directory to your SDCard root directory (with a FAT partition).

The images will be loaded to RAM and you should see Linux booting :)

> **Note**: For more information about the possible ways to load application code to the CPU with LiteX, please have a look at the LiteX's [wiki](https://github.com/enjoy-digital/litex/wiki/Load-Application-Code-To-CPU).

### Configure/Use the peripherals
Please visit the [HOWTO](https://github.com/litex-hub/linux-on-litex-vexriscv/blob/master/HOWTO.md) document to learn how to configure and use the peripherals from Linux.

[> Generating the Linux binaries (optional)
-------------------------------------------
```sh
$ git clone http://github.com/buildroot/buildroot
$ cd buildroot
$ make BR2_EXTERNAL=../linux-on-litex-vexriscv/buildroot/ litex_vexriscv_defconfig
$ make
```
The binaries are located in *output/images/* and *images/*.

[> Generating the Linux binaries with USB host support (optional)
-----------------------------------------------------------------
```sh
$ git clone http://github.com/buildroot/buildroot
$ cd buildroot
$ make BR2_EXTERNAL=../linux-on-litex-vexriscv/buildroot/ litex_vexriscv_usbhost_defconfig
$ make
```
The binaries are located in *output/images/* and *images/*.

[> Generating the OpenSBI binary (optional / part of the buildroot build sequence)
-------------------------------------------
```sh
$ git clone https://github.com/litex-hub/opensbi --branch 1.3.1-linux-on-litex-vexriscv
$ cd opensbi
$ make CROSS_COMPILE=riscv-none-embed- PLATFORM=litex/vexriscv
```

The binary will be located at *build/platform/litex/vexriscv/firmware/fw_jump.bin*.

[> Generating the VexRiscv Linux variant (optional)
---------------------------------------------------

If the VexRiscv configuration you ask isn't already generated, you will need to install java and SBT on your machine to enable their local on demande generation.

To install java and SBT see Install VexRiscv requirements: https://github.com/enjoy-digital/VexRiscv-verilog#requirements

[> Udev rules (optional)
----------------------------
Not needed but can make loading/flashing bitstreams easier:
```sh
$ git clone https://github.com/litex-hub/litex-buildenv-udev
$ cd litex-buildenv-udev
$ make install
$ make reload
```
