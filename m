Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29812AE46
	for <lists+linux-raid@lfdr.de>; Thu, 26 Dec 2019 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfLZTT3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 26 Dec 2019 14:19:29 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33513 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZTT3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 26 Dec 2019 14:19:29 -0500
Received: by mail-ed1-f44.google.com with SMTP id r21so23529068edq.0
        for <linux-raid@vger.kernel.org>; Thu, 26 Dec 2019 11:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olbCkqegvjcroEOpYLrC9RxdmsumgcpfRr0UAxoR5xw=;
        b=iLVTIVHpmTF4ACSfF/4/HPnDttis0tCD0NmihisjoR9FXXF/icqldHZZht2LldAeCM
         lL4d5uyeadz9TTduD27Jotk628B5BHwmO7iVwijJ90mTBZbBtQXtb0xqnJH486/CocSO
         TS6BZeNkN1uvp0NI3c1nXVQQSdG9b8rJcR0uRt1qRKSaq0+nN3waeCm0AiiRXRsFJivm
         gyEKeK8Dw6j+NVqdQaZZ987Jw3dUrMwXvNmLFMlL/bGR7/mvbSMcbgItBVhunYdXhQIZ
         K10hTKMi1x8mF2/u1bbXqvsnQebwY1hg63T9/VW9Ja77OxJlDPd5wFT1BzTHm2oIS+uy
         5EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olbCkqegvjcroEOpYLrC9RxdmsumgcpfRr0UAxoR5xw=;
        b=Cby0+ukeKjDi2ApBMm7/iCmZn0m7qdUDezd7vqacvBX+GNsRSzCu8XmgeyU0bKQ9DX
         ynbR2H5Wid5VYHKGBlp2VwTtD92ZWXHiJLxQVt2YE9PENi2gGtG7d7lUrzjIbVPGACJv
         AeIlsaDbJ5mxoilmWUl1p3jAQnshKNrzY6GY8k0eLIFKRjquelIsj2EaKmkAgmdKrXyj
         ACgIUfXWDxWTJGcJURdd12ZZ8BS9LSjo4wVAmLpEa4tibs+a+H5rnebUvjAh/pQWodls
         T1RZq4GwGB2xwVrowSfEvSkzs5GESLgUe0fnJAtMY4WJgSc48BhSWhZ60vQIgkEzLKX4
         0SmA==
X-Gm-Message-State: APjAAAWlCOwOYNNdtJQm6tyZY0zSuXNWDWRZbqFFrrPfnc6+kTTFrwkS
        do8g3CJ8wGZTa8HK9HWmcsEl8sP1xlCVYVMar7fBzWSr9Tw=
X-Google-Smtp-Source: APXvYqy5w4UtXkxIhrZvxdgXhz2FsH37rfTLGz9vjotxJEUVvB50oSChSpb4JRKlHLRmSRiuwwSs3IhpxWEi164Q3UQ=
X-Received: by 2002:aa7:d1d0:: with SMTP id g16mr52594586edp.56.1577387967359;
 Thu, 26 Dec 2019 11:19:27 -0800 (PST)
MIME-Version: 1.0
References: <CAM-0FgP5dXnTbri-wB-2LJU-QE5wd9nsq=kzMW9kXND=wF=z8w@mail.gmail.com>
 <20191217182509.GA16121@metamorpher.de> <CAM-0FgOpi4EGuhM7DXSutRtxRSJ4nb9kLzM0U_3LZi-jxUDVWQ@mail.gmail.com>
 <20191222130452.GA2580@metamorpher.de> <20191222134019.GA3770@metamorpher.de>
In-Reply-To: <20191222134019.GA3770@metamorpher.de>
From:   Patrick Pearcy <patrick.pearcy@gmail.com>
Date:   Thu, 26 Dec 2019 14:19:15 -0500
Message-ID: <CAM-0FgNegq5Ujd=K9Rjk-Vi9Y2zzb1U3YXScs6MxrDbC2xmbeg@mail.gmail.com>
Subject: Re: WD MyCloud PR4100 RAID Failure
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Andreas -

THANKS!!!  Following the link pointers (RAID Recovery - Linus Raid)
you provided, I was successful in re-creating the Array using:

1. mdadm --create --assume-clean --level=5 --raid-devices=4 /dev/md1
/dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2  (I took a chance at this as I
didn't have spare drives to copy 24TB of info to)
2. I then re-booted the PR4100.  Upon reboot, I still got the message
in the admin console that the Device was not configured and asked if I
wanted to create an array.  I ran mdadm --assemble --force --verbose
/dev/md1 /dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2  without any errors.
3. I mounted the array to /mnt/HD with mount /dev/md1 /mnt/HD and was
able to change directories/view the folders & files in the Array.

HOWEVER,

Upon reboot of the PR4100 - the array etc. went away and I was back to
configure the file system message.   I successfully re-ran the mdadm
--assemble and mount commands so I can 'see the data' but I can't
figure out how to 'copy' the data from the PR4100 (i.e., how to share
the directory) OR mount the array (and shares) in the PR4100
automatically...   Any suggestions??

- Best wishes Patrick

On Sun, Dec 22, 2019 at 8:40 AM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Sun, Dec 22, 2019 at 02:04:52PM +0100, Andreas Klauer wrote:
> >        truncate -s $((15619661440)) "$disk".img
>
> whoops, should be $((15619661440*512))
