Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE401CED0E
	for <lists+linux-raid@lfdr.de>; Tue, 12 May 2020 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELGf0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 12 May 2020 02:35:26 -0400
Received: from [59.100.172.133] ([59.100.172.133]:52822 "EHLO
        hammer.websitemanagers.com.au" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGf0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 12 May 2020 02:35:26 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2020 02:35:25 EDT
Received: (qmail 13172 invoked by uid 1011); 12 May 2020 06:27:59 -0000
Received: from 192.168.5.112 by hammer (envelope-from <mailinglists@websitemanagers.com.au>, uid 1008) with qmail-scanner-1.24 
 (clamdscan: 0.102.1/25738. spamassassin: 3.4.2.  
 Clear:RC:1(192.168.5.112):. 
 Processed in 0.04229 secs); 12 May 2020 06:27:59 -0000
Received: from unknown (HELO ADAM-MBP.local) (adamg+websitemanagers.com.au@192.168.5.112)
  by 0 with ESMTPA; 12 May 2020 06:27:59 -0000
Subject: Re: raid6check extremely slow ?
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Wolfgang Denk <wd@denx.de>, linux-raid@vger.kernel.org
References: <20200510120725.20947240E1A@gemini.denx.de>
 <2cf55e5f-bdfb-9fef-6255-151e049ac0a1@cloud.ionos.com>
 <20200511064022.591C5240E1A@gemini.denx.de>
 <f003a8c7-e96d-ddc3-6d1d-42a13b70e0b6@cloud.ionos.com>
 <20200511161415.GA8049@lazy.lzy>
 <CAOxFTcyH8ET=DXsm7RQ3eVbxg+6g+nX-apwahBejniGz1QR2+g@mail.gmail.com>
 <59cd0b9f-b8ac-87c1-bc7e-fd290284a772@cloud.ionos.com>
 <d350c913-0ec6-c1a2-fb41-1fa0dec6632f@cloud.ionos.com>
 <CAOxFTcyj6-8PJwrhfCptZkOPW7iciQOUxuazCcAUnXgnD-d3kg@mail.gmail.com>
From:   Adam Goryachev <mailinglists@websitemanagers.com.au>
Organization: Website Managers
Message-ID: <dbc3f2ee-589e-9347-6918-a1f544721443@websitemanagers.com.au>
Date:   Tue, 12 May 2020 16:27:59 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOxFTcyj6-8PJwrhfCptZkOPW7iciQOUxuazCcAUnXgnD-d3kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 12/5/20 11:52, Giuseppe Bilotta wrote:
> On Mon, May 11, 2020 at 11:16 PM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>> On 5/11/20 11:12 PM, Guoqing Jiang wrote:
>>> On 5/11/20 10:53 PM, Giuseppe Bilotta wrote:
>>>> Would it be possible/effective to lock multiple stripes at once? Lock,
>>>> say, 8 or 16 stripes, process them, unlock. I'm not familiar with the
>>>> internals, but if locking is O(1) on the number of stripes (at least
>>>> if they are consecutive), this would help reduce (potentially by a
>>>> factor of 8 or 16) the costs of the locks/unlocks at the expense of
>>>> longer locks and their influence on external I/O.
>>>>
>>> Hmm, maybe something like.
>>>
>>> check_stripes
>>>
>>>      -> mddev_suspend
>>>
>>>      while (whole_stripe_num--) {
>>>          check each stripe
>>>      }
>>>
>>>      -> mddev_resume
>>>
>>>
>>> Then just need to call suspend/resume once.
>> But basically, the array can't process any new requests when checking is
> Yeah, locking the entire device might be excessive (especially if it's
> a big one). Using a granularity larger than 1 but smaller than the
> whole device could be a compromise. Since the “no lock” approach seems
> to be about an order of magnitude faster (at least in Piergiorgio's
> benchmark), my guess was that something between 8 and 16 could bring
> the speed up to be close to the “no lock” case without having dramatic
> effects on I/O. Reading all 8/16 stripes before processing (assuming
> sufficient memory) might even lead to better disk utilization during
> the check.

I know very little about this, but could you perhaps lock 2 x 16 
stripes, and then after you complete the first 16, release the first 16, 
lock the 3rd 16 stripes, and while waiting for the lock continue to 
process the 2nd set of 16?

Would that allow you to do more processing and less waiting for 
lock/release?

Regards,
Adam

