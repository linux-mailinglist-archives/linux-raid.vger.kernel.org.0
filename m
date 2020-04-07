Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6D1A0DA6
	for <lists+linux-raid@lfdr.de>; Tue,  7 Apr 2020 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgDGMbk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 7 Apr 2020 08:31:40 -0400
Received: from atl.turmel.org ([74.117.157.138]:43260 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgDGMbj (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 7 Apr 2020 08:31:39 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jLnOE-0005qN-Li; Tue, 07 Apr 2020 08:31:38 -0400
Subject: Re: Raid-6 cannot reshape
From:   Phil Turmel <philip@turmel.org>
To:     Alexander Shenkin <al@shenkin.org>,
        Wols Lists <antlists@youngman.org.uk>,
        Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <24a0ef04-46a9-13ee-b8cb-d1a0a5b939fb@shenkin.org>
 <6b9b6d37-6325-6515-f693-0ff3b641a67a@shenkin.org>
 <3135fb29-cfaa-d8ac-264d-fd3110217370@shenkin.org>
 <CAAMCDecyr4R_z3-E8HYwYM4CyQtAY_nBmXdvvMkTgZCcCp7MjQ@mail.gmail.com>
 <5E8B5865.9060107@youngman.org.uk>
 <08d66411-5045-56e1-cbad-7edefa94a363@turmel.org>
 <945332b3-6a47-c2b3-7d1e-70a44f6fd370@shenkin.org>
 <b9bb796e-08cd-e10a-d345-992e5f3abea7@turmel.org>
 <618f5171-785f-09b0-8748-d2549d22c0ab@shenkin.org>
 <38852671-9c5a-3807-0284-41f902e5f81b@turmel.org>
Message-ID: <44069d88-f838-2b8b-1002-a1fff5502d2d@turmel.org>
Date:   Tue, 7 Apr 2020 08:31:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <38852671-9c5a-3807-0284-41f902e5f81b@turmel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/7/20 8:28 AM, Phil Turmel wrote:
>>
>> Thanks Phil,
>>
>> The --invalid-backup parameter was necessary to get this up and running.
>>   It's now up with the 7th disk as a spare.  Shall I run fsck now, or can
>> I just try to grow again?
>>
>> proposed grow operation:
>>> mdadm --grow -raid-devices=7 --backup-file=/dev/usb/grow_md127.bak
>> /dev/md127
>>> mdadm --stop /dev/md127
>>> umount /dev/md127 # not sure if this is necessary
>>> resize2fs /dev/md127
> 
> An fsck could help, if any blocks did get moved.
> 
> I would not attempt a grow again until you find out why the previous 
> attempt didn't make progress.  Check if mdmon is running, and/or compile 
> a fresh copy of mdadm from source.  If you don't figure it out, you'll 
> just end up in the same spot again.


Oh, one more point:  Don't use a backup file.  Let mdadm shift the data 
offsets to get the temporary space needed.  (It'll run faster, too.)

(I don't see any mdadm --examine reports in the list thread.  Did you do 
them and keep the complete output?)

Phil

