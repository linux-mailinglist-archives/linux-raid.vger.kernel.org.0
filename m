Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF201A309
	for <lists+linux-raid@lfdr.de>; Fri, 10 May 2019 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfEJSfM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 May 2019 14:35:12 -0400
Received: from esa2.ucsf.iphmx.com ([68.232.143.34]:48988 "EHLO
        esa2.ucsf.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJSfM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 May 2019 14:35:12 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2019 14:35:11 EDT
IronPort-SDR: Fl1FMZMjA28g74af2fIc9OmoJ5jW7K70AQvox/3NvXP/3gYDCqyguqSPBXHl8Ka8TDF5OMvndx
 NO5R66zpllXw==
Received: from unknown (HELO bcuda1.ucsf.edu) ([64.54.9.250])
  by esa2.ucsf.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 11:25:07 -0700
X-ASG-Debug-ID: 1557512689-0e7f45703b2db18000e-LoH05x
Received: from MNEXCHWAP003.net.ucsf.edu (mx1.ucsf.edu [64.54.247.196]) by bcuda1.ucsf.edu with ESMTP id zrdqmvrJedUAuz7K (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 10 May 2019 11:24:56 -0700 (PDT)
X-Barracuda-Envelope-From: Ross.Boylan@ucsf.edu
X-Barracuda-Effective-Source-IP: mx1.ucsf.edu[64.54.247.196]
X-Barracuda-Apparent-Source-IP: 64.54.247.196
Received: from MNEXCHWAP005.net.ucsf.edu (64.54.247.245) by
 MNEXCHWAP003.net.ucsf.edu (64.54.247.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 May 2019 11:24:38 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (64.54.247.196)
 by MNEXCHWAP005.net.ucsf.edu (64.54.247.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 10 May 2019 11:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsfonline.onmicrosoft.com; s=selector1-ucsfonline-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RayKUVOig/SNn5rq95r+Ly67g4Rc4uAsDiyKQsiEf+A=;
 b=JXepOg70FZ8+gR5lrdKnJC7G6l4yONuK/qIxoQuvlY95cdDZBUSND9I56d28iJiDtfxdEiX4auoaj2ytZQSAWpa9KY8Ic3dd666W061xNJjTFAMo6Bb2IlB9b02+0+PAKrzftj/5rnNdFiZnoeSub6FRMdcesjNbuJ4p/qLYL4s=
Received: from BYAPR05MB5736.namprd05.prod.outlook.com (20.178.48.85) by
 BYAPR05MB5766.namprd05.prod.outlook.com (20.178.48.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.7; Fri, 10 May 2019 18:24:36 +0000
Received: from BYAPR05MB5736.namprd05.prod.outlook.com
 ([fe80::4937:1deb:f62b:53c7]) by BYAPR05MB5736.namprd05.prod.outlook.com
 ([fe80::4937:1deb:f62b:53c7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 18:24:36 +0000
From:   "Boylan, Ross" <Ross.Boylan@ucsf.edu>
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
CC:     Ross Boylan <rossboylan@stanfordalumni.org>
Subject: recovering a single device RAID
Thread-Topic: recovering a single device RAID
X-ASG-Orig-Subj: recovering a single device RAID
Thread-Index: AQHVB1r1xjMLXjctgUCqWmegMvbSTA==
Date:   Fri, 10 May 2019 18:24:36 +0000
Message-ID: <BYAPR05MB57361A5C0EFE92E880333A5D870C0@BYAPR05MB5736.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ross.Boylan@ucsf.edu; 
x-originating-ip: [66.181.128.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4dc69fd-959a-4370-4fe9-08d6d574c1f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5766;
x-ms-traffictypediagnostic: BYAPR05MB5766:
x-microsoft-antispam-prvs: <BYAPR05MB5766D2F01A33376D80E41C38870C0@BYAPR05MB5766.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(6506007)(81166006)(2351001)(7736002)(478600001)(6916009)(6116002)(81156014)(305945005)(71190400001)(71200400001)(2906002)(52536014)(102836004)(14454004)(6436002)(25786009)(7696005)(26005)(99286004)(8676002)(3846002)(5640700003)(4326008)(186003)(53936002)(72206003)(73956011)(66946007)(88552002)(14444005)(786003)(33656002)(75432002)(66446008)(68736007)(316002)(486006)(76116006)(66066001)(64756008)(476003)(66476007)(66556008)(256004)(8936002)(2501003)(55016002)(9686003)(86362001)(5660300002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5766;H:BYAPR05MB5736.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ucsf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iLyo4DvnQMVmvivPIvnfM/nQUXvwDGSF0Cc8Fkb3PMI6tN7njALtE8Bdl0I4+uruX903cFW+KOtcjCaBcVgq/qPxJwpHYtdbIk7mtKhBlE85IQvnIQ2gesHzT7F+C+2zcis/K6yNP/zU3PcEsNpxMfm4k+I6Sh/Q7GKp8tjc8ln5WH3sAHeuJJLS/zNKiT6e0SPe+alc8igRtpj3/LL5Ckr7dyNvvWq0aQk5PXaps0EBj4hB+tOjld+ThAowMmy6iDOldSe8r5r+8lRTRMvz1OWquXsSwqLC3L3HEzL+20m0RRoCRzM+rIr1u4ae5qClX72pOPvuwoYS2kRiTOCYi2nYpkKz3rThdrlZXQkYgF13wVac2Am9REbfMCCWxTrmTuV1nvDzeKfabEWq5BWz94l3XyDcr9gt8zI8BnDc8zU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dc69fd-959a-4370-4fe9-08d6d574c1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 18:24:36.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a52fd37d-7666-49ce-b534-c4505c2f5226
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5766
X-OriginatorOrg: ucsf.edu
X-Barracuda-Connect: mx1.ucsf.edu[64.54.247.196]
X-Barracuda-Start-Time: 1557512696
X-Barracuda-Encrypted: ECDHE-RSA-AES128-SHA256
X-Barracuda-URL: https://bcuda1.ucsf.edu:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ucsf.edu
X-Barracuda-Scan-Msg-Size: 2340
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.71088
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have a RAID 1 array built on a single partition.  That partition has a ha=
rdware error (only one sector, but that's enough).  I guess I should have g=
ot around to adding some redundancy.
I used ddrescue to copy the partition to another disk.  What is the best wa=
y to proceed?

I thought I'd mark the bad partition as failed, but
# mdadm -v --fail /dev/sdc2; date
mdadm: /dev/sdc2 does not appear to be an md device
Apparently the array name is required as a first argument.  I have stopped =
it, so that
mdadm /dev/md/media5 --fail /dev/sdc2
would fail, I assume, since there is no /dev/md/media5.

The naive approach would be to reactivate the array, but there seem to be 2=
 risks in doing so:
  1) I have the 2 bit-identical partitions (excepting the bad sector), both=
 of which claim to be the unique members of the array.
What if the wrong one gets picked, or both get picked and synced?
   2) Assuming I activated the array with the single failing partition, wou=
ldn't the failure process convert it to a zero-element array?

Also, is it OK to have 2 completely identical copies of a block device that=
 is an element of a RAID array?  My thought was that different devices shou=
ld have different device UUIDs, so that a bit copy is problematic.  Of cour=
se, even with different device UUIDs there would be 2 devices claiming to b=
e members of a single element array....

Thanks.
Ross Boylan

Some details:
~# date; mdadm -E /dev/sdc2
Fri 10 May 2019 10:42:29 AM PDT
/dev/sdc2:
          Magic : a92b4efc
        Version : 1.2
    Feature Map : 0x0
     Array UUID : 4432ee71:d3f469e2:bfb17f29:67a23156
           Name : tempserver:media5
  Creation Time : Fri Feb 24 16:51:53 2017
     Raid Level : raid1
   Raid Devices : 1

 Avail Dev Size : 7813769216 (3725.90 GiB 4000.65 GB)
     Array Size : 3906884416 (3725.90 GiB 4000.65 GB)
  Used Dev Size : 7813768832 (3725.90 GiB 4000.65 GB)
    Data Offset : 262144 sectors
   Super Offset : 8 sectors
   Unused Space : before=3D262064 sectors, after=3D384 sectors
          State : clean
    Device UUID : a7e01684:709e2639:2186cf57:2b3590c1

    Update Time : Thu May  9 14:58:51 2019
       Checksum : 62576dc4 - correct
         Events : 104


   Device Role : Active device 0
   Array State : A ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=3D repla=
cing)

