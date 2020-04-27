Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB34E1BA6C2
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgD0Oot (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 10:44:49 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17134 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgD0Oos (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587998681; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=VGWFEZZ6e4unssKRvuEWN51qDeUUelUSl/l2II5pBpE7sRGDB193Hmn6xkXAQKEIj5/q0dghZMBig8fem5+zSSTxqhY7HwYzMY7mmlYa8wTwpPV1eS7jdlti8Ba6En/ihQsl7/MGsfpBhYLilpYeRbtUJa3SqK3wBFNhvuf0QzY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587998681; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JOz63ygnE0M94eFHYG4Y+QU/3aSlg8O6YKlLKl9wKr4=; 
        b=ZtqBDk/CzwOy1v/mrY0IGblHP1mFp4FqXFh3u30pq5HWJDksIhfaVGs/61TuOlWx9C1uwqPXGYbSdoMarMn+2wyeYf+e0/5kUCHnc9BmlQ/3lnFOFuCLhLXP3c5seLEC5EXVTDfcroauELU39Zw3GoHJ5h6yZmE/iSGke2Oe8C0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 158799867997425.24385601648919; Mon, 27 Apr 2020 16:44:39 +0200 (CEST)
Subject: Re: [PATCH] Assemble: print error message if mdadm fails assembling
 with --uuid option
To:     Gioh Kim <gi-oh.kim@cloud.ionos.com>, linux-raid@vger.kernel.org
Cc:     neilb@suse.com, jsorensen@fb.com, jinpu.wang@cloud.ionos.com
References: <20190416160817.10526-1-gi-oh.kim@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <291d7ab2-34f8-8f6e-cbd3-18113d9226be@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:44:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20190416160817.10526-1-gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/16/19 12:08 PM, Gioh Kim wrote:
> When mdadm tries to assemble one working device and one zeroed-out device,
> it failed but print successful message because there is --uuid option.
> 
> Following script always reproduce it.
> 
> dd if=/dev/zero of=/dev/ram0 oflag=direct
> dd if=/dev/zero of=/dev/ram1 oflag=direct
> ./mdadm -C /dev/md111 -e 1.2 --uuid="12345678:12345678:12345678:12345678" \
>     -l1 -n2 /dev/ram0 /dev/ram1
> ./mdadm -S /dev/md111
> dd if=/dev/zero of=/dev/ram1 oflag=direct
> ./mdadm -A /dev/md111 --uuid="12345678:12345678:12345678:12345678" \
>     /dev/ram0 /dev/ram1
> 
> Following is message from mdadm.
> 
> mdadm: No super block found on /dev/ram1 (Expected magic a92b4efc, got 00000000)
> mdadm: no RAID superblock on /dev/ram1
> mdadm: /dev/md111 assembled from 1 drive - need all 2 to start it (use --run to insist).
> 
> The mdadm say that it assembled but mdadm does not create /dev/md111.
> The message is wrong.
> 
> After applying this patch, mdadm reports error correctly as following.
> 
> mdadm: No super block found on /dev/ram1 (Expected magic a92b4efc, got 00000000)
> mdadm: no RAID superblock on /dev/ram1
> mdadm: /dev/ram1 has no superblock - assembly aborted
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Applied!

This looks like an ideal case for something to be added to the test suite.

Thanks,
Jes
