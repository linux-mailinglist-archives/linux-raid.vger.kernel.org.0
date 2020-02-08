Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9A15623E
	for <lists+linux-raid@lfdr.de>; Sat,  8 Feb 2020 02:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHBYz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 20:24:55 -0500
Received: from mail.prgmr.com ([71.19.149.6]:59824 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgBHBYz (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 7 Feb 2020 20:24:55 -0500
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 30196720128;
        Sat,  8 Feb 2020 01:26:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 30196720128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1581143218;
        bh=sOfGim2wfWMiBMZ731NcOtESV42EJJ29M+EfMpJohFg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qAsI4yr+Tfs6VrxnPmyh6A35XaICWE0M9IB38QSmAl0be8j/qIHQ96EW586hoab0e
         2xyireXmpMS46z0j4j+5S3B8LqLyj4kUVx2NCVqRS+lJsL4Y7DBQn4zfrhMDrQhu5s
         qV0OC5MolRIuicOlRGRBUOeYhK8VboYBypjjCV3o=
Subject: Re: Was Re: Question - - - - now: issue resolved
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com>
 <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
 <1faaef72-62ed-2c36-19d7-f6995691779f@prgmr.com>
 <CAPpdf58wY2G4XpNhfnHG42fHkpT6Z_EtLnLdtTaGvhRG_N5KKA@mail.gmail.com>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <1a4495cf-bd6a-7e56-46fa-87ed84d9a13c@prgmr.com>
Date:   Fri, 7 Feb 2020 17:24:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPpdf58wY2G4XpNhfnHG42fHkpT6Z_EtLnLdtTaGvhRG_N5KKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/7/20 4:56 PM, o1bigtenor wrote:
> On Fri, Feb 7, 2020 at 5:41 PM Sarah Newman <srn@prgmr.com> wrote:

>> I said the command dmesg, not /var/log.
>>
>> If systemd-journald is broken, or your file system is broken, you could have tons of error messages in dmesg and nothing logged to disk.
>>
> 
> Found one couplet - - - it might be applicable (please advise):
> 
> [12458.717443] EXT4-fs (md0p1): warning: maximal mount count reached,
> running e2fsck is recommended
> [12459.215097] EXT4-fs (md0p1): mounted filesystem with ordered data
> mode. Opts: (null)

What it says. You might want to run fsck at some point. Don't do it while the file system is mounted. If fsck wants to make changes, back up your data 
first.

>> just to make sure it hasn't been moved elsewhere on accident. That seems like the most likely scenario given the lack of error messages, unless no
>> messages at all have been logged due to previously mentioned issues.
>>
> Ran the suggested - - - - - well - - - - somehow I managed to drop the directory
> into a much smaller one. Dunno how that happened or any details (if someone
> cares to give method(s) and means for determining that I would be very
> grateful!) but I have now found the missing directory and its contents
> seem to be intact.
> 
> I did understand that maybe asking on the linux-raid 'exchange' might not
> have been the 'best' place to do so but this seemed quite weird and the
> directory was on a raid-array and I thought that maybe this could be a signal
> that there were more issues brewing. That seems now not to be the case.

If something in hardware or the kernel is having issues, almost always you will see error messages.

It's also better to do quick and easy checks first even if you don't have a hypothesis for what would have lead to that state.
