Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7EA156165
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGW6Y (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 17:58:24 -0500
Received: from mail.prgmr.com ([71.19.149.6]:57372 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgBGW6Y (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 7 Feb 2020 17:58:24 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 17:58:24 EST
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id A4DFE720127;
        Fri,  7 Feb 2020 22:52:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com A4DFE720127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1581133947;
        bh=OZGeo6gOC9huuZwLa5osSbrTy5qgUVoZCipkHF/RzVU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Lmpq+v9v2x/V9LgWJweIEsEcR35mXkkUMmGVvQ5Ugq3uh8LIytVjwyKAFJ0HOW8Cb
         Vxt0DH5WtPJyZ3PT+36vh1AjbhvRggkDSyv8XXKKxGiC1F1dM0QHY15TTJrijkYC8G
         ZK8jAoX402hHccWvBLsyc/zO0XwlKpR3/WJs6pwY=
Subject: Re: Question
To:     o1bigtenor <o1bigtenor@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com>
Date:   Fri, 7 Feb 2020 14:50:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/7/20 7:49 AM, o1bigtenor wrote:
> Greetings
> 
> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> (11) system.
> mdadm - v4.1 - 2018-10-01 is the version being used.
> 
> Some weirdness is happening - - - vis a vis - - - I have one directory
> (not small) that has disappeared. I last accessed said directory
> (still have the pdf open which is how I could get this information)
> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> section of the file in question.

I assume you've looked at lsof?

https://www.linux.com/news/bring-back-deleted-files-lsof/

If it is a software problem, it just as likely, if not more likely, that it is a file system problem rather than a raid problem. You don't mention 
what file system. You're possibly also actually looking at data in the in-memory disk cache rather than what's actually stored on disk given there's 
been no reboot.

Is there anything suspicious in dmesg?


