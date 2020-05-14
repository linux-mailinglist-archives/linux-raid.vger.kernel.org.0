Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A260A1D3831
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgENR3i (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 13:29:38 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:49786 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgENR3h (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 May 2020 13:29:37 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 13:29:37 EDT
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id BE9F13C251B;
        Thu, 14 May 2020 19:20:27 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id r7Ao8_aiTmF4; Thu, 14 May 2020 19:20:25 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 9291B3C2750;
        Thu, 14 May 2020 19:20:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 9291B3C2750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1589476825;
        bh=ikz1/fHOvopxM7ByaZ9RL80eCjXKy0j6DZVC7NujUMY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=xSprWziyC0OIqXZsHnWIg4z26WN5FBGPUo5YNYuXvDI+5hy1kCuh2b8WWO9g7OCCN
         MmiV5quNz67gL1SOd8S8/xsrPNUzWYANRWuI9nWlUPU6UVR6Xh+rWUU5RmKO1EKISg
         KCS0M1gp7jzTHd9or0YdAXbTRcUK5AstKzES5pMT+oDF+W3eTDNcZ0P51easrICPCt
         r0GH4M9U06tH7rhzhJHkiB94NYKEDxjZ53KqidFTOFHerQ2pVjUqMWYMEyEpY+fQA8
         r5bO4lWYSpvpD/RQgpFSDsaz6KVKCEktkJRS7flZX6ods2QxXkWcg1hIi/PG7aBTDJ
         5LW2UMyF00Ltg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rN_HTE2jKJI9; Thu, 14 May 2020 19:20:25 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 6DFA93C251B;
        Thu, 14 May 2020 19:20:25 +0200 (CEST)
Date:   Thu, 14 May 2020 19:20:24 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     Wolfgang Denk <wd@denx.de>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1999694976.3317399.1589476824607.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <20200510120725.20947240E1A@gemini.denx.de>
References: <20200510120725.20947240E1A@gemini.denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:31.45.45.239]
X-Mailer: Zimbra 8.8.10_GA_3801 (ZimbraWebClient - FF75 (Mac)/8.8.10_GA_3786)
Thread-Topic: raid6check extremely slow ?
Thread-Index: 4APnrFQ7P+ITKw6iZQvC4acBGQv6cQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

> I'm running raid6check on a 12 TB (8 x 2 TB harddisks)
> RAID6 array and wonder why it is so extremely slow...
> It seems to be reading the disks only a about 400 kB/s,
> which results in an estimated time of some 57 days!!!
> to complete checking the array.  The system is basically idle, there
> is neither any significant CPU load nor any other I/o (no to the
> tested array, nor to any other storage on this system).
>=20
> Am I doing something wrong?

Try checking with iostat -x to see if one disk is performing worse than the=
 other ones. This sometimes happens and can indicate a failure that the nor=
mal SMART/smartctl stuff can't identify. If you see a utilisation of one of=
 the disks at 100%, that's the bastard. Under normal circumstances, you pro=
bably won't be able to return that, since it "works". There's a quick fix f=
or that, though. Just unplug the disk, plug it into a power cable, let it s=
pin up and then sharpy twist it 90 degees a few times, and it's all sorted =
out and you can return it ;)

Vennlig hilsen

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =C3=
=AD snj=C3=B3 rita.
