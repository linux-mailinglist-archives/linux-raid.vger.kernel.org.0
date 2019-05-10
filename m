Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7334A19FF6
	for <lists+linux-raid@lfdr.de>; Fri, 10 May 2019 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEJPRA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 May 2019 11:17:00 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39419 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfEJPRA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 May 2019 11:17:00 -0400
Received: by mail-lf1-f52.google.com with SMTP id f1so4413583lfl.6
        for <linux-raid@vger.kernel.org>; Fri, 10 May 2019 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wNeQfkei9d9to8479UlrG19Zd1Sl/xiFqVxADCMcvvQ=;
        b=f0yhCahIuYSdnez+fdooj8enER0rNvdu5ji282OwTE8qF6cI0Wv8iXowhCjM1k0n2T
         p/l146HJzVhsI0LCI7cbXyWLZKnbrc63N7lf0C5BQWZd5tQqCwYCseJOu//k/tRU1pfO
         N5O3goAWroDen40JXCyIw8XV57K8t7SdvK/rldKW5OljFYmkjzJTr7Biioqh9oglzaHt
         bNxJtzdgapZ5F2a+QaQhAYO0APWAGrIRxP6ukXMRsvdTLuGZX554TbGJGfCCLBubQqlT
         3nKOkhFHiUP4H/S7Ko1L8Qgjlb2ib96kqdk+oRKq5c1h32E5YUhVmtfSdAX/MpAKXt79
         BH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wNeQfkei9d9to8479UlrG19Zd1Sl/xiFqVxADCMcvvQ=;
        b=SPvaWmzaq4coVyodRkIJrTmw+nAw3DLRgAIluoO61iGXdPAQPWktHhgD3x9vKR+Dyq
         pnq5f6g9pjpLgspaPhGkl1wZUTEMYSLhm4pJhlgBQvTgbTaYT9Hlx53OGv/wHUPwb3eg
         u10gpMww+dzYUJjIsBe7N08d9MhPvERIKuFwFCfinsqg+gLlAiFyPZ3zSt3Zxrh6l+eA
         LMqNEtbkXC0b3X72kLOZarRovpg9bzI2O1Vbrp60HzVLdPjWOrsNAvp+j7Yl3VFEAD9l
         wks2b+Xplm9J0Pc4XIBHVnTmVD/ZydAczQKbTBjOZzn1r0UYyl3HsovK5Uh3X+DBLWJq
         Cy7g==
X-Gm-Message-State: APjAAAVUWzSaXZ2TXQR3q4oh4DXadZErA4VV3RNChZ9w2WxZ2ofGv5b+
        tE1VSQmURE7yGfa5WDrqpjDAM7ucA2j3XpTnStcRIA==
X-Google-Smtp-Source: APXvYqwoRMU3YbLoVauM+DrznTRHchLMjxIOL6G8N8nRf7V1oS9RDD1oXS4WXd143TCbk92x99LrT7G0pWyv8vhfk2k=
X-Received: by 2002:ac2:443c:: with SMTP id w28mr6324099lfl.38.1557501417521;
 Fri, 10 May 2019 08:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net> <1486566915.13433540.1557468499945.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <1486566915.13433540.1557468499945.JavaMail.zimbra@karlsbakk.net>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Fri, 10 May 2019 10:16:45 -0500
Message-ID: <CAAMCDecuOER88FMdvpoBpGTy8wHBSXVtaf5u7xJzyGHC4qoK6Q@mail.gmail.com>
Subject: Re: ID 5 Reallocated Sectors Count
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have found the max number it can get to depends on the disk/mfg.
Older seagates only did 512, newer 1.5's could get to 4096 if I am
remembering correctly.  I do know for sure that the newer disk I had
went much higher before the disk itself officially failed.

I have found disks that aren't reporting re-allocates, but respond
poorly, and seem to be hitting close to the 7 second timeout and cause
large IO pauses, and it is just best to replace the disk when it
starts acting up like that.

On Fri, May 10, 2019 at 1:10 AM Roy Sigurd Karlsbakk <roy@karlsbakk.net> wr=
ote:
>
> > I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (fr=
om SMART)
> > is climbing frantically on one disk. It's a r6 so it shouldn't be much =
of an
> > issue once the disk eventually fails, but does anyone out there know ho=
w many
> > reallocated sectors you can have on a drive? This is an older 1TB ST310=
00524NS
>
> To sum this up, it climbed quite a bit until the whole machine just hung,=
 reponsiveless. After this, the named disk was replaced and the new disk ad=
ded to the raid. Things work now, and I (or we) have learned that if given =
flag climbes this quickly, better replace the bugger in the first place :)
>
> Vennlig hilsen
>
> roy
> --
> Roy Sigurd Karlsbakk
> (+47) 98013356
> http://blogg.karlsbakk.net/
> GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
> --
> Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =
=C3=AD snj=C3=B3 rita.
