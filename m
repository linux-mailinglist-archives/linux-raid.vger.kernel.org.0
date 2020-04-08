Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC61A1ECF
	for <lists+linux-raid@lfdr.de>; Wed,  8 Apr 2020 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDHKaK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 8 Apr 2020 06:30:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:39483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHKaK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 8 Apr 2020 06:30:10 -0400
IronPort-SDR: gsXctHxce0cMc+WIvPyBGBxS4zzxyncLMq9CwPPuIWS9DGO8xR1DVXGqSEN+89rWKoNV/zX7R1
 80/DJrM9PQKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 03:30:09 -0700
IronPort-SDR: zRe66jraaQo2eCOcAtjMTe9gFTBu+9vz7KvuHpTrQDE3Z38khCmiQC7zsf0yua2ytPiOXUnBMe
 a1hWrDcd6nRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="425093094"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2020 03:30:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 03:30:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Apr 2020 03:30:08 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Apr 2020 03:30:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 03:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm8bSvXFTK3cWUKw8OgKWa8XXDe8TcEWE0+Je5ONc09WkhJnlvg1nLBclFb4JEtCrVTmsgbPK8t7GFSxCuc/hizJV4HmzU0j+R8PZ88CeogLjdD5+l6kURQ1fDSFOc/ltOITFqNKVMIWY3YFiem+ZyPx1XGYESwKN380CVUg9kDyKUQ1Eoi7SFMiQVwIaFRLNco1Znxb+pxPOq0mzvQNzMQr2mrroCn1xdJ4HYMpeIjiDQZPuffVySXoZIWgL6mERJ8lWwZWtWCih2hNKyf5ydK+fBBixN+0g7ApPmOUncnnYUNaDkHghtaEJf1gQfMsBgFpx6JlhK2+HRk5jyxxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K1Sl0rdU1O5w05XNhKX1viDiPvvwSkALWf+lOx6NsY=;
 b=LU+hdwDnOujE/kVPpxZ7MdXWZ+R5es5sa1FbhZiENtOFFf+KmUfNSQWH+NvSgvG13CrGP8eRZ55NQTcNYy7rFeud9vBo4Tri2MUwWtXAabINrncMdNPSrI+Wr3Roz+AE5GlCPLDq4SY0wnQn7OcVhdZjl88CUvCXzQi5+7RturFUmu6IOWj/X3Ro1cIsNv2FNHeyqZcAQ7+MKDMhkaJvjnARdQsp1FtpqQZ1EsHvTRlO2Yw5w4C7c19ADcJz1UJ67+/fpeiEf4vCYM36D9erEVhFy3fp4IEhd9Nxhk0npgtldMS4lFJ9Sq4OeegOL7SN+8CQCYdbGxqijqtIZ3jehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K1Sl0rdU1O5w05XNhKX1viDiPvvwSkALWf+lOx6NsY=;
 b=h7zPWFsTIpq7JJIdMPtgFlsNx6txnlWTHk/z1lWpnTwK9bHq6pcR6KqFV/xgunAPOWf82X16fvVlO1qKEq4gUGXn33UWwLRwl+davAtJHK3E32NkTU0xJuY+z6DawBjpmcWSl9tUkbEpGkbgG4Fy+ZQy5tXXldr13JjmPkYG0ac=
Received: from SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Wed, 8 Apr
 2020 10:30:07 +0000
Received: from SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::7910:9799:768b:28d9]) by SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::7910:9799:768b:28d9%6]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 10:30:07 +0000
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     Adriaan Callaerts <adriaan.callaerts@gmail.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: RE: Need help restoring imsm raid
Thread-Topic: Need help restoring imsm raid
Thread-Index: AQHWDSU5QuBg8lYq+UKy3EAJK/6dW6hvBPkA
Date:   Wed, 8 Apr 2020 10:30:07 +0000
Message-ID: <SA0PR11MB454206D7F5CCE24500250869FFC00@SA0PR11MB4542.namprd11.prod.outlook.com>
References: <CAN+Z1SEtq+5Y5bfZE1S8Zd6cZhoub+Dqt9UtNkx8V=cqabHbkw@mail.gmail.com>
In-Reply-To: <CAN+Z1SEtq+5Y5bfZE1S8Zd6cZhoub+Dqt9UtNkx8V=cqabHbkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mariusz.tkaczyk@intel.com; 
x-originating-ip: [89.64.91.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae441efd-c15e-4ca7-5f39-08d7dba7ced1
x-ms-traffictypediagnostic: SA0PR11MB4767:
x-microsoft-antispam-prvs: <SA0PR11MB476784FC84F1960111F04AF5FFC00@SA0PR11MB4767.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4542.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39860400002)(52536014)(7696005)(66476007)(26005)(76116006)(66946007)(66556008)(186003)(9686003)(5660300002)(6506007)(64756008)(81166007)(66446008)(55016002)(110136005)(86362001)(53546011)(316002)(81156014)(478600001)(8676002)(33656002)(71200400001)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jht4ztL9Y1O8v0ePHlaPBDFKnjQai72uowU8NWIxrXW/MAzryIXkaG42T2uzuWXm6IZGsKM+NtujQr759X5D27ueLfalsjzQstqtlyEYx9roye4UE2qtVZCXdDqNECR9pXilltr2TGSN6C/QtM0O7yRwDUb34nnl0++oliTMLIpQBdfknpeJ0Sufjy0UzRhuBSm+eV/2z0iLo+zZ14nz0Ds2Z9HDhLGWL/DIDGRoLDpNmxQc/Vudr1F1sz+sYUO3T6Ce1BBA7hP0N76fY9DZdCy8oBfgPIOgArMdUk/k9sHCRwCzEsxmVR8+/Yom71Fhfg6EnH4PxtCDDaVKsB7MJxg+6C0ghb1/VhDjrutUKJZE7DtkUoW0hzGB/1X7TuU80/MDVm0T6YZg4TL42wzcJwB7T5ZcLzpQtYZipcdZNDh1kcIZKe4E3DvLfIwCJxGo
x-ms-exchange-antispam-messagedata: Wm3HA06IHwDjA+GAlGdAkzXl4LkavvwU9mzDZWFAMpvoud0sM3zAzaMnWeMPlOb0EMjcd/tzq8Ot8ZxykfxqwLHKNiwO5uCSkfClKMjKxrth8/aiTtXWkkZBiSO4GWQ4HyvEYsRE+It20TFR6AhRdQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae441efd-c15e-4ca7-5f39-08d7dba7ced1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 10:30:07.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fjhOyhb0ZmFzLYJTXtopq5RqBmFPf+GDsyGuCUUHK2nGmPIDWr8ksJPdvF+vAh9KL2yKT33T7+VdSZKkx/vMUyp7ASEITWi45iY0jI+nfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

SGksDQpJTVNNIG1ldGFkYXRhIGlzIHdyaXR0ZW4gYXQgdGhlIGVuZCBvZiBkcml2ZS4gSSBzdXNw
ZWN0IHRoYXQgYmVmb3JlIHdyaXRpbmcgR1BUIG1ldGFkYXRhLCBpbnN0YWxsZXIgY2xlYXJlZCBl
eGl0aW5nIG9uZS4NClVuZm9ydHVuYXRlbHksIFlvdXIgUkFJRDAgaXMgZ29uZSBhbmQgY2Fubm90
IGJlIHJlYXNzZW1ibGVkLiBSQUlEMSBpcyBzdGlsbCBhbmQgb3BlcmF0aW9uIHlvdXIgcGVyc29u
YWwgZGF0YSBpcyBzYWZlIGJ1dCBwbGVhc2UgYmFja3VwIGl0IGZpcnN0bHkuDQrCoA0KVGhlIG9u
bHkgaWRlYSBJIGhhdmUgaXMgdG8gcmVjcmVhdGUgdGhlIFJBSUQwIGFycmF5IG9uIGRyaXZlcyB3
aXRoIHRoZSBzYW1lIHNpemUgYXMgb2xkIHJhaWQuIA0KSXQgY2FuIGJlIGRvbmUgZnJvbSBzeXN0
ZW0gdmlhIG1kYWRtLg0KI3N0b3AgcjEgaWYgcnVubmluZw0KIyBtZGFkbSAtUyAvZGV2L21kLzxu
YW1lPg0KIyByZW1vdmUgcjAgYXJyYXkgZnJvbSBtZXRhZGF0YQ0KIyBtZGFkbSAtLWtpbGwtc3Vi
YXJyYXkgMCAvZGV2L21kLzxjb250YWluZXI+DQojIHN0YXJ0IHIxDQojIG1kYWRtIC1JIC9kZXYv
bWQvPGNvbnRhaW5lcj4NCiMgYWRkIGRpc2sgdG8gcmVjb3ZlciByMQ0KIyBtZGFkbSAtLWFkZCAv
ZGV2L21kLzxjb250YWluZXI+IC9kZXYvc2RhDQojIHdhaXQgZm9yIHJlY292ZXJ5IHRvIGVuZA0K
IyBjYXQgL3Byb2MvbWRzdGF0DQojIG5vdyByZWNyZWF0ZSByMCB2b2x1bWUgKGl0IGlzIGltcG9y
dGFudCB0byBwdXQgbWVtYmVyIGRyaXZlcyBpbiBjb3JyZWN0IG9yZGVyKQ0KIyBtZGFkbSAtQ1Ig
PG5hbWU+IC1sIDAgIC1uMiAvZGV2L3NkYSAvZGV2L3NkYg0KwqANCkl0IHdpbGwgdGFrZSB0aGUg
YmlnZ2VzdCBibG9jayBvZiBmcmVlIHNwYWNlIGZyb20gZWFjaCBkcml2ZSB3aGljaCBzaG91bGQg
YmUgc2FtZSBhcyBvbGQgcjAuICBUaGUgcmVzdCBvZiBkcml2ZSBpcyBhbHJlYWR5IGluIHIxLiAN
ClRoZW4geW91IGNhbiBjb21wYXJlIG5ldyBtZXRhZGF0YSB3aXRoIG9sZCBvbmUuIFBlciBkZXYg
c2l6ZSBhbmQgYXJyYXkgc2l6ZSAgZm9yIGVhY2ggZHJpdmUgaW4gcjAgc2hvdWxkIGJlIHRoZSBz
YW1lIGFzIHByZXZpb3VzLg0KUGxlYXNlIGFsc28gdmVyaWZ5IHNsb3RzIGZvciByMCBpbiBtZXRh
ZGF0YTogc2RhIHNob3VsZCBiZSAwLCBzZGIgMS4NCsKgDQpUaGUgd29yc2UgcHJvYmxlbSBpcyB5
b3VyIHBhcnRpdGlvbiB0YWJsZSBvbiByMCwgaXQgd2FzIG92ZXJ3cml0dGVuIGJlY2F1c2UgdGhl
IGZpcnN0IHNlY3RvcnMgb2YgaXQgYXJlIGFsc28gdGhlIGZpcnN0IHNlY3RvcnMgb2YgdGhlIGRy
aXZlLg0KV2l0aCB0aGlzIHByb2JsZW0gSSBjYW5ub3QgaGVscCB5b3UuIEkgcmVjb21tZW5kIHRv
IHVzZSBkZC1yZXNjdWUgb3Igb3RoZXIgdG9vbC4gR1BUIGhhcyBhIGJhY2t1cCB3aGljaCBzaG91
bGQgYmUgd3JpdHRlbiBhdCB0aGUgZW5kDQpvZiByMCB2b2x1bWUgb3Igc29tZXdoZXJlIGVsc2Ug
YW5kIHNob3VsZCBub3QgYmUgY2xlYXJlZCBieSBVYnVudHUgaW5zdGFsbGVyLiBJIGJlbGlldmUg
dGhhdCB3aW5kb3dzIHVzZXMgR1BUIGFsc28uDQoNCkdvb2QgbHVjay4NCk1hcml1c3oNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxpbnV4LXJhaWQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIDxsaW51eC1yYWlkLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEFk
cmlhYW4gQ2FsbGFlcnRzDQpTZW50OiBUdWVzZGF5LCBBcHJpbCA3LCAyMDIwIDExOjM5IFBNDQpU
bzogbGludXgtcmFpZEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IE5lZWQgaGVscCByZXN0b3Jp
bmcgaW1zbSByYWlkDQoNCkkgaGF2ZSB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbjoNCg0KDQoNCkni
gJl2ZSBzZXQgdXAgbXkgV2luZG93cyBQQyBhIGxvbmcgdGltZSBhZ28gdG8gaGF2ZSB0aGUgZm9s
bG93aW5nIHJhaWQgc2V0dXA6DQoNCi0gVHdvIDFUQiBkaXNrcyBpbiB0aGlzIG1hY2hpbmUNCi0g
SW50ZWwgTWF0cml4IFN0b3JhZ2UgTWdtdA0KLSBUaGUgZGlza3MgaGF2ZSBvbmUgSU1TTSByYWlk
IGNvbnRhaW5lciB3aXRoIHR3byB2b2x1bWVzIGluc2lkZQ0KICArIFRoZSBmaXJzdCAyMDBHQiBv
ZiBib3RoIGRpc2tzIGlzIGFsbG9jYXRlZCB0byBhIFJBSUQwIHZvbHVtZQ0KICArIFRoZSByZW1h
aW5pbmcgODAwR0Igb2YgYm90aCBkaXNrcyBmb3JtIGEgUkFJRDEgdm9sdW1lDQotIEJvdGggdm9s
dW1lcyB0aGVuIGNvbnRhaW4gbXVsdGlwbGUgcGFydGl0aW9ucyB3aXRoIHZhcmlvdXMgZGF0YSwN
CiAgKyBtb3N0bHkgdGhlIFJBSUQwIG9uZSBjb250YWlucyBwYXJ0aXRpb25zIGZvciBPUyBmaWxl
cyAoV2luZG93cyBTeXN0ZW0gUGFydGl0aW9uLCBDLWRyaXZlIGFuZCB0aGUgbGlrZSkNCiAgKyBh
bmQgdGhlbiB0aGUgUkFJRDEgY29udGFpbnMgYWN0dWFsIHBlcnNvbmFsIGRhdGEgKGRvY3VtZW50
cywgcGhvdG9zLCBtdXNpYyBldGMpDQoNCkEgZmV3IG1vbnRocyBiYWNrLCBJIGRlY2lkZWQgdG8g
dHJ5IGFuZCBpbnN0YWxsIGEgZHVhbC1ib290IFVidW50dQ0KMTguMDQgb24gdGhlIG1hY2hpbmUu
DQpXaGF0IGVuZGVkIHVwIGhhcHBlbmluZyAoSSB0aGluaykgaXMgSSBsZXQgdGhlIGluc3RhbGxl
ciB3cml0ZSB0aGUgcGFydGl0aW9uIHRhYmxlIHRvIHRoZSB3cm9uZyBwYXJ0IG9mIHRoZSBkaXNr
ICgvZGV2L3NkYSBpbnN0ZWFkIG9mIGEgZGV2bWFwcGVyL2RtcmFpZCBibG9jayBkZXZpY2UsIEkg
ZG9uJ3QgcmVtZW1iZXIgZXhhY3RseSksIHdoaWNoIGNvcnJ1cHRlZCB0aGUgcmFpZCBzZXR1cC4g
SSBoYXZlbid0IHRvdWNoZWQgdGhlIGRldmljZSBzaW5jZSB0aGVuLCBidXQgbm93IHdhbnQgdG8g
c3RhcnQgdXNpbmcgdGhlIG1hY2hpbmUgYWdhaW4gYW5kIGhlbmNlIHdhbnQgdG8gcmVjb3ZlciBt
eSBkYXRhIGFzIG11Y2ggYXMgcG9zc2libGUgYmVmb3JlIChpZiBuZWNlc3NhcnkpIHJlaW5zdGFs
bGluZyBhbnkgT1Nlcy4NCg0KVGhlIGN1cnJlbnQgc2l0dWF0aW9uIGlzIHRoYXQgSSBjYW4gbm8g
bG9uZ2VyIGJvb3QgdGhlIFBDIGZyb20gZGlzayAobm9yIHdpbmRvd3Mgb3IgbGludXgpIGFuZCBJ
IGNhbiBubyBsb25nZXIgcmVhZCBhbnkgb2YgbXkgZGF0YSBvbiBlaXRoZXIgZGlzay92b2x1bWUv
cGFydGl0aW9uIGJ5IGRlZmF1bHQgd2hlbiB1c2luZyBhIGxpbnV4LWZyb20tVVNCLg0KDQpXaGVu
IGluc3BlY3RpbmcgdGhlIHBhcnRpdGlvbnMgb24gdGhlIGRyaXZlcywgaXQgZGV0ZWN0cyBpbnZh
bGlkIHBhcnRpdGlvbnMgd2hpY2ggbWFrZSBubyBzZW5zZSAoaW5jb3JyZWN0IGZpbGVzeXN0ZW0g
dHlwZXMsIHBhcnRpdGlvbiBzaXplcywgZXRjKS4NCg0KSG93ZXZlciwgc29tZSBmaWRkbGluZyB3
aXRoIG1kYWRtIOKAk3NjYW4gY2FuIG1vdW50IHRoZSBSQUlEMSB2b2x1bWUgaW4gZGVncmFkZWQg
bW9kZSB3aGljaCBhbGxvd3MgbWUgdG8gcmVhZCBteSBmaWxlcyBpbiB0aGF0IHZvbHVtZS4NCg0K
VGhpcyBsZWFkcyBtZSB0byBiZWxpZXZlIHRoYXQgSU1TTSBzdG9yZXMgc29tZSBtZXRhZGF0YSBh
dCB0aGUgYmVnaW5uaW5nIG9mIGJvdGggZGlza3MgKEnigJl2ZSBmb3VuZCBubyBwcm9vZiBvciBk
b2N1bWVudGF0aW9uIGFueXdoZXJlIHRoYXQgY29uZmlybXMgdGhpcyksIGFuZCB0aGF0IG15IHdy
aXRpbmcgb2YgYSBuZXcgcGFydGl0aW9uIHRhYmxlIGhhcyBvdmVyd3JpdHRlbiBvciBhdCBsZWFz
dCBjb3JydXB0ZWQgdGhhdCBtZXRhZGF0YSBvbiB0aGUgZmlyc3QgZGlzay4NCknigJl2ZSBnb3R0
ZW4gdGhpcyBmYXIgaW4gaW52ZXN0aWdhdGluZywgYnV0IGFtIG5vIGNsb3NlciB0byBmaXhpbmcg
dGhlIGlzc3VlLiBJIGhhdmUgYmVlbiBoZXNpdGFudCB0byBydW4gYW55IG9wZXJhdGlvbnMgd2hp
Y2ggbWlnaHQgYmUgZGVzdHJ1Y3RpdmUgdG8gbXkgZGF0YSAoaWYgaXTigJlzIG5vdCBsb3N0IGFs
cmVhZHk/KS4gQW55IGhlbHAgaW4gZnVydGhlciBkaWFnbm9zaW5nIC0gYW5kIGVzcGVjaWFsbHkg
aW4gZml4aW5nIC0gbXkgc2NyZXd1cCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkIQ0KDQoN
CktpbmQgcmVnYXJkcywNCkFkcmlhYW4gQ2FsbGFlcnRzDQo=
