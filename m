Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AC1BA6B5
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0Om3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 10:42:29 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17111 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0Om3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587997640; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=eYO0gkjR926uHEi8uW/tDTu40M0kALY+CZyrEj4as0ZO3GtPV9EwzDVBMP5RWoX531u0Eni9U5R3j/AUqySncv/M3aFCzraIFPAqErX4+rjA5mmerSCJZg7QJy37FB4YPNyOgJJX54Z8EJ6/rEIBUuw6g7L350+ZcNNU2zogRQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587997640; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Sr41w9Ji6EmZN1xZjYloPWOZ4ZPNUxiK84ED/kDnQfI=; 
        b=erqmlps5UFRG45h6oaD83Ufn2AyXhJb0zEwCZ5J4nHLpd4oMCXrb8cyv99CTzpcjasJuc77gNxNQj7l4E0nZmOQGOIMFuXw64W6IaR02tVpRDihHwQT9c7e2Hry87M1xHas7p2NejhFou/5ABCWwRlLlToGtOg3ybiBAYb0GR50=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 15879976388820.3458775039784996; Mon, 27 Apr 2020 16:27:18 +0200 (CEST)
Subject: Re: [PATCH] Monitor: improve check_one_sharer() for checking
 duplicated process
To:     Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
Cc:     Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
References: <20200410162446.6292-1-colyli@suse.de>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <4a177b2d-f054-cffc-f970-1ec63e74701a@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:27:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410162446.6292-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/10/20 12:24 PM, Coly Li wrote:
> When running mdadm monitor with scan mode, only one autorebuild process
> is allowed. check_one_sharer() checks duplicated process by following
> steps,
> 1) Read autorebuild.pid file,
>    - if file does not exist, no duplicated process, go to 3).
>    - if file exists, continue to next step.
> 2) Read pid number from autorebuild.pid file, then check procfs pid
>    directory /proc/<PID>,
>    - if the directory does not exist, no duplicated process, go to 3)
>    - if the directory exists, print error message for duplicated process
>      and exit this mdadm.
> 3) Write current pid into autorebuild.pid file, continue to monitor in
>    scan mode.
> 
> The problem for the above step 2) is, if after system reboots and
> another different process happens to have exact same pid number which
> autorebuild.pid file records, check_one_sharer() will treat it as a
> duplicated mdadm process and returns error with message "Only one
> autorebuild process allowed in scan mode, aborting".
> 
> This patch tries to fix the above same-pid-but-different-process issue
> by one more step to check the process command name,
> 1) Read autorebuild.pid file
>    - if file does not exist, no duplicated process, go to 4).
>    - if file exists, continue to next step.
> 2) Read pid number from autorebuild.pid file, then check procfs file
>    comm with the specific pid directory /proc/<PID>/comm
>    - if the file does not exit, it means the directory /proc/<PID> does
>      not exist, go to 4)
>    - if the file exits, continue next step
> 3) Read process command name from /proc/<PIC>/comm, compare the command
>    name with "mdadm" process name,
>    - if not equal, no duplicated process, goto 4)
>    - if strings are equal, print error message for duplicated process
>      and exit this mdadm.
> 4) Write current pid into autorebuild.pid file, continue to monitor in
>    scan mode.
> 
> Now check_one_sharer() returns error for duplicated process only when
> the recorded pid from autorebuild.pid exists, and the process has exact
> same command name as "mdadm".
> 
> Reported-by: Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  Monitor.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

Applied!

Thanks,
Jes

