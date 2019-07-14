Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F015D6808D
	for <lists+linux-raid@lfdr.de>; Sun, 14 Jul 2019 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfGNRtO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Jul 2019 13:49:14 -0400
Received: from mail.prgmr.com ([71.19.149.6]:55182 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfGNRtO (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 14 Jul 2019 13:49:14 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 13:49:13 EDT
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id D857472008C;
        Sun, 14 Jul 2019 18:40:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com D857472008C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1563144018;
        bh=uiy7+ewbMGpUOe15/FXTRKippcXi4J8sT0g76PlT+Mw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=Ov+X3qggn98i1xoSYrAV0+bazZjstcQGbn18Ayj7QnfK+fFWLWI/sHsySAZFuD2ig
         HiF8y6AIYRgK+mBxoSPtFGgEa9GaeN6HvmMYJjES+iQ6hQCNaSYE7bUr7ZnkdSAvan
         fUX1l6PoRTFIJUpP0jTLJOZ5vlC+gz5M1QJQIaNE=
Subject: Re: Weird behaviour of md, maybe a bug in 4.19.xx kernel?
To:     Tito <farmatito@tiscali.it>, linux-raid@vger.kernel.org
References: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
 <5D2B3FF9.8000806@youngman.org.uk>
 <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
Cc:     Wols Lists <antlists@youngman.org.uk>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <5da074ee-a0e5-18ac-84ad-6311ff95f0ba@prgmr.com>
Date:   Sun, 14 Jul 2019 10:43:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 7/14/19 10:05 AM, Tito wrote:
> On 7/14/19 4:45 PM, Wols Lists wrote:
>> On 14/07/19 15:05, Tito wrote:
>>> Hi,
>>> I've got this email address from the MAINTAINERS file in the linux kernel
>>> source, so I hope it is the right place to contact.
>>> I'm running a debian/devuan system for a long time with several
>>> md arrays on the embedded controller and on a ibm M1015 card
>>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
>>> My typical setup is:
>>
>> You've got the right place. I can't see any mention of what disks you
>> have, because that could well be relevant.
>>
>> Can I point you at the raid wiki for a good read ... :-)
>>
>> https://raid.wiki.kernel.org/index.php/Linux_Raid
>>
>> It contains a bunch of advice on troubleshooting and stuff, and it'll
>> hopefully help you identify anything weird so making it easier for you
>> to point us in the right direction and provide us with the stuff we need.
>>
>> Cheers,
>> Wol
>>
> 
> Hi,
> thanks for your advice, read the wiki and gathered all info as requested,
> hope that attaching them is ok, or do you prefer them in the body.


On 7/14/19 10:05 AM, Tito wrote:> On 7/14/19 4:45 PM, Wols Lists wrote:
 >> On 14/07/19 15:05, Tito wrote:
 >>> Hi,
 >>> I've got this email address from the MAINTAINERS file in the linux kernel
 >>> source, so I hope it is the right place to contact.
 >>> I'm running a debian/devuan system for a long time with several
 >>> md arrays on the embedded controller and on a ibm M1015 card
 >>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
 >>> My typical setup is:
 >>
 >> You've got the right place. I can't see any mention of what disks you
 >> have, because that could well be relevant.
 >>
 >> Can I point you at the raid wiki for a good read ... :-)
 >>
 >> https://raid.wiki.kernel.org/index.php/Linux_Raid
 >>
 >> It contains a bunch of advice on troubleshooting and stuff, and it'll
 >> hopefully help you identify anything weird so making it easier for you
 >> to point us in the right direction and provide us with the stuff we need.
 >>
 >> Cheers,
 >> Wol
 >>
 >
 > Hi,
 > thanks for your advice, read the wiki and gathered all info as requested,
 > hope that attaching them is ok, or do you prefer them in the body.

To me this looks like your problem:

 > Jul 14 07:54:12 debian kernel: [38809.927619] sd 2:0:6:0: [sdg] tag#580 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
 > Jul 14 07:54:12 debian kernel: [38809.927624] sd 2:0:6:0: [sdg] tag#580 Sense Key : Not Ready [current]
 > Jul 14 07:54:12 debian kernel: [38809.927627] sd 2:0:6:0: [sdg] tag#580 Add. Sense: Logical unit not ready, cause not reportable
 > Jul 14 07:54:12 debian kernel: [38809.927632] sd 2:0:6:0: [sdg] tag#580 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00

FYI there's no overlap between the drives in the raid1 (sda, sdk, sdj) and the drives in the raid5 and raid6.

According to lsdrv sda, sdk, sdj, and sdl are all on the on-board SATA controller. If you've never seen an error on sdl despite it being in the raid6 
then I'd pin the blame on the SAS2008 card. You should probably start by checking the firmware version and making sure it's up to date. If it is up to 
date then try looking for bugs and updates related to the mpt3sas driver.

--Sarah





