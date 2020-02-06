Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53B154543
	for <lists+linux-raid@lfdr.de>; Thu,  6 Feb 2020 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBFNqp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Feb 2020 08:46:45 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37641 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFNqp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 Feb 2020 08:46:45 -0500
Received: by mail-lf1-f43.google.com with SMTP id b15so4139904lfc.4
        for <linux-raid@vger.kernel.org>; Thu, 06 Feb 2020 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubicast.eu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=u8q0remdsew4BmPYtlf4i6RVRfuoqK4dQElALuWoog0=;
        b=PR0K2QQ8drFpJe9a19RcHYUBHAteZAtwk6pWfbhBi0erolOutz1oTK8qIwHNaENphD
         4TT8vC994eFJWqxd76rQ0gAONBnJrY7CTsoo8aElpC4jVC+mY+Eh5pw5IOxPxvoyxuTr
         jy37PPRzc9jSSpWPbjgt4MIamctVp9IBtzPadYypYgaTAGbPBUQ9aC7txldCSaheDkW5
         oKaczcwcUotX6j2eWdfbGjU8RKfIte/fmCEaYb1KaLVlK/gXFf2yOmAPjH/pKQpaGW9G
         T3zcQwsFNTvarpFR01MVp/Fd5NXqzS3V388ymroQ4BJpARZSnwx4M4opXFfgfoLXyaF9
         Q7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u8q0remdsew4BmPYtlf4i6RVRfuoqK4dQElALuWoog0=;
        b=YwdbBsgykeYrLEmwm2/iJ3YgJd+dYei5cDCgxPBSjBoEB/sco7VDUd8X57GHBAD4Ix
         c5NdA2LKj+EjhlF0z6XWaXyV99QEY2AtumiD2pVDtt2RBsz6b1wVftBuu3+Vb6d2I1KE
         YFvCKUuHFbqLH+pAnQAeUB0siWRO49H626n0vhRivtoecTNiGrRkmd7uMkH+Z3yiIbOx
         w03JepJeGvd1CQNJXFqKev6SRuhpLv0/NjcCars04om/FlQPdn0YDmfdzOGfh+Eyz420
         vy0l5vpHy77aonmed/QYK4SlVQM+u8Yu3OK3YV2UJSg7tBaHNSmdrCXMvlMyEv4Pdxqo
         y+ZQ==
X-Gm-Message-State: APjAAAVWaqIrPt9EnqW7DbtW2s9eMLO7uWK4eRbaRFbJ+GzzJQaoBK0t
        4sH8yAF24DvCD5uDus/KbSe5Q1ft3k9nz8liOxhuqz89PZo=
X-Google-Smtp-Source: APXvYqw97BB3WR+Ektsm+aK0opu7nsJ71t6qsiESbPmX/YpoJIcjt4LB90/66LwaGKCwyeLPnxb5Naph7OtXV4/mhdo=
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr1850714lfl.191.1580996803192;
 Thu, 06 Feb 2020 05:46:43 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Karolak <nicolas.karolak@ubicast.eu>
Date:   Thu, 6 Feb 2020 14:46:51 +0100
Message-ID: <CAO8Scz75h0mTqePyyeehnY+706R=eUgh7DOOKyCaWWJfADRUVg@mail.gmail.com>
Subject: Recover RAID6 with 4 disks removed
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello,
I have (had...) a RAID6 array with 8 disks and tried to remove 4 disks
from it, and obviously i messed up. Here is the commands i issued (i
do not have the output of them):

```
mdadm --manage /dev/md1 --fail /dev/sdh
mdadm --manage /dev/md1 --fail /dev/sdg
mdadm --detail /dev/md1
cat /proc/mdstat
mdadm --manage /dev/md1 --fail /dev/sdf
mdadm --manage /dev/md1 --fail /dev/sde
mdadm --detail /dev/md1
cat /proc/mdstat
mdadm --manage /dev/md1 --remove /dev/sdh
mdadm --manage /dev/md1 --remove /dev/sdg
mdadm --manage /dev/md1 --remove /dev/sde
mdadm --manage /dev/md1 --remove /dev/sdf
mdadm --detail /dev/md1
cat /proc/mdstat
mdadm --grow /dev/md1 --raid-devices=4
mdadm --grow /dev/md1 --array-size 7780316160  # from here it start
going wrong on the system
```

I began to have "inpout/output" error, `ls` or `cat` or almost every
command was not working (something like "/usr/sbin/ls not found").
`mdadm` command was still working, so i did that:

```
mdadm --manage /dev/md1 --re-add /dev/sde
mdadm --manage /dev/md1 --re-add /dev/sdf
mdadm --manage /dev/md1 --re-add /dev/sdg
mdadm --manage /dev/md1 --re-add /dev/sdh
mdadm --grow /dev/md1 --raid-devices=8
```

The disks were re-added, but as "spares". After that i powered down
the server and made backup of the disks with `dd`.

Is there any hope to retrieve the data? If yes, then how?

Any help is really appreciated. Thanks in advance.

Regards,
Nicolas KAROLAK
