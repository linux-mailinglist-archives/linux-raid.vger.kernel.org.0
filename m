Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08F21BA68E
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgD0Oh1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 10:37:27 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17193 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgD0Oh1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587998244; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=PLO5mhJqp6BRdsg39Jf7ECI2UN8TrABgfPlA+eDEzs0tCrVJd4/F0lBs2E6W50G9GshRc+w9bxopsXyDXdwE1ptUW+iSozViyDyxk+3NoFBhwghl66NEYvq8aaWCZ041JuKfuVWCiCXTmLK9KmbhD11a+4khpc0h60rLUz5SAgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587998244; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=uql5O4NIPXxlO1Gx3nciiwvHADZe9bqbp1eWp3bXNdc=; 
        b=HMgre2U8bfmcvwVQssyT99lwomujtv9W1vwET97eYRKVK9jWy27bGVam6KHcQNYUOPQm3M3XKIq4IlA9rYZj+eGFF6Th3JNyCUDMWIcUveucscMtEpdnSmQgbHjSSKDEJr8jERbSOpygUbujhE6PlNAq+oa4D4Ha1VqoKGZnEUc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1587998243651724.020759497099; Mon, 27 Apr 2020 16:37:23 +0200 (CEST)
Subject: Re: [PATCH v2] Manage, imsm: Write metadata before add
To:     Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200417115555.24080-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <b674992e-fa21-0d51-9006-5bd620aca96b@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:37:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417115555.24080-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/17/20 7:55 AM, Tkaczyk Mariusz wrote:
> New drive in container always appears as spare. Manager is able to
> handle that, and queues appropriative update to monitor.
> No update from mdadm side has to be processed, just insert the drive and
> ping the mdmon. Metadata has to be written if no mdmon is running (case
> for Raid0 or container without arrays).
> 
> If bare drive is added very early on startup (by custom bare rule),
> there is possiblity that mdmon was not restarted after switch root. Old
> one is not able to handle new drive. New one fails because there is
> drive without metadata in container and metadata cannot be loaded.
> 
> To prevent this, write spare metadata before adding device
> to container. Mdmon will overwrite it (same case as spare migration,
> if drive appears it writes the most recent metadata).
> Metadata has to be written only on new drive before sysfs_add_disk(),
> don't race with mdmon if running.
> 
> Signed-off-by: Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
> ---
> v2: removed unused variable.
> 
>  Manage.c      |  6 +----
>  super-intel.c | 66 +++++++++++++++++++++++++++++++++------------------
>  2 files changed, 44 insertions(+), 28 deletions(-)

Applied!

Thanks,
Jes


