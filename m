Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C013AC98
	for <lists+linux-raid@lfdr.de>; Tue, 14 Jan 2020 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgANOsI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 14 Jan 2020 09:48:08 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:36618 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgANOsI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 14 Jan 2020 09:48:08 -0500
Received: by mail-vs1-f48.google.com with SMTP id u14so8369641vsu.3
        for <linux-raid@vger.kernel.org>; Tue, 14 Jan 2020 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmBLlRTzbDnhDAgO/2BWihQE7eGKEkwVS6Xuz4B5waw=;
        b=Zxez9xQ6KKfeL/yLUw6AAj/Hpb6QI6qMGwwKVFY3IzibkVaG/En3yQEsapCK5KmevM
         SM5Z3pxk2/LTjlVZ4Ud53CbEOHtZr5M4kP9BWBjrRWwTaZANNJcyvfRqxRFvGsVvL/kz
         8JGMKIwKWXN4iMqCALQiONBHMw2ezcorhuMPeunTXGRCDNpqI86VH3B0wkNPra58SgFB
         i9NI89q+kRMZ4e3gCkG8KzYiPqtSgTbUNoTY18Im4Q7dMb6QRjEq4TmesjbIeyspd2nw
         0KZFwk+RsTBLE2Oi8tsn9JIaQXTlB83c5ErKb6IAY016Y5ML2s2oLbeQgT/2G0SgE1sr
         Xngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmBLlRTzbDnhDAgO/2BWihQE7eGKEkwVS6Xuz4B5waw=;
        b=TnhU9Plyq/wCEVvUoYWQOqVHoX3PJimwExOUInrQYZX1vZwFMmv0tcHuDFcGcSPM6V
         wLXwjGvcc5R/gT97j8KuWuLtQPS0b91/btyfRuq8VM9nipPr7Jr7ngUGpfGYALNZHg+a
         rGYv/QAj/06UAfOSA7rjpKEydXuedWt1IkvHIMFJoI75ai0KuxR9JlOwWrAlxNPE/P/Q
         BwKjB7Kr7IbuicmthAcmKWNa51M2mb7aN8tfAzTWFEwSl5kt6kjyc8Fg4rxbLPMfjvCg
         +Bg7X7HNxIVD98qxaoGPh/a/Cpu+2bw79bPb7Z94Fb1PLNVoyrBXdrl/o2uSNSDLllKo
         EsBg==
X-Gm-Message-State: APjAAAXLQGNxdIt8sTJJjy5s51wOmue+n/aFOpxw2ice4YbdFjMebM/n
        QDtPZyzpPn3yDamDRSc7iaH8J3snJ+Axk6xtZrfxwxGI
X-Google-Smtp-Source: APXvYqxfB+EDv4VZvzLzweZhPgzVjqCK68k0xkYKzsO73S8OXhsRpmguKbiG9XSmvcXnN7xGVwFArYa0RfLPgiXSCnA=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr1458370vsq.215.1579013287410;
 Tue, 14 Jan 2020 06:48:07 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk> <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
In-Reply-To: <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Tue, 14 Jan 2020 08:47:56 -0600
Message-ID: <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Well, I went ahead and tried the forced assembly:

bill@bill-desk:~$ sudo mdadm --assemble --force /dev/md1 /dev/sdg1
/dev/sdh1 /dev/sdi1
[sudo] password for bill:
mdadm: Merging with already-assembled /dev/md/1
mdadm: Marking array /dev/md/1 as 'clean'
mdadm: failed to RUN_ARRAY /dev/md/1: Input/output error

(The drive letters have changed because I removed a bunch of other
drives. The original drives are now on sd[b,c,d,e] and the copies are
on sd[f,g,h,i] with sdf being a copy of the presumably bad sdb with
the event count which doesn't agree with the other 3 disks.)

So, it failed. dmesg shows:

152144.483755] md: array md1 already has disks!
[152144.483772] md: kicking non-fresh sdb1 from array!
[152144.520313] md/raid:md1: not clean -- starting background reconstruction
[152144.520345] md/raid:md1: device sdd1 operational as raid disk 2
[152144.520346] md/raid:md1: device sde1 operational as raid disk 1
[152144.520348] md/raid:md1: device sdc1 operational as raid disk 3
[152144.522219] md/raid:md1: cannot start dirty degraded array.
[152144.566782] md/raid:md1: failed to run raid set.
[152144.566785] md: pers->run() failed ...
[152144.568169] md1: ADD_NEW_DISK not supported
[152144.569894] md1: ADD_NEW_DISK not supported
[152144.571498] md1: ADD_NEW_DISK not supported
[152144.573964] md1: ADD_NEW_DISK not supported

mdstat shows sdb no longer part of the array:

bill@bill-desk:~$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
md1 : inactive sdd1[2] sde1[1] sdc1[4]
      11720653824 blocks super 1.2

details of the array:

ill@bill-desk:~$ sudo mdadm -D /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Tue Sep 25 23:31:31 2018
        Raid Level : raid5
     Used Dev Size : 18446744073709551615
      Raid Devices : 4
     Total Devices : 3
       Persistence : Superblock is persistent

       Update Time : Sat Jan  4 16:52:59 2020
             State : active, FAILED, Not Started
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 64K

Consistency Policy : unknown

              Name : bill-desk:1  (local to host bill-desk)
              UUID : 723f939b:62b73a3e:e86e1fe1:e37131dc
            Events : 38643

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       -       0        0        1      removed
       -       0        0        2      removed
       -       0        0        3      removed

       -       8       65        1      sync   /dev/sde1
       -       8       49        2      sync   /dev/sdd1
       -       8       33        3      sync   /dev/sdc1

Now if I try the forced assemble again I get:

ill@bill-desk:~$ sudo mdadm --assemble --force /dev/md1 /dev/sdg1
/dev/sdh1 /dev/sdi1
mdadm: Found some drive for an array that is already active: /dev/md/1
mdadm: giving up.

I'm lost now. Not sure what to do anymore. Do I need to edit
mdadm.conf? Do I need to remove the original drives? Any ideas Wols?

Bill
