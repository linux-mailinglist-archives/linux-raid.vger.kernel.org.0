Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5D122F47
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfLQOv1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 09:51:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbfLQOv1 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 17 Dec 2019 09:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576594286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rg5FIy6RGPLxIimpARPAy2Gnvy607s5mPsnm2wlJocM=;
        b=h37OVnVkcbh/JpHslkRAmCnvdss9+EkLCVLe/s2pAHflppk4fViGhwlBNuiijkHX5UTML+
        gdkZkgUAyk3+U9mUE55OC+oUiGdRAZ22o3Py/Mjtp+2mdiuIqpgCsqxWX9XOFHU42PC8t8
        3Oc1qSObTZ2xGQE3GScc3vaCv249UgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-nV7jC6cfNO2ZysefSiK9lA-1; Tue, 17 Dec 2019 09:51:22 -0500
X-MC-Unique: nV7jC6cfNO2ZysefSiK9lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631761005502;
        Tue, 17 Dec 2019 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9832860BE0;
        Tue, 17 Dec 2019 14:51:19 +0000 (UTC)
Subject: Re: Broken Environment syntax in
 mdcheck_start/mdcheck_continue.service
To:     Jes Sorensen <jes@trained-monkey.org>,
        Jes Sorensen <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>
References: <60128448-c1e6-5155-7ad8-fc19493fc9b1@redhat.com>
 <8a6600ec-2b4a-50e9-bfb0-b3d9331a8a54@trained-monkey.org>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <5cd5a7ea-5cff-1504-35a3-ca48101efbfb@redhat.com>
Date:   Tue, 17 Dec 2019 22:51:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8a6600ec-2b4a-50e9-bfb0-b3d9331a8a54@trained-monkey.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes

Thanks. I'll send the patch later by git send-email.

Thanks

Xiao


On 12/17/2019 10:28 PM, Jes Sorensen wrote:
> Hi Xiao,
>
> Can you please sent a patch that has the proper signed-off-by line.
>
> Also your mail client is broken, it states UTF-8 but there's what looks
> like quoted-unreadble stuff in the description text.
>
> Thanks,
> Jes
>
> On 12/17/19 9:24 AM, Xiao Ni wrote:
>> Hi all
>>
>> In rhel7 we encounter one systemd service failed problem.
>>
>> [root@intel-rosecity-07 ~]# systemctl start mdcheck_start
>> [root@intel-rosecity-07 ~]# systemctl status mdcheck_start -l
>> =E2=97=8F mdcheck_start.service - MD array scrubbing
>>     Loaded: loaded (/usr/lib/systemd/system/mdcheck_start.service;
>> static; vendor preset: disabled)
>>     Active: inactive (dead)
>>
>> Dec 17 09:16:59 intel-rosecity-07.khw1.lab.eng.bos.redhat.com
>> systemd[1]: [/usr/lib/systemd/system/mdcheck_start.service:14] Invalid
>> environment assignment, ignoring: MDADM_CHECK_DURATION=3D"6 hours"
>>
>> This patch can fix this problem. So is it a systemd syntax problem? Th=
e
>> service can start sucessfully in rhel8.
>>
>> diff --git a/systemd/mdcheck_start.service b/systemd/mdcheck_start.ser=
vice
>> index f17f1aa..da62d5f 100644
>> --- a/systemd/mdcheck_start.service
>> +++ b/systemd/mdcheck_start.service
>> @@ -11,7 +11,7 @@ Wants=3Dmdcheck_continue.timer
>>
>>   [Service]
>>   Type=3Doneshot
>> -Environment=3D MDADM_CHECK_DURATION=3D"6 hours"
>> +Environment=3D "MDADM_CHECK_DURATION=3D6 hours"
>>   EnvironmentFile=3D-/run/sysconfig/mdadm
>>   ExecStartPre=3D-/usr/lib/mdadm/mdadm_env.sh
>>   ExecStart=3D/usr/share/mdadm/mdcheck --duration ${MDADM_CHECK_DURATI=
ON}
>>
>>
>> Best Regards
>>
>> Xiao
>>
>>
>
>

