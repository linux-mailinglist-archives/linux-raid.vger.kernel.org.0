Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3C16B78D
	for <lists+linux-raid@lfdr.de>; Tue, 25 Feb 2020 03:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgBYCLP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 21:11:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36885 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYCLO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Feb 2020 21:11:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so599568pjb.2
        for <linux-raid@vger.kernel.org>; Mon, 24 Feb 2020 18:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:subject:references:to:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1wiymfVqi1TlkiMXit8o2mBfE1g/7pVdoBXGqZVqWg=;
        b=EVsFKd5OEK07S7y/GDm/5DrjT+lk+1V7dT0xGPfIeRozqX15XWWPyLcABBnc3jo68w
         9BpsLbvY7aHaNDZgW0F1xWsuv1nYmWPuXGLuChxYJFXQgDyJ87lq0H6516p31KDeJ+Qk
         MkLUlwS8xCWpdzmAtga1pod9LMqCu+SF3jisFLSBv+RX/2X7D9O/w/y/gqSUmuOzmFT+
         peO6M2rBhjfuJVE3q8M/T9GwJTkHRrs/FvJvu/y7wXu7p+dUHUQmuHXOVsfcHrut5Kio
         ZPPMkUvAGWyyz8sYfe3ZnpU11URVq9fTD8TqhLaBXYSHqPHiUUC+ztGNpzcdh7J76qhl
         +N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:references:to:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1wiymfVqi1TlkiMXit8o2mBfE1g/7pVdoBXGqZVqWg=;
        b=ncS41prX6aSnj4NJCDL7/be1o8Qhq2tkcJuJVSupfrMJMachL36VrfCh2Nt4DAUTF8
         m8hzxGvJTxbTNeK8i8CIfPxiy52jDLyGGqbPrg0PrkocX28CABix7bmrx22op11mvgM7
         pvmgZt1KxMG2+P8LP2GQ0ogEM6/5U+sTjEdTuRGrvjV4D90g9xxLYH4Gpev1KbQSOE8B
         luVcAww8JbdosKsMUjeBeP2/Kd1GrPwM7txUHdJcsoqPCn4hTq1vVMxq7aRBWSAr5Oeg
         Wci4HpI9hvKY5usVi2RphJanJzvp1CTXNW1JN0va+8281qCSvhGcB6FL3WdDqNiCuwLj
         oJHg==
X-Gm-Message-State: APjAAAXWSbWBh6ZImLYWI8QL91Zn9juGHJ4P6ZCeZdpIQ7JaNNRpeHlf
        MnGziUEySjckYJUpE4M5ptZgSCPagoc=
X-Google-Smtp-Source: APXvYqwrTY6vzibEHGBJvDHe0S0htuixDJxTNr9ZlIgs057JOXhlrJixgRsvAw99Ge6jI8asUsMbKQ==
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr2270531pjt.105.1582596671653;
        Mon, 24 Feb 2020 18:11:11 -0800 (PST)
Received: from ?IPv6:240e:82:3:25f6:bf:4749:e7b3:6112? ([240e:82:3:25f6:bf:4749:e7b3:6112])
        by smtp.gmail.com with ESMTPSA id 17sm14024341pfv.142.2020.02.24.18.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 18:11:10 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: Pausing md check hangs
References: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
To:     gnikolov@icdsoft.com, song@kernel.org
Cc:     linux-raid <linux-raid@vger.kernel.org>
Message-ID: <15519216-347d-c355-fa1e-e1ec29f7e996@cloud.ionos.com>
Date:   Tue, 25 Feb 2020 03:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2ce8813c-fd3e-5e78-39ac-049ddfa79ff6@icdsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 1/27/20 2:42 PM, Georgi Nikolov wrote:
> Hi,
> 
> I posted a kernel bug about this a month ago but it did not receive any attention: 
> https://bugzilla.kernel.org/show_bug.cgi?id=205929
> Here is a copy of the bug report and I hope that this is the correct place to discuss this:
> 
> I have a Supermicro server with 10 md raid6 arrays each consisting of 8 SATA drives. SATA drives are 
> Hitachi/HGST Ultrastar 7K4000 8T.
> When i try to pause array check with "echo idle > "/sys/block/<md_dev>/md/sync_action" it randomly 
> hangs at different md device.
> Process "mdX_raid6" is at 100% cpu usage.cat /sys/block/mdX/md/journal_mode hungs forever.

Hmm, "echo idle > /sys/block/<md_dev>/md/sync_action" can't get reconfig_mutex, but seems
it should acquire mddev->lock instead of reconfig_mutex to align with other read functions
of raid5_attrs. I think we need to change it.

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 9b6da759dca2..a961d8eed73e 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2532,13 +2532,10 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
         struct r5conf *conf;
         int ret;

-       ret = mddev_lock(mddev);
-       if (ret)
-               return ret;
-
+       spin_lock(&mddev->lock);
         conf = mddev->private;
         if (!conf || !conf->log) {
-               mddev_unlock(mddev);
+               spin_unlock(&mddev->lock);
                 return 0;
         }

@@ -2558,7 +2555,7 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
         default:
                 ret = 0;
         }
-       mddev_unlock(mddev);
+       spin_unlock(&mddev->lock);
         return ret;
  }


> 
> Here is the state at the moment of crash for one of the md devices:
> 
> root@supermicro:/sys/block/mdX/md# find -mindepth 1 -maxdepth 1 -type f|sort|grep -v 
> journal_mode|xargs -r egrep .
> ./array_size:default
> ./array_state:write-pending

MD_SB_CHANGE_PENDING was set, so md_update_sb() didn't clear it yet.

> grep: ./bitmap_set_bits: Permission denied
> ./chunk_size:524288
> ./component_size:7813895168
> ./consistency_policy:resync
> ./degraded:0
> ./group_thread_cnt:4

To narrow down the issue, I'd suggest to disable multiple raid5 workers.

> ./last_sync_action:check
> ./layout:2
> ./level:raid6
> ./max_read_errors:20
> ./metadata_version:1.2
> ./mismatch_cnt:0
> grep: ./new_dev: Permission denied
> ./preread_bypass_threshold:1
> ./raid_disks:8
> ./reshape_direction:forwards
> ./reshape_position:none
> ./resync_start:none
> ./rmw_level:1
> ./safe_mode_delay:0.204
> ./skip_copy:0
> ./stripe_cache_active:13173
> ./stripe_cache_size:8192
> ./suspend_hi:0
> ./suspend_lo:0
> ./sync_action:check

Since it was 'check' for sync_action means the array was set with RECOVERY_RUNNING,
RECOVERY_SYNC and RECOVERY_CHECK.

> ./sync_completed:3566405120 / 15627790336
> ./sync_force_parallel:0
> ./sync_max:max
> ./sync_min:1821385984
> ./sync_speed:126
> ./sync_speed_max:1000 (local)
> ./sync_speed_min:1000 (system)

The sync_speed is really low which means the system was under heavy pressure.

> 
> root@supermicro:~# cat /proc/mdstat
> Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] [raid4] [raid10]
> md4 : active raid6 sdaa[2] sdab[3] sdy[0] sdae[6] sdac[4] sdad[5] sdaf[7] sdz[1]
>        46883371008 blocks super 1.2 level 6, 512k chunk, algorithm 2 [8/8] [UUUUUUUU]
>        [====>................]  check = 22.8% (1784112640/7813895168) finish=20571.7min speed=4884K/sec
> 

When check was in progress, I guess write 'idle' to sync_action was not quit in below
section. Specifically, I think it was waiting the completion of md_misc_wq, otherwise
the check should be interrupted after set MD_RECOVERY_INTR.

         if (cmd_match(page, "idle") || cmd_match(page, "frozen")) {
                 if (cmd_match(page, "frozen"))
                         set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
                 else
                         clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
                 if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
                     mddev_lock(mddev) == 0) {
                         flush_workqueue(md_misc_wq);
                         if (mddev->sync_thread) {
                                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
                                 md_reap_sync_thread(mddev);
                         }
                         mddev_unlock(mddev);



But it is not clear to me why flush_workqueue was not finished. Maybe the below could
help but I am not sure.

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4779,7 +4779,8 @@ action_store(struct mddev *mddev, const char *page, size_t len)
                 if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
                     mddev_lock(mddev) == 0) {
                         flush_workqueue(md_misc_wq);
-                       if (mddev->sync_thread) {
+                       if (mddev->sync_thread ||
+                           test_bit(MD_RECOVERY_RUNNING,&mddev->recovery)) {


Thanks,
Guoqing
