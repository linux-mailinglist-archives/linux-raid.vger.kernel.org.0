Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE0B98AC
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfITUv5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 16:51:57 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:39176 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbfITUvy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 20 Sep 2019 16:51:54 -0400
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 34B502403F;
        Fri, 20 Sep 2019 16:51:54 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 3ED1CA5B51; Fri, 20 Sep 2019 16:51:53 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23941.15337.175082.79768@quad.stoffel.home>
Date:   Fri, 20 Sep 2019 16:51:53 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Sarah Newman <srn@prgmr.com>
Cc:     Liviu.Petcu@ugal.ro, linux-raid@vger.kernel.org
Subject: Re: RAID 10 with 2 failed drives
In-Reply-To: <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
References: <08df01d56f2b$3c52bdb0$b4f83910$@ugal.ro>
        <23940.1755.134402.954287@quad.stoffel.home>
        <094701d56f7c$95225260$bf66f720$@ugal.ro>
        <cf597586-a450-f85a-51e1-76df59f22839@prgmr.com>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Sarah" == Sarah Newman <srn@prgmr.com> writes:

Sarah> On 9/19/19 11:28 PM, Liviu Petcu wrote:
>> Thank you John Stoffel.
>> 
>> So far I have done nothing but mdadm - exams.  Both disks seem to be gone
>> and have no led activity. Below are the system information and the details
>> of the event from /var/log/messages.

Sarah> Maybe try reseating the drives, or reseating cables, or put the
Sarah> drives in a different server? Two drives being kicked at the
Sarah> same time sounds like a problem other than the hard drives
Sarah> themselves, unless you haven't been running any sort of SMART
Sarah> self tests or raid checks.


I agree with Sarah, make sure those two drives are really dead first.
If you have a USB3 port and one of those USB->SATA dongles, that might
be a quick and easy way to confirm.

I've been super busy at work today, just finally checking my own email.
