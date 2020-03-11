Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7210181797
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgCKMRd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Mar 2020 08:17:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59017 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgCKMRc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 11 Mar 2020 08:17:32 -0400
Received: from [86.146.112.25] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jC0Ik-0002DM-7P; Wed, 11 Mar 2020 12:17:30 +0000
Subject: Re: checkarray not running or emailing
To:     Leslie Rhorer <lesrhorer@att.net>, linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5E68D6D9.5040004@youngman.org.uk>
Date:   Wed, 11 Mar 2020 12:17:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/03/20 01:11, Leslie Rhorer wrote:
>     Is there seriously no one here who knows how checkarray was launched
> in previous versions?

You need to ask on a Debian list. I for one don't have a damn clue
because I actively avoid apt-based systems.

Sorry, I don't mean to be harsh, but each distro "does its own thing" so
a lot of people (like me) *will* be clueless on that point, even if we
are raid experts.

Cheers,
Wol
> 
> On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>>     I have upgraded 2 of my servers to Debian Buster, and now neither
>> one seems to be running checkarray automatically.  In addition, when I
>> run checkarray manually, it isn't sending update emails on the status
>> of the job.  Actually, I have never been able to figure out how
>> checkarray runs.  One my older servers, there doesn't seem to be
>> anything in /etc/crontab, /etc/cron.monthly, /etc/init.d/,
>> /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that would run checkarray.

