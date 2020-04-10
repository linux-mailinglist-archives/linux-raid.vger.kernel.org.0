Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AFD1A3D69
	for <lists+linux-raid@lfdr.de>; Fri, 10 Apr 2020 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgDJAc6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 20:32:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727078AbgDJAc6 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 Apr 2020 20:32:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03A0TuQT030492;
        Thu, 9 Apr 2020 17:32:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HAsGqi7T6yb5mVM1TMtEg1O34oAP2UxH2/LMN+XWJTc=;
 b=qYsJur3kahMxLkoRqYc45AQ711OztJYOB8eT7x2EKfb7W+Ifk/Wloc+kNP8XLx0tFBsu
 b4nulqG9L+iTLtJ1LMaZAY5zOOqnbGGiX5RzUE4sWgLR+39Zn9mKxqoT/bG4Z0fAoF4P
 lGewjA06HqVsxX6CGqSlbjRfQeV/TXXhIos= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 30adrm05ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Apr 2020 17:32:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 9 Apr 2020 17:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm6/XCarfZ7oyNTc7c6Oo2OCSeEkR9TI3qkU5/RAyt5ZesPSUbGA42wT4BaMQKtYKIJv3WvPVVycCsumrIRrtM3oONOB77ha6ws/LZfdj6i2gC2/uLJ9zxSlDpUb3W5a7Zb0lNuQhzUtjUeTL4E5BkAnDqSaP6cmv+sGEJvMpnOoynYIaRx6hC7hyqdqXOY8oSWEAEL1O9EQK8K3rPKGQzNMB3qM9rMA6tbtvQu+vFMA0sPxNa5jdLPYbFTQExY34xtONPWNu0NA4ihHOwDuOPnVOYOqKigzU+o9cFzboQ/54ryQG6w1qRk+GBYJnB9tYyQah4Z/lYecBt0pKNr5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAsGqi7T6yb5mVM1TMtEg1O34oAP2UxH2/LMN+XWJTc=;
 b=WW7Q9eIe6HWQlsuP3+jGYWHi7DxObkpqH1m9TW7jsS7ges0QOAnJYHrxxldXo/jhR6IVZ03jb6WdXvqtJiJQVzOo3ofFa58fXjeNSGFIDt3CT1K4CLQzaTGnhguPy75mrqEEJ8WOiGp3NAXeQHfnuhSNdQTCmmgeTC6bDDJ9Ot3Si9frXYB3ZvECdUx+b97YDqwOd3dW7Av0tvsNyR6fta052s1AF7FgRbGAEupv+Qxl9uI+yZsWHuFQSz6VXWGneyUKsqSNbKKimigbe+wYMaSZQdWb91miQRATAH7wbSvv9qnh/azNi5RJnsFlow096RS8cpshJL8s1MMc5xcq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAsGqi7T6yb5mVM1TMtEg1O34oAP2UxH2/LMN+XWJTc=;
 b=MRHsfAQlfc6jR2ZYFyEBqgnlVxplAEBgWsC5g0AQaglQXSDlZKjni3bVczkfjFc+xWxQg9gUN8ATwY2QJmOd/iH41V/QZf/MJ7A/zQYAn1VUCDzOSYKNpLbUulhK9jE8UySKGM3hLrvp0bo5CVygUy0vsaR/8wdlCy100n4pb0k=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3948.namprd15.prod.outlook.com (2603:10b6:303:4b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 10 Apr
 2020 00:32:43 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 00:32:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Song Liu <song@kernel.org>, linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 0/4] md: fix lockdep warning
Thread-Topic: [PATCH 0/4] md: fix lockdep warning
Thread-Index: AQHWCsyMWGAAjy9ot06/3TRG/e2JP6hwamuAgADxCYCAAC4KAA==
Date:   Fri, 10 Apr 2020 00:32:43 +0000
Message-ID: <DA29BDF5-4B14-48AF-8B21-3B6A82857B7C@fb.com>
References: <20200404215711.4272-1-guoqing.jiang@cloud.ionos.com>
 <CAPhsuW4rWa_ZCX=3eW9Xk_jtZdu+uKX4HZtbfEJfS9ms4a+OSg@mail.gmail.com>
 <76835eb0-d3a7-c5ea-5245-4dcf21a40f7c@cloud.ionos.com>
In-Reply-To: <76835eb0-d3a7-c5ea-5245-4dcf21a40f7c@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:dd4a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8b4751d-9067-4461-e74c-08d7dce6af52
x-ms-traffictypediagnostic: MW3PR15MB3948:
x-microsoft-antispam-prvs: <MW3PR15MB39486982EA270ACAB6C04B6DB3DE0@MW3PR15MB3948.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3882.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(316002)(66446008)(66946007)(8936002)(33656002)(76116006)(6512007)(4326008)(6486002)(186003)(2906002)(64756008)(8676002)(66556008)(71200400001)(81156014)(6506007)(2616005)(54906003)(66476007)(6916009)(86362001)(36756003)(81166007)(53546011)(5660300002)(478600001)(21314003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ysaa3d0/HnUAEK0wnmAbcx5KTNFD+VC2FiOmfk8Ywa1sDxbzs0M44/WC+upVR4kFHf1gH3wV6XN7Xc9x9lRKe2pLfdRM7vKCGgZtDoUSPTny+/1zTrj6G71xsSGtnXnedaatfRSHryfJe5xLvqKdXbtdFNrHz600z8I4rgNUYqBQgdxHCEwneO2kNeec+7oawUDMRNCpu2afE4D3c+W5yd1Ys6Miraw/WcZitBHuurfSG1WPTQ3Dn3NbibWr57V/S94SNlLg1BgLA3cQTAGMST1DOKKF4jzDV8rXKHJM7jzkQYnnWdHtMC19Ly3PvkZ9PFTC6Pz2hhbuT5VZ+PFKbI7xXuZ49tAmjbeu0PS/c4wilXf2Qz5zc9yOjn8mbChuKZz4iPveAXPxfkqnNrL2NKU1Hn3I2bdcM6D1gZAPUZrz4749wHMju97DgeC/hM7JrAYNKnI01RiEtuj60ZDpKUCm2sAAkcaNMl7ukxfPJgg=
x-ms-exchange-antispam-messagedata: yOCtgkcBLhyDqK/bJz2hNF0Gm8+C24Ii5tjEy9CyCdx0m7IVDtT1R/I1MUvh1huWD06tpt6D9fvZaZQInEGkkimdWEaQk9Q74LjcS6mndqD288XT0OoQ0seD1qv59ZPwrMA64MZBDJPeU/ITdiHxqrRtlmclN8YgJ2r9bIcPVvyxaBkh8x1iPCh1L5AkbdZW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A173C84F8055CD448B938E76DE92EE67@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b4751d-9067-4461-e74c-08d7dce6af52
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 00:32:43.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnzBmpS7V/5PMxAXLuomR2PE3OTpts41NsUJIK9LiqnuJdO7W22DtVjpMVTAu8YOrQc8TpUmk/vS4/z0TapgHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3948
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_09:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=928 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004100001
X-FB-Internal: deliver
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



> On Apr 9, 2020, at 2:47 PM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=
 wrote:
>=20
> On 09.04.20 09:25, Song Liu wrote:
>> Thanks for the fix!
>>=20
>> On Sat, Apr 4, 2020 at 3:01 PM Guoqing Jiang
>> <guoqing.jiang@cloud.ionos.com> wrote:
>>> Hi,
>>>=20
>>> After LOCKDEP is enabled, we can see some deadlock issues, this patchse=
t
>>> makes workqueue is flushed only necessary, and the last patch is a clea=
nup.
>>>=20
>>> Thanks,
>>> Guoqing
>>>=20
>>> Guoqing Jiang (5):
>>>   md: add checkings before flush md_misc_wq
>>>   md: add new workqueue for delete rdev
>>>   md: don't flush workqueue unconditionally in md_open
>>>   md: flush md_rdev_misc_wq for HOT_ADD_DISK case
>>>   md: remove the extra line for ->hot_add_disk
>> I think we will need a new workqueue (2/5). But I am not sure about
>> whether we should
>> do 1/5 and 3/5. It feels like we are hiding errors from lock_dep. With
>> some quick grep,
>> I didn't find code pattern like
>>=20
>>        if (work_pending(XXX))
>>                flush_workqueue(XXX);
>=20
> Maybe the way that md uses workqueue is quite different from other subsys=
tems ...
>=20
> Because, this is the safest way to address the issue. Otherwise I suppose=
 we have to
> rearrange the lock order or introduce new lock, either of them is tricky =
and could
> cause regression.
>=20
> Or maybe it is possible to  flush workqueue in md_check_recovery, but I w=
ould prefer
> to make less change to avoid any potential risk.
>=20

Agreed that we should try to avoid risk. Let me think more about this.=20

Thanks,
Song=
