Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D0156199
	for <lists+linux-raid@lfdr.de>; Sat,  8 Feb 2020 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGXlF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 18:41:05 -0500
Received: from mail.prgmr.com ([71.19.149.6]:57866 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgBGXlF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 7 Feb 2020 18:41:05 -0500
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id D87A6720127;
        Fri,  7 Feb 2020 23:43:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com D87A6720127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1581136989;
        bh=snphcY8BRGp4rwuXrxQZWWKEFrYPbAMKxuUwaO5R4xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T8t7szOXVCdZBg031PKn/Vq9Ywb7V+hnFerV8eiRDvcpeTN2FH9ksii6cC5o0mStj
         VJ2g1Guza8vdaUxDPbPaR9GSsptgp8KBoZMmtKuiQnL+Iu8CMRwNbgtch02AlP/koe
         Ja5Nn+eV/tPo6fR3q4cE5zcc9Fpnz87W/hMNXwuw=
Subject: Re: Question
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com>
 <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <1faaef72-62ed-2c36-19d7-f6995691779f@prgmr.com>
Date:   Fri, 7 Feb 2020 15:41:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/7/20 3:21 PM, o1bigtenor wrote:
> On Fri, Feb 7, 2020 at 4:50 PM Sarah Newman <srn@prgmr.com> wrote:
>>
>> On 2/7/20 7:49 AM, o1bigtenor wrote:
>>> Greetings
>>>
>>> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
>>> (11) system.
>>> mdadm - v4.1 - 2018-10-01 is the version being used.
>>>
>>> Some weirdness is happening - - - vis a vis - - - I have one directory
>>> (not small) that has disappeared. I last accessed said directory
>>> (still have the pdf open which is how I could get this information)
>>> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
>>> section of the file in question.
>>
> 
> Greetings
> 
> 
>> I assume you've looked at lsof?
> 
> No I hadn't - - - - thanks for the tip.
> only a few thousand line in a terminal - - - - - but nothing what I was
> looking for.
>>
>> https://www.linux.com/news/bring-back-deleted-files-lsof/
>>
>> If it is a software problem, it just as likely, if not more likely, that it is a file system problem rather than a raid problem. You don't mention
>> what file system. You're possibly also actually looking at data in the in-memory disk cache rather than what's actually stored on disk given there's
>> been no reboot.
> 
> The array (raid-10) is on ext4.
>>
>> Is there anything suspicious in dmesg?
> 
> I hadn't looked at the messages files in /var/log so I went back to
> date in question.
> Didn't see anything there either.

I said the command dmesg, not /var/log.

If systemd-journald is broken, or your file system is broken, you could have tons of error messages in dmesg and nothing logged to disk.

> 
> What about doing this:
> 
> Made the array read only.
> Copy the whole array using dd to a larger array on a different machine
> (good overnight job).
> Then run something like testdisk on the whole array.
> The last would largely be a waste of time as what has
> disappeared is one of about 40 upper level directories  and
> it likely contained about 10 to 50 GB of files (dunno how many
> levels of directories though - - - I use LOTS).
> 
> I'm looking for a reasonably solid method of trying to recover
> this directory and all of its contents (about 8 years worth of
> putting things into it so replicating it - - - - tough!).

Making the original data read-only and operating on a copy of it is a reasonable idea.

You probably want http://extundelete.sourceforge.net/ though I would first try

find / -name "somefileyouknowthenameof"

just to make sure it hasn't been moved elsewhere on accident. That seems like the most likely scenario given the lack of error messages, unless no 
messages at all have been logged due to previously mentioned issues.

--Sarah


