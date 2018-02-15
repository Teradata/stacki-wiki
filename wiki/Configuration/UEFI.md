## UEFI (oof-ee)

One of the most frequent questions we get is, "Can I do UEFI?" (We pronounce it "oofee" for the record because it sounds funny.)

The answer is "Yes," and in Stacki 5.0 you don't have to do anything (see the caveat below). If your machines are set to use UEFI mode in the BIOS and are set to PXE first, they'll install UEFI correctly, and you'll be in compliance with whatever corporate gods have mandated on high that you use UEFI. No lightning for you.

So Legacy BIOS mode or UEFI Bios mode, both work fine, even mixed. If your bios is setup correctly and the backends are set to PXE first, it should just work.

***Caveat:*** UEFI and Stack 5.0

Really the issue is UEFI and Redhat. They shipped a bad grub2-efi rpm with the original 7.4 release. Which means you need an updates pallet. You can go to [Creating-Simple-Pallets](Creating-Simple-Pallets) to learn how to create your own updates ISO, or download the one we are distributing that has that fix in it.

The stackios ISO already has the grub2-efi fix in it.

***Caveat 2:*** UEFI and custom partitioning

When a node boots in UEFI mode, it requires an MSDOS FAT32 partition mounted on `/boot/efi` to be present.

The default partitioning scheme checks for UEFI mode, and includes the `/boot/efi` partition.

However, when custom partitioning is used, it's the responsibility of the system administrator to include the `/boot/efi` partition. The minimum/recommended size requirement of this partition is 256M/512M.
