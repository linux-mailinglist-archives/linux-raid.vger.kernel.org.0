Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF75F9668
	for <lists+linux-raid@lfdr.de>; Mon, 10 Oct 2022 02:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJJA5S (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 9 Oct 2022 20:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiJJA5A (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 9 Oct 2022 20:57:00 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50CA4BAB
        for <linux-raid@vger.kernel.org>; Sun,  9 Oct 2022 17:40:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665362401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdMoINWopUojLi7isqDQwSSMYLf8rxZoh8ltx/IKUhk=;
        b=RYPzBSaj1hvq7e1DuM1nr6WXL9rBml0+kEqkoRpUb8jkMP1NSZ4mTuiKy7zceqEzdb7NwF
        I2JNbR/g5+Tp+L3eHOkfqG+M1NEUiakV5TlpJtoFSVm7I7EYg7k8zHVVZLA/+vUHQix2ot
        rBNt9f3speIBFNaeqmZmkT7x9EO9Nz0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: Memory leak when raid10 takeover raid0
To:     Xiao Ni <xni@redhat.com>, linux-raid <linux-raid@vger.kernel.org>
Cc:     Song Liu <song@kernel.org>
References: <CALTww2-EAeM6aKeZbZ2udTwS5RFwNWfF9uag=npewB9j0H51Hw@mail.gmail.com>
Message-ID: <35f4a626-7f83-56c5-4cad-73ede197ccbf@linux.dev>
Date:   Mon, 10 Oct 2022 08:40:00 +0800
MIME-Version: 1.0
In-Reply-To: <CALTww2-EAeM6aKeZbZ2udTwS5RFwNWfF9uag=npewB9j0H51Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Xiao,

On 10/8/22 5:06 PM, Xiao Ni wrote:
> Hi all
>
> Sometimes it will have a memory leak problem when raid10 takeover raid0.
> And then panic.
>
> [ 6973.704097] BUG bio-176 (Not tainted): Objects remaining in bio-176
> on __kmem_cache_shutdown()
> [ 6973.705627] -----------------------------------------------------------------------------
> [ 6973.705627]
> [ 6973.707331] Slab 0x0000000067cd8c6c objects=21 used=1
> fp=0x000000005bf568c8
> flags=0xfffffc0000100(slab|node=0|zone=1|lastcpupid=0x1fffff)
> [ 6973.709498] CPU: 0 PID: 735535 Comm: mdadm Kdump: loaded Not
> tainted 4.18.0-423.el8.x86_64 #1

It is an old kernel, does it also happen to latest mainline version? Not 
sure mdadm test suite
covers this case.

> [ 6973.711027] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [ 6973.712068] Call Trace:
> [ 6973.712550]  dump_stack+0x41/0x60
> [ 6973.713185]  slab_err.cold.117+0x53/0x67
> [ 6973.713878]  ? __unfreeze_partials+0x1a0/0x1a0
> [ 6973.714659]  ? cpumask_next+0x17/0x20
> [ 6973.715309]  __kmem_cache_shutdown+0x16e/0x300
> [ 6973.716097]  kmem_cache_destroy+0x4d/0x120
> [ 6973.716843]  bioset_exit+0xb0/0x100
> [ 6973.717486]  level_store+0x280/0x650
> [ 6973.718147]  ? security_capable+0x38/0x60
> [ 6973.718856]  md_attr_store+0x7c/0xc0
> [ 6973.719489]  kernfs_fop_write+0x11e/0x1a0
> [ 6973.720200]  vfs_write+0xa5/0x1b0
> [ 6973.720785]  ksys_write+0x4f/0xb0
> [ 6973.721374]  do_syscall_64+0x5b/0x1b0
> [ 6973.722028]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> [ 6973.723005] RIP: 0033:0x7fb15d2b5bc8
> [ 6973.723660] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 55 4b 2a 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> d4 55
> [ 6973.726926] RSP: 002b:00007ffed8ebc8a8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 6973.728278] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb15d2b5bc8
> [ 6973.729515] RDX: 0000000000000006 RSI: 0000560330046dd7 RDI: 0000000000000004
> [ 6973.730748] RBP: 0000560330046dd7 R08: 000056033003b927 R09: 00007fb15d315d40
> [ 6973.731986] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [ 6973.733240] R13: 00007ffed8ebcc80 R14: 00007ffed8ebe8ee R15: 0000000000000000
> [ 6973.734520] Disabling lock debugging due to kernel taint
> [ 6973.735452] Object 0x000000000923869f @offset=3264
> [ 6973.736317] kmem_cache_destroy bio-176: Slab cache still has objects
> [ 6973.737479] CPU: 0 PID: 735535 Comm: mdadm Kdump: loaded Tainted: G
>     B            --------- -  - 4.18.0-423.el8.x86_64 #1
> [ 6973.739438] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [ 6973.740437] Call Trace:
> [ 6973.740877]  dump_stack+0x41/0x60
> [ 6973.741473]  kmem_cache_destroy+0x116/0x120
> [ 6973.742209]  bioset_exit+0xb0/0x100
> [ 6973.742824]  level_store+0x280/0x650
> [ 6973.743463]  ? security_capable+0x38/0x60
> [ 6973.744177]  md_attr_store+0x7c/0xc0
> [ 6973.744807]  kernfs_fop_write+0x11e/0x1a0
> [ 6973.745516]  vfs_write+0xa5/0x1b0
> [ 6973.746112]  ksys_write+0x4f/0xb0
> [ 6973.746695]  do_syscall_64+0x5b/0x1b0
> [ 6973.747373]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> [ 6973.748293] RIP: 0033:0x7fb15d2b5bc8
> [ 6973.748929] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 55 4b 2a 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> d4 55
> [ 6973.752255] RSP: 002b:00007ffed8ebc8a8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 6973.753628] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb15d2b5bc8
> [ 6973.754900] RDX: 0000000000000006 RSI: 0000560330046dd7 RDI: 0000000000000004
> [ 6973.756142] RBP: 0000560330046dd7 R08: 000056033003b927 R09: 00007fb15d315d40
> [ 6973.757420] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [ 6973.758702] R13: 00007ffed8ebcc80 R14: 00007ffed8ebe8ee R15: 0000000000000000
> [ 6973.762429] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000000
> [ 6973.763818] PGD 0 P4D 0
> [ 6973.764277] Oops: 0002 [#1] SMP PTI
> [ 6973.764896] CPU: 0 PID: 12 Comm: ksoftirqd/0 Kdump: loaded Tainted:
> G    B            --------- -  - 4.18.0-423.el8.x86_64 #1
> [ 69 it73.766944] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [ 6973.767999] RIP: 0010:mempool_free+0x52/0x80
> [ 6973.768779] Code: e4 6f 96 00 e9 0f 72 96 00 48 89 f7 e8 a7 5e 75
> 00 48 63 53 08 3b 53 04 7d 30 48 8b 4b 10 8d 72 01 48 89 df 89 73 08
> 48 89 c6 <48> 89 2c d1 e8 f5 5e 75 00 48 8d 7b 30 31 c9 5b ba 01 00 00
> 00 be
> [ 6973.772088] RSP: 0018:ffffbc6c4068fdf8 EFLAGS: 00010093
> [ 6973.773026] RAX: 0000000000000293 RBX: ffff9b5844fed7d8 RCX: 0000000000000000
> [ 6973.774318] RDX: 0000000000000000 RSI: 0000000000000293 RDI: ffff9b5844fed7d8
> [ 6973.775560] RBP: ffff9b5759046cc0 R08: 000000000000003d R09: ffff9b57420e62a0
> [ 6973.776794] R10: 0000000000000008 R11: ffff9b574a602a00 R12: ffff9b5845004ed0
> [ 6973.778096] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
> [ 6973.779357] FS:  0000000000000000(0000) GS:ffff9b5870000000(0000)
> knlGS:0000000000000000
> [ 6973.780757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6973.781806] CR2: 0000000000000000 CR3: 0000000043410002 CR4: 00000000007706f0
> [ 6973.783076] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 6973.784313] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 6973.785593] PKRU: 55555554
> [ 6973.786098] Call Trace:
> [ 6973.786549]  md_end_io_acct+0x31/0x40
> [ 6973.787227]  blk_update_request+0x224/0x380
> [ 6973.787994]  blk_mq_end_request+0x1a/0x130
> [ 6973.788739]  blk_complete_reqs+0x35/0x50
> [ 6973.789456]  __do_softirq+0xd7/0x2c8
> [ 6973.790114]  ? sort_range+0x20/0x20
> [ 6973.790763]  run_ksoftirqd+0x2a/0x40
> [ 6973.791400]  smpboot_thread_fn+0xb5/0x150
> [ 6973.792114]  kthread+0x10b/0x130
> [ 6973.792724]  ? set_kthread_struct+0x50/0x50
> [ 6973.793491]  ret_from_fork+0x1f/0x40
>
> The reason is that raid0 doesn't do anything in raid0_quiesce. During
> the level change in level_store, it needs
> to make sure all inflight bios to finish.  We can add a count to do
> this in raid0. Is it a good way?
>
> There is a count mddev->active_io in mddev. But it's decreased in
> md_handle_request rather than in the callback
> endio function. Is it right to decrease active_io in callbcak endio function?
>

I think it is a race between ios and takeover action, since 
mddev_suspend called by
level_store should ensure no io is submitted to array at that time by below.

     wait_event(mddev->sb_wait, atomic_read(&mddev->active_io) == 0)

However it can't guarantee new io comes after mddev_suspend because the 
empty
raid0 quiesce.  Maybe we can do something like this.

diff --git a/drivers/md/md.c b/drivers/md/md.c
index afaf36b2f6ab..0fdc07008bcf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3891,6 +3891,7 @@ level_store(struct mddev *mddev, const char *buf, 
size_t len)
         if (rv)
                 return rv;

+       set_bit(MD_TAKENOVER, &mddev->flags);
         if (mddev->pers == NULL) {
                 strncpy(mddev->clevel, buf, slen);
                 if (mddev->clevel[slen-1] == '\n')
@@ -4074,6 +4075,7 @@ level_store(struct mddev *mddev, const char *buf, 
size_t len)
         rv = len;
  out_unlock:
         mddev_unlock(mddev);
+       clear_bit(MD_TAKENOVER, &mddev->flags);
         return rv;
  }

diff --git a/drivers/md/md.h b/drivers/md/md.h
index b4e2d8b87b61..e77da3bc6a72 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -255,6 +255,7 @@ struct md_cluster_info;
   *                array is ready yet.
   * @MD_BROKEN: This is used to stop writes and mark array as failed.
   * @MD_DELETED: This device is being deleted
+ * @MD_TAKENOVER: This device is being taken over to another personality.
   *
   * change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added
   */
@@ -272,6 +273,7 @@ enum mddev_flags {
         MD_NOT_READY,
         MD_BROKEN,
         MD_DELETED,
+       MD_TAKENOVER,
  };

  enum mddev_sb_flags {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 78addfe4a0c9..b00ae87c42d3 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -523,6 +523,9 @@ static bool raid0_make_request(struct mddev *mddev, 
struct bio *bio)
         unsigned chunk_sects;
         unsigned sectors;

+       if (test_bit(MD_TAKENOVER, &mddev->flags))
+               return true;
+
         if (unlikely(bio->bi_opf & REQ_PREFLUSH)
             && md_flush_request(mddev, bio))
                 return true;

Another way is set mddev->pers to NULL before mddev_suspend in 
level_store, then move
"mddev->pers = pers" after mddev_resume, this way makes md_submit_bio 
returns earlier.
I guess this way is more simple and straightforward.

diff --git a/drivers/md/md.c b/drivers/md/md.c
index afaf36b2f6ab..5a7134e3c182 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3979,6 +3979,9 @@ level_store(struct mddev *mddev, const char *buf, 
size_t len)
                 goto out_unlock;
         }

+       /* Only accept IO after takeover is done */
+       mddev->pers = NULL;
+
         /* Looks like we have a winner */
         mddev_suspend(mddev);
         mddev_detach(mddev);
@@ -3986,7 +3989,6 @@ level_store(struct mddev *mddev, const char *buf, 
size_t len)
         spin_lock(&mddev->lock);
         oldpers = mddev->pers;
         oldpriv = mddev->private;
-       mddev->pers = pers;
         mddev->private = priv;
         strscpy(mddev->clevel, pers->name, sizeof(mddev->clevel));
         mddev->level = mddev->new_level;
@@ -4067,6 +4069,7 @@ level_store(struct mddev *mddev, const char *buf, 
size_t len)
         pers->run(mddev);
         set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
         mddev_resume(mddev);
+       mddev->pers = pers;
         if (!mddev->thread)
                 md_update_sb(mddev, 1);
         sysfs_notify_dirent_safe(mddev->sysfs_level);

Thanks,
Guoqing
