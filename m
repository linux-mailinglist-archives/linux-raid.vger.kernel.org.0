Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4D1989A7
	for <lists+linux-raid@lfdr.de>; Tue, 31 Mar 2020 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgCaBud (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 21:50:33 -0400
Received: from atl.turmel.org ([74.117.157.138]:60053 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgCaBuc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Mar 2020 21:50:32 -0400
Received: from [108.243.25.188] (helo=[192.168.20.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jJ62x-0006Vu-Ke; Mon, 30 Mar 2020 21:50:31 -0400
Subject: Re: Requesting assistance recovering RAID-5 array
To:     "crowston.name" <kevin@crowston.name>, Daniel Jones <dj@iowni.com>,
        antlists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
References: <CAB00BMjPSg2wdq7pjt=AwmcDmr0ep2+Xr0EAy6CNnVhOsWk8pg@mail.gmail.com>
 <058b3f48-e69d-2783-8e08-693ad27693f6@youngman.org.uk>
 <CAB00BMgYmi+4XvdmJDWjQ8qGWa9m0mqj7yvrK3QSNH9SzYjypw@mail.gmail.com>
 <etPan.5e829cbd.69391496.da7e@crowston.name>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <92b8501b-af27-b6dc-b35b-fd3142386ade@turmel.org>
Date:   Mon, 30 Mar 2020 21:50:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <etPan.5e829cbd.69391496.da7e@crowston.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Kevin,

On 3/30/20 9:27 PM, crowston.name wrote:
> I got the following error trying to run lsdrv:
> 
> ./lsdrv
> Traceback (most recent call last):
>    File "./lsdrv", line 423, in <module>
>      probe_block('/sys/block/'+x)
>    File "./lsdrv", line 340, in probe_block
>      blk.__dict__.update(extractvars(runx(['vol_id', '--export', '/dev/block/'+blk.dev])))
>    File "./lsdrv", line 125, in runx
>      out, err = sub.communicate()
>    File "/usr/lib/python2.5/subprocess.py", line 667, in communicate
>      return self._communicate(input)
>    File "/usr/lib/python2.5/subprocess.py", line 1138, in _communicate
>      rlist, wlist, xlist = select.select(read_set, write_set, [])
> select.error: (4, 'Interrupted system call')
> 
> 
> 
> 
> Kevin Crowston
> 206 Meadowbrook Dr.
> Syracuse, NY 13210 USA
> Phone: +1 (315) 464-0272
> Fax: +1 (815) 550-2155

Please don't hijack threads with unrelated reports.

Please report this on github where I can track it, but note that I'm not 
even trying to support python 2.5.

Phil
