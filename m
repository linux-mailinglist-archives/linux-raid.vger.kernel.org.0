Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4415622D
	for <lists+linux-raid@lfdr.de>; Sat,  8 Feb 2020 01:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBHA45 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 19:56:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42245 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBHA45 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 19:56:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so1089210otd.9
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 16:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmfrhcZsord7A5W898vXQoQK7vAXxNveBtmNzgNUZIY=;
        b=BleeXM9D5W5cdJEplcmwwDpcgY49ccsjNl7ZvrhosSlDNKopvr3XgGlcS0+iztufxD
         cZc+nYUE+Fu6erxTh1HLerakN4qni8qfTExfbqjAF1Nkbd3svuj3JRlzEJ8iLQ1uelie
         YCPyReTq5AZKan8OW1GXNYKMBGWPBsOP9FMwhEcf4vWtJeEWnk4tb+4HwSiE/mG7GWno
         y9umSkv/bhrrIhtoKDdANX0gc9ox0dxkSBcxVL7WhuiU8Pq1/4DVtYc5XEDYRMdBppWk
         0DLcrrbuQSBmkFC7vlhP2T5n9YxqjN4NoU+yhkjKPzWQPqQqHtm6AqKAA7wONg5lIs1s
         ag4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmfrhcZsord7A5W898vXQoQK7vAXxNveBtmNzgNUZIY=;
        b=rFf1aKbTjSEJm8lD/G3Fnf+t7ZkZx/Hr0LkeuSGU4NZJLx1RbVwqSAnVdjN4RoW5zU
         sSy0TH5tfSFZvrOUIYxpTslw4RO05eOYSoSecIgVXB2TEm8fGtez2pyYYCpzmelN/faI
         93I906sTlsfpIzJEBGgmJ+2nkjNr0t3qwAxBCjp0MEvDN2pntbTyjjLluVBso8iN1yuy
         exQHOkSUylrr2lDDmlYV/bjLweC4wA4+wb/Udh3g5+N8g6iXuK7Drv819UR7oLislOIO
         8W5rDK+L0uo/Jhyc83pMLeYNDNMCTmiaxAaSaNDq9fx3V1fpjDMeyJbP16mXEAeWn1sJ
         xUIA==
X-Gm-Message-State: APjAAAVz56KXpVWRpFqLyKCqbYVbHo6hlogWJrFpsngMj0J7irOgjee9
        0VHZQ2DSwhgfULYsU9TtgXOUwxTpXUlxoip+VWAqngAi
X-Google-Smtp-Source: APXvYqxSBwO0B3UqLf3gc++t7/zgTHdSLSfyLIOGe+22MQi0/f40M+Nosv1yIupwWxG5vtlnb27ArpEKXq5g2sW6fMk=
X-Received: by 2002:a9d:7999:: with SMTP id h25mr1608868otm.347.1581123415947;
 Fri, 07 Feb 2020 16:56:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com> <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
 <1faaef72-62ed-2c36-19d7-f6995691779f@prgmr.com>
In-Reply-To: <1faaef72-62ed-2c36-19d7-f6995691779f@prgmr.com>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 18:56:20 -0600
Message-ID: <CAPpdf58wY2G4XpNhfnHG42fHkpT6Z_EtLnLdtTaGvhRG_N5KKA@mail.gmail.com>
Subject: Was Re: Question - - - - now: issue resolved
To:     Sarah Newman <srn@prgmr.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Feb 7, 2020 at 5:41 PM Sarah Newman <srn@prgmr.com> wrote:
>
> On 2/7/20 3:21 PM, o1bigtenor wrote:
> > On Fri, Feb 7, 2020 at 4:50 PM Sarah Newman <srn@prgmr.com> wrote:
> >>
> >> On 2/7/20 7:49 AM, o1bigtenor wrote:
> >>> Greetings
> >>>
> >>> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> >>> (11) system.
> >>> mdadm - v4.1 - 2018-10-01 is the version being used.
> >>>
> >>> Some weirdness is happening - - - vis a vis - - - I have one directory
> >>> (not small) that has disappeared. I last accessed said directory
> >>> (still have the pdf open which is how I could get this information)
> >>> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> >>> section of the file in question.
> >>
> >
> > Greetings
> >
> >
> >> I assume you've looked at lsof?
> >
> > No I hadn't - - - - thanks for the tip.
> > only a few thousand line in a terminal - - - - - but nothing what I was
> > looking for.
> >>
> >> https://www.linux.com/news/bring-back-deleted-files-lsof/
> >>
> >> If it is a software problem, it just as likely, if not more likely, that it is a file system problem rather than a raid problem. You don't mention
> >> what file system. You're possibly also actually looking at data in the in-memory disk cache rather than what's actually stored on disk given there's
> >> been no reboot.
> >
> > The array (raid-10) is on ext4.
> >>
> >> Is there anything suspicious in dmesg?
> >
> > I hadn't looked at the messages files in /var/log so I went back to
> > date in question.
> > Didn't see anything there either.
>
> I said the command dmesg, not /var/log.
>
> If systemd-journald is broken, or your file system is broken, you could have tons of error messages in dmesg and nothing logged to disk.
>

Found one couplet - - - it might be applicable (please advise):

[12458.717443] EXT4-fs (md0p1): warning: maximal mount count reached,
running e2fsck is recommended
[12459.215097] EXT4-fs (md0p1): mounted filesystem with ordered data
mode. Opts: (null)

> >
> > What about doing this:
> >
> > Made the array read only.
> > Copy the whole array using dd to a larger array on a different machine
> > (good overnight job).
> > Then run something like testdisk on the whole array.
> > The last would largely be a waste of time as what has
> > disappeared is one of about 40 upper level directories  and
> > it likely contained about 10 to 50 GB of files (dunno how many
> > levels of directories though - - - I use LOTS).
> >
> > I'm looking for a reasonably solid method of trying to recover
> > this directory and all of its contents (about 8 years worth of
> > putting things into it so replicating it - - - - tough!).
>
> Making the original data read-only and operating on a copy of it is a reasonable idea.

Reading the 'man' page I think the command to change the array to read-only
would be mdadm /name/of/array --readonly

Is that correct?
>
> You probably want http://extundelete.sourceforge.net/ though I would first try
>
> find / -name "somefileyouknowthenameof"
>
> just to make sure it hasn't been moved elsewhere on accident. That seems like the most likely scenario given the lack of error messages, unless no
> messages at all have been logged due to previously mentioned issues.
>
Ran the suggested - - - - - well - - - - somehow I managed to drop the directory
into a much smaller one. Dunno how that happened or any details (if someone
cares to give method(s) and means for determining that I would be very
grateful!) but I have now found the missing directory and its contents
seem to be intact.

I did understand that maybe asking on the linux-raid 'exchange' might not
have been the 'best' place to do so but this seemed quite weird and the
directory was on a raid-array and I thought that maybe this could be a signal
that there were more issues brewing. That seems now not to be the case.

Thank you to those who took the time to give suggestions or ideas with
the end result that the issue was resolved!!

Thanks a muchly!!!!
(hope that the subject change and adding that the issue was resolved
is appropriate
for this group)
