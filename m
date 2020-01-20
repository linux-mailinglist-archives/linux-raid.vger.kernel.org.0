Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA314267E
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jan 2020 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgATJAI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jan 2020 04:00:08 -0500
Received: from smtp1.servermx.com ([134.19.178.79]:47220 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATJAH (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 20 Jan 2020 04:00:07 -0500
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 04:00:07 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7TTT9JlPFCtW5c9oIFTcDeu9mN1w1wwzxC1OEYepS9E=; b=Lt5iCYyTiDgEGQL/rHFjVvW4sv
        5KkGVpeYvpvqxuT5mFVAexF0m4ME7l5Bpzgh+/MXoKrfuqsioaoojLMRucSEtVjxmVBngV2r7Sh7z
        JcD9tcVJpCHBjtYRcSNXSLLYk0o1vVp5QeXCaBIzVy9v9ZtUEALfg9hSAzungeTyXvJA=;
Received: by exim4; Mon, 20 Jan 2020 09:49:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7TTT9JlPFCtW5c9oIFTcDeu9mN1w1wwzxC1OEYepS9E=; b=Lt5iCYyTiDgEGQL/rHFjVvW4sv
        5KkGVpeYvpvqxuT5mFVAexF0m4ME7l5Bpzgh+/MXoKrfuqsioaoojLMRucSEtVjxmVBngV2r7Sh7z
        JcD9tcVJpCHBjtYRcSNXSLLYk0o1vVp5QeXCaBIzVy9v9ZtUEALfg9hSAzungeTyXvJA=;
Received: by exim4; Mon, 20 Jan 2020 09:49:47 +0100
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id D086F6A74BA; Mon, 20 Jan 2020 08:49:44 +0000 (GMT)
Date:   Mon, 20 Jan 2020 08:49:44 +0000
From:   Robin Hill <robin@robinhill.me.uk>
To:     William Morgan <therealbrewer@gmail.com>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
Message-ID: <20200120084944.GA8538@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: William Morgan <therealbrewer@gmail.com>,
        Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
 <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk>
 <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk>
 <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk>
 <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun Jan 19, 2020 at 11:02:54AM -0600, William Morgan wrote:

> bill@bill-desk:~$ sudo lsblk -f
> NAME    FSTYPE            LABEL       UUID
>     FSAVAIL FSUSE% MOUNTPOINT
> .
> .
> .
> sdj
> └─sdj1  linux_raid_member bill-desk:0
> 06ad8de5-3a7a-15ad-8811-6f44fcdee150
>   └─md0 ext4
> ceef50e9-afdd-4903-899d-1ad05a0780e0
> sdk
> └─sdk1  linux_raid_member bill-desk:0
> 06ad8de5-3a7a-15ad-8811-6f44fcdee150
>   └─md0 ext4
> ceef50e9-afdd-4903-899d-1ad05a0780e0
> sdl
> └─sdl1  linux_raid_member bill-desk:0
> 06ad8de5-3a7a-15ad-8811-6f44fcdee150
>   └─md0 ext4
> ceef50e9-afdd-4903-899d-1ad05a0780e0
> sdm
> └─sdm1  linux_raid_member bill-desk:0
> 06ad8de5-3a7a-15ad-8811-6f44fcdee150
>   └─md0 ext4                          ceef50e9-afdd-4903-899d-1ad05a0780e0
> 
> But then I get confused about the UUIDs. I'm trying to automount the
> array using fstab (no unusual settings in there, just defaults), but
> I'm not sure which of the two UUIDs above to use. So I look at mdadm
> for help:
> 
> bill@bill-desk:~$ sudo mdadm --examine --scan
> ARRAY /dev/md/0  metadata=1.2 UUID=06ad8de5:3a7a15ad:88116f44:fcdee150
> name=bill-desk:0
> 
> However, if I use this UUID starting with "06ad", then I get an error:
> 
> bill@bill-desk:~$ sudo mount -all
> mount: /media/bill/STUFF: mount(2) system call failed: Structure needs cleaning.
> 
> But I don't know how to clean it if fsck says it's OK.
> 
> On the other hand, if I use the UUID above starting with "ceef", then
> it mounts and everything seems OK.
> 
> Basically, I don't understand why lsblk lists two UUIDs for the array,
> and why mdadm gives the wrong one in terms of mounting. This is where
> I was confused before about the UUID changing. Any insight here?
> 

One is the UUID for the array (starting with "06ad") - this is what you
use in /etc/mdadm.conf. The second is the UUID for the filesystem you
have on the array (starting with "ceef") - that's used in /etc/fstab. If
you recreate the filesystem then you'll get a different filesystem UUID
but keep the same array UUID.

Cheers,
    Robin
-- 
     ___        
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |
