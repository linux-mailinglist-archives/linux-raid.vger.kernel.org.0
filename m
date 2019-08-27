Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AF9F3BC
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2019 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfH0UFx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 27 Aug 2019 16:05:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44915 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfH0UFx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 27 Aug 2019 16:05:53 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so995825iog.11
        for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2019 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NpJRUAxfDhQCCxfwlZTeIe73nAzvPLl+flaFew2/aK0=;
        b=SqQDyaR6XAWj96uh56tJkMJdhxwTw4/z8YAsM0DI4SMgn9O1kFVXjJLw12XG3m1H9H
         q5sxvcHTJuOJZ0SF+rxwp232oZU1SxWf0rsS+jph3MRNRNgSyUT5ykGuXzoMI5IGCtr1
         hbJbfSHh5w3DLsopZmdMg54psoyCRL7nIMu+QMq3dHV6KGxNW04JyWorm/ahWjK/Oym+
         eoo2crVa6igqnxDqgklHlIKk8fF5f7f1xRv1X+SM4bE+SimuQYD/OdyVBDMhlPKszb6I
         1cXKi7hnaLEA/6V6km0T8foYGEZFLAj8gUw5jsKtGJkbSjZ3wfRAtQkq08U+PA2hJweH
         UX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NpJRUAxfDhQCCxfwlZTeIe73nAzvPLl+flaFew2/aK0=;
        b=hz/jsJdeCvkPswTPhnV/WAvsW23sNkkGF2PFhx6D1gN6k0Jqsp4knv7mUHNUEncnSL
         JAnrLUyJ/XuX617TZrn0W3aa9qKQnWnT2TtMRnhU3wTV7e5yFFx2nNxbd0+LMMNi3CL7
         Ms+Ne2OYzlfOGMh3wgNr9Kard6qNcHj58OUK9s5yCOwppc1EDYVNUtcU3DFwqm1a9qzt
         crC8r4Uialc8QWTIjzKsIJBQKaWt5EYzk9LbnBJZ/z+SBD1OntAbGAEDWjtmxfw3xI1Y
         6WN7eFNnDduGTYPx59hraEkWhQQzm90NOmt3vdj51o29OBqQFCbvgejMoPuWz98bR051
         dp1w==
X-Gm-Message-State: APjAAAUwT71fLv5UE2wkJbFI9fBZiV6SrMomTbFE2Cp+1P7mA8SZbyiz
        XqMUeVxkZKcl9LKn+W451cbK4A==
X-Google-Smtp-Source: APXvYqwqFm2zxsMeIfdtAX733CpmOiqgG1iaR5pbLJiV6ih10qJUaeAVrGGtGlteW9HVbKnC+NC3pA==
X-Received: by 2002:a02:caa8:: with SMTP id e8mr590991jap.67.1566936352645;
        Tue, 27 Aug 2019 13:05:52 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v23sm124224ioh.58.2019.08.27.13.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:05:51 -0700 (PDT)
Subject: Re: [GIT PULL] md-next 20190827
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Nigel Croxon <ncroxon@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <D4B2FC6B-6939-4EFB-A8A6-9105C04AFAFB@fb.com>
 <43e21a6d-b1e5-b91d-9320-2b90bd230cab@kernel.dk>
 <2E921D63-D2AB-43D0-B7D8-6A10CD06CA4B@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7259a5b2-966b-159a-dcb3-3a88de184b4e@kernel.dk>
Date:   Tue, 27 Aug 2019 14:05:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2E921D63-D2AB-43D0-B7D8-6A10CD06CA4B@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/27/19 2:03 PM, Song Liu wrote:
> Hi Jens,
> 
>> On Aug 27, 2019, at 12:58 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/27/19 1:47 PM, Song Liu wrote:
>>> Hi Jens,
>>>
>>> Please consider pulling the following patches for md on top of your for-5.4/block
>>> branch.
>>>
>>> Thanks,
>>> Song
>>>
>>>
>>>
>>> The following changes since commit 97b27821b4854ca744946dae32a3f2fd55bcd5bc:
>>>
>>>    writeback, memcg: Implement foreign dirty flushing (2019-08-27 09:22:38 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
>>>
>>> for you to fetch changes up to 0009fad033370802de75e4cedab54f4d86450e22:
>>>
>>>    raid5 improve too many read errors msg by adding limits (2019-08-27 12:36:37 -0700)
>>>
>>> ----------------------------------------------------------------
>>> NeilBrown (2):
>>>        md: only call set_in_sync() when it is expected to succeed.
>>>        md: don't report active array_state until after revalidate_disk() completes.
>>>
>>> Nigel Croxon (1):
>>>        raid5 improve too many read errors msg by adding limits
>>
>> You've cut the bottom part of this off, which is a bit problematic as I
>> always verify that the diffstat matches between what you send and what
>> I pull.
>>
> 
> Sorry for this problem. Here is the full note from git-request-pull:
> 
> Thanks,
> Song
> 
> 
> 
> The following changes since commit 97b27821b4854ca744946dae32a3f2fd55bcd5bc:
> 
>    writeback, memcg: Implement foreign dirty flushing (2019-08-27 09:22:38 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
> 
> for you to fetch changes up to 0009fad033370802de75e4cedab54f4d86450e22:
> 
>    raid5 improve too many read errors msg by adding limits (2019-08-27 12:36:37 -0700)
> 
> ----------------------------------------------------------------
> NeilBrown (2):
>        md: only call set_in_sync() when it is expected to succeed.
>        md: don't report active array_state until after revalidate_disk() completes.
> 
> Nigel Croxon (1):
>        raid5 improve too many read errors msg by adding limits
> 
>   drivers/md/md.c    | 14 +++++++++-----
>   drivers/md/md.h    |  3 +++
>   drivers/md/raid5.c | 14 ++++++++++----
>   3 files changed, 22 insertions(+), 9 deletions(-)

Thanks, that's what I got, too.

-- 
Jens Axboe

