Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F97181966
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgCKNQl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 09:16:41 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:48256 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgCKNQk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Mar 2020 09:16:40 -0400
X-Greylist: delayed 1536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 09:16:39 EDT
Received: from [10.8.0.1] (helo=srv.home ident=heh17268)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jC0p5-0005OI-1l; Wed, 11 Mar 2020 20:50:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=TWW0tvg24nn87VOdYas7f1Gc8AGPPPrCv1lqfGukqEU=;
        b=ap8UMWHhQR+VpUudzn+rCelefUynyka2GS9VHmbSGqu8hY3/kvzjEW9FMNUp6C/H8YgRWCRBZZI6Y4giecXE0GQDHVVO6q5EHpohK4gU1Q83XW0cjqj0hnXcvbGvUI0p/zJbM8uVS0FWi61KPtsSmDZO5gRcmUM1posPI9GeYks=;
Subject: Re: checkarray not running or emailing
To:     Leslie Rhorer <lesrhorer@att.net>, linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
Date:   Wed, 11 Mar 2020 20:50:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/3/20 09:11, Leslie Rhorer wrote:
>      Is there seriously no one here who knows how checkarray was launched in previous versions?
> 
> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>     I have upgraded 2 of my servers to Debian Buster, and now neither one seems to be running checkarray automatically.  In addition, when I run checkarray manually, it isn't sending update emails on the status of the job.  Actually, I have never been able to figure out how checkarray runs.  One my older servers, there doesn't seem to be anything in /etc/crontab, /etc/cron.monthly, /etc/init.d/, /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that would run checkarray.
> 

On mine it's in /etc/cron.d/mdadm

brad@srv:/etc/cron.d$ cat mdadm
#
# cron.d/mdadm -- schedules periodic redundancy checks of MD devices
#
# Copyright © martin f. krafft <madduck@madduck.net>
# distributed under the terms of the Artistic Licence 2.0
#

# By default, run at 00:57 on every Sunday, but do nothing unless the day of
# the month is less than or equal to 7. Thus, only run on the first Sunday of
# each month. crontab(5) sucks, unfortunately, in this regard; therefore this
# hack (see #380425).
57 0 * * 0 root if [ -x /usr/share/mdadm/checkarray ] && [ $(date +\%d) -le 7 ]; then /usr/share/mdadm/checkarray --cron --all --idle --quiet; fi

dpkg -L mdadm gave me a list of files and I just checked the cron entries.

I don't run anything that recent, but Debian is Debian.

Brad
-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr
