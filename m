Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D55182C30
	for <lists+linux-raid@lfdr.de>; Thu, 12 Mar 2020 10:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLJRY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 12 Mar 2020 05:17:24 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:43030 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLJRY (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 12 Mar 2020 05:17:24 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh2472)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jCJxv-000627-0J; Thu, 12 Mar 2020 17:17:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=/5z4ppCW/jIZa3QXPRRHuny1n0CbENkuvkVw0r6y6zk=;
        b=l809AioWaMfZYW1p2gcesG5Ncmf7oQCq688q1w8i21oASdtKfWHbA+wRHWHTPwtg6STodK2Esb+lDoCC8O6bKKGizoMOqHbF1bLzKBmSbhyZG0jxK3d16rITrXo7ODkVPU0JE/VFOzKBXI9NP14t1syjDBNpKEKDt6DjJ1wBsyg=;
Subject: Re: checkarray not running or emailing
To:     Leslie Rhorer <lesrhorer@att.net>, linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
 <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
 <10e2db3d-13e6-573f-18bd-1443d6a27884@fnarfbargle.com>
 <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <61f5fc7b-bd2a-a151-a228-3d2a6f4d3ee6@fnarfbargle.com>
Date:   Thu, 12 Mar 2020 17:17:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7ba840ec-74fd-96bf-5088-7f8479ddcba5@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 12/3/20 09:41, Leslie Rhorer wrote:
>     Aha! There it is, on both the old and new systems, so it probably is running.  The question remains, "Why isn't it posting to email?"
>
root@srv:~# mdadm --monitor --test --oneshot /dev/md2
mdadm: Monitor using email address "root" from config file

And in the mail :

This is an automatically generated mail message from mdadm
running on srv

A TestMessage event had been detected on md device /dev/md2.

Faithfully yours, etc.

P.S. The /proc/mdstat file currently contains the following:

Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
md2 : active raid1 nvme0n1[2] md5[3](W)
       952696320 blocks super 1.2 [2/2] [UU]
       bitmap: 6/8 pages [24KB], 65536KB chunk



Brad

-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr

