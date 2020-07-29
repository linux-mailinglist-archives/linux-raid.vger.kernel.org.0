Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1023172B
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 03:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgG2BVD (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Jul 2020 21:21:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32749 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729918AbgG2BVC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Jul 2020 21:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595985661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkAmgW+fbtLYPlYbUoL10BsOjmChoZYntLFs1UC36Jg=;
        b=ffC7rVxWapz8rakbltfYSCMruhdlQy0JTmhTHZAD/bPVFV2hJ9BouRUKdLh7OPphQjKSTh
        T5Xus20Jae7el7CPcRz1LiNyvm44YWbLqm1cBAflj1RPB/B6wYoqQdDvrfMlnAi8AS3ubc
        0uW4zpVQ6OVzFamBc/BS3WB8qD2Un/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-K4k6nFPLPlaSHuDclED28w-1; Tue, 28 Jul 2020 21:13:48 -0400
X-MC-Unique: K4k6nFPLPlaSHuDclED28w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47811DE0;
        Wed, 29 Jul 2020 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F30AB5DA72;
        Wed, 29 Jul 2020 01:13:45 +0000 (UTC)
Subject: Re: [PATCH 1/2] super1.0 calculates max sectors in a wrong way
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>
References: <1593503737-5067-1-git-send-email-xni@redhat.com>
 <1593503737-5067-2-git-send-email-xni@redhat.com>
 <CAPhsuW7WY7kQ77BKBqev2CVFPS63C7u0HtBqkB49XtbRCysWmg@mail.gmail.com>
 <9626595c-cdd8-f46d-629e-67f9b11d2b6a@redhat.com>
 <CAPhsuW5RAEb7i-VQ+MS0XfGKNyd=2_=VoGVjk2SU6A30cW9PKg@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <22684ab9-7c20-f0a3-4045-3357bbf53125@redhat.com>
Date:   Wed, 29 Jul 2020 09:13:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5RAEb7i-VQ+MS0XfGKNyd=2_=VoGVjk2SU6A30cW9PKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 07/29/2020 08:43 AM, Song Liu wrote:
>> Hi Song
>>
>> This calculation of bitmap is decided by mdadm. In mdadm super1.c
>> choose_bm_space function,
>> it uses this way to calculate bitmap space. Do I need to add comments
>> here to describe this?
>> Something like "mdadm function choose_bm_space decides the bitmap space"?
> Thanks for the explanation.
>
> I merged the two patches, made some changes, and applied it to md-next. Please
> let me know whether it looks good.
>
The function super_10_choose_bm_space can make people confused. All 
types of super1 calculate
bitmap space in the same way (super1.0, 1.1 and 1.2). Could you change 
the function name to
super_1_choose_bm_space?

Thanks
Xiao

