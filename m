Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9B5AB500
	for <lists+linux-raid@lfdr.de>; Fri,  2 Sep 2022 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiIBPX6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 2 Sep 2022 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiIBPXl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 2 Sep 2022 11:23:41 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181C14798D
        for <linux-raid@vger.kernel.org>; Fri,  2 Sep 2022 07:56:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 62so1811973iov.5
        for <linux-raid@vger.kernel.org>; Fri, 02 Sep 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EtTF9EqiNb9FltUoRB7YeQSN4yRH+4IQSs4gnc82N08=;
        b=m+6M+GnNEs3H2+hqxUT+TReZQzR/jtkEL7dJ1KG+FiDQekxj961Kj/1BnGnGOQnYO4
         QYJ9KnVRacrzP8dpmSbwCKdYHqyD+/vQPMIJ8GSFZQ8Pl0ncmyMiczi/02pamypBGAcw
         3M5+hfO9jbJuedWeOS6ZsqXFtHYMST/qaKwtz8rXJvr4zgYNVdX0E6z7zGthZZJloVmP
         igxzbisnwWI6kZgzTHmMj/IxMcKjErRKdSmWdjcBkZXkcdKA/s8d742FGwuMh9z80xfM
         t1PzPLADAMVKh+sGuuT4XBs3vLdP6/WmQpyThPKWXZsx21Y6h+e/4x9zGR7ygR4Bi5yN
         4U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EtTF9EqiNb9FltUoRB7YeQSN4yRH+4IQSs4gnc82N08=;
        b=AJf7xPJULGk4R6gcGIIKzNMxYwx0/vjN18Ccgv6uxPMlTnWzygWtJ+7AxS/nCdC4vy
         J1dbrqgQj9XcnnrLvweIz8Pl3WBM0uEYwfg1GcJEqJASxnUVvhBjBeqjZwk+TV8eC/X6
         5QdD2Teai3PfVxyLU0xPrWx0uNZeEawergXYwbEYysBiVSqPTpUg8yyo4xG4HUga/nCg
         Pr25ghfWFZPKFbTCVvUv63SykS2Z2j2nhE988raSgdOBsyFtKYrcD2i7T+2TA+JTWAGW
         6Zf8hr1Q1PI8thCSp8HPEFHVipEcmGPukbWP0WXGEjB2ys4cOIOMShimwCI10SKos7kT
         bznQ==
X-Gm-Message-State: ACgBeo33wmG3EJADM0Ob3l45/XrZh/DWP6YJyc41qhR54HfDayqtg1sm
        jKf/KtZqdFZ4DVvMokbHinUXwVHVrKeZa8EmsWoX7QWkOA==
X-Google-Smtp-Source: AA6agR6AiPB1CJGdWDu2jvGUYOs1YcaFu3GLNe0AvhSN5UuR+5o1Y959bN69sY1PtLRHw71exnWERKvWoojW1fUcyiQ=
X-Received: by 2002:a05:6638:3888:b0:349:f45b:4d28 with SMTP id
 b8-20020a056638388800b00349f45b4d28mr19849395jav.40.1662130607820; Fri, 02
 Sep 2022 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAKAPSkJLd836Zp3xU=zSOHg3qcEmi29Y2qOwWzeAFaDp+dNTvg@mail.gmail.com>
 <70e2ae22-bbba-77a4-c9bc-4c02752f4cb7@youngman.org.uk> <dc24b476-2f0a-8406-f1c0-e33b5b0eb388@youngman.org.uk>
 <4a414fc6-2666-302f-8d3d-08eb7a2986fc@turmel.org> <CAKAPSkJAQYsec-4zzcePbkJ7Ee0=sd_QvHj4Stnyineq+T8BXw@mail.gmail.com>
 <25355.47062.897268.3355@quad.stoffel.home> <ee66bcbe-0a9b-57a6-439f-72cc46debe48@turmel.org>
 <25355.50871.743993.605394@quad.stoffel.home> <CAKAPSkLQ4K1R_aD1=iURTFQmm_DXDMr=wx+VDET7DOUy+6Zp_Q@mail.gmail.com>
 <25357.13191.843087.630097@quad.stoffel.home> <1d978f6c-e1cc-e928-efc5-11ff167938b1@eyal.emu.id.au>
 <CAKAPSkJhf8hWGTQiCne6BnMPYoum4hJT3diz9U1FGAfq=_N-nA@mail.gmail.com>
 <CAKAPSkK1bTf+7GOxmB-odjr2zej6XBCT_VGhfNC1KnSXZHjeRw@mail.gmail.com>
 <8e994200-146e-61ce-bb4a-f7f111f47b10@youngman.org.uk> <CAKAPSkKQA3cV1rcj9cNrdKorOOqyjHf_4BCLxbEx8ibusJP5nA@mail.gmail.com>
 <25359.50842.604856.467479@quad.stoffel.home>
In-Reply-To: <25359.50842.604856.467479@quad.stoffel.home>
From:   Peter Sanders <plsander@gmail.com>
Date:   Fri, 2 Sep 2022 10:56:36 -0400
Message-ID: <CAKAPSkL45hc2kTkZyZwhuMz+Pr+rqP70tARvMz4CzEdTtB1sHw@mail.gmail.com>
Subject: Re: RAID 6, 6 device array - all devices lost superblock
To:     John Stoffel <john@stoffel.org>
Cc:     Wols Lists <antlists@youngman.org.uk>,
        Eyal Lebedinsky <fedora@eyal.emu.id.au>,
        linux-raid@vger.kernel.org
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

contents of /proc/mdstat

root@superior:/mnt/backup# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
unused devices: <none>
root@superior:/mnt/backup#



Here are the steps I ran (minus some mounting other devices and
looking around for mdadm tracks on the old os disk)

  410  DEVICES=3D$(cat /proc/partitions | parallel --tagstring {5}
--colsep ' +' mdadm -E /dev/{5} |grep $UUID | parallel --colsep '\t'
echo /dev/{1})
  411  apt install parallel
  412  DEVICES=3D$(cat /proc/partitions | parallel --tagstring {5}
--colsep ' +' mdadm -E /dev/{5} |grep $UUID | parallel --colsep '\t'
echo /dev/{1})
  413  echo $DEVICES
  414  cat /proc/partitions
  415  DEVICES=3D/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg
  416  DEVICES=3D"/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg"
  417  echo $DEVICES
  418  parallel 'test -e /dev/loop{#} || mknod -m 660 /dev/loop{#} b 7
{#}' ::: $DEVICES
  419  ls /dev/loop*
  420  dc
  421  cd /mnt/backup/
  422  ls
  423  parallel truncate -s300G overlay-{/} ::: $DEVICES
  424  ls
  425  ls -la
  426  df -h
  427  parallel 'size=3D$(blockdev --getsize {}); loop=3D$(losetup -f
--show -- overlay-{/}); echo 0 $size snapshot {} $loop P 8 | dmsetup
create {/}' ::: $DEVICES
  428  ls /dev/mapper/
  429  OVERLAYS=3D$(parallel echo /dev/mapper/{/} ::: $DEVICES)
  430  echo $OVERLAYS
  431  dmsetup status
  432  mdadm --assemble --force /dev/md1 $OVERLAYS
  433  history
  434  dmsetup status
  435  echo $OVERLAYS
  436  mdadm --assemble --force /dev/md0 $OVERLAYS
  437  cat /proc/partitions
  438  mkdir /mnt/oldroot
  << look for inird mdadm files >>
  484  echo $OVERLAYS
  485  mdadm --create /dev/md0 --level=3Draid6 -n 6 /dev/mapper/sdb
/dev/mapper/sdc /dev/mapper/sdd /dev/mapper/sde /dev/mapper/sdf
/dev/mapper/sdg
  << cancelled out of 485, review instructions... >>
  486  mdadm --create /dev/md0 --level=3Draid6 -n 6 /dev/mapper/sdb
/dev/mapper/sdc /dev/mapper/sdd /dev/mapper/sde /dev/mapper/sdf
/dev/mapper/sdg
  487  fsck -n /dev/md0
  488  mdadm --stop /dev/md0
  489  echo $DEVICES
  490   parallel 'dmsetup remove {/}; rm overlay-{/}' ::: $DEVICES
  491  dmsetup status
  492  ls
  493  rm overlay-*
  494  ls
  495  parallel losetup -d ::: /dev/loop[0-9]*
  496  parallel 'test -e /dev/loop{#} || mknod -m 660 /dev/loop{#} b 7
{#}' ::: $DEVICES
  497  parallel truncate -s300G overlay-{/} ::: $DEVICES
  498  parallel 'size=3D$(blockdev --getsize {}); loop=3D$(losetup -f
--show -- overlay-{/}); echo 0 $size snapshot {} $loop P 8 | dmsetup
create {/}' ::: $DEVICES
  499  dmsetup status
  500  /sbin/reboot
  501  history
  502  dmsetup status
  503  mount
  504  cat /proc/partitions
  505  nano /etc/fstab
  506  mount /mnt/backup/
  507  ls /mnt/backup/
  508  rm /mnt/backup/
  509  rm /mnt/backup/overlay-sd*
  510  emacs setupOverlay &
  511  ps auxww | grep emacs
  512  kill 65017
  513  ls /dev/loo*
  514  DEVICES=3D'/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg'
  515  echo $DEVICES
  516   parallel 'test -e /dev/loop{#} || mknod -m 660 /dev/loop{#} b
7 {#}' ::: $DEVICES
  517  ls /dev/loo*
  518  parallel truncate -s4000G overlay-{/} ::: $DEVICES
  519  ls
  520  rm overlay-sd*
  521  cd /mnt/bak
  522  cd /mnt/backup/
  523  ls
  524  parallel truncate -s4000G overlay-{/} ::: $DEVICES
  525  ls -la
  526  blockdev --getsize /dev/sdb
  527  man losetup
  528  man losetup
  529  parallel 'size=3D$(blockdev --getsize {}); loop=3D$(losetup -f
--show -- overlay-{/}); echo 0 $size snapshot {} $loop P 8 | dmsetup
create {/}' ::: $DEVICES
  530  dmsetup status
  531  history | grep mdadm
  532  history
  533  dmsetup status
  534  history | grep dmsetup
  535  dmsetup status
  536  dmsetup remove sdg
  537  dmsetup ls --tree
  538  lsof
  539  dmsetup ls --tre
  540  dmsetup ls --tree
  541  lsof | grep -i sdg
  542  lsof | grep -i sdf
  543  history |grep dmsetup | less
  544  dmsetup status
  545  history > ~plsander/Documents/raidIssues/joblog

On Wed, Aug 31, 2022 at 4:37 PM John Stoffel <john@stoffel.org> wrote:
>
> >>>>> "Peter" =3D=3D Peter Sanders <plsander@gmail.com> writes:
>
> > encountering a puzzling situation.
> > dmsetup is failing to return.
>
> I don't think you need to use dmsetup in your case, but can you post
> *all* the commands you ran before you got to this point, and the
> output of
>
>        cat /proc/mdstat
>
> as well?  Thinking on this some more, you might need to actually also
> add:
>
>         --assume-clean
>
> to the 'mdadm create ....' string, since you don't want it to zero the
> array or anything.
>
> Sorry for not remembering this at the time!
>
> So if you can, please just start over from scratch, showing the setup
> of the loop devices, the overlayfs setup, and the building the RAID6
> array, along with the cat /proc/mdstat after you do the initial build.
>
> John
>
> P.S.  For those who hated my email citing tool, I pulled it out for
> now.  Only citing with > now.  :-)
>
> > root@superior:/mnt/backup# dmsetup status
> > sdg: 0 5860533168 snapshot 16/8388608000 16
> > sdf: 0 5860533168 snapshot 16/8388608000 16
> > sde: 0 5860533168 snapshot 16/8388608000 16
> > sdd: 0 5860533168 snapshot 16/8388608000 16
> > sdc: 0 5860533168 snapshot 16/8388608000 16
> > sdb: 0 5860533168 snapshot 16/8388608000 16
>
> > dmsetup remove sdg  runs for hours.
> > Canceled it, ran dmsetup ls --tree and find that sdg is not present in =
the list.
>
> > dmsetup status shows:
> > sdf: 0 5860533168 snapshot 16/8388608000 16
> > sde: 0 5860533168 snapshot 16/8388608000 16
> > sdd: 0 5860533168 snapshot 16/8388608000 16
> > sdc: 0 5860533168 snapshot 16/8388608000 16
> > sdb: 0 5860533168 snapshot 16/8388608000 16
>
> > dmsetup ls --tree
> > root@superior:/mnt/backup# dmsetup ls --tree
> > sdf (253:3)
> >  =E2=94=9C=E2=94=80 (7:3)
> >  =E2=94=94=E2=94=80 (8:80)
> > sde (253:1)
> >  =E2=94=9C=E2=94=80 (7:1)
> >  =E2=94=94=E2=94=80 (8:64)
> > sdd (253:2)
> >  =E2=94=9C=E2=94=80 (7:2)
> >  =E2=94=94=E2=94=80 (8:48)
> > sdc (253:0)
> >  =E2=94=9C=E2=94=80 (7:0)
> >  =E2=94=94=E2=94=80 (8:32)
> > sdb (253:5)
> >  =E2=94=9C=E2=94=80 (7:5)
> >  =E2=94=94=E2=94=80 (8:16)
>
> > any suggestions?
>
>
>
> > On Tue, Aug 30, 2022 at 2:03 PM Wols Lists <antlists@youngman.org.uk> w=
rote:
> >>
> >> On 30/08/2022 14:27, Peter Sanders wrote:
> >> >
> >> > And the victory conditions would be a mountable file system that pas=
ses a fsck?
> >>
> >> Yes. Just make sure you delve through the file system a bit and satisf=
y
> >> yourself it looks good, too ...
> >>
> >> Cheers,
> >> Wol
