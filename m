Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9651CD1E0
	for <lists+linux-raid@lfdr.de>; Mon, 11 May 2020 08:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgEKGdw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 11 May 2020 02:33:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60765 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgEKGdw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 11 May 2020 02:33:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49LB3K5SRxz1rqRQ
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 08:33:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49LB3K5KdCz1qrj8
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 08:33:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UQTJ-MFNCFii for <linux-raid@vger.kernel.org>;
        Mon, 11 May 2020 08:33:49 +0200 (CEST)
X-Auth-Info: sbCKydZ1NKO+ys7U2xb3E1o0W0czrJvkfp4bFQ67Wlo=
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-raid@vger.kernel.org>; Mon, 11 May 2020 08:33:48 +0200 (CEST)
Received: by janitor.denx.de (Postfix, from userid 108)
        id 9DC72A0255; Mon, 11 May 2020 08:33:48 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 859CCA0074;
        Mon, 11 May 2020 08:33:42 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 1D483240E1A;
        Mon, 11 May 2020 08:33:42 +0200 (CEST)
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     linux-raid@vger.kernel.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: raid6check extremely slow ?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20200510132611.GA12994@lazy.lzy>
References: <20200510120725.20947240E1A@gemini.denx.de> <20200510132611.GA12994@lazy.lzy>
Comments: In-reply-to Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
   message dated "Sun, 10 May 2020 15:26:11 +0200."
Date:   Mon, 11 May 2020 08:33:42 +0200
Message-Id: <20200511063342.1D483240E1A@gemini.denx.de>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Piergiorgio,

In message <20200510132611.GA12994@lazy.lzy> you wrote:
>
> raid6check is CPU bounded, no vector optimization
> and no multithread.
>
> Nevertheless, if you see no CPU load (single core
> load), then something else is not OK, but I've no
> idea what it could be.
>
> Please check if one core is up 100%, if this is
> the case, then there is the limit.
> If not, sorry, I cannot help.

No, there is virtually no CPU load at all:

top - 08:32:36 up 8 days, 16:34,  3 users,  load average: 1.00, 1.01, 1.00
Tasks: 243 total,   1 running, 242 sleeping,   0 stopped,   0 zombie
%Cpu0  :  0.0 us,  0.0 sy,  0.0 ni, 98.7 id,  0.0 wa,  1.3 hi,  0.0 si,  0.0 st
%Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  0.3 us,  1.3 sy,  0.0 ni, 97.7 id,  0.0 wa,  0.3 hi,  0.3 si,  0.0 st
%Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu5  :  1.7 us,  3.7 sy,  0.0 ni, 90.4 id,  3.0 wa,  0.7 hi,  0.7 si,  0.0 st
%Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  24034.6 total,  10921.2 free,   1882.4 used,  11230.9 buff/cache
MiB Swap:   7828.5 total,   7828.5 free,      0.0 used.  21757.0 avail Mem

What I find interesting is thet all disks are more or less
constantly at around 400 kB/s (390...400, never more).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
That's their goal, remember, a goal that's really contrary to that of
the programmer or administrator. We just want to get our  jobs  done.
$Bill  just  wants  to  become  $$Bill. These aren't even marginallly
congruent.
         -- Tom Christiansen in <6jhtqk$qls$1@csnews.cs.colorado.edu>
