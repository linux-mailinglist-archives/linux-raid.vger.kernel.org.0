Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97745A4026
	for <lists+linux-raid@lfdr.de>; Mon, 29 Aug 2022 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiH1XYh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 28 Aug 2022 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH1XYg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 28 Aug 2022 19:24:36 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E45D13D
        for <linux-raid@vger.kernel.org>; Sun, 28 Aug 2022 16:24:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n202so5320070iod.6
        for <linux-raid@vger.kernel.org>; Sun, 28 Aug 2022 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Q95MHTm0gbh1hhT4GA+7oAjMwtn4MXOTymj8qNmmL6g=;
        b=hhrq4nqGJ5IxaesTzNhiz62tA4KSNIResI1YNE8dnKSFpQLRzftASkAZV64V2lZPpC
         YrqUd/0eAzHl05bdZWj8mINaWws3FqeCASMfh4CWViBpD05twYAOTWW5M/mHEigXKBLr
         qgmFm/+NYNeusLSe+XJtJNen67RYIqh9hBdl+wFpLMCu+ODJzsne0U/KFoG0rXG4zJnu
         xCSB1+ILENCpdGLZ7BRtad3R1Nom8y9c9HX2LoqxbX4xSQPBMPBm+CVlyoTXuOy9MZ3r
         0GmoXNNOZf532aW8TUbc37ZSHL6g0aCzNq/8p14gB3ZisELHRQHt3iISTk7hc9k/0EOX
         6I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Q95MHTm0gbh1hhT4GA+7oAjMwtn4MXOTymj8qNmmL6g=;
        b=gCx+QBHAI3eZkMtQphWYQd4R5+3UsWQqYre3d/XM/cLNz3iklmvY1C7RJo1npSiyhk
         qh9/m7XPboaEeuqJ8wlnRLL8oA3svYzbdDj/8iF9WPe2Mz1aD1WvG6bnf4dfFbQdcUHX
         dEtHL4R80QvLy/v+W8/5FZgINXxa9PvLyyQcm+AtMk/5f4YnCtHKa3avHyx3oOnYvQos
         wLmj8gGmv+IYjcAkwiR3SLkdWMmy1UCJSZNIz/2YPafZzVz/Q3lgPs5nzGMijrr8CIOh
         EIHAlzJvSQOGABDl/bA9Im1wSVCvQJjJfN6jp0l/VjiIFv24BECvBV5MgeyL7V6wxfFa
         y7Bg==
X-Gm-Message-State: ACgBeo0hK/U/JEonIhPg+LY1Ql2aGn1GF5ide4oSw/Qe/OAyGHbtaBdB
        cUDDtndLH+6/WGtaY3ntfDKizT0iuDomnEuzt9g/gNQNcm2h
X-Google-Smtp-Source: AA6agR7uRuGoQPkkcIfV1ff6wj28n1F28Bfs2PNoW48DRePRZdvJUGRxYOcl9mqNYsPI5vKo424y5AQpeZk0vsANrys=
X-Received: by 2002:a05:6638:1914:b0:346:c2f5:632f with SMTP id
 p20-20020a056638191400b00346c2f5632fmr9159531jal.296.1661729072092; Sun, 28
 Aug 2022 16:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAKAPSkJLd836Zp3xU=zSOHg3qcEmi29Y2qOwWzeAFaDp+dNTvg@mail.gmail.com>
 <70e2ae22-bbba-77a4-c9bc-4c02752f4cb7@youngman.org.uk> <dc24b476-2f0a-8406-f1c0-e33b5b0eb388@youngman.org.uk>
 <4a414fc6-2666-302f-8d3d-08eb7a2986fc@turmel.org> <CAKAPSkJAQYsec-4zzcePbkJ7Ee0=sd_QvHj4Stnyineq+T8BXw@mail.gmail.com>
 <25355.47062.897268.3355@quad.stoffel.home> <ee66bcbe-0a9b-57a6-439f-72cc46debe48@turmel.org>
 <25355.50871.743993.605394@quad.stoffel.home>
In-Reply-To: <25355.50871.743993.605394@quad.stoffel.home>
From:   Peter Sanders <plsander@gmail.com>
Date:   Sun, 28 Aug 2022 19:24:21 -0400
Message-ID: <CAKAPSkLQ4K1R_aD1=iURTFQmm_DXDMr=wx+VDET7DOUy+6Zp_Q@mail.gmail.com>
Subject: Re: RAID 6, 6 device array - all devices lost superblock
To:     John Stoffel <john@stoffel.org>
Cc:     Phil Turmel <philip@turmel.org>,
        Wols Lists <antlists@youngman.org.uk>,
        NeilBrown <neilb@suse.com>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Phil,

fstab from the working config -

# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda1 during installation
UUID=3D50976432-b750-4809-80ac-3bbdd2773163 /               ext4
errors=3Dremount-ro 0       1
# /home was on /dev/sda6 during installation
UUID=3Deb93a2c4-0190-41fa-a41d-7a5966c6bc47 /home           ext4
defaults        0       2
# /var was on /dev/sda5 during installation
UUID=3Dd1aa6d1f-3ee9-48a8-9350-b15149f738c4 /var            ext4
defaults        0       2
/dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0
/dev/sr1        /media/cdrom1   udf,iso9660 user,noauto     0       0
# raid array
/dev/md0    /mnt/raid6    ext4    defaults    0    2

No LVM, one large EXT4 partition

I have several large files ( NEF and various mpg files) I can identify
and have backup copies available.

I have the overlays created. 300G for each of the six drives.

- Peter

On Sun, Aug 28, 2022 at 3:49 PM John Stoffel <john@stoffel.org> wrote:
>
> >>>>> "Phil" =3D=3D Phil Turmel <philip@turmel.org> writes:
>
> Phil> Pssst! John,
> Phil> All of my comments were attributed to Peter by your mail client. ):
>
> Yeah... sometimes my mail reader gets confused when it cites previous
> emails.  I shoudl probably just drop to > only from now on.
>
>
> Phil> On 8/28/22 14:45, John Stoffel wrote:
> >>>>>>> "Peter" =3D=3D Peter Sanders <plsander@gmail.com> writes:
> >>
> Peter> It was set up on the device level, not partitions.  (I remember
> Peter> getting some advice on the web that device was better than
> Peter> partition... Yay for internet advice)
> >>
> >> Yeah, this is NOT good advice.  Generally systems will not destroy
> >> existing partition tables, but if they see an empty (to them)
> >> disk... all bets are off.
> >>
> Peter> I'm surveying my other disks to see what I have available to do
> Peter> the overlay attempt.
> >>
> >> They're small.  They are sparse files, so just follow the
> >> instructions.
> >>
> Peter> What are the size of the overlay files going to end up being?
> >>
> >> Not too large, but it depends on how much data is written to the
> >> overlayfs to get your data back.  If you follow the instructions on
> >> this page:
> >>
> >> https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID
> >>
> >> It says to create a sparse file for each disk that is 1% of the size
> >> of the disk.  This can add up... you might need to add a blank disk to
> >> your system to hold these.
> >>
> >> In this case, if you think you know which order the disks were in, you
> >> could try to create the RAID6 array (but only using the overlayfs
> >> devices!!!!!)  I can't stress this enough.
> >>
> >>
> Peter> I did run into UEFI vs AHCI issues early in the process.. they
> Peter> are all set to non-UEFI.
> >>
> >> That's good.
> >>
> Peter> OS update was onto a new SSD...
> >>
> >> Ok.  Do you have the old OS disk around by any chance?  That might
> >> give some pointers to how the disks are setup..  You could look in
> >> /var/tmp/initrd/... for old mdadm.conf files, which might give more
> >> details.
> >>
> Peter> On Sun, Aug 28, 2022, 12:47 Phil Turmel <philip@turmel.org> wrote:
> >>
> Peter> Hi Peter, et al,
> >>
> Peter> On 8/28/22 05:54, Wols Lists wrote:
> >>>> On 28/08/2022 10:14, Wols Lists wrote:
> >>>>> Currently I have no /dev/md* devices.
> >>>>> I have access to the old mdadm.conf file - have tried assembling wi=
th
> >>>>> it, with the default mdadm.conf, and with no mdadm.conf file in /et=
c
> >>>>> and /etc/mdadm.
> >>>>>
> >>>>> It looks like the drives weren't partitioned :-( I think you're int=
o
> >>>>> forensics.
> >>
> Peter> It is too soon to say this.  The supplied mdadm.conf file does not
> Peter> contain specific partition information.  It is possible the partit=
ion
> Peter> tables have just been wiped.
> >>
> >>>> Whoops - my system froze while I was originally writing my reply, an=
d I
> >>>> forgot to put this into my rewrite ...
> >>>>
> >>>> Look up overlays in the wiki. I've never done it myself, but a fair =
few
> >>>> people have said the instructions worked a treat.
> >>>>
> >>>> You're basically making the drives read-only (all writes get dumped =
into
> >>>> the overlay file), and then re-creating the array over the top, so y=
ou
> >>>> can test whether you got it right. If you don't, you just ditch the
> >>>> overlays and start again, if you did get it right you can recreate t=
he
> >>>> array for real.
> >>>>
> >>>> Cheers,
> >>>> Wol
> >>
> Peter> On 8/28/22 11:10, John Stoffel wrote:
> >>>>>>>>> "Peter" =3D=3D Peter Sanders <plsander@gmail.com> writes:
> >>>>
> Peter> have a RAID 6 array, 6 devices.  Been running it for years without=
 much issue.
> Peter> Had hardware issues with my system - ended up replacing the
> Peter> motherboard, video card, and power supply and re-installing the OS
> Peter> (Debian 11).
> >>>>
> >>>> Can you give us details on the old vs new motherboard/cpu?  It might
> >>>> be that you need to tweak the BIOS of the motherboard to expose the
> >>>> old SATA formats as well.
> >>>>
> >>>> Did you install debian onto a fresh boot disk?  Is your BIOS setup t=
o
> >>>> only do the new form of booting from UEFI devices, so maybe check yo=
ur
> >>>> BIOS settings that the data drives are all in AHCI mode, or possibly
> >>>> even in IDE mode.  It all depends on how old the original hardware
> >>>> was.
> >>>>
> >>>> I just recenly upgraded from a 2010 MB/CPU combo and I had to tweak
> >>>> the BIOS defaults to see my disks.  I guess I should do a clean
> >>>> install from a blank disk, but I wanted to minimize downtime.
> >>
> Peter> It is important to end up in AHCI mode on all MOBO ports.  If not =
set
> Peter> that way now, please change them.
> >>
> >>>> Wols has some great advice here, and I heartily recommend that you u=
se
> >>>> overlayfs when doing your testing.  Check the RAID WIKI for
> >>>> suggestions.
> >>
> Peter> Concur.
> >>
> >>>> And don't panic!  Your data is probably there, but just missing the
> >>>> super blocks or partition tables.
> >>
> Peter> Both, I suspect.
> >>
> Peter> On 8/27/22 22:00, Peter Sanders wrote:
> >>>> lsdrv ------------------------
> >>>> PCI [nvme] 01:00.0 Non-Volatile memory controller: Phison Electronic=
s
> >>>> Corporation E12 NVMe Controller (rev 01)
> >>>> =E2=94=94nvme nvme0 PCIe SSD                                 {211129=
25606047}
> >>>>   =E2=94=94nvme0n1 238.47g [259:0] Partitioned (dos)
> >>>>    =E2=94=9Cnvme0n1p1 485.00m [259:1] ext4 {f38776ac-1ce9-4fc8-ba50-=
94844b9f504e}
> >>>>    =E2=94=82=E2=94=94Mounted as /dev/nvme0n1p1 @ /boot
> >>>>    =E2=94=9Cnvme0n1p2 1.00k [259:2] Partitioned (dos)
> >>>>    =E2=94=9Cnvme0n1p5 60.54g [259:3] ext4 {5ee1c3c0-3a05-466c-9f98-f=
5807c8d813b}
> >>>>    =E2=94=82=E2=94=94Mounted as /dev/nvme0n1p5 @ /
> >>>>    =E2=94=9Cnvme0n1p6 93.13g [259:4] ext4 {9064169f-4fe3-4836-a906-2=
8c1b445cdff}
> >>>>    =E2=94=82=E2=94=94Mounted as /dev/nvme0n1p6 @ /var
> >>>>    =E2=94=9Cnvme0n1p7 37.00m [259:5] ext4 {25e161ad-94a0-4298-afaf-1=
8e2433766ee}
> >>>>    =E2=94=9Cnvme0n1p8 82.89g [259:6] ext4 {ac874071-d759-4d33-b32f-8=
3272f3eacd9}
> >>>>    =E2=94=82=E2=94=94Mounted as /dev/nvme0n1p8 @ /home
> >>>>    =E2=94=94nvme0n1p9 1.41g [259:7] swap {02cef84b-9a9d-4a0a-973c-fd=
a1a78c533c}
> >>>> PCI [pata_jmicron] 26:00.1 IDE interface: JMicron Technology Corp.
> >>>> JMB368 IDE controller (rev 10)
> >>>> =E2=94=94scsi 0:0:0:0 MAD DOG  LS-DVDRW TSH652M {MAD_DOG_LS-DVDRW_TS=
H652M}
> >>>>   =E2=94=94sr0 1.00g [11:0] Empty/Unknown
> >>>> PCI [ahci] 26:00.0 SATA controller: JMicron Technology Corp. JMB363
> >>>> SATA/IDE Controller (rev 10)
> >>>> =E2=94=94scsi 2:x:x:x [Empty]
> >>>> PCI [ahci] 2b:00.0 SATA controller: Advanced Micro Devices, Inc. [AM=
D]
> >>>> FCH SATA Controller [AHCI mode] (rev 51)
> >>>> =E2=94=9Cscsi 6:0:0:0 ATA      TOSHIBA HDWD130  {477ALBNAS}
> >>>> =E2=94=82=E2=94=94sda 2.73t [8:0] Partitioned (PMBR)
> >>>> =E2=94=94scsi 7:0:0:0 ATA      TOSHIBA HDWD130  {Y7211KPAS}
> >>>>   =E2=94=94sdc 2.73t [8:32] Partitioned (gpt)
> >>>> PCI [ahci] 2c:00.0 SATA controller: Advanced Micro Devices, Inc. [AM=
D]
> >>>> FCH SATA Controller [AHCI mode] (rev 51)
> >>>> =E2=94=9Cscsi 8:0:0:0 ATA      WDC WD30EZRX-00D {WD-WCC1T0668790}
> >>>> =E2=94=82=E2=94=94sdb 2.73t [8:16] Partitioned (gpt)
> >>>> =E2=94=9Cscsi 9:0:0:0 ATA      WDC WD30EZRX-00D {WD-WCC4N0091255}
> >>>> =E2=94=82=E2=94=94sdd 2.73t [8:48] Partitioned (gpt)
> >>>> =E2=94=9Cscsi 12:0:0:0 ATA      WDC WD30EZRX-00M {WD-WCAWZ2669166}
> >>>> =E2=94=82=E2=94=94sde 2.73t [8:64] Partitioned (gpt)
> >>>> =E2=94=94scsi 13:0:0:0 ATA      TOSHIBA HDWD130  {477ABEJAS}
> >>>>   =E2=94=94sdf 2.73t [8:80] Partitioned (gpt)
> >>
> Peter> Unfortunately, my lsdrv tool is not able to reconstruct missing pa=
rts.
> Peter> It is most useful when used on a *good* system and *saved* for hel=
p
> Peter> diagnosing *future* problems.
> >>
> Peter> Please share your /etc/fstab, and if you were using LVM on top of =
the
> Peter> raid, share your lvm.conf and anything in /etc/lvm/backup.
> >>
> Peter> Please describe the layer(s) that were on top of the raid.
> >>
> Peter> We need to help you look for signatures, and it helps to be select=
ive in
> Peter> what signatures to look for.
> >>
> Peter> After that, we will want to figure out your raid's chunk size and =
data
> Peter> offsets.  If you know of a particular large file (8MB or larger) t=
hat is
> Peter> sure to be in the raid and you happen to have a copy tucked away, =
then
> Peter> my findHash[1] tool might be able to definitively determine those
> Peter> values.  (Time consuming, though.)
> >>
> Peter> Meanwhile, don't do *anything* that would write to those drives.
> >>
> Peter> Phil
> >>
> Peter> [1] https://github.com/pturmel/findHash
> >>
>
