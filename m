Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B37583A76
	for <lists+linux-raid@lfdr.de>; Thu, 28 Jul 2022 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiG1IkH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 28 Jul 2022 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiG1IkE (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 28 Jul 2022 04:40:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208595A3F9
        for <linux-raid@vger.kernel.org>; Thu, 28 Jul 2022 01:40:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 883D238789;
        Thu, 28 Jul 2022 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658997601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQ8TRlzc//9AxiaENuXl0slO7d0yvbcGPZ8DkoYXoHQ=;
        b=jftwN8nkGH7OVo5ypQrA95GeEYEPcXzGA5qoEjsScd8k3NXFyEjBNh4YxIiv4gmnUtVxCV
        U2W++QtCNbVz5AzR9brcwAr6a1X9lEPRvKttX4/HkMebAHrhkofCTwvkiza2R8nUqnbfX1
        dTE1H8DFH8GGSfMAbHmhnoytS5euuyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658997601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQ8TRlzc//9AxiaENuXl0slO7d0yvbcGPZ8DkoYXoHQ=;
        b=etyoAWRDBhHQCJCPD2/ti2uIDnoOur1Zc9E3L74MVDdj4N1CRcL4Ru4lVMnFlKyTcL3S8Z
        IcfiywU9VgkwyWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FAD813427;
        Thu, 28 Jul 2022 08:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /DiLE19L4mLONgAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 28 Jul 2022 08:39:59 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] mdadm/systemd: remove KillMode=none from service file
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20220728095535.00007b7b@linux.intel.com>
Date:   Thu, 28 Jul 2022 16:39:56 +0800
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Benjamin Brunner <bbrunner@suse.com>,
        Franck Bui <fbui@suse.de>,
        Jes Sorensen <jes@trained-monkey.org>,
        Neil Brown <neilb@suse.de>, Xiao Ni <xni@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19888116-2ED0-4183-B104-E53027AA1A65@suse.de>
References: <20220215133415.4138-1-colyli@suse.de>
 <20220728095535.00007b7b@linux.intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> 2022=E5=B9=B47=E6=9C=8828=E6=97=A5 15:55=EF=BC=8CMariusz Tkaczyk =
<mariusz.tkaczyk@linux.intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 15 Feb 2022 21:34:15 +0800
> Coly Li <colyli@suse.de> wrote:
>=20
>> For mdadm's systemd configuration, current systemd KillMode is "none" =
in
>> following service files,
>> - mdadm-grow-continue@.service
>> - mdmon@.service
>>=20
>> This "none" mode is strongly againsted by systemd developers (see man =
5
>> systemd.kill for "KillMode=3D" section), and is considering to remove =
in
>> future systemd version.
>>=20
>> As systemd developer explained in disuccsion, the systemd kill =
process
>> is,
>> 1. send the signal specified by KillSignal=3D to the list of =
processes (if
>> any), TERM is the default
>> 2. wait until either the target of process(es) exit or a timeout =
expires
>> 3. if the timeout expires send the signal specified by =
FinalKillSignal=3D,
>> KILL is the default
>>=20
>> For "control-group", all remaining processes will receive the SIGTERM
>> signal (by default) and if there are still processes after a period f
>> time, they will get the SIGKILL signal.
>>=20
>> For "mixed", only the main process will receive the SIGTERM signal, =
and
>> if there are still processes after a period of time, all remaining
>> processes (including the main one) will receive the SIGKILL signal.
>>=20
>> =46rom the above comment, currently KillMode=3Dcontrol-group is a =
proper
>> kill mode. Since control-gropu is the default kill mode, the fix can =
be
>> simply removing KillMode=3Dnone line from the service file, then the
>> default mode will take effect.
>=20
> Hi All,
> We are experiencing issues with IMSM metadata on RHEL8.7 and 9.1 (the =
patch
> was picked by Redhat). There are several issues which results in hang =
task,
> characteristic to missing mdmon:
>=20
> [ 619.521440] task:umount state:D stack: 0 pid: 6285 ppid: =
flags:0x00004084
> [ 619.534033] Call Trace:
> [ 619.539980] __schedule+0x2d1/0x830
> [ 619.547056] ? finish_wait+0x80/0x80
> [ 619.554261] schedule+0x35/0xa0
> [ 619.560999] md_write_start+0x14b/0x220
> [ 619.568492] ? finish_wait+0x80/0x80
> [ 619.575649] raid1_make_request+0x3c/0x90 [raid1]
> [ 619.584111] md_handle_request+0x128/0x1b0
> [ 619.591891] md_make_request+0x5b/0xb0
> [ 619.599235] generic_make_request_no_check+0x202/0x330
> [ 619.608185] submit_bio+0x3c/0x160
> [ 619.615161] ? bio_add_page+0x42/0x50
> [ 619.622413] submit_bh_wbc+0x16a/0x190
> [ 619.629713] jbd2_write_superblock+0xf4/0x210 [jbd2]
> [ 619.638340] jbd2_journal_update_sb_log_tail+0x65/0xc0 [jbd2]
> [ 619.647773] __jbd2_update_log_tail+0x3f/0x100 [jbd2]
> [ 619.656374] jbd2_cleanup_journal_tail+0x50/0x90 [jbd2]
> [ 619.665107] jbd2_log_do_checkpoint+0xfa/0x400 [jbd2]
> [ 619.673572] ? prepare_to_wait_event+0xa0/0x180
> [ 619.681344] jbd2_journal_destroy+0x120/0x2a0 [jbd2]
> [ 619.689551] ? finish_wait+0x80/0x80
> [ 619.696096] ext4_put_super+0x76/0x390 [ext4]
> [ 619.703584] generic_shutdown_super+0x6c/0x100
> [ 619.711065] kill_block_super+0x21/0x50
> [ 619.717809] deactivate_locked_super+0x34/0x70
> [ 619.725146] cleanup_mnt+0x3b/0x70
> [ 619.731279] task_work_run+0x8a/0xb0
> [ 619.737576] exit_to_usermode_loop+0xeb/0xf0
> [ 619.744657] do_syscall_64+0x198/0x1a0
> [ 619.751155] entry_SYSCALL_64_after_hwframe+0x65/0xca
>=20
> It can be reproduced by mounting LVM created on IMSM RAID1 array and =
then
> reboot. I verified that reverting the patch fixes the issue.
>=20
> I understand that from systemd perspective the behavior in not wanted, =
but
> this is exactly what we need, to have working mdmon process even if =
systemd was
> stopped. KillMode=3Dnone does the job.
> I searched for alternative way to prevent systemd from stopping the =
mdmon unit
> but I failed. I tried to change signals, so I configured unit to send =
SIGPIPE
> (because it is ignored by mdmon)- it worked but later system hanged =
because
> mdmon unit cannot be stopped.
>=20
> I also tried to configure mdmon unit to be stopped after umount.target =
and I
> failed too. It cannot be achieved by setting After=3D or Before=3D. =
The one
> objection I have here is that systemd-shutdown tries to stop raid =
arrays later,
> so it could be better to have running mdmon there.
>=20
> IMO KillMode=3Dnone is desired in this case. Later, mdmon is restarted =
in dracut
> by mdraid module.
>=20
> If there is no other solution for the problem, I will need to ask Jes =
to revert
> this patch. For now, I asked Redhat to do it.
> Do you have any suggestions?


If Redhat doesn=E2=80=99t use the latest systemd, they should drop this =
patch. For mdadm upstream we should keep this because it was suggested =
by systemd developer.

Thanks.

Coly Li

