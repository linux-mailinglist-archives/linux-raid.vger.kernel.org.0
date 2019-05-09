Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E871858C
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIGuo (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 May 2019 02:50:44 -0400
Received: from zimbra.karlsbakk.net ([193.29.58.196]:38000 "EHLO
        zimbra.karlsbakk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIGuo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 May 2019 02:50:44 -0400
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id CAAAA3C023D;
        Thu,  9 May 2019 08:50:39 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id w7teOIT-6vAA; Thu,  9 May 2019 08:50:38 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 4C1583C0246;
        Thu,  9 May 2019 08:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 4C1583C0246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1557384638;
        bh=Es/eK16psBfUOZGnT8GOqquDfGfrpT38pvgsoZtraJo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tZLERhAsyIVKrrdMOSAIxDhy6A/N8ol++dn2WAj0C4CYwq+0du8QydwzeRHP7mjiM
         p10yUrp9IKsorns5g3utxwLb+McNoTVllBC8MSnWpF+jWkE1JZl0Fp8YpPUhV4/a1c
         Y+r5cwlLXj95mWBF4dWCxPzOAYk6KH7nYbAn+i5zP00baM3j+SQTxlRwcNdGpAUZgA
         cIbc3HiZCD96QOZ3gBip85oLiFb+vatEWNS76d0456HPtbq8VVA00IYZGFddulhvO7
         tQrnobmdPvDPdeyiKCPMyO32x0CaJKbP/46abahwNXvW99L3NH2PapZC3YMsX2EiPl
         NaSc2afefLdEw==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 767CLnrL-cB1; Thu,  9 May 2019 08:50:38 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 265043C023D;
        Thu,  9 May 2019 08:50:38 +0200 (CEST)
Date:   Thu, 9 May 2019 08:50:36 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     NeilBrown <neilb@suse.com>
Cc:     Linux Raid <linux-raid@vger.kernel.org>
Message-ID: <1345381911.13103226.1557384636899.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <87ef58yylo.fsf@notabene.neil.brown.name>
References: <1059881755.12544793.1557239163561.JavaMail.zimbra@karlsbakk.net> <87ef58yylo.fsf@notabene.neil.brown.name>
Subject: Re: Spare pool documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [::ffff:176.11.89.245]
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF66 (Mac)/8.8.10_GA_3786)
Thread-Topic: Spare pool documentation
Thread-Index: 1IHgEiuE+Uv+5lWock/XXQOXcHL/nQ==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>> I came across the phenomonen of 'spare pools', merely mentioned in the manual
>> pages I've found, but just, so I did some testing in my raidtest vm to see if I
>> could make it work. It seems fine by me, but so far I don't have more than one
>> raidset (plus the small one for the root). Are there any official documentation
>> on this except for the few lines in the manual pages?
>>
>> I wrote about my tests here:
>> https://wiki.malinux.no/index.php/Roy's_notes#Spare_pools
> 
> Thank you for sharing your notes.
> There is also
>   https://raid.wiki.kernel.org/index.php/Tweaking,_tuning_and_troubleshooting#Sharing_spare_disks_between_different_arrays
> 
> It is always possible to improve the documentation.  If you have
> specific suggestions of change to make to specific documents, please
> share them.  Maybe even send a patch.


I have no idea where to find the thing to path, but if you want to, you can just grab my example code there. It should be sufficient for most users, (more or less?) regardless of their level of knowledge, since an example is easier to understand than the current text.

roy
