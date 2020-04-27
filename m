Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465641BA6A1
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0Okj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 10:40:39 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17109 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgD0Okj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587998436; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=YRJBZGtLrre0Hyx3hbfCPOK8VbnJQ3NQ/cM6SAC0W/8qESRCaOGOTpjDo7+/vz1wULSMkMlMWLF8/fDRsrmvE4zGy+ZFK/Svmh1ebAPclDtqRyzJNAH6nzNbEN3XGry2l0lkr1vVQKKAa5ZJmyRnJJ2ubJroeAYltKG5tuomQE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587998436; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=RxjbtkCqXlrBhzkUla1NM3z7Yyu35pYgfk0A3g/fsIc=; 
        b=HiCh4+t8Om61qOIIHrBe9e65UEAtUnycBtseexNE7U/INpcO0xDlIqep1A3AyKqSxX1VnXJ8GL685xheMF8YRgkXOXMWbFL/aWXWUVJy3bW1fwUJhSRsr5kbKG991QCnKGfG3pBfY2eHud3+mzmor7cJCoQqRTSSwZLHhwlUVSk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1587998434264336.1548673134853; Mon, 27 Apr 2020 16:40:34 +0200 (CEST)
Subject: Re: [PATCH] Monitor: remove autorebuild pidfile when it exits
To:     Lidong Zhong <lidong.zhong@suse.com>
Cc:     linux-raid@vger.kernel.org
References: <20200327012854.5654-1-lidong.zhong@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <7fce6b8e-dbbc-b8b9-608b-cc5479484882@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:40:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200327012854.5654-1-lidong.zhong@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/26/20 9:28 PM, Lidong Zhong wrote:
> mdadm monitor is supposed to run in background and never exit. However
> if it is killed by accident and the pid stored in autorebuild.pid is 
> taken by some other process, it reports an error when restarting
> "mdadm: Only one autorebuild process allowed in scan mode, aborting"
> even though no autorebuild process exists. With the patch, this file
> will be removed at the end to fix this scenario.
> 
> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
> ---
> Hi Jes, 
> 
> Sorry to ping you, but could you please share your opinion about this patch? TIA.
> ---
>  Monitor.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Monitor.c b/Monitor.c
> index b527165..4cb113d 100644
> --- a/Monitor.c
> +++ b/Monitor.c
> @@ -62,6 +62,7 @@ struct alert_info {
>  	int dosyslog;
>  };
>  static int make_daemon(char *pidfile);
> +static int cleanup_sharer_pidfile();
>  static int check_one_sharer(int scan);
>  static void alert(char *event, char *dev, char *disc, struct alert_info *info);
>  static int check_array(struct state *st, struct mdstat_ent *mdstat,
> @@ -71,6 +72,12 @@ static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist,
>  			  int test, struct alert_info *info);
>  static void try_spare_migration(struct state *statelist, struct alert_info *info);
>  static void link_containers_with_subarrays(struct state *list);
> +static volatile sig_atomic_t finished = 0;
> +
> +static void _exit_handler(int sig)                                                                                               
> +{
> +	finished= 1;

Please respect formatting rules.

Also this patch fails to apply cleanly:

Applying: Monitor: remove autorebuild pidfile when it exits
Using index info to reconstruct a base tree...
M	Monitor.c
.git/rebase-apply/patch:27: trailing whitespace.
static void _exit_handler(int sig)

.git/rebase-apply/patch:46: trailing whitespace.
	
.git/rebase-apply/patch:47: trailing whitespace.
	signal(SIGTERM, &_exit_handler);
.git/rebase-apply/patch:48: trailing whitespace.
	signal(SIGKILL, &_exit_handler);
warning: 4 lines add whitespace errors.
Falling back to patching base and 3-way merge...
Auto-merging Monitor.c

Please fix and resubmit a v2.

Jes
