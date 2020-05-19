Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06C1D8C09
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 02:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgESAL4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 20:11:56 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17140 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgESAL4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 20:11:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589847113; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=TmvtjNvjYrY4fQG81kC5ytpgr6gwrPn8lBvrCTACJzAS4l7FGQX1xUnXd3llawUpP2IAWqBMwo6V+zYRFxm243gkizIMaAAmg2jZ0ss89S9oDh5tJfzQpL3yINAADpkE0G4rNieAaTYh969dzJ9YHbfifAQdUSAqCHModVqJz5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589847113; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Wlcd3hU8bhjNWNR9ck2J8Az9K+5jtEV8p1rmhdvZd6k=; 
        b=jxP7mbErBqt7AreF4FltsTmD9wYTlLg2VchP9L7vPtFm+tViU9uFC9W10mkGvVKDbZuvC3ecGueVavC+7SKlIX4M9XYTKSdQHVUOfPVyRMWMImjMyKoppwT4QlbErSxhPJ6L8RAMSRDrco4gMJijX4HAiljJYqPEOHyCifI9cdc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589847111839117.96655313329597; Tue, 19 May 2020 02:11:51 +0200 (CEST)
Subject: Re: [PATCH V3 1/2] uuid.c: split uuid stuffs from util.c
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-raid@vger.kernel.org
References: <20200518215336.29000-1-guoqing.jiang@cloud.ionos.com>
 <20200518215336.29000-2-guoqing.jiang@cloud.ionos.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <de973f06-54ac-de63-61e3-34c07c932c69@trained-monkey.org>
Date:   Mon, 18 May 2020 20:11:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518215336.29000-2-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/18/20 5:53 PM, Guoqing Jiang wrote:
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
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  Makefile |   6 +--
>  util.c   |  87 ------------------------------------------
>  uuid.c   | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 90 deletions(-)
>  create mode 100644 uuid.c

Applied!

Thanks,
Jes


