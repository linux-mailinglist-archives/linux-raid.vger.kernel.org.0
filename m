Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1274A183DCE
	for <lists+linux-raid@lfdr.de>; Fri, 13 Mar 2020 01:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCMANe (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 20:13:34 -0400
Received: from sonic312-25.consmr.mail.bf2.yahoo.com ([74.6.128.87]:45491 "EHLO
        sonic312-25.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgCMANe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 12 Mar 2020 20:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1584058412; bh=mxGYKHq5VR0J4nApcJPZKDxryCBNznQRuADbTE0HsA4=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=R+nJG4G0PNSt1Gu9OCVrQFUSwqDcWrHVeBjHfJ+Gffbh6/JD7WupN3G+O6l+Yqv5uTzvvf70ePrk1tXZqOLlan1VRgnUCPOvNQOk6GonXlUHTQRLo00E7bkOqsxkSqoEAaVCxjYF06rqLTG5hYSNzfc3n2+JKKjmdIK3LguD2Ok=
X-YMail-OSG: w.JDe64VM1mYyfgN.zH6ge6_tRYYg0urHeNiN0SLx9ZmUnroppk2.0Fg5Dy_mFA
 6qec.2ON55wVTCEAQyhbDmk.uEwrWScGwiFyt_jPRmfohuP.dgp7pYtwNxjI8NBsx9G5xRD5a3P7
 Cq7zFZOR1Z8PhaD2TV2yye6b_vl_hXPShxGuHnT5DC5b_9KaCchkmgDWHXrCDGIBMWNCHMN3oBTm
 sxsA7CGsUYzmX9ugBwGkYFf9bQhDxTxlHu6WYAyj93dD1fRGvns66nTbbynbD_c_3LvIWB027ubZ
 wzWKG7xYCh2YsSetIq_1PIFulXd_V..Qmw5ae0G5UglyK7Yd_UdD_Lcu1DCIiy1pP1hgDdRIWGOy
 VyzteWpUCpJpmEQQW_H9m_qyFg728KTy2MKrG0zpMAoUjXxtRKNVgpEkhxImp49wd7oewtzvodyj
 oSj.JhQNR5BkJx5t3hlfWamXqb2N0Kt0oBcMWbleo6DFQKl4aEio3uaCjqqhasL_Moan7I7o65NR
 bm76lbiraOrnULjoVeRngqWrfAFK_kYpKOqY2T8j.smjcd4S3vQlbv9OU5e0dfzL20QiXUOR97EE
 Xhew_bviGRPvL9vwsH9EUJ8VuIy.DcEQbNAOTHr45R7cx_PMUAPaw._1iLwTR9076m2U9Jb_NtsZ
 jsLzDkdOz2t.HhOUNVdoMpSIg872LN6qUlvqKE3iVTZURGDvxyml_05IzST9yH6FNiLljsQ1eOXI
 VbZC6nDRVTRODRHaiPNMp6lh.yukJEaplFR1JOyxUdoUu5HBQCaDW_9S9W4hG6..BSqQ5gsT9jEN
 3s1HtKwKokZcV5NjAbWDsU6oSu6gyczWR2iJi7dJdsiVVbpKSTet4kvb3HwRiCwQqtRR5eiff8WD
 SgAHk9Gkc1I.quSB.bEJu7lvhedXHOAzaX3.tXj4ITMxlKMYnr0JEzlT1gurmroQDX22nPvVAKg3
 Q4Nd9ga.2c9VlWzJ1VV0rxIcTENJVSGysPactuWs4lrOEEf2Bxof3HPtemUjI3Ta1De70S5tHDad
 opxNfdZndwHO8y799ChIpMg4SPTIOoEknVEFV88.u7jCgSmY3T6Q0x1HR39QzA9BJX.yq2lakmPN
 WAme4nXwoJmpB8Zmam8dKadOp0POuYzaLDze3Uf3yTEgvQpTzPifDIVfkEhtZa2G9pxQshIfuyQM
 hpjci_q9bg.7tBrpth_Uj32jEbZf9ET0bdD57GO1GFKq2zeuz3J_8LFnwgWXMdK5V8PI9.YQJ.FZ
 AbD.snFQtbS_sCf61mX9FFopWQThXafqLUNalORaJXDhkm3j6lhNFxXmW30R2kh_N0FfgCk6p9RI
 KuKahe0VuXIXPtHtjNaGMNa_C2WKwX1r7VRgdEGwU43LuwBzCTR0ifL7qcxz9iRRgYoPvhrVI7.S
 gsOfk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 13 Mar 2020 00:13:32 +0000
Received: by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4ab39671e0937f8cd1d7cc725b9e7677;
          Fri, 13 Mar 2020 00:13:26 +0000 (UTC)
Subject: Re: checkarray not running or emailing
To:     Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
 <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
 <61f5fc7b-bd2a-a151-a228-3d2a6f4d3ee6@fnarfbargle.com>
From:   Leslie Rhorer <lesrhorer@att.net>
Message-ID: <baa6f582-e3ea-7668-568b-0b7da2b3a618@att.net>
Date:   Thu, 12 Mar 2020 19:13:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <61f5fc7b-bd2a-a151-a228-3d2a6f4d3ee6@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Yes, that works just fine, as does the daily email alert whenever 
an array is degraded, but `checkarray --cron --all --idle` doesn't 
produce an email.  It starts the array verification on all the arrays, 
but no status on the processes are sent.

     The normal execution for the script is to submit `echo check >  
/sys/block/mdx/md/sync_action` and then exit.  Obviously, the rest of 
the processes are handled by the scheduler and mdadm. I'm not seeing how 
anything other than mdadm should be generating the status emails.

     So why does `mdadm --monitor --test --oneshot /dev/mdx` produce an 
email message when `echo check > /sys/block/mdx/md/sync_action` produces 
none?  The "new" servers are running mdadm v4.1 under Debian Buster.  
The "old" servers are running mdadm v3.3.2 under Debian Jessie.

On 3/12/2020 4:17 AM, Brad Campbell wrote:
>
> On 12/3/20 09:41, Leslie Rhorer wrote:
>>     Aha! There it is, on both the old and new systems, so it probably 
>> is running.  The question remains, "Why isn't it posting to email?"
>>
> root@srv:~# mdadm --monitor --test --oneshot /dev/md2
> mdadm: Monitor using email address "root" from config file
>
> And in the mail :
>
> This is an automatically generated mail message from mdadm
> running on srv
>
> A TestMessage event had been detected on md device /dev/md2.
>
> Faithfully yours, etc.
>
> P.S. The /proc/mdstat file currently contains the following:
>
> Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
> md2 : active raid1 nvme0n1[2] md5[3](W)
>       952696320 blocks super 1.2 [2/2] [UU]
>       bitmap: 6/8 pages [24KB], 65536KB chunk
>
>
>
> Brad
>
