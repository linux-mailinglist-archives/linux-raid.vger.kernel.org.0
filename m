Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69822DFAF
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jul 2020 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGZOVS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 10:21:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63199 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGZOVR (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Jul 2020 10:21:17 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jzhWd-000369-40; Sun, 26 Jul 2020 15:21:15 +0100
Subject: Re: [PATCH v2] mdadm/Detail: show correct state for cluster-md array
To:     "heming.zhao@suse.com" <heming.zhao@suse.com>,
        linux-raid@vger.kernel.org
References: <1595401905-3459-1-git-send-email-heming.zhao@suse.com>
 <7697b7eb-76f9-8102-a490-1684e5f18acf@suse.com>
 <5F1D3B50.8080006@youngman.org.uk>
 <7aeb1f5a-df3c-183e-93cd-61631a40e9b5@suse.com>
Cc:     neilb@suse.com, jes@trained-monkey.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F1D9159.1020200@youngman.org.uk>
Date:   Sun, 26 Jul 2020 15:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <7aeb1f5a-df3c-183e-93cd-61631a40e9b5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 26/07/20 10:22, heming.zhao@suse.com wrote:
> Hello Wols,
> 
> I just started to learn mdadm code. Maybe there are some historical reasons to keep leaked issue. 
> I guess your said daemon mode is: "mdadm --monitor --daemonise ...".

> After very quickly browsing the code in Monitor.c, these mode check /proc/mdstat, send ioctl GET_ARRAY_INFO, and
> read some /sys/block/mdX/md/xx files. There is no way to call ExamineBitmap().

> In currently mdadm code, the only way to call ExamineBitmap() is by cmd "mdadm -X /dev/sdX". So as my last mail said, when the mdadm program finish, all leaked memory will be released.
> And last week, before I send v2 patch, I try to use valgrind to check memory related issue, there are many places to leak. e.g. 

You're learning the mdadm code? Personally, I find it hard to learn
stuff if there's no purpose behind what I'm studying. Treat it as a
learning exercise and fix all the leaks ;-)

As they say, if a job's worth doing it's worth doing well, and you can
learn what stuff is doing while you're working your way through it.

I need to learn my way around mdadm, and I've got a task in mind that'll
teach me a load of it, so all being well I'll soon be following in your
footsteps ...

Cheers,
Wol
