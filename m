Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F7B9491
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404637AbfITPxq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 11:53:46 -0400
Received: from mail.prgmr.com ([71.19.149.6]:58244 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbfITPxq (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 11:53:46 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2019 11:53:46 EDT
Received: from [192.168.2.33] (c-174-62-72-237.hsd1.ca.comcast.net [174.62.72.237])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 91A2D72008B;
        Fri, 20 Sep 2019 16:39:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 91A2D72008B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1569011956;
        bh=6OgIybeJf2r2yRYtd6fxgI++DZ7gPX8pv8TFHlHA7iQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OUJxOHnnUC13gFpg/URrGWryHwG0VhX93t9JT95Pj16VkkKMOlVWBMU6PDNE9Heno
         O45ARenY43ai0ejkQkpP2ia6ljOO8jxVLf//OIA66t3UQxpCpCXB5bmOPDjqwbMlVi
         GwXsmSurLMeoJ8lRam8iVQHRt35tEnmIvg+1/bBA=
Subject: Re: RAID 10 with 2 failed drives
To:     Liviu.Petcu@ugal.ro
Cc:     linux-raid@vger.kernel.org
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
 <23940.1755.134402.954287@quad.stoffel.home>
 <094701d56f7c$95225260$bf66f720$@ugal.ro>
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
Date:   Fri, 20 Sep 2019 08:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <094701d56f7c$95225260$bf66f720$@ugal.ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/19/19 11:28 PM, Liviu Petcu wrote:
> Thank you John Stoffel.
> 
> So far I have done nothing but mdadm - exams.  Both disks seem to be gone
> and have no led activity. Below are the system information and the details
> of the event from /var/log/messages.

Maybe try reseating the drives, or reseating cables, or put the drives in a different server? Two drives being kicked at the same time sounds like a 
problem other than the hard drives themselves, unless you haven't been running any sort of SMART self tests or raid checks.

