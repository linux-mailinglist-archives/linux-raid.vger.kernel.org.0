Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5261EE27
	for <lists+linux-raid@lfdr.de>; Mon,  7 Nov 2022 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiKGJDq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 7 Nov 2022 04:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGJDq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 7 Nov 2022 04:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94B167CA
        for <linux-raid@vger.kernel.org>; Mon,  7 Nov 2022 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667811762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6MeXp6XKoNnqHoeQPzduoNfvYIgeOWAzImBmsc0WYM=;
        b=NNJuer35m+XR6IcFx53rDZ8EKgTKaxQlObzcsRiV/ojC5venDChuCYieqlLAlot3MfpOzI
        IMVqTWJA7UiBHAE+zWE0dz5liN+6pcUc0iaRVjm8MUUD48YvdcMG6XYJqyVAUg8NdN7iiT
        r9YxkOmA+oRPoxldI4sqz+jlLWgZ26M=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-lT1JdBLLMKi_QC8Vjx-c4g-1; Mon, 07 Nov 2022 04:02:41 -0500
X-MC-Unique: lT1JdBLLMKi_QC8Vjx-c4g-1
Received: by mail-pf1-f197.google.com with SMTP id e12-20020a62aa0c000000b0056c12c0aadeso5305550pff.21
        for <linux-raid@vger.kernel.org>; Mon, 07 Nov 2022 01:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6MeXp6XKoNnqHoeQPzduoNfvYIgeOWAzImBmsc0WYM=;
        b=gAYZSi8Yod7x/RYcHcSZn1eoeBIxRwEMhG4ZPo2NFuJmmw/vWRAckfDkF4anAOwSSC
         LoL/1V9OrZMEETrNxIVahpBy2+GKsNw8b4WVb6YQGDeCLdHNGGTZ/ulWfAHZUW3cikDI
         WYmmD2j0wfYe1j/Z1vokcb8/p63cPiqmL4g6fSq5iPVkTwQI8cKkh2nrhUK6fMCsj21C
         iRZFCAujZIA579rF2l1tz7Pfj7kRBhI2PQQpSVBZrVlwE7dz46TX0uxAvEhiLz45sn45
         VGauz3dFnytmvplfhv38A4QmFSnQXs7TO6kc51Kv5oKQff40oTMfBk+5TN/pU5xYGWSW
         QGpA==
X-Gm-Message-State: ACrzQf0cLXVfS1HCVDSJXhnW2sADMrze9fDV3HlJhvPcR2w6dPpHc3it
        BnZTSb8815lSbtzbCJUbMdJ+yKpu+2g7De0saTnufbvVevB+w52AmiQGTAxnEMa0MTQ/OGsx5v3
        nwGfuKrun4Aj5Cam5VN5oLMTip0kXlEcmoQqSdg==
X-Received: by 2002:a17:90b:3446:b0:213:4990:fa2 with SMTP id lj6-20020a17090b344600b0021349900fa2mr69626862pjb.73.1667811760050;
        Mon, 07 Nov 2022 01:02:40 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5KXZZZw35gbK0ngxY0Si5UuU5WyqfIZkWGNole990QGB9ZACld+gAnJUXYIbis0c7bqYpBVXUPFJdFLnuRoBo=
X-Received: by 2002:a17:90b:3446:b0:213:4990:fa2 with SMTP id
 lj6-20020a17090b344600b0021349900fa2mr69626822pjb.73.1667811759640; Mon, 07
 Nov 2022 01:02:39 -0800 (PST)
MIME-Version: 1.0
References: <984d4620-e53f-0d1f-c61a-0485ea79e3f6@rechte.fr>
 <CALTww2-dKxDzTo6svQm+8wyo5UiY6v+amjoKjbhHQ4dVvDO67w@mail.gmail.com>
 <3466aa97-597e-0c8e-42df-eaf2e947348f@rechte.fr> <CALTww2_ug4Je4niEhqOHa6AS5cETRAK_qTJz+D6pP1Yr9ZjEBA@mail.gmail.com>
 <411fac2e-43b9-2fe9-05e3-d57c535595e3@rechte.fr>
In-Reply-To: <411fac2e-43b9-2fe9-05e3-d57c535595e3@rechte.fr>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 7 Nov 2022 17:02:28 +0800
Message-ID: <CALTww2_ge=DHFWg1617PgL+JJurjOWxmzjHMp3bLQ=iB=v90ZQ@mail.gmail.com>
Subject: Re: mdadm udev rule does not start mdmonitor systemd unit.
To:     =?UTF-8?B?TWFyYyBSZWNodMOp?= <marc4@rechte.fr>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Nov 7, 2022 at 4:48 PM Marc Recht=C3=A9 <marc4@rechte.fr> wrote:
>
> Le 07/11/2022 =C3=A0 09:30, Xiao Ni a =C3=A9crit :
> > On Sun, Nov 6, 2022 at 4:51 PM Marc Recht=C3=A9 <marc4@rechte.fr> wrote=
:
> >> Le 03/11/2022 =C3=A0 03:54, Xiao Ni a =C3=A9crit :
> >>> On Tue, Nov 1, 2022 at 8:27 PM Marc Recht=C3=A9 <marc4@rechte.fr> wro=
te:
> >>>> Hello,
> >>>>
> >>>> I have a udev rule and a md127 device with the properties as followi=
ng.
> >>>>
> >>>> The mdmonitor service is not started (no trace in systemd journal).
> >>>> However I can manually start the service.
> >>>>
> >>>> I just noticed that SYSTEMD_READY porperty is 0 which could explain =
this
> >>>> behaviour (according to man systemd.device) ?
> >>> Hi Marc
> >>>
> >>> For raid device, SYSTEMD_READY will be 1 when the change event happen=
s.
> >>> And for lvm volume, SYSTEMD_READY will be 1 when the add event happen=
s.
> >>> So you need to notice about his in your udev rule.
> >>>
> >>>> I don't know how to further debug.
> >>> You can add systemd.log_level=3Ddebug udev.log-priority=3Ddebug to yo=
ur boot conf
> >>> file. For example,
> >>> /boot/loader/entries/xxx-4.18.0-416.el8.x86_64.conf. My environment
> >>> is rhel. Maybe it's different on your system.
> >>>
> >>> Then you can add some printf logs into your udev rule. I did in this
> >>> way, something
> >>> like this:
> >>>
> >>> ENV{SYSTEMD_READY}=3D=3D"0", GOTO=3D"test_end"
> >>> SUBSYSTEM=3D=3D"block", ACTION=3D=3D"add", RUN{program}+=3D"/usr/bin/=
echo
> >>> mdadm-test-add-SYSTEMD_READY"
> >>> SUBSYSTEM=3D=3D"block", ACTION=3D=3D"change", RUN{program}+=3D"/usr/b=
in/echo
> >>> mdadm-test-change-SYSTEMD_READY"
> >>>
> >>> You can check the logs by journalctl command. So you can know which
> >>> rule runs in your udev rule.
> >>>
> >>> Regards
> >>> Xiao
> >>>> Thanks
> >>>>
> >>>> # udevadm info --query=3Dproperty --name=3D/dev/md127
> >>>>
> >>>> DEVPATH=3D/devices/virtual/block/md127
> >>>> DEVNAME=3D/dev/md127
> >>>> DEVTYPE=3Ddisk
> >>>> DISKSEQ=3D6
> >>>> MAJOR=3D9
> >>>> MINOR=3D127
> >>>> SUBSYSTEM=3Dblock
> >>>> USEC_INITIALIZED=3D5129215
> >>>> ID_IGNORE_DISKSEQ=3D1
> >>>> MD_LEVEL=3Draid1
> >>>> MD_DEVICES=3D2
> >>>> MD_METADATA=3D1.2
> >>>> MD_UUID=3D800ee577:652e6fdc:79f6768e:dea2f7ea
> >>>> MD_DEVNAME=3DSysRAID1Array1
> >>>> MD_NAME=3Dlinux2:SysRAID1Array1
> >>>> ID_FS_UUID=3Dx94VGG-7hfP-rn1c-MR53-q6to-QPZR-73eAdq
> >>>> ID_FS_UUID_ENC=3Dx94VGG-7hfP-rn1c-MR53-q6to-QPZR-73eAdq
> >>>> ID_FS_VERSION=3DLVM2 001
> >>>> ID_FS_TYPE=3DLVM2_member
> >>>> ID_FS_USAGE=3Draid
> >>>> SYSTEMD_WANTS=3Dmdmonitor.service
> >>>> SYSTEMD_READY=3D0
> >>>> UDISKS_MD_LEVEL=3Draid1
> >>>> UDISKS_MD_DEVICES=3D2
> >>>> UDISKS_MD_METADATA=3D1.2
> >>>> UDISKS_MD_UUID=3D800ee577:652e6fdc:79f6768e:dea2f7ea
> >>>> UDISKS_MD_DEVNAME=3DSysRAID1Array1
> >>>> UDISKS_MD_NAME=3Dlinux2:SysRAID1Array1
> >>>> UDISKS_MD_DEVICE_dev_nvme0n1p2_ROLE=3D0
> >>>> UDISKS_MD_DEVICE_dev_nvme0n1p2_DEV=3D/dev/nvme0n1p2
> >>>> UDISKS_MD_DEVICE_dev_nvme1n1p2_ROLE=3D1
> >>>> UDISKS_MD_DEVICE_dev_nvme1n1p2_DEV=3D/dev/nvme1n1p2
> >>>> DEVLINKS=3D/dev/md/SysRAID1Array1
> >>>> /dev/disk/by-id/md-name-linux2:SysRAID1Array1
> >>>> /dev/disk/by-id/lvm-pv-uuid-x94VGG-7hfP-rn1c-MR53-q6to-QPZR-73eAdq
> >>>> /dev/disk/by-id/md-uuid-800ee577:652e6fdc:79f6768e:dea2f7ea
> >>>> TAGS=3D:systemd:
> >>>> CURRENT_TAGS=3D:systemd:
> >>>>
> >>>> # cat /usr/lib/udev/rules.d/63-md-raid-arrays.rules
> >>>> # do not edit this file, it will be overwritten on update
> >>>>
> >>>> SUBSYSTEM!=3D"block", GOTO=3D"md_end"
> >>>>
> >>>> # handle md arrays
> >>>> ACTION!=3D"add|change", GOTO=3D"md_end"
> >>>> KERNEL!=3D"md*", GOTO=3D"md_end"
> >>>>
> >>>> # partitions have no md/{array_state,metadata_version}, but should n=
ot
> >>>> # for that reason be ignored.
> >>>> ENV{DEVTYPE}=3D=3D"partition", GOTO=3D"md_ignore_state"
> >>>>
> >>>> # container devices have a metadata version of e.g. 'external:ddf' a=
nd
> >>>> # never leave state 'inactive'
> >>>> ATTR{md/metadata_version}=3D=3D"external:[A-Za-z]*",
> >>>> ATTR{md/array_state}=3D=3D"inactive", GOTO=3D"md_ignore_state"
> >>>> TEST!=3D"md/array_state", ENV{SYSTEMD_READY}=3D"0", GOTO=3D"md_end"
> >>>> ATTR{md/array_state}=3D=3D"clear*|inactive", ENV{SYSTEMD_READY}=3D"0=
",
> >>>> GOTO=3D"md_end"
> >>>> ATTR{md/sync_action}=3D=3D"reshape", ENV{RESHAPE_ACTIVE}=3D"yes"
> >>>> LABEL=3D"md_ignore_state"
> >>>>
> >>>> IMPORT{program}=3D"/usr/bin/mdadm --detail --no-devices --export $de=
vnode"
> >>>> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_NAME}=3D=3D"?*",
> >>>> SYMLINK+=3D"disk/by-id/md-name-$env{MD_NAME}",
> >>>> OPTIONS+=3D"string_escape=3Dreplace"
> >>>> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_UUID}=3D=3D"?*",
> >>>> SYMLINK+=3D"disk/by-id/md-uuid-$env{MD_UUID}"
> >>>> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_DEVNAME}=3D=3D"?*", SYMLINK+=3D"md/=
$env{MD_DEVNAME}"
> >>>> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_NAME}=3D=3D"?*",
> >>>> SYMLINK+=3D"disk/by-id/md-name-$env{MD_NAME}-part%n",
> >>>> OPTIONS+=3D"string_escape=3Dreplace"
> >>>> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_UUID}=3D=3D"?*",
> >>>> SYMLINK+=3D"disk/by-id/md-uuid-$env{MD_UUID}-part%n"
> >>>> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_DEVNAME}=3D=3D"*[^0-9]",
> >>>> SYMLINK+=3D"md/$env{MD_DEVNAME}%n"
> >>>> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_DEVNAME}=3D=3D"*[0-9]",
> >>>> SYMLINK+=3D"md/$env{MD_DEVNAME}p%n"
> >>>>
> >>>> IMPORT{builtin}=3D"blkid"
> >>>> OPTIONS+=3D"link_priority=3D100"
> >>>> OPTIONS+=3D"watch"
> >>>> ENV{ID_FS_USAGE}=3D=3D"filesystem|other|crypto", ENV{ID_FS_UUID_ENC}=
=3D=3D"?*",
> >>>> SYMLINK+=3D"disk/by-uuid/$env{ID_FS_UUID_ENC}"
> >>>> ENV{ID_FS_USAGE}=3D=3D"filesystem|other", ENV{ID_PART_ENTRY_UUID}=3D=
=3D"?*",
> >>>> SYMLINK+=3D"disk/by-partuuid/$env{ID_PART_ENTRY_UUID}"
> >>>> ENV{ID_FS_USAGE}=3D=3D"filesystem|other", ENV{ID_FS_LABEL_ENC}=3D=3D=
"?*",
> >>>> SYMLINK+=3D"disk/by-label/$env{ID_FS_LABEL_ENC}"
> >>>>
> >>>> ENV{MD_LEVEL}=3D=3D"raid[1-9]*", ENV{SYSTEMD_WANTS}+=3D"mdmonitor.se=
rvice"
> >>>>
> >>>> # Tell systemd to run mdmon for our container, if we need it.
> >>>> ENV{MD_LEVEL}=3D=3D"raid[1-9]*", ENV{MD_CONTAINER}=3D=3D"?*",
> >>>> PROGRAM=3D"/usr/bin/readlink $env{MD_CONTAINER}", ENV{MD_MON_THIS}=
=3D"%c"
> >>>> ENV{MD_MON_THIS}=3D=3D"?*", PROGRAM=3D"/usr/bin/basename $env{MD_MON=
_THIS}",
> >>>> ENV{SYSTEMD_WANTS}+=3D"mdmon@%c.service"
> >>>> ENV{RESHAPE_ACTIVE}=3D=3D"yes", PROGRAM=3D"/usr/bin/basename
> >>>> $env{MD_MON_THIS}", ENV{SYSTEMD_WANTS}+=3D"mdadm-grow-continue@%c.se=
rvice"
> >>>>
> >>>> LABEL=3D"md_end"
> >>>>
> >>>>
> >> Hello Xiao,
> >>
> >> Thanks for the tips.
> >>
> >> It appears that SYSTEMD_READY =3D=3D 1 when entering the add/change ev=
ent,
> >> but it seems it is reset to 0 while processing the rules.
> >>
> >> Following is modified rule with debug info. Relevant journal entries:
> >>
> >> md127: '/usr/bin/echo mdadm-test-add-SYSTEMD_READY'(out)
> >> 'mdadm-test-add-SYSTEMD_READY'
> > You see the log in your test. From the following udev rule, it only can=
 handle
> > add/change events. And SYSTEMD_READY is 1, it doesn't go to the md_test
> > label. And the log appears. So it doesn't reset to 0, right?
> >
> > Regards
> > Xiao
> >
> >> ...
> >>
> >> md127: '/usr/bin/udevadm info --query=3Dproperty --name=3D/dev/md127'(=
out)
> >> 'SYSTEMD_READY=3D0'
> >>
> >>
> >> $ cat 63-md-raid-arrays.rules
> >>
> >> # do not edit this file, it will be overwritten on update
> >>
> >> SUBSYSTEM!=3D"block", GOTO=3D"md_end"
> >>
> >> # handle md arrays
> >> ACTION!=3D"add|change", GOTO=3D"md_end"
> >> KERNEL!=3D"md*", GOTO=3D"md_end"
> >>
> >> ENV{SYSTEMD_READY}=3D=3D"0", GOTO=3D"md_test"
> >> RUN{program}+=3D"/usr/bin/echo mdadm-test-add-SYSTEMD_READY"
> >> LABEL=3D"md_test"
> >>
> >>
> >> # partitions have no md/{array_state,metadata_version}, but should not
> >> # for that reason be ignored.
> >> ENV{DEVTYPE}=3D=3D"partition", GOTO=3D"md_ignore_state"
> >>
> >> # container devices have a metadata version of e.g. 'external:ddf' and
> >> # never leave state 'inactive'
> >> ATTR{md/metadata_version}=3D=3D"external:[A-Za-z]*",
> >> ATTR{md/array_state}=3D=3D"inactive", GOTO=3D"md_ignore_state"
> >> TEST!=3D"md/array_state", ENV{SYSTEMD_READY}=3D"0", GOTO=3D"md_end"
> >> ATTR{md/array_state}=3D=3D"clear*|inactive", ENV{SYSTEMD_READY}=3D"0",
> >> GOTO=3D"md_end"
> >> ATTR{md/sync_action}=3D=3D"reshape", ENV{RESHAPE_ACTIVE}=3D"yes"
> >> LABEL=3D"md_ignore_state"
> >>
> >> IMPORT{program}=3D"/usr/bin/mdadm --detail --no-devices --export $devn=
ode"
> >> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_NAME}=3D=3D"?*",
> >> SYMLINK+=3D"disk/by-id/md-name-$env{MD_NAME}",
> >> OPTIONS+=3D"string_escape=3Dreplace"
> >> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_UUID}=3D=3D"?*",
> >> SYMLINK+=3D"disk/by-id/md-uuid-$env{MD_UUID}"
> >> ENV{DEVTYPE}=3D=3D"disk", ENV{MD_DEVNAME}=3D=3D"?*", TAG+=3D"systemd",
> >> SYMLINK+=3D"md/$env{MD_DEVNAME}"
> >> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_NAME}=3D=3D"?*",
> >> SYMLINK+=3D"disk/by-id/md-name-$env{MD_NAME}-part%n",
> >> OPTIONS+=3D"string_escape=3Dreplace"
> >> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_UUID}=3D=3D"?*",
> >> SYMLINK+=3D"disk/by-id/md-uuid-$env{MD_UUID}-part%n"
> >> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_DEVNAME}=3D=3D"*[^0-9]",
> >> SYMLINK+=3D"md/$env{MD_DEVNAME}%n"
> >> ENV{DEVTYPE}=3D=3D"partition", ENV{MD_DEVNAME}=3D=3D"*[0-9]",
> >> SYMLINK+=3D"md/$env{MD_DEVNAME}p%n"
> >>
> >>
> >> IMPORT{builtin}=3D"blkid"
> >> OPTIONS+=3D"link_priority=3D100"
> >> OPTIONS+=3D"watch"
> >> ENV{ID_FS_USAGE}=3D=3D"filesystem|other|crypto", ENV{ID_FS_UUID_ENC}=
=3D=3D"?*",
> >> SYMLINK+=3D"disk/by-uuid/$env{ID_FS_UUID_ENC}"
> >> ENV{ID_FS_USAGE}=3D=3D"filesystem|other", ENV{ID_PART_ENTRY_UUID}=3D=
=3D"?*",
> >> SYMLINK+=3D"disk/by-partuuid/$env{ID_PART_ENTRY_UUID}"
> >> ENV{ID_FS_USAGE}=3D=3D"filesystem|other", ENV{ID_FS_LABEL_ENC}=3D=3D"?=
*",
> >> SYMLINK+=3D"disk/by-label/$env{ID_FS_LABEL_ENC}"
> >>
> >> ENV{MD_LEVEL}=3D=3D"raid[1-9]*", ENV{SYSTEMD_WANTS}+=3D"mdmonitor.serv=
ice"
> >> ENV{MD_LEVEL}=3D=3D"raid[1-9]*", ENV{SYSTEMD_WANTS}+=3D"hello.service"
> >>
> >> #RUN{program}+=3D"/usr/bin/echo SYSTEMD_READY =3D $env(SYSTEMD_READY)"
> >> RUN{program}+=3D"/usr/bin/udevadm info --query=3Dproperty --name=3D/de=
v/md127"
> >>
> >> # Tell systemd to run mdmon for our container, if we need it.
> >> ENV{MD_LEVEL}=3D=3D"raid[1-9]*", ENV{MD_CONTAINER}=3D=3D"?*",
> >> PROGRAM=3D"/usr/bin/readlink $env{MD_CONTAINER}", ENV{MD_MON_THIS}=3D"=
%c"
> >> ENV{MD_MON_THIS}=3D=3D"?*", PROGRAM=3D"/usr/bin/basename $env{MD_MON_T=
HIS}",
> >> ENV{SYSTEMD_WANTS}+=3D"mdmon@%c.service"
> >> ENV{RESHAPE_ACTIVE}=3D=3D"yes", PROGRAM=3D"/usr/bin/basename
> >> $env{MD_MON_THIS}", ENV{SYSTEMD_WANTS}+=3D"mdadm-grow-continue@%c.serv=
ice"
> >>
> >> LABEL=3D"md_end"
> >>
> >>
> >>
> Please see my second message, where I think this is because of a
> conflicting rule in 69-dm-lvm.rules:49 which later resets it:
>
> ENV{LVM_MD_PV_ACTIVATED}!=3D"1", ENV{SYSTEMD_READY}=3D"0"
>

I'm not familiar with this so I can't give my answer. Sorry for this.
I just right
did some jobs related with udev rules and tried this debug method.

If you are suspicious about if SYSTEMD_READY is changed or not, maybe
you can add some debug logs before and after the suspicious place?

Regards
Xiao

