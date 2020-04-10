Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3001F1A4C24
	for <lists+linux-raid@lfdr.de>; Sat, 11 Apr 2020 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJWeG (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Apr 2020 18:34:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58464 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbgDJWeG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 10 Apr 2020 18:34:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AMUaYQ016074;
        Fri, 10 Apr 2020 15:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+Ce5g4jiuY8beYegiP4656ZISerpmO4e81Qliw6Wvfw=;
 b=FslqUCqiVMM4BGbPgo4rjtSjJAq7gn8lINaX3mPxbWMQ83xajgJ3RmA7oei/z8QSAzKN
 geCxuOy8DmZPXiQ02LFin3KNZEbdkV1RroBAOU9fp/i6xWqrYjDhFDonEtMxLQy8eVZ2
 ElRBGR6dDKXgs1+u5LtkAGpLuC2vy5466Is= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30afb84m0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 15:34:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 15:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VipZKqS76qDLV1F/NTAluaoXnLFYudnw6eU1YkFJAAE3sOsjFNOMIqyZBaINizbX+Qw+5yF8CKhvfR/P/nlcy6F2MCQzma81ZWZeCU+93CPUdJWTnsXT2RiEnTpMpxZXdFzU5BQoUnuRh6jnAleMMZxSBkGsiAPh8Wmlsih7wUqEU5bWRQxzIS2p/e81NDR8MZ9b6Rwt9a3b8/rzHZrsxAEm3pavEceK7RELxb7xwSrTfMx99UXXW+zMfvCluhNKd0ZBI6jQ4D1vrDyzwFB65h5Hb/4zxFMxoKDAgSg9EP58TbnJY8BeJ3UBZpELkBfTaImBc5RpqA0IwUig43EuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ce5g4jiuY8beYegiP4656ZISerpmO4e81Qliw6Wvfw=;
 b=Sh0Z6yZi9KMtEn3uBSLRSe5+KkR1mpTxYk83siqoySGCX09I59cmCN703/fiXAXcP3dW6TRuCP2bPOM4cEtgX++zx5AWsdQ/lRWX+grvwBDHQtivfgn2Q/PoA0f6zEjm52Xo1PD3xq4iSVB/LfPMptz652ueWcsYg+wyTVenykCZvMiJA0PtXA4hZSJwgTVuCUFFl3gFV5eEhKGNI99MWD4jiqz/k8Mov3MRMB43MNL3phnaDqgNOy5jqnos3tOr+8piphQbkXkGnPFHmCvj5sUErbBZt0DGVL7NOgvNPs/u5rUdBtTTNDYJJmeE5tI95LuU6nr7+wJacoh2QTWPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ce5g4jiuY8beYegiP4656ZISerpmO4e81Qliw6Wvfw=;
 b=N+NBRWKPtAhUIPisQHXBpIIAygQPx9OttxjcWdASqBli2zT8TjlWUWyJTD4aqeuJpNAkq8YDSTNKwHQSSyenUj91U9pX9ZyhxgxmYS4TxJpb+5QpZx4G3Pon4dq/U11ISKmHO70X0jwipJv9dpIGxv0x2NFduD9U7pIEKv8sy+Q=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3964.namprd15.prod.outlook.com (2603:10b6:303:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 10 Apr
 2020 22:34:01 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 22:34:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Song Liu <song@kernel.org>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 0/4] md: fix lockdep warning
Thread-Topic: [PATCH 0/4] md: fix lockdep warning
Thread-Index: AQHWCsyMWGAAjy9ot06/3TRG/e2JP6hwamuAgADxCYCAAC4KAIABcSsA
Date:   Fri, 10 Apr 2020 22:34:01 +0000
Message-ID: <11131DC5-A7DA-450B-86D9-803EAE8099A2@fb.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
 <76835eb0-d3a7-c5ea-5245-4dcf21a40f7c@cloud.ionos.com>
 <DA29BDF5-4B14-48AF-8B21-3B6A82857B7C@fb.com>
In-Reply-To: <DA29BDF5-4B14-48AF-8B21-3B6A82857B7C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:d485]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b9fdfb-7b89-4ce3-2e59-08d7dd9f448f
x-ms-traffictypediagnostic: MW3PR15MB3964:
x-microsoft-antispam-prvs: <MW3PR15MB3964B237884928049D84F5CAB3DE0@MW3PR15MB3964.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3882.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(71200400001)(66476007)(33656002)(36756003)(81156014)(8676002)(86362001)(8936002)(478600001)(6486002)(64756008)(316002)(54906003)(2616005)(6506007)(66446008)(6512007)(66556008)(5660300002)(186003)(53546011)(66946007)(6916009)(76116006)(4326008)(2906002)(21314003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Qx91PFxwMAyUUDwm4zWOc5BAXmamCcSQyQaZYfvPPWVdvUa3r0ByTyrG7CWpJDu1xDhU4w9mMjrlwVXRguPUgAOQw8cqQLBFId/cDW9aWfMAyrv0sdG16LnAhYAJUE0aQvpuNxb9EwR0vlzJEDQhjWfE5EkgPYfRARGZsgKRdGNoysVeoijqw+ybg4Zemk4ScKPYnrOCs+plzdslyKGhw/gU80RIyt4lj4WszuMwNi+3WAcURUslBDVZd52W/6SQrRlML91IgotZonBdu7KIGJTpqueHJrK3X+izRs3iXldS3ra4Q6xy09KALRGH5uJEeZRKTCwqkkCDjR/2aGe/7giFkLmSOzYZlgUSXhhbMAnZA2x7oLnxf7AtrXqMmmjZPNSJERC3YjJLx6cKPmBYja2Uoxe5iNmzJqCB6VB+QZ+qZTPC+M8oHkheI4umayQEz/jhAhAP3ar512eAz+WsKpW+DuRKdirTIiCxKCPCOA=
x-ms-exchange-antispam-messagedata: /XDSL7Kgi551kuDd3sjI243dxieqUFtzJzuNLGwQy2ZW+8VnxyWTPUQrxllx/ZJv7dr3nzsAM3YL4Y3Jxu58EXxBPy+FtNZyf+U/R/eFvtiJ23IhXNs5ECFynxCLQCvWaO/se69u+d0Iuh+08voG5XKJLuTdzTwUAyEuTOZHFj8NU4VlHtWCtqDnW6GkJsbq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53D14FDD0DF0FD4896F09C571C181868@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9fdfb-7b89-4ce3-2e59-08d7dd9f448f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 22:34:01.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YybE1zsSisXYEi7oIVgVLM+awW5MIfxIi+sjadUWhQ7W+F6MWSHh9OnqdYSX9j3Dsa7p58vigpXQpNNqQAratA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3964
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_10:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=992
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100159
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Apr 9, 2020, at 5:32 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 9, 2020, at 2:47 PM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>>=20
>> On 09.04.20 09:25, Song Liu wrote:
>>> Thanks for the fix!
>>>=20
>>> On Sat, Apr 4, 2020 at 3:01 PM Guoqing Jiang
>>> <guoqing.jiang@cloud.ionos.com> wrote:
>>>> Hi,
>>>>=20
>>>> After LOCKDEP is enabled, we can see some deadlock issues, this patchs=
et
>>>> makes workqueue is flushed only necessary, and the last patch is a cle=
anup.
>>>>=20
>>>> Thanks,
>>>> Guoqing
>>>>=20
>>>> Guoqing Jiang (5):
>>>>  md: add checkings before flush md_misc_wq
>>>>  md: add new workqueue for delete rdev
>>>>  md: don't flush workqueue unconditionally in md_open
>>>>  md: flush md_rdev_misc_wq for HOT_ADD_DISK case
>>>>  md: remove the extra line for ->hot_add_disk
>>> I think we will need a new workqueue (2/5). But I am not sure about
>>> whether we should
>>> do 1/5 and 3/5. It feels like we are hiding errors from lock_dep. With
>>> some quick grep,
>>> I didn't find code pattern like
>>>=20
>>>       if (work_pending(XXX))
>>>               flush_workqueue(XXX);
>>=20
>> Maybe the way that md uses workqueue is quite different from other subsy=
stems ...
>>=20
>> Because, this is the safest way to address the issue. Otherwise I suppos=
e we have to
>> rearrange the lock order or introduce new lock, either of them is tricky=
 and could
>> cause regression.
>>=20
>> Or maybe it is possible to  flush workqueue in md_check_recovery, but I =
would prefer
>> to make less change to avoid any potential risk.

After reading it a little more, I guess this might be the best solution for=
 now.=20
I will keep it in a local branch for more tests.=20

Thanks again for the fix.=20
Song

