Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D4196B89
	for <lists+linux-raid@lfdr.de>; Sun, 29 Mar 2020 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgC2GiF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Mar 2020 02:38:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbgC2GiF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 29 Mar 2020 02:38:05 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02T6Zt6M032116;
        Sat, 28 Mar 2020 23:37:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7LwA10AGlRtbw7z7yfsv6tVmxpyFvq0W2jHdcECtC9E=;
 b=Wb5pg9UXGFkB6MZErotSEWnRBSbRBJRafmBARD9Jayecb9ALOXfOa1TQg5JKjvPW5DM3
 s1XolOpnqINDrSNkTgvztfb0Xq3rTA3vjcyubHzykY2fdaBnUsTCR2gPqccZDkbqt77K
 bTzX8rG3ePyBjCQBmnowKlh4KthXVcYIYgE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3022mbk342-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 28 Mar 2020 23:37:58 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 28 Mar 2020 23:37:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAHUwaeFdhAMEufDTx8M4wckTZ+4N2mBtfClWt79KzvgxailnfFyLwt+YXrfh5aVahMcm0LfNxro1WkLA75+vu7f/6xL91OL6DCUwoPHNILnmL0Cl9bQMkKMq4sA4FlzpsE2njDl6cYKlAKCf6CVTzk80Sh6EpIqOS4+sne+bQUG8d4Is0al8ogbRbenCnIieDazik0e90Djdq6k+zETYE7ajYn+qOgKpje+Pjh85Dro5jRBj7YufdIFW34KneEi2BDo6KmhbPvNHUcQeXQwMMOfRyOteiyvFR9X79vL4YbxlIOwmZSr2DHlGeJqhTACLgDEyr8T5lY0xx7NMI7zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LwA10AGlRtbw7z7yfsv6tVmxpyFvq0W2jHdcECtC9E=;
 b=G2GCDMNbD7WqJ0238zcFm8Guv8nc73Jx1TTQ4VT5Q9qCvWPNzf8LmdXPoJn0zxVC5Lbzy8d1u+ZsS9dk7oU0Ktgwrz5luAXnWn4vMXznVZBBtweu9tEXrC7csC2nxbIA6E+u4CiTe7MMcRdv75kOVEzRZUgIV+fzqs+rlm50AmPt2HSi2k0w+FRCZrjsy6PJW7ujffJiQmiblZA5Nm6dPXE/lLi3nossZ3IF9VzZmLsiM7j0aF3lFF+HWVDWi/ZqgkZUe61dKt8z/YXL2guSs90s+FDvjT6AhdhUsyaQcdE0tpsBQ3FakBe2EYPMDRCuiS3V5nT4KfqOiw74KQls3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LwA10AGlRtbw7z7yfsv6tVmxpyFvq0W2jHdcECtC9E=;
 b=GGDav6I8plI4/F5Z7B6NH4tB6kiHDHrSrBNXH0Ed09rZ5DED6ePPhQ1oDoHWiq1r1HY6Gce8QZP+H4li/z0SzK3Kl8xcRY81rae1UpUvoZyTblbGCd+kLGP+Z7/mf3/U91ALVtGAdxKl+Ya3H5uU0qwJKCwJNGheBKi19WTlClw=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3916.namprd15.prod.outlook.com (2603:10b6:303:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sun, 29 Mar
 2020 06:37:30 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2856.019; Sun, 29 Mar 2020
 06:37:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Coly Li <colyli@suse.de>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [BUG REPORT] suspicious deadlock when stopping md raid5 on
 5.6-rc7 kernel
Thread-Topic: [BUG REPORT] suspicious deadlock when stopping md raid5 on
 5.6-rc7 kernel
Thread-Index: AQHWAxYUmz7SjZZruUSzkMNhR0+e/ahevE8AgABmjYA=
Date:   Sun, 29 Mar 2020 06:37:29 +0000
Message-ID: <1C09DD5B-4AC7-40B4-BB58-187645B85755@fb.com>
References: <4a0ac66e-3deb-313a-60bb-ae1a2d45b751@suse.de>
 <84c00170-d564-8e1e-3bbc-6eebf27cfe31@cloud.ionos.com>
In-Reply-To: <84c00170-d564-8e1e-3bbc-6eebf27cfe31@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:8d01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9218e5a-dacb-42c3-f75f-08d7d3aba765
x-ms-traffictypediagnostic: MW3PR15MB3916:
x-microsoft-antispam-prvs: <MW3PR15MB391628D1FD4A9C3DA74C49ACB3CA0@MW3PR15MB3916.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3882.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(71200400001)(186003)(86362001)(478600001)(76116006)(2616005)(6486002)(66476007)(66556008)(4326008)(64756008)(6916009)(66446008)(66946007)(8676002)(81166006)(81156014)(8936002)(6512007)(6506007)(53546011)(54906003)(2906002)(36756003)(5660300002)(33656002)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeX2lIC24On1K9cWnxMfrv/r3zT/ntQeo1Fgj/C58oChHbEUUlQgDf2cVcugqqXygLbfs56L/l/uRfd4bkPU5m3cGBieCC49wtV8pdNTZ9OntSxy/pO+sSFZ1FrK3UQykqwCvXMpD0vlNZvL0Axl9l6jK9J8Lu/GB1P2Q11jN9N7BRAOQFBprzZnn4Xxvi9GsHQnUkr6TF4vKnBw9qCMe3rdDDghnxAasCP0FtPOsyEQTlNbgHcmV64Z8zAUANKmFqS595sLejYl9bnZioecUH8mFNMImfhE+dIhoqarERz6JjoGQ1t7wa9byRMjLDtqJspO0rOoIKZRECPf0ktYpnf1XxdGkRXpTrG9dK32xv0wad+HxG02jVodHq0j/KLUIxWmPeroODYixGXrjBKUnNHsUn8iYqf4ySrvoRna2BFRIKJCbl1D7poY3/IwP0ND
x-ms-exchange-antispam-messagedata: CgMpUZmppPv0ti+XvY8PN4YTEC/f14P6q1WymYb984C2EXD50r/uCoQ3qLm/REwo4bJipIG7fTcQU5pevAGKGsGqUTP4BtuuFTAGuzRzsiqMpfb7DNjvZLTTpAnbNNWDTJ5i4PQuDx4v2Cf0w3Hi0UmS//sT+JtfOo0ClyJNLxuNp3IIFOIqJlyH7/F2TbsX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BE798B842A8734B83C3105E0A889CC8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9218e5a-dacb-42c3-f75f-08d7d3aba765
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 06:37:29.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrVkAgF+EUVJgDrRcMSSEgrhU4CQhe98dXd/ZV6mcvmaWs1h4ENY3i7D6U8EEa0VfseqRDr73/wGvXRli90ZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3916
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-29_01:2020-03-27,2020-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003290063
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Mar 28, 2020, at 5:30 PM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
>=20
>=20
> On 3/26/20 3:26 AM, Coly Li wrote:
>> Hi Song and Guoqing,
>> Here is the step how I encounter the lockdep warning (yes lockdep engine
>> enabled),
>> export IMSM_NO_PLATFORM=3D1
>> mdadm -CR imsm0 -e imsm -n 4 /dev/nvme{0,1,2,3}n1
>> mdadm -CR vol5 -l 5 -n 3 /dev/nvme{0,1,2}n1 --assume-clean
>> mdadm --manage --stop /dev/md126
>> (The warning message shows up when I run the above line to stop md126)
>> mdadm --manage --stop /dev/md127
>> The kernel is just upstream Linux kernel with 5.6-rc7 tag. I use 4 NVMe
>> SSD to reproduce another issue, and encounter the following warning by
>> the above steps,
>> [ 1604.255664] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ 1604.329616] WARNING: possible circular locking dependency detected
>> [ 1604.403579] 5.6.0-rc7-default #5 Tainted: G            E
>> [ 1604.471295] ------------------------------------------------------
>> [ 1604.545253] kworker/5:0/843 is trying to acquire lock:
>> [ 1604.606731] ffff8889ff2d11e8 (kn->count#256){++++}, at:
>> kernfs_remove+0x1f/0x30
>> [ 1604.694230]
>> [ 1604.694230] but task is already holding lock:
>> [ 1604.764026] ffff888a1d3b7e10
>> ((work_completion)(&rdev->del_work)){+.+.}, at: process_one_work+0x42b/0=
xb30
>> [ 1604.878564]
>> [ 1604.878564] which lock already depends on the new lock.
>> [ 1604.878564]
>> [ 1604.976436]
>> [ 1604.976436] the existing dependency chain (in reverse order) is:
>> [ 1605.065993]
>> [ 1605.065993] -> #4 ((work_completion)(&rdev->del_work)){+.+.}:
>> [ 1605.152443]        process_one_work+0x4b5/0xb30
>> [ 1605.206643]        worker_thread+0x65/0x5a0
>> [ 1605.256688]        kthread+0x1d9/0x200
>> [ 1605.301535]        ret_from_fork+0x3a/0x50
>> [ 1605.350527]
>> [ 1605.350527] -> #3 ((wq_completion)md_misc){+.+.}:
>> [ 1605.424495]        flush_workqueue+0xfb/0x990
>> [ 1605.476653]        __md_stop_writes+0x34/0x1f0 [md_mod]
>> [ 1605.539206]        do_md_stop+0x2b8/0xb40 [md_mod]
>> [ 1605.596561]        array_state_store+0x297/0x450 [md_mod]
>> [ 1605.661196]        md_attr_store+0xb3/0x100 [md_mod]
>> [ 1605.720598]        kernfs_fop_write+0x1a0/0x240
>> [ 1605.774799]        vfs_write+0xff/0x280
>> [ 1605.820679]        ksys_write+0x120/0x170
>> [ 1605.868646]        do_syscall_64+0x78/0x330
>> [ 1605.918686]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [ 1605.985361]
>> [ 1605.985361] -> #2 (&mddev->open_mutex){+.+.}:
>> [ 1606.055161]        __mutex_lock+0x12f/0xd20
>> [ 1606.105233]        do_md_stop+0x1ee/0xb40 [md_mod]
>> [ 1606.162587]        array_state_store+0x297/0x450 [md_mod]
>> [ 1606.227219]        md_attr_store+0xb3/0x100 [md_mod]
>> [ 1606.286618]        kernfs_fop_write+0x1a0/0x240
>> [ 1606.340822]        vfs_write+0xff/0x280
>> [ 1606.386703]        ksys_write+0x120/0x170
>> [ 1606.434660]        do_syscall_64+0x78/0x330
>> [ 1606.484704]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [ 1606.551380]
>> [ 1606.551380] -> #1 (&mddev->reconfig_mutex){+.+.}:
>> [ 1606.625341]        __mutex_lock+0x12f/0xd20
>> [ 1606.675412]        rdev_attr_store+0x6f/0xf0 [md_mod]
>> [ 1606.735853]        kernfs_fop_write+0x1a0/0x240
>> [ 1606.790050]        vfs_write+0xff/0x280
>> [ 1606.835931]        ksys_write+0x120/0x170
>> [ 1606.883888]        do_syscall_64+0x78/0x330
>> [ 1606.933927]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [ 1607.000604]
>> [ 1607.000604] -> #0 (kn->count#256){++++}:
>> [ 1607.065213]        __lock_acquire+0x1ba8/0x1f50
>> [ 1607.119413]        lock_acquire+0xf3/0x240
>> [ 1607.168408]        __kernfs_remove+0x45b/0x4f0
>> [ 1607.221563]        kernfs_remove+0x1f/0x30
>> [ 1607.270564]        kobject_del+0x50/0xa0
>> [ 1607.317515]        md_delayed_delete+0x15/0x20 [md_mod]
>> [ 1607.380035]        process_one_work+0x50c/0xb30
>> [ 1607.434238]        worker_thread+0x65/0x5a0
>> [ 1607.484279]        kthread+0x1d9/0x200
>> [ 1607.529116]        ret_from_fork+0x3a/0x50
>> [ 1607.578110]
>> [ 1607.578110] other info that might help us debug this:
>> [ 1607.578110]
>> [ 1607.673903] Chain exists of:
>> [ 1607.673903]   kn->count#256 --> (wq_completion)md_misc -->
>> (work_completion)(&rdev->del_work)
>> [ 1607.673903]
>> [ 1607.827946]  Possible unsafe locking scenario:
>> [ 1607.827946]
>> [ 1607.898780]        CPU0                    CPU1
>> [ 1607.952980]        ----                    ----
>> [ 1608.007173]   lock((work_completion)(&rdev->del_work));
>> [ 1608.069690]                                lock((wq_completion)md_mis=
c);
>> [ 1608.149887]
>> lock((work_completion)(&rdev->del_work));
>> [ 1608.242563]   lock(kn->count#256);
>> [ 1608.283238]
>> [ 1608.283238]  *** DEADLOCK ***
>=20
> Seems lots of works are attached to md_misc_wq, I think the deadlock is c=
aused by competing the same work queue, need to investigate more. And I vag=
uely recall there was report about md check hang, which I guess could be re=
lated to flush_workqueue as well.
>=20
>=20
>> [ 1608.283238]
>> [ 1608.354078] 2 locks held by kworker/5:0/843:
>> [ 1608.405152]  #0: ffff8889eecc9948 ((wq_completion)md_misc){+.+.}, at:
>> process_one_work+0x42b/0xb30
>> [ 1608.512399]  #1: ffff888a1d3b7e10
>> ((work_completion)(&rdev->del_work)){+.+.}, at: process_one_work+0x42b/0=
xb30
>> [ 1608.632130]
>> [ 1608.632130] stack backtrace:
>> [ 1608.684254] CPU: 5 PID: 843 Comm: kworker/5:0 Tainted: G            E
>>     5.6.0-rc7-default #5
>> [ 1608.787332] Hardware name: Lenovo ThinkSystem SR650
>> -[7X05CTO1WW]-/-[7X05CTO1WW]-, BIOS -[IVE148M-2.41]- 10/31/2019
>> [ 1608.912287] Workqueue: md_misc md_delayed_delete [md_mod]
>> [ 1608.976886] Call Trace:
>> [ 1609.006132]  dump_stack+0xb7/0x10b
>> [ 1609.046814]  check_noncircular+0x2c4/0x320
>> [ 1609.095818]  ? print_circular_bug.isra.36+0x240/0x240
>> [ 1609.156279]  ? __lockdep_free_key_range+0xb0/0xb0
>> [ 1609.212564]  ? __lock_acquire+0x1ba8/0x1f50
>> [ 1609.262606]  __lock_acquire+0x1ba8/0x1f50
>> [ 1609.310574]  ? register_lock_class+0x8c0/0x8c0
>> [ 1609.363741]  lock_acquire+0xf3/0x240
>> [ 1609.406501]  ? kernfs_remove+0x1f/0x30
>> [ 1609.451349]  __kernfs_remove+0x45b/0x4f0
>> [ 1609.498267]  ? kernfs_remove+0x1f/0x30
>> [ 1609.543106]  ? kernfs_fop_readdir+0x3b0/0x3b0
>> [ 1609.595240]  kernfs_remove+0x1f/0x30
>> [ 1609.638003]  kobject_del+0x50/0xa0
>> [ 1609.678721]  md_delayed_delete+0x15/0x20 [md_mod]
>> [ 1609.735005]  process_one_work+0x50c/0xb30
>> [ 1609.782974]  ? pwq_dec_nr_in_flight+0x120/0x120
>> [ 1609.837188]  worker_thread+0x65/0x5a0
>> [ 1609.880997]  ? process_one_work+0xb30/0xb30
>> [ 1609.931037]  kthread+0x1d9/0x200
>> [ 1609.969638]  ? kthread_create_worker_on_cpu+0xc0/0xc0
>> [ 1610.030080]  ret_from_fork+0x3a/0x50
>> [ 1809.448921] md: md127 stopped.
>=20
> Thanks,
> Guoqing

Thanks Coly and Guoqing!

I am able to reproduce this issue. I will look more into it.=20

Song

