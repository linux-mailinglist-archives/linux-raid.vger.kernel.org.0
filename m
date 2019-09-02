Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E07A4CDD
	for <lists+linux-raid@lfdr.de>; Mon,  2 Sep 2019 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfIBAlg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Sep 2019 20:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfIBAlg (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 1 Sep 2019 20:41:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89FC3AE49;
        Mon,  2 Sep 2019 00:41:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Dmitrij Gusev <dmitrij@gusev.co>, linux-raid@vger.kernel.org
Date:   Mon, 02 Sep 2019 10:41:28 +1000
Subject: Re: Kernel error at a LVM snapshot creation
In-Reply-To: <80b41a78-d2db-90fa-885a-a03098b5b82e@gusev.co>
References: <20190829081514.29660-1-yuyufen@huawei.com> <877e6vf45p.fsf@notabene.neil.brown.name> <07ffeca5-6b69-0602-0981-2221cfb682af@huawei.com> <80b41a78-d2db-90fa-885a-a03098b5b82e@gusev.co>
Message-ID: <87v9ubedhj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01 2019, Dmitrij Gusev wrote:

> Hello.
>
> I get a kernel error every time I create LVM snapshot - at the creation=20
> and at boot time, though the snapshot itself is working properly.

Wrong email list. Easy mistake to make though.
Please use  dm-devel@redhat.com

NeilBrown


>
> Sorry if I'm writing to the incorrect mailing list, please direct me to=20
> the correct one. (I wasn't able to find LVM related).
>
> Linux nexus 4.19.69 #2 SMP Thu Aug 29 16:33:35 CDT 2019 x86_64 Intel(R)=20
> Xeon(R) E-2174G CPU @ 3.80GHz GenuineIntel GNU/Linux
>
> At boot log:
>
> [=C2=A0=C2=A0 17.160402] ------------[ cut here ]------------
> [=C2=A0=C2=A0 17.160900] generic_make_request: Trying to write to read-on=
ly=20
> block-device dm-4 (partno 0)
> [=C2=A0=C2=A0 17.161424] WARNING: CPU: 3 PID: 941 at block/blk-core.c:217=
6=20
> generic_make_request_checks+0x28d/0x6a0
> [=C2=A0=C2=A0 17.161935] Modules linked in: fuse hid_generic usbhid hid i=
2c_dev=20
> mei_wdt eeepc_wmi asus_wmi evdev sparse_keymap rfkill wmi_bmof=20
> snd_hda_codec_hdmi coretemp snd_hda_codec_realtek intel_rapl=20
> snd_hda_codec_generic x86_pkg_temp_thermal intel_powerclamp kvm_intel=20
> crct10dif_pclmul crc32_pclmul i915 crc32c_intel ghash_clmulni_intel=20
> intel_cstate snd_hda_intel snd_hda_codec kvmgt vfio_mdev intel_rapl_perf=
=20
> mdev vfio_iommu_type1 vfio kvm snd_hda_core snd_hwdep igb snd_pcm=20
> snd_timer snd e1000e soundcore irqbypass cec rc_core hwmon dca i2c_i801=20
> drm_kms_helper drm intel_gtt agpgart thermal fan i2c_algo_bit=20
> fb_sys_fops syscopyarea sysfillrect sysimgblt i2c_core video mei_me mei=20
> xhci_pci xhci_hcd button pcc_cpufreq wmi acpi_pad acpi_tad loop=20
> dm_snapshot dm_bufio ext4 mbcache jbd2
> [=C2=A0=C2=A0 17.165955] CPU: 3 PID: 941 Comm: kworker/3:3 Not tainted 4.=
19.69 #2
> [=C2=A0=C2=A0 17.166464] Hardware name: ASUSTeK COMPUTER INC. System Prod=
uct=20
> Name/WS C246 PRO, BIOS 1003 06/04/2019
> [=C2=A0=C2=A0 17.166952] Workqueue: kcopyd do_work
> [=C2=A0=C2=A0 17.167467] RIP: 0010:generic_make_request_checks+0x28d/0x6a0
> [=C2=A0=C2=A0 17.167952] Code: 5c 03 00 00 48 89 ef 48 8d 74 24 08 c6 05 =
11 47 f3=20
> 00 01 e8 55 60 01 00 48 c7 c7 d0 5d 08 bd 48 89 c6 44 89 e2 e8 22 cd cc=20
> ff <0f> 0b 4c 8b 65 08 8b 45 30 c1 e8 09 49 8b 74 24 50 85 c0 0f 84 5f
> [=C2=A0=C2=A0 17.169020] RSP: 0018:ffff9df3c400faf8 EFLAGS: 00010282
> [=C2=A0=C2=A0 17.169533] RAX: 0000000000000000 RBX: ffff927c05350988 RCX:=
=20
> 0000000000000311
> [=C2=A0=C2=A0 17.170049] RDX: 0000000000000001 RSI: 0000000000000082 RDI:=
=20
> 0000000000000246
> [=C2=A0=C2=A0 17.170562] RBP: ffff927c06a64900 R08: 0000000000000000 R09:=
=20
> 0000000000000311
> [=C2=A0=C2=A0 17.171106] R10: 0000000000aaaaaa R11: 0000000000000000 R12:=
=20
> 0000000000000000
> [=C2=A0=C2=A0 17.171616] R13: 0000000000000000 R14: 0000000000001000 R15:=
=20
> ffff927c05472b80
> [=C2=A0=C2=A0 17.172130] FS:=C2=A0 0000000000000000(0000) GS:ffff927c0bb8=
0000(0000)=20
> knlGS:0000000000000000
> [=C2=A0=C2=A0 17.172646] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 17.173191] CR2: 00007f40a05f9ff0 CR3: 000000015a20a004 CR4:=
=20
> 00000000003606e0
> [=C2=A0=C2=A0 17.173711] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
=20
> 0000000000000000
> [=C2=A0=C2=A0 17.174238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
=20
> 0000000000000400
> [=C2=A0=C2=A0 17.174752] Call Trace:
> [=C2=A0=C2=A0 17.175279]=C2=A0 ? kmem_cache_alloc+0x37/0x1c0
> [=C2=A0=C2=A0 17.175771]=C2=A0 generic_make_request+0x5b/0x400
> [=C2=A0=C2=A0 17.176247]=C2=A0 submit_bio+0x43/0x130
> [=C2=A0=C2=A0 17.176726]=C2=A0 ? bio_add_page+0x48/0x60
> [=C2=A0=C2=A0 17.177195]=C2=A0 dispatch_io+0x1c8/0x460
> [=C2=A0=C2=A0 17.177689]=C2=A0 ? dm_hash_remove_all.cold+0x21/0x21
> [=C2=A0=C2=A0 17.178168]=C2=A0 ? list_get_page+0x30/0x30
> [=C2=A0=C2=A0 17.178624]=C2=A0 ? dm_kcopyd_do_callback+0x40/0x40
> [=C2=A0=C2=A0 17.179102]=C2=A0 dm_io+0x11c/0x210
> [=C2=A0=C2=A0 17.179545]=C2=A0 ? dm_hash_remove_all.cold+0x21/0x21
> [=C2=A0=C2=A0 17.179990]=C2=A0 ? list_get_page+0x30/0x30
> [=C2=A0=C2=A0 17.180429]=C2=A0 run_io_job+0xd4/0x1c0
> [=C2=A0=C2=A0 17.180863]=C2=A0 ? dm_kcopyd_do_callback+0x40/0x40
> [=C2=A0=C2=A0 17.181293]=C2=A0 ? dm_kcopyd_client_destroy+0x140/0x140
> [=C2=A0=C2=A0 17.181719]=C2=A0 process_jobs+0x82/0x1b0
> [=C2=A0=C2=A0 17.182147]=C2=A0 do_work+0xb9/0xf0
> [=C2=A0=C2=A0 17.182570]=C2=A0 process_one_work+0x1ba/0x3d0
> [=C2=A0=C2=A0 17.182992]=C2=A0 worker_thread+0x4d/0x3d0
> [=C2=A0=C2=A0 17.183441]=C2=A0 ? process_one_work+0x3d0/0x3d0
> [=C2=A0=C2=A0 17.183857]=C2=A0 kthread+0x117/0x130
> [=C2=A0=C2=A0 17.184270]=C2=A0 ? kthread_create_worker_on_cpu+0x70/0x70
> [=C2=A0=C2=A0 17.184680]=C2=A0 ret_from_fork+0x35/0x40
> [=C2=A0=C2=A0 17.185082] ---[ end trace f01c6b7a501faa64 ]---
>
> Best regards,
>
> Dmitrij Gusev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1sZTgACgkQOeye3VZi
gblj2xAAvrFNtFt7FPyMPeb8Lh2ENQRqp6xqZRetW3EjvFUCLbYcRPKZj/VahP2q
xkMTtJddZPdN0CJtLCDXkO0MarMWPSpABAdvK0ybNlAfk5sDToEPLoBXAjSCEZKt
TygQOPQqnmKqtGhDiFdisv/41KbGL5FaPpTz8Fzrq65wGjUe2ynRSn3decoxhzTj
eCuFWxreYKwqicI2sVJkxNzPKc7PRoaI+hF9/Zza9wXf6JDMsEna07nR26NENLrR
RyJ6ejIo9hTj8gbUhZzmQppsGuSuctIBqC+VeAqzP+CMqK5KAzo6W4o4znOzXFnc
prhU61a/09sl7c/eAPbtXODiEbpP+t8LFW7LmBdvJ8GG8dteR9wd3WzSKbHyPcWq
n4nE7pV1E4/+gb4piiLoZZh7kvHU9QbJUbdo+FSSczwX2NyPl5684KxGHeBxTn/B
0/wBO+2sEUtLu0t3CSsWbECnQV0B5+1wBlSIYW1gQnTZRX2aYYDjZU9Z/F/Grl0K
jII+tzz/UqqGIU/1YA/uJBrBP+vrbs9rEVloPkCFXMIh8QrVkAh9r9A+jQ+I59Iv
52OnXSJNie4+sE3w+Gn8a0dtXH++I7cH94gwtxj7NIbAp5aQmOTt7d3/RWSS5cv/
836/vZdeSgrgNKbSpVBJ8w3UMNZR2vR3XJ8uks1cFHysdrhlX58=
=1mz1
-----END PGP SIGNATURE-----
--=-=-=--
