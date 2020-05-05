Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311F31C51DA
	for <lists+linux-raid@lfdr.de>; Tue,  5 May 2020 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEEJZp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 May 2020 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgEEJZo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 May 2020 05:25:44 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE05C061A0F
        for <linux-raid@vger.kernel.org>; Tue,  5 May 2020 02:25:44 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVtpf-0003xA-40; Tue, 05 May 2020 11:25:43 +0200
Subject: Re: RAID 1 | Test Booting from /dev/sdb
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <221092f3-5b8a-5d95-01d9-261e6449f747@peter-speer.de>
 <5EB12900.3030505@youngman.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <608e4d08-a99d-97f3-0476-3a880096f858@peter-speer.de>
Date:   Tue, 5 May 2020 11:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EB12900.3030505@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588670744;97012ca7;
X-HE-SMSGID: 1jVtpf-0003xA-40
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 05.05.20 10:51, Wols Lists wrote:
>> Change boot medium to /dev/sdb
>> and do a "mdadm /dev/md0 --add /dev/sda1" to get it recovered again
>> without loosing the "added" data (i.e. in /var/log) from booting? Also
>> device identifiers could change I guess. Even if I am fine with loosing
>> the "added" data from booting with /dev/sdb, will - when booting again
>> from /dev/sda - /dev/sda be the master in the array again?
>>
>> It is not clear to me if I understood correctly in which case which
>> array member will be the master which will be the base for recovery. Is
>> it always the HD one booted from?
>>
> The "master" if recovery is required will be the "older" one - in this
> case sda because it was disconnected. HOWEVER. Just check whether you
> have a bitmap or journal enabled. You can't have both at once, but the
> result should be that sda rejoins the array cleanly, raid has a record
> of which writes occurred while it was offline, and it will be updated.
> 

Does this mean in my scenario /dev/sda1 will come up again and will held 
data in /var/log/ where I can see i.e. log entries which are written 
when the system booted up using /dev/sdb as boot device?

I try to be prepared, just in case :-)

Thanks again for sharing your knowledge, Wols.
It is highly appreciated.
