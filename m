Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B7155CE4
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 18:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGRac (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 12:30:32 -0500
Received: from mail.thelounge.net ([91.118.73.15]:64839 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGRac (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 12:30:32 -0500
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48Dj4P60kxzXQQ;
        Fri,  7 Feb 2020 18:30:29 +0100 (CET)
Subject: Re: Question
To:     o1bigtenor <o1bigtenor@gmail.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <b75c2dc2-d14e-39dc-0c06-7bab53fa7cb8@thelounge.net>
 <CAPpdf5882kxxkK2YrEmWWcM2X=ffcV+YB-GFTck2Qi34ufWE2g@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <f4146b7d-3ff3-e08d-4dac-1ac9a3de138e@thelounge.net>
Date:   Fri, 7 Feb 2020 18:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPpdf5882kxxkK2YrEmWWcM2X=ffcV+YB-GFTck2Qi34ufWE2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 07.02.20 um 17:26 schrieb o1bigtenor:
> On Fri, Feb 7, 2020 at 9:53 AM Reindl Harald <h.reindl@thelounge.net> wrote:
>>
>> Am 07.02.20 um 16:49 schrieb o1bigtenor:
>>> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
>>> (11) system.
>>> mdadm - v4.1 - 2018-10-01 is the version being used.
>>>
>>> Some weirdness is happening - - - vis a vis - - - I have one directory
>>> (not small) that has disappeared. I last accessed said directory
>>> (still have the pdf open which is how I could get this information)
>>> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
>>> section of the file in question.
>>>
>>> Has been suggested to me that I make the array read only until this is resolved.
>>> I have space on the the array on a different system to recover this array.
>>> Suggestions on how to do both of the above would be aprreciated
>>
>> directories on a filesystem on top of a RAID don't disappear silently -
>> my bet is a simple drag&drop move or deletion aka PEBCAK
> 
> I checked with bash - - history  and in about 500 items there is no mention of
> such. Looked in log files and can't find anything either. Quite
> puzzling - - - -
> that's why I'm asking here.
> 
> And yes - - - I am aware that all too often I'm the problem. I've
> gotten a lot more
> careful that I was even 5 years ago - - - grin.

if you shave no system error showing any evidence you are wrong here -
even if it would be true witout any errors message you are wrong here
because it's the same as asking if your neighbours dog pissed on your wall

even with a filesystem error you are wrong here and it's impossible that
the raid forget about exactly one folder because that layer don't now
about folders and the FS would puke if a complete area desiapperas at
running fsck - period
