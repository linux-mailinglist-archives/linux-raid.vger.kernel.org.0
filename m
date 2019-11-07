Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8996BF2F02
	for <lists+linux-raid@lfdr.de>; Thu,  7 Nov 2019 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbfKGNRx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 7 Nov 2019 08:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727142AbfKGNRx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 7 Nov 2019 08:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573132671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp1BvhQ0uMmLaBYZtWxGqBX/tsqlMsHsWvvCokk9I8E=;
        b=LkDenNk9YlquzG/jGubmlEeva8VTOb3ceBfH87pW1O+8mbuTlB4Pb6ZNJZPm6QHIv6/nrw
        jZRHN041sekJt1FW0DtNClh9b7gnlPe8wArKRQmSDXdr4qQbjlHbqkFHKB7Oy2b4CXHAup
        zS3+Akl0DOPwl1XmVbGgVrhtweiFNY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-JT8yGwsHN1CVlof11jyG_w-1; Thu, 07 Nov 2019 08:17:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55286107ACC3;
        Thu,  7 Nov 2019 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBF9B5C298;
        Thu,  7 Nov 2019 13:17:46 +0000 (UTC)
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Wols Lists <antlists@youngman.org.uk>,
        Nigel Croxon <ncroxon@redhat.com>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <a91541f0-f38f-6b9f-b02c-b6b803e9673c@redhat.com>
Date:   Thu, 7 Nov 2019 21:17:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5DC0C34B.1040102@youngman.org.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JT8yGwsHN1CVlof11jyG_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 11/05/2019 08:33 AM, Wols Lists wrote:
> On 04/11/19 20:01, Nigel Croxon wrote:
>> The MD driver for level-456 should prevent re-reading read errors.
>>
>> For redundant raid it makes no sense to retry the operation:
>> When one of the disks in the array hits a read error, that will
>> cause a stall for the reading process:
>> - either the read succeeds (e.g. after 4 seconds the HDD error
>> strategy could read the sector)
>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>> seconds (might be even longer)
> Okay, I'm being completely naive here, but what is going on? Are you
> saying that if we hit a read error, we just carry on, ignore it, and
> calculate the missing block from parity?
>
> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
> or whatever ... :-)
>
Hi Wol

What's the meaning of "two errors on a raid-5"? Two read errors happen=20
on one disk?
Or there are two read errors on two disks?

Regards
Xiao

