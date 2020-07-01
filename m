Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927312107DE
	for <lists+linux-raid@lfdr.de>; Wed,  1 Jul 2020 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGAJSZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 1 Jul 2020 05:18:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:21758 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGAJSY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 1 Jul 2020 05:18:24 -0400
IronPort-SDR: I6+3ZUjoCf1RgJJ2+oIoBPMQWxyctivOFCmMPfbpFRTpXuqNJNcLRv/z7qTczJtkE1bBQTWJve
 WhM0ZQxnemZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="144689300"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="144689300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 02:18:23 -0700
IronPort-SDR: MYsVxGpD7N8eE+2qdJBsGE3VtGopiN1maxilsfHHkgY1yYnqyMQmkkTvCST61gvn4FSAcCCWy1
 ek//HZyDrc9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="481231860"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2020 02:18:23 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 02:18:23 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Jul 2020 02:18:22 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Jul 2020 02:18:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 02:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE4lqo+HvOQyF2N1TFBAewjiYUdVRlZq9hz4mgimQsOMvx/2rG5bIGdhYNSa92eDPkN3nszv0LC4BIwJ4DWYOfeZKBeiDDR7B70X48vbvZqxP98Z/L6WCerjfTvAP8toQFk7c8fxh50jHffYQxRv1EdLf2gMfMUk5eNfJFBrumdk8OoijrUF40/zO8SYr4/31iVzAwxNJfs9+rj6nhgy4L/oG6okkDzqMc8K/JpVPp/ow/FeihpjgKgu4oLxUQ3csgfBuYh0cuahzeSXrDKaRs8zmk4pBykT/cy6wmiZ53BoFQjWnIcS8XDYrx+6Tp2znsu55lo4bHVKK9aaYuaVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbb/9HDy5Po/m/RuhR/wK7MpKDpLnTKSuE+zWYJwogQ=;
 b=Ax0FcthoUTn6I39uf0sdPeurC4Dw9gAEgVJupe0S5Vw4G8JPSxYNroDtyUnBu3oYLZWl5UDukhYPcDoA362PxebPxNvrmCg4vRqNli2TXlAXGhAcqJ2kLTIoYNyp8sSsozWsfhTxRc0kj3/ZKK/2lEAuCTMt6qQS5T/Vr3AD7wQPDbCqj8iG0pBMevZUOmNn4y2fP276Zw//1xkMbXUJyA2pKMIE28qDm5WCUwGFJNeMfakpw2uck5ZI7P45EICNbBfY/OLfBbwgMSY3Y0BimDPYyy3nR5Qg654FWBpb4Itu8v/ZNpHaOHWJwvWtGrPImnbCHmB0kmzeG0xVPQBGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbb/9HDy5Po/m/RuhR/wK7MpKDpLnTKSuE+zWYJwogQ=;
 b=ti/m/qdjQN8rrbE9dfCGNvyrUOj1h/M67Zciex7YUXPqmFA85dontfHqrk66mWcFw/2pwM6hbEXBnGw9FHI+w8gRMJkiNxzY1+T/cx/5PzKM5hjzQuHcmwp6Kg/dpvpgBgXEXIB/OZDVkGc0+AE1naBGlqsBoZKJaycuSxeZ5bQ=
Received: from SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 by SN6PR11MB3439.namprd11.prod.outlook.com (2603:10b6:805:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 09:18:20 +0000
Received: from SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::704d:376f:6f0e:bd6a]) by SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::704d:376f:6f0e:bd6a%7]) with mapi id 15.20.3153.022; Wed, 1 Jul 2020
 09:18:20 +0000
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     Jes Sorensen <jes@trained-monkey.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>
Subject: mdadm-4.2 release
Thread-Topic: mdadm-4.2 release
Thread-Index: AdZPheeNauIrxPkpSpiQcZh2gh+bugAAhgkA
Date:   Wed, 1 Jul 2020 09:18:20 +0000
Message-ID: <SA0PR11MB4542AD5A1AEF00B96404D5A4FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
References: <SA0PR11MB454290C854066D0AFD7EEC75FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
In-Reply-To: <SA0PR11MB454290C854066D0AFD7EEC75FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: trained-monkey.org; dkim=none (message not signed)
 header.d=none;trained-monkey.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [89.64.90.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88298ac0-0745-457f-3576-08d81d9fb2aa
x-ms-traffictypediagnostic: SN6PR11MB3439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3439FC4CE9DDE378448B45BFFF6C0@SN6PR11MB3439.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1xTsucYznsappxqnbj+llZ7OKKSCvItArrpB/wVxEeYwIvXbCPnFgI8EtCnN+tbUIxWlG7Xl0MKt3+ksFQGyYn9GXSygSxiqmiqdtRjxdVgXHHs0bMVhEovzySdtT+FhFsv7wTV/WVFfFdHTZuxqBgCHv2nMw/yTkwyWimmnQt+tu48Jkmd8DzCbl2ByuYQMQR2Mqdop+tiEl2DuRsaq6LPaVMSCYa9QX86MThhBoiuU029tKglY8p4LXXrcg1X1GVacU1alSReML6UQHcWts+14tOTkQeQiH1j6EmvgGY9Veg1g5ZZMtNEdmS84mAwPcwTsBMML5l6AYjBHh2grQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4542.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(76116006)(66476007)(66946007)(66556008)(64756008)(66446008)(26005)(186003)(8936002)(8676002)(2940100002)(7696005)(6506007)(316002)(4326008)(86362001)(54906003)(55016002)(6916009)(107886003)(478600001)(558084003)(33656002)(9686003)(52536014)(2906002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VnHIdq1yruacBFrVhPLMLCqqT72yq6Tn+TZYQ5Lumu+TNiBffOH7FqvcChfuRtA4xvIabod3yrArfWYcyOLIyv6wLjUgiaVjb30iWP1AWWqWA3TzsRgsXsPQrkrhZBN5O/A6BQwC/72RaWMs32FgaKKOU9X2rhszo2LWi6mS3rBOgaZn0mrqafXqMgqfZSOq8L/+gIqOwuDggCr4k4j/GYEi+28IIW+m/PMsmNthl6pT8b14CFNmP+J5obfdFg/IshItz+/Htc2iQxlUIj6g6cBAqRtkNobzqtylVyp4X4Oo7TnRsozJ16Zkp9qTP7mNL0YUATp8cYAvSvGZnEveR4Td4ktHBv1O2nNc04bQd70TMN5syBL9Y8V77Uw25FCHl9ngRf5yZ38Y60U6zdw59/Lp144d3Q+PAcDHkPUrC4maBRa388mNoVvPH+O/wejuhsgAOvZzIkFU6GTSKjdx5ae3uS/uj4JTpLBcEwzHBVo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4542.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88298ac0-0745-457f-3576-08d81d9fb2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:18:20.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CL3/0Z2H3iymd2WQm29b70i9yfwCCdA5j41Ea8Sc4jJokT6/dAOJix65bw/g4zo+lirXTgIgjsBjgUqNJFIMEYF9T4Nunq05rPVwzSEEr64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3439
X-OriginatorOrg: intel.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,
It will be nice to release mdadm-4.2 soon. =A0If I remember correctly, rele=
ase has been planned for May- now is July.
Do you still working on it?
We are ok with releasing it on current HEAD.
Sorry for spam, resending as plain text.

Thanks,
Mariusz
