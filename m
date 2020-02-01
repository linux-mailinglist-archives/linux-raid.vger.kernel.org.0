Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8B14F80C
	for <lists+linux-raid@lfdr.de>; Sat,  1 Feb 2020 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgBAO0p (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 1 Feb 2020 09:26:45 -0500
Received: from us.icdsoft.com ([192.252.146.184]:53238 "EHLO us.icdsoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgBAO0p (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 1 Feb 2020 09:26:45 -0500
Received: (qmail 12723 invoked by uid 1001); 1 Feb 2020 14:26:41 -0000
Received: from unknown (HELO ?94.155.37.10?) (gnikolov@icdsoft.com@94.155.37.10)
  by 192.252.159.165 with ESMTPA; 1 Feb 2020 14:26:41 -0000
Subject: Re: Pausing md check hangs
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
 <CAPhsuW4Jc-qef9uW-JSut90qOpDc_4VoAFpMU8KwqnK7EeT_xg@mail.gmail.com>
 <ac3ae81d-8dad-8b4e-bc61-fc37514e3929@icdsoft.com>
 <CAPhsuW4JJiDroE33m0=XE9PxtUOncK3--waY_zxxbAT9j+1m6g@mail.gmail.com>
From:   Georgi Nikolov <gnikolov@icdsoft.com>
Message-ID: <cc483055-45de-4bd2-8a4f-71e9c8ed6b90@icdsoft.com>
Date:   Sat, 1 Feb 2020 16:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4JJiDroE33m0=XE9PxtUOncK3--waY_zxxbAT9j+1m6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

The output of this command was empty:

cat /proc/$(pidof md2_raid6)/stack # md2_raid6 process was consuming 
100% cpu

> Thanks for the information. I suspect the hang is waiting for md_lock().
>
> Could you please dump the mdX_raid6 stack when the hang happens?
> You can do it by:
>
>      cat /proc/$(pidof mdX_raid6)/stack
>
> Thanks,
> Song


Regards,

Georgi Nikolov

