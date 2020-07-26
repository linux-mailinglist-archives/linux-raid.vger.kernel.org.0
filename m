Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5E022DF87
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jul 2020 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGZNoN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 09:44:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726042AbgGZNoN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 26 Jul 2020 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595771052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BD9zuqacDpwcDwo8zIRLtGsH2lXqS33eKBNZY303ROg=;
        b=bjOU2HQZp0Yn3Ne1xLWdVXdp+Pe3XkOZ/0H4dRBJIpZJG343eTU6NwCJObPVUHxpZCyE+5
        yxbdkBHjZ0vXWClX8mGf0LeAAoLgzDpB6z+xR9qO0fW0ACHQs2bPiIY3qaE/0zs8ljpGL7
        LHsAmR+P/srZ7B8xM3+6Kpy7o8aoVJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-gl-XkLlFPN6z33Ogn3OrCQ-1; Sun, 26 Jul 2020 09:44:08 -0400
X-MC-Unique: gl-XkLlFPN6z33Ogn3OrCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C0B1DE0;
        Sun, 26 Jul 2020 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A49D1001281;
        Sun, 26 Jul 2020 13:44:03 +0000 (UTC)
Subject: Re: [PATCH v2 mdadm 1/1] Specify nodes number when updating cluster
 nodes
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        jes@trained-monkey.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
References: <1595503205-11129-1-git-send-email-xni@redhat.com>
 <5F1D476C.4090605@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <4441f34e-0b04-afcb-8bf7-45d3d605d438@redhat.com>
Date:   Sun, 26 Jul 2020 21:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5F1D476C.4090605@youngman.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/26/2020 05:05 PM, Wols Lists wrote:
> On 23/07/20 12:20, Xiao Ni wrote:
>> Now it allow updating cluster nodes without specify --nodes. It can write superblock
>> with zero nodes. It can break the current cluster. Add this check to avoid this problem.
>>
>> v2: It needs check c.update first to void NULL pointer reference
>                                         ^^^^
> Do you mean "avoid"?

Hi Wol

Yes. Thanks for pointing out the error. I'll re-send the patch

Regards
Xiao

