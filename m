Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8C1D7FEA
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgERRS2 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 13:18:28 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17163 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRS1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 13:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589822301; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HTOn3f0oqFNCRJuVW7LRTuA16PlUEb5VEEN8uskTuObigYojy0RSy4VJQBcsYI8GqE1mS62pQ/zi55m52S78oQweDrxuykfOBKwL95MYLk5N4T2C+8H/bi0H+GNxOg0b2Kns9Yt3vhQCzVhBpLE0mWxk/aU0yuf8IZJTf/q1WH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589822301; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ubnzvf0R7n57Nxi6FZxvwDPxh8U/P7Ezw76Xdgm+Dv4=; 
        b=GN+59E5GQzRuwNRUMhc6rEpJCg9jDSaMqMxv4eJhOqmtUjFo4Ghx1D06ajSAodwkdUA2Q38mTkRXcsFJQW39VYbjTnIXIp0t9HlYXT6vwiLLLmr30aYQoQDcUjV12exWaIQAhOOeAqJtMyCT8oazyyB4H3XfYqSVA1Vsux95Qa4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 15898222989751015.9736893525348; Mon, 18 May 2020 19:18:18 +0200 (CEST)
Subject: Re: [PATCH 1/2] uuid.c: split uuid stuffs from util.c
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org,
        Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>
References: <20200515134026.8084-1-guoqing.jiang@cloud.ionos.com>
 <20200515134026.8084-2-guoqing.jiang@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <c06c34ec-c3f7-7abb-c1eb-642c52b04d63@trained-monkey.org>
Date:   Mon, 18 May 2020 13:18:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515134026.8084-2-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/15/20 9:40 AM, Guoqing Jiang wrote:
> Currently, 'make raid6check' is build broken since commit b06815989
> ("mdadm: load default sysfs attributes after assemblation").
> 
> /usr/bin/ld: sysfs.o: in function `sysfsline':
> sysfs.c:(.text+0x2707): undefined reference to `parse_uuid'
> /usr/bin/ld: sysfs.c:(.text+0x271a): undefined reference to `uuid_zero'
> /usr/bin/ld: sysfs.c:(.text+0x2721): undefined reference to `uuid_zero'
> 
> Apparently, the compile of mdadm or raid6check are coupled with uuid
> functions inside util.c. However, we can't just add util.o to CHECK_OBJS
> which raid6check is needed, because it caused other worse problems.
> 
> So, let's introduce a uuid.c file which is indenpended file to fix the
> problem, all the contents are splitted from util.c.
> 
> Cc: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  Makefile |  6 ++--
>  util.c   | 87 -----------------------------------------------------
>  uuid.c   | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 90 deletions(-)
>  create mode 100644 uuid.c

I am fine with this change, but uuid.c needs to respect the license
header that was in util.c

Jes

