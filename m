Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802EF31B7CB
	for <lists+linux-raid@lfdr.de>; Mon, 15 Feb 2021 12:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBOLIn (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 15 Feb 2021 06:08:43 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48069 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229779AbhBOLIl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 15 Feb 2021 06:08:41 -0500
Received: from [192.168.0.6] (ip5f5aea71.dynamic.kabel-deutschland.de [95.90.234.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 788182064791F;
        Mon, 15 Feb 2021 12:07:58 +0100 (CET)
Subject: Re: [PATCH V2] md: don't unregister sync_thread with reconfig_mutex
 held
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, song@kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Donald Buczek <buczek@molgen.mpg.de>,
        it+raid@molgen.mpg.de
References: <1613177399-22024-1-git-send-email-guoqing.jiang@cloud.ionos.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <36a660ed-b995-839e-ac82-dc4ca25ccb8a@molgen.mpg.de>
Date:   Mon, 15 Feb 2021 12:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613177399-22024-1-git-send-email-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

[+cc Donald]

Am 13.02.21 um 01:49 schrieb Guoqing Jiang:
> Unregister sync_thread doesn't need to hold reconfig_mutex since it
> doesn't reconfigure array.
> 
> And it could cause deadlock problem for raid5 as follows:
> 
> 1. process A tried to reap sync thread with reconfig_mutex held after echo
>     idle to sync_action.
> 2. raid5 sync thread was blocked if there were too many active stripes.
> 3. SB_CHANGE_PENDING was set (because of write IO comes from upper layer)
>     which causes the number of active stripes can't be decreased.
> 4. SB_CHANGE_PENDING can't be cleared since md_check_recovery was not able
>     to hold reconfig_mutex.
> 
> More details in the link:
> https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t
> 
> And add one parameter to md_reap_sync_thread since it could be called by
> dm-raid which doesn't hold reconfig_mutex.
> 
> Reported-and-tested-by: Donald Buczek <buczek@molgen.mpg.de>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> V2:
> 1. add one parameter to md_reap_sync_thread per Jack's suggestion.
> 
>   drivers/md/dm-raid.c |  2 +-
>   drivers/md/md.c      | 14 +++++++++-----
>   drivers/md/md.h      |  2 +-
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index cab12b2..0c4cbba 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3668,7 +3668,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
>   	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
>   		if (mddev->sync_thread) {
>   			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -			md_reap_sync_thread(mddev);
> +			md_reap_sync_thread(mddev, false);
>   		}
>   	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
>   		return -EBUSY;
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index ca40942..0c12b7f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4857,7 +4857,7 @@ action_store(struct mddev *mddev, const char *page, size_t len)
>   				flush_workqueue(md_misc_wq);
>   			if (mddev->sync_thread) {
>   				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -				md_reap_sync_thread(mddev);
> +				md_reap_sync_thread(mddev, true);
>   			}
>   			mddev_unlock(mddev);
>   		}
> @@ -6234,7 +6234,7 @@ static void __md_stop_writes(struct mddev *mddev)
>   		flush_workqueue(md_misc_wq);
>   	if (mddev->sync_thread) {
>   		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -		md_reap_sync_thread(mddev);
> +		md_reap_sync_thread(mddev, true);
>   	}
>   
>   	del_timer_sync(&mddev->safemode_timer);
> @@ -9256,7 +9256,7 @@ void md_check_recovery(struct mddev *mddev)
>   			 * ->spare_active and clear saved_raid_disk
>   			 */
>   			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -			md_reap_sync_thread(mddev);
> +			md_reap_sync_thread(mddev, true);
>   			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>   			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
> @@ -9291,7 +9291,7 @@ void md_check_recovery(struct mddev *mddev)
>   			goto unlock;
>   		}
>   		if (mddev->sync_thread) {
> -			md_reap_sync_thread(mddev);
> +			md_reap_sync_thread(mddev, true);
>   			goto unlock;
>   		}
>   		/* Set RUNNING before clearing NEEDED to avoid
> @@ -9364,14 +9364,18 @@ void md_check_recovery(struct mddev *mddev)
>   }
>   EXPORT_SYMBOL(md_check_recovery);
>   
> -void md_reap_sync_thread(struct mddev *mddev)
> +void md_reap_sync_thread(struct mddev *mddev, bool reconfig_mutex_held)
>   {
>   	struct md_rdev *rdev;
>   	sector_t old_dev_sectors = mddev->dev_sectors;
>   	bool is_reshaped = false;
>   
>   	/* resync has finished, collect result */
> +	if (reconfig_mutex_held)
> +		mddev_unlock(mddev);
>   	md_unregister_thread(&mddev->sync_thread);
> +	if (reconfig_mutex_held)
> +		mddev_lock_nointr(mddev);
>   	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
>   	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>   	    mddev->degraded != mddev->raid_disks) {
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 34070ab..7ae3d98 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -705,7 +705,7 @@ extern struct md_thread *md_register_thread(
>   extern void md_unregister_thread(struct md_thread **threadp);
>   extern void md_wakeup_thread(struct md_thread *thread);
>   extern void md_check_recovery(struct mddev *mddev);
> -extern void md_reap_sync_thread(struct mddev *mddev);
> +extern void md_reap_sync_thread(struct mddev *mddev, bool reconfig_mutex_held);
>   extern int mddev_init_writes_pending(struct mddev *mddev);
>   extern bool md_write_start(struct mddev *mddev, struct bio *bi);
>   extern void md_write_inc(struct mddev *mddev, struct bio *bi);
> 
