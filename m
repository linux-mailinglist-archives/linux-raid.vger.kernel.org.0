Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5862F1FFC40
	for <lists+linux-raid@lfdr.de>; Thu, 18 Jun 2020 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgFRUGW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 18 Jun 2020 16:06:22 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17466 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFRUGV (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 18 Jun 2020 16:06:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592510762; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=WHm0I1MIV3xROxJrak2xhLthx0bOGQB3YzRvcnwCIut5Av3fG6dVtSTgRG+YaQGvNUjgxGdgMwcUtQB4+yJCGOltoDp9BLQLgnMrl7WAM6Tci2Koi6PyBoMkSGM9gG+shq5DB0dyBYhTIihCesnEQODdLoWVVFbUoUrm4Fix+3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1592510762; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ImAkaf/7fRnINWQZjVUBgTLY9Nd9BTtrLazmu2r/NDc=; 
        b=DCYGwgV2m86HVu/OTAREeWgWGXrpbhc8AmXs1pMjecyjKKRUw+oYSOpHHcQkyvLLpCE37fSIaBrALyFKoDa9d3tWvcvEiKvgTphSy6LguyGhhHo6TdNnfEkTrftqoefRFFkpOXsIxWkj0WoIBvaFcp6bJeC8RHN2ARnDah2qdhU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.165.210] (163.114.130.7 [163.114.130.7]) by mx.zoho.eu
        with SMTPS id 159251076101517.733336576227657; Thu, 18 Jun 2020 22:06:01 +0200 (CEST)
Subject: Re: [PATCH] mdadm/Grow: prevent md's fd from being occupied during
 delayed time
To:     allenpeng <allenpeng@synology.com>, linux-raid@vger.kernel.org
Cc:     jes.sorensen@gmail.com
References: <1591952439-8768-1-git-send-email-allenpeng@synology.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <a19f6d66-09d8-6c7d-59f7-762395dd22ea@trained-monkey.org>
Date:   Thu, 18 Jun 2020 16:05:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591952439-8768-1-git-send-email-allenpeng@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 6/12/20 5:00 AM, allenpeng wrote:
> If we start reshaping on md which shares sub-devices with another
> resyncing md, it may be forced to wait for others to complete. mdadm
> occupies the md's fd during this time, which causes the md can not be
> stopped and the filesystem can not be mounted on the md. We can close
> md's fd earlier to solve this problem.
> 
> Reproducible Steps:
> 
> 1. create two partitions on sda, sdb, sdc, sdd
> 2. create raid1 with sda1, sdb1
> mdadm -C /dev/md1 --assume-clean -l1 -n2 /dev/sda1 /dev/sdb1
> 3. create raid5 with sda2, sdb2, sdc2
> mdadm -C /dev/md2 --assume-clean -l5 -n3 /dev/sda2 /dev/sdb2 /dev/sdc2
> 4. start resync at md1
> echo repair > /sys/block/md1/md/sync_action
> 5. reshape raid5 to raid6
> mdadm -a /dev/md2 /dev/sdd2
> mdadm --grow /dev/md2 -n4 -l6 --backup-file=/root/md2-backup
> 
> Now mdadm is occupying the fd of md2, causing md2 unable to be stopped
> 
> 6.Try to stop md2, an error message shows
> mdadm -S /dev/md2
> mdadm: Cannot get exclusive access to /dev/md3:Perhaps a running process,
> mounted filesystem or active volume group?
> 
> Reviewed-by: Alex Wu <alexwu@synology.com>
> Reviewed-by: BingJing Chang <bingjingc@synology.com>
> Reviewed-by: Danny Shih <dannyshih@synology.com>
> Signed-off-by: ChangSyun Peng <allenpeng@synology.com>

Applied!

Thanks,
Jes

