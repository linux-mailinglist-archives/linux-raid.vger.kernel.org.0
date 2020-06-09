Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D11F36B8
	for <lists+linux-raid@lfdr.de>; Tue,  9 Jun 2020 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFIJP1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jun 2020 05:15:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:41484 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgFIJPY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 9 Jun 2020 05:15:24 -0400
IronPort-SDR: D/syfCWVlrIQlotq+KuFSZMh6w+pG0ho637oV9E3T7s9Acj62JYUgkahz9Eq5E7LdMjJjjqTDi
 yEthZKmzTOPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:15:23 -0700
IronPort-SDR: PTMTVrrUiVBSBbfX/BVBSYd46/RIApwRSn6lg5R+nzEupwQ9bWwMFxmai157cnndhjMCNUEv34
 buk0PT1gPbxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="418345164"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2020 02:15:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 02:15:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 9 Jun 2020 02:15:22 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 02:15:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 02:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRBqcyUcN/Al34ozzDe32DhkMHJC6sBWQkTV3SpcvukWcyMBHJCrgm8mgvu+UD9wrfq11yz9UOdkHPqfdIsa4azQxbtB2APD4SJFAQCZouV10WW6JEP3j+fZSWLywL6/cekRfP8KCTsxKPgnaSWb6y2F+RAujjdnwwBrclb+9WMyvPSRpqKA9uLO+t7xJ4jpG79uCAxbbKQ4GOyWm4gzjEDOBSMVCD3jbMUtoc8vzPqcInJPg8AI4pALB1FOubYLQH4OhzeypUBAfIUjW3xrhA7adOSPG1FfjJ0nSNCG6bft0qp3IkrC8ctLIymF8adtLp0EP/7RKiF8iEK3buGaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l96czNRWlVk6RYLfWaa5hLjjmn+mcuLJw5mxLTZCHd4=;
 b=SGvjOVyeIoaiAB/bH5v2iFCceDm/rB0q5yS/XBNOYCuqoijjyu4LyzweMI7sRI+O9EZt6poIPCBIpsS/TMoZ07ZN/YZJWjMwBcM8itA19G9/zkYV2Xc4BJ/9wZAQcMV5FWYK5CbqAzTaoRqT9l86g/0SVQlFw7cNZEL6QlbipdX8mS7VFLqfTcJln/66K+/F8PtS0OUbvaGAjkSrC5PNelOKsyoKpWVNMIkrHetO7Rcirets8KLy7tqxUO44AEgA70xZt82avQp3PO1ASonCFl5cwennTDDTN8nNkXCYxYQ1gPhVmZVbO/lXWKsR/Lc8CrK7VcpwFYmp76ZhVov8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l96czNRWlVk6RYLfWaa5hLjjmn+mcuLJw5mxLTZCHd4=;
 b=zGicGc9kbWNpgGr9k2VgN8sQiUiITMUiNAORR/qQUxriKAs/+XEHkQUsQFSJ8JO/LUzLWIglGSNCdfAptX1FpTMeVvy2d75OvQj1IlmqRTmAaTiBNexDTI+xTX17w3KxJW0dim76LJaTj8FCEhjXjWh4O6aO+z0avDjeTGJbjho=
Received: from SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 9 Jun
 2020 09:15:16 +0000
Received: from SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::704d:376f:6f0e:bd6a]) by SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::704d:376f:6f0e:bd6a%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 09:15:16 +0000
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jes Sorensen <jes@trained-monkey.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Tanska, Kinga" <kinga.tanska@intel.com>
Subject: RE: [PATCH v2] Use more secure HTTPS URLs
Thread-Topic: [PATCH v2] Use more secure HTTPS URLs
Thread-Index: AQHWNP/IpyRp2lqarEiaxGRq5xGWTajKLsqAgAAz+wCABa0XEA==
Date:   Tue, 9 Jun 2020 09:15:16 +0000
Message-ID: <SA0PR11MB454273621EA4A4876B1D3503FF820@SA0PR11MB4542.namprd11.prod.outlook.com>
References: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
 <8b02033d-7570-e654-dc18-a96f0a71d00c@trained-monkey.org>
 <31fb5c7a-90c9-1810-1087-9dfa32c2f7f3@molgen.mpg.de>
In-Reply-To: <31fb5c7a-90c9-1810-1087-9dfa32c2f7f3@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.196.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e85924af-c155-4822-a83c-08d80c559f9f
x-ms-traffictypediagnostic: SA0PR11MB4544:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB454490995EA595FDDE5803DCFF820@SA0PR11MB4544.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2sRrN/iqTLjpVQLJTcS69tTTjApgJkJfwr7Pin9g6/aUfEYGnSZe0oglcgsCVC0dy39ATj/lhkhlFA6Ylzlr5W8pV1vkhq7fg8Vr4fJXnFZG5d/C8GW71UN0pRkaBzKKVYiej07jKXK2FbSSpZmOLXZCJMD3kx7dQh0NLRVqzAWon6nkUt4jqTU0k4/riP3RaL4IgLHe9z9xEqFe3UIDn2a7hJCbApT7Qa8clQ0TqVnuJbAVUGqomVK9VZuJMc9S3Hi4G1VF7ygv0LUBSRG1Sg0wmZpeByRNyqbf6em6e1HRdZS0mq4F5NvkGnvRhTPuCnC6vpD/RQZ0iW27c0ROVpvqUwGzrFkPDrmqZGyCsexPU2Y8lsnM6E3bPASj3SeHIWxXRG/N9O2QtjbunGR6nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4542.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(966005)(83380400001)(55016002)(5660300002)(9686003)(26005)(4326008)(86362001)(8936002)(52536014)(54906003)(110136005)(107886003)(316002)(7696005)(76116006)(8676002)(186003)(53546011)(33656002)(71200400001)(66476007)(64756008)(66946007)(478600001)(6506007)(66446008)(2906002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HE0Xdv9P73azQeXZMDLf7m64beRtjLnJ13xH8FTGn1VAu+ytHJAAbIzW6+A2MzyAK8yA0cVxPWu7Zc1oogC0PCAYNfFCxfR7LpoLgcqCFm5lT+YqacRkSbHBt21P4y7Y5k9UgDEDpYXnM6p+9qRWEuejqLmOMAre+RThBZ3EHqRwpWbkS0KUMWM9sAFI/JMD/xwRVmPZYmTAC9u3xsRPC1KoUuc+7A+NqAohjBRTu1XQ5ZO8m9kddagHovan2wkI2xYBg4+EHXoYsN5XxdQjc12g3Dbvs7XWQW9lIcVn4cDCfktu7qvr3171tGeEJvbWB8Up4Gqnk6PxctS71GyFS13TH4vWcM6BVxsHY0V6MRYSiCtxgNir+OxYPXnuZYm1zMqaZneAaKcsZCVySAb13WiFo4M4FYGtwosZUw+ibHCNytkCIy1tAU2Zast1AeQG2tn1FRtz6Wto0kRYlR9rSdgNiu2qQYzN4dJHi72G3kCFSdRd2iU0n/64C3jR3z4Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e85924af-c155-4822-a83c-08d80c559f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 09:15:16.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C//6UbrApWn4HmurNerh5ttexMUeXSAWOHCAFzwEk1IiB43063ASix1uTEm1xnspUGtyG3X9W+4Y/VfJaNmEczci3S+d2pOg8QaV3wdiDF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

SGksDQpJJ20gcmVjb21tZW5kaW5nIHRoaXMgbGluazoNCmh0dHBzOi8vd3d3LmludGVsLmNvbS9j
b250ZW50L3d3dy91cy9lbi9zdXBwb3J0L3Byb2R1Y3RzLzEyMjQ4NC9tZW1vcnktYW5kLXN0b3Jh
Z2Uvc3NkLXNvZnR3YXJlL2ludGVsLXZpcnR1YWwtcmFpZC1vbi1jcHUtaW50ZWwtdnJvYy5odG1s
DQoNCkN1cnJlbnRseSB3ZSBkb24ndCBoYXZlIGFueSBvbmxpbmUgc3VwZXJibG9jayBkZXNjcmlw
dGlvbiwgcmVkaXJlY3RpbmcgdG8gdGhlIFZST0Mgc3VwcG9ydCBwYWdlIGlzIHRoZSBiZXN0IHdl
IGNhbiBkby4NClByZXZpb3VzIGxpbmsgaXMgcGVybWFuZW50bHkgZGVhZC4NCg0KVGhhbmtzLA0K
TWFyaXVzeg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogbGludXgtcmFpZC1v
d25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXJhaWQtb3duZXJAdmdlci5rZXJuZWwub3JnPiBP
biBCZWhhbGYgT2YgUGF1bCBNZW56ZWwNClNlbnQ6IEZyaWRheSwgSnVuZSA1LCAyMDIwIDg6MjMg
UE0NClRvOiBKZXMgU29yZW5zZW4gPGplc0B0cmFpbmVkLW1vbmtleS5vcmc+OyBUa2FjenlrLCBN
YXJpdXN6IDxtYXJpdXN6LnRrYWN6eWtAaW50ZWwuY29tPg0KQ2M6IGxpbnV4LXJhaWRAdmdlci5r
ZXJuZWwub3JnOyBCYWxkeXNpYWssIFBhd2VsIDxwYXdlbC5iYWxkeXNpYWtAaW50ZWwuY29tPjsg
VGFuc2thLCBLaW5nYSA8a2luZ2EudGFuc2thQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIFVzZSBtb3JlIHNlY3VyZSBIVFRQUyBVUkxzDQoNCkRlYXIgSmVzLA0KDQoNCkFtIDA1
LjA2LjIwIHVtIDE3OjE3IHNjaHJpZWIgSmVzIFNvcmVuc2VuOg0KPiBPbiA1LzI4LzIwIDEwOjUy
IEFNLCBQYXVsIE1lbnplbCB3cm90ZToNCj4+IEFsbCBVUkxzIGluIHRoZSBzb3VyY2UgYXJlIGF2
YWlsYWJsZSBvdmVyIEhUVFBTLCBzbyBjb252ZXJ0IGFsbCBVUkxzIA0KPj4gdG8gSFRUUFMgd2l0
aCB0aGUgY29tbWFuZCBiZWxvdy4NCj4+DQo+PiAgICAgIGdpdCBncmVwIC1sICdodHRwOi8vJyB8
IHhhcmdzIHNlZCAtaSAncyxodHRwOi8vLGh0dHBzOi8vLGcnDQo+Pg0KPj4gUmV2ZXJ0IHRoZSBj
aGFuZ2VzIHRvIGFubm91bmNlbWVudCBmaWxlcyBgQU5OT1VOQ0UtKmAgYXMgcmVxdWVzdGVkIGJ5
IA0KPj4gdGhlIG1haW50YWluZXIuDQo+Pg0KPj4gQ2M6IGxpbnV4LXJhaWRAdmdlci5rZXJuZWwu
b3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRl
Pg0KPj4gLS0tDQo+PiAgIGV4dGVybmFsLXJlc2hhcGUtZGVzaWduLnR4dCAgICAgIHwgMiArLQ0K
Pj4gICBtZGFkbS44LmluICAgICAgICAgICAgICAgICAgICAgICB8IDYgKysrLS0tDQo+PiAgIG1k
YWRtLnNwZWMgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tDQo+PiAgIHJhaWQ2Y2hlY2su
OCAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4gICByZXN0cmlwZS5jICAgICAgICAgICAg
ICAgICAgICAgICB8IDIgKy0NCj4+ICAgdWRldi1tZC1yYWlkLXNhZmUtdGltZW91dHMucnVsZXMg
fCAyICstDQo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9leHRlcm5hbC1yZXNoYXBlLWRlc2lnbi50eHQgDQo+
PiBiL2V4dGVybmFsLXJlc2hhcGUtZGVzaWduLnR4dCBpbmRleCAxMGM1N2NjLi5lNGNmNGUxIDEw
MDY0NA0KPj4gLS0tIGEvZXh0ZXJuYWwtcmVzaGFwZS1kZXNpZ24udHh0DQo+PiArKysgYi9leHRl
cm5hbC1yZXNoYXBlLWRlc2lnbi50eHQNCj4+IEBAIC0yNzcsNCArMjc3LDQgQEAgc3luY19hY3Rp
b24NCj4+ICAgDQo+PiAgIC4uLg0KPj4gICANCj4+IC1bMV06IExpbnV4IGtlcm5lbCBkZXNpZ24g
cGF0dGVybnMgLSBwYXJ0IDMsIE5laWwgQnJvd24gDQo+PiBodHRwOi8vbHduLm5ldC9BcnRpY2xl
cy8zMzYyNjIvDQo+PiArWzFdOiBMaW51eCBrZXJuZWwgZGVzaWduIHBhdHRlcm5zIC0gcGFydCAz
LCBOZWlsIEJyb3duIA0KPj4gK2h0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy8zMzYyNjIvDQo+PiBk
aWZmIC0tZ2l0IGEvbWRhZG0uOC5pbiBiL21kYWRtLjguaW4NCj4+IGluZGV4IDllN2NiOTYuLjdm
MzI3NjIgMTAwNjQ0DQo+PiAtLS0gYS9tZGFkbS44LmluDQo+PiArKysgYi9tZGFkbS44LmluDQo+
PiBAQCAtMzY3LDcgKzM2Nyw3IEBAIFVzZSB0aGUgSW50ZWwoUikgTWF0cml4IFN0b3JhZ2UgTWFu
YWdlciBtZXRhZGF0YSBmb3JtYXQuICBUaGlzIGNyZWF0ZXMgYQ0KPj4gICB3aGljaCBpcyBtYW5h
Z2VkIGluIGEgc2ltaWxhciBtYW5uZXIgdG8gRERGLCBhbmQgaXMgc3VwcG9ydGVkIGJ5IGFuDQo+
PiAgIG9wdGlvbi1yb20gb24gc29tZSBwbGF0Zm9ybXM6DQo+PiAgIC5JUA0KPj4gLS5CIGh0dHA6
Ly93d3cuaW50ZWwuY29tL2Rlc2lnbi9jaGlwc2V0cy9tYXRyaXhzdG9yYWdlX3NiLmh0bQ0KPj4g
Ky5CIGh0dHBzOi8vd3d3LmludGVsLmNvbS9kZXNpZ24vY2hpcHNldHMvbWF0cml4c3RvcmFnZV9z
Yi5odG0NCj4gDQo+IFNvcnJ5IGZvciBiZWluZyBhIHBhaW4sIGJ1dCB0aGlzIGxpbmsgaXNuJ3Qg
YWN0dWFsbHkgdmFsaWQuDQoNClNvcnJ5LCBmb3Igbm90IG1lbnRpb25pbmcgdGhhdCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UuIEluZGVlZCB0aGUgb3JpZ2luYWwgcGFnZSBpcyBnb25lLCBidXQgdGhl
IHBsYWluIEhUVFAgVVJMIGdldHMgcmVkaXJlY3RlZCB0byBIVFRQUywgc28gaXQgZG9lc27igJl0
IGNoYW5nZSB0aGUgYmVoYXZpb3IgZnJvbSBiZWZvcmUuDQoNCmBgYA0KJCBjdXJsIC1JIGh0dHA6
Ly93d3cuaW50ZWwuY29tL2Rlc2lnbi9jaGlwc2V0cy9tYXRyaXhzdG9yYWdlX3NiLmh0bQ0KSFRU
UC8xLjEgMzAxIE1vdmVkIFBlcm1hbmVudGx5DQpTZXJ2ZXI6IEFrYW1haUdIb3N0DQpDb250ZW50
LUxlbmd0aDogMA0KTG9jYXRpb246IGh0dHBzOi8vd3d3LmludGVsLmNvbS9kZXNpZ24vY2hpcHNl
dHMvbWF0cml4c3RvcmFnZV9zYi5odG0NCkRhdGU6IEZyaSwgMDUgSnVuIDIwMjAgMTg6MjA6NDMg
R01UDQpDb25uZWN0aW9uOiBrZWVwLWFsaXZlDQpTZXQtQ29va2llOiBkZXRlY3RlZF9iYW5kd2lk
dGg9TE9XOyBwYXRoPS87IGRvbWFpbj0uaW50ZWwuY29tOyBzZWN1cmU7IEh0dHBPbmx5DQpTZXQt
Q29va2llOiBzcmNfY291bnRyeWNvZGU9REU7IHBhdGg9LzsgZG9tYWluPS5pbnRlbC5jb207IHNl
Y3VyZTsgSHR0cE9ubHkNCkFjY2Vzcy1Db250cm9sLUFsbG93LU9yaWdpbjogKg0KWC1Db250ZW50
LVR5cGUtT3B0aW9uczogbm9zbmlmZg0KDQpgYGANCg0KU28sIG1heWJlIHRha2UgdGhpcyBwYXRj
aCwgYW5kIHRoZSBvdXRkYXRlZCBVUkwgY2FuIGJlIGZpeGVkIGluIGEgZm9sbG93LXVwIG9uY2Ug
aXTigJlzIGtub3duLg0KDQo+IERvZXMgc29tZW9uZSBmcm9tIEludGVsIGtub3cgd2hhdCB0byBw
b2ludCBhdD8NCg0KVGhhdOKAmWQgYmUgZ3JlYXQuDQoNCg0KS2luZCByZWdhcmRzLA0KDQpQYXVs
DQo=
