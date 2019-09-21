Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35308B9F38
	for <lists+linux-raid@lfdr.de>; Sat, 21 Sep 2019 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfIURlR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 21 Sep 2019 13:41:17 -0400
Received: from mail.prgmr.com ([71.19.149.6]:34320 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfIURlQ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 21 Sep 2019 13:41:16 -0400
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id CF0D9720068;
        Sat, 21 Sep 2019 18:36:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com CF0D9720068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569105390;
        bh=3i0LKLdCKUWT/p7uCVqM0SFhJcQiq9huCKZEbtgiL8s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QZ6Leu1iaBoO0kNFaV5E94+pyLSa5S1PIpIDrooOhgehYm8DkZUN6oleTYEGpTCOq
         1RQ230vfUbt1U1P+XbyMt6SEv+Req756ppdVJ5o0aGnBwnHSK9jKiodB6q+wkVEDa8
         K8JcNYF5pJlGk5UmwJX9ho6Gn0qrdOHu5ir0h194=
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro
Cc:     'John Stoffel' <john@stoffel.org>, linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
 <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
 <23941.15337.175082.79768@quad.stoffel.home>
 <001e01d5705d$b1785360$1468fa20$@ugal.ro>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <8a277324-d9b8-f2c9-bec0-5ed90c6e3eb4@prgmr.com>
Date:   Sat, 21 Sep 2019 10:41:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <001e01d5705d$b1785360$1468fa20$@ugal.ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/21/19 2:19 AM, Liviu Petcu wrote:

> Yes. Only one of the 2 disks reported by mdadm as failed, is broken. I
> almost finished making images of all the discs, and for the second "failed"
> disc ddrescue reported error-free copying. I intend to use the images to
> recreate the array. I haven't done this before, but I hope I can handle
> it...

If by recreate you mean run mdadm --create, you really shouldn't start with that - it's easy to get wrong.

You can almost certainly use mdadm --assemble --force per
https://raid.wiki.kernel.org/index.php/RAID_Recovery

--Sarah
