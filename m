Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12223A67B
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHCMs3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 08:48:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:27317 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgHCMsP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Aug 2020 08:48:15 -0400
IronPort-SDR: 3YRzhc6xgNi+pSS5tvg7KvxZ8na8HEp4T75HoinmYw/U8rDGtL8meJlMWqXvyI1NtJCJJ1VnIc
 jx+xpzIVE0PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="131655566"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="131655566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 05:48:15 -0700
IronPort-SDR: EBNgy/anBt4bc8zhiEm6AOlSwU8EReaLgTjrOyZoN4fehwNLKXg2PJaHVgG4n0A2GGRC3ISc4v
 4J5Xhgvz1IQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="324052841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2020 05:48:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Aug 2020 05:48:14 -0700
Received: from orsmsx109.amr.corp.intel.com (10.22.240.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 3 Aug 2020 05:48:14 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Aug 2020 05:48:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Aug 2020 05:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu1AFgkWZlH2v/q3v0IV5P9cg82/AGBoW8cQwuWL5dEVs0QNO4yd9cSu8+Zvc2bMoigkqP+9/7dretV1s72tpB3p73PwOQIAMhklbA3B6tSjYKQe1JSGO0l4bAunD4/WXyX1iCrn28SCjK3y/GMmh8BTKb9QyjoDOtA8C4YlU9nD1Ea7vSyiAxuFoDdl/IRi+xIjEXVM4vRIhCr6khfwMgZqRnF/r5f3r7DMevb5YV5qWim2O7BVSOJkqM9yNyaGqQYoC05m9S3EDt5bXF97bP+jEAOoN10evhLD4jllv7yRXylFkkJiLlyoh8RQtQUCNNhBKPolelFu/vbjwVwM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cIIgfb9k2xbk5jWLSaseTedDr0Snu929IMyS5g9mXo=;
 b=WC1hW0vWdp8N1qTXkftVKGACdLRVNHzQ1FkvmtMeXbOyrpfJAT3fJ3W04Whcw/sGJbJKUeTOHkxKl66zpOVm0JMqebfOUy2vcuCLf76tU6aF9UQ97z2twQPWpHRhvVeIiKeSAk094znspwtlDBGXne8LMItXDJ2Ncid7JvdEShOf75J8Mr5yWyNqNTx052zv1UE4FbH2FqlUEg6O1UofVEatVypgoyymAezgUZq6qVktQkJAv6k9iTmVdXaFl2R9yMzd9EfOgv43raxZJuNy97dzwO3mRF2qo6iEMLRVI581ZtXN+P9siaTsZkdTWsyuFztmC0w1VtmsbY0/WYI4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cIIgfb9k2xbk5jWLSaseTedDr0Snu929IMyS5g9mXo=;
 b=FokRPSqxXOWdFu1GaevkAbzE3je9cV44mz6IhjbIwhvXN0chjDypJtNJ3yuQBUPZzW0knEs6YVs8+hBqBgmylT2dTwtoJTn1HmpqergafcdiQvyLH70IKNdRWgpQvwb6nZdknzY4waGIA5wfuNfvfu/8/vxcmo/HarVBY2oriK0=
Received: from SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Mon, 3 Aug
 2020 12:48:12 +0000
Received: from SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::415d:735b:8402:25bf]) by SA0PR11MB4542.namprd11.prod.outlook.com
 ([fe80::415d:735b:8402:25bf%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 12:48:12 +0000
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>,
        Jes Sorensen <jes@trained-monkey.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>
Subject: RE: mdadm-4.2 release
Thread-Topic: mdadm-4.2 release
Thread-Index: AdZPheeNauIrxPkpSpiQcZh2gh+bugAAhgkABoL4KNA=
Date:   Mon, 3 Aug 2020 12:48:12 +0000
Message-ID: <SA0PR11MB4542B9DC53D2B8013450A767FF4D0@SA0PR11MB4542.namprd11.prod.outlook.com>
References: <SA0PR11MB454290C854066D0AFD7EEC75FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
 <SA0PR11MB4542AD5A1AEF00B96404D5A4FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
In-Reply-To: <SA0PR11MB4542AD5A1AEF00B96404D5A4FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [89.64.92.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae807379-120a-4a15-1fc9-08d837ab7b95
x-ms-traffictypediagnostic: SA0PR11MB4752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB47520D1ACDFD879219810B55FF4D0@SA0PR11MB4752.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Mlc8GI1EHhn3wlxacRwdc5Sa7qSCIuS/TC95aC1rlUjVgpZ9ln4TEJxyYk0IaAjjcfDg2bggVvUIMWPMken5XcHOBzuv5Puot53a50J/A6NeH80qFEoQoOGfd48NlDlQlHfE5oB70bXYTbAGz5hwCA3N5Cw6rPqAVXWYEXdrYRhmh6XQOkyIH0KojhC978Dm9cTMCNgoMUXWHEkTXx0WUuLnHEbnAnP0BHdosBvyBkMvv3BqpUdP3WUDXHwZij04uCL0PRp7guusHIjWhRnXMmmHYuKYAivhyFDBpL2xgHUAsHuv4sMUc5HIwia5V+SJpvg3GmeuzEZFJ4MEDN9PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4542.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(2906002)(86362001)(52536014)(7696005)(316002)(53546011)(478600001)(186003)(66476007)(9686003)(5660300002)(71200400001)(66446008)(55016002)(110136005)(66556008)(6506007)(83380400001)(54906003)(8936002)(64756008)(76116006)(4326008)(8676002)(33656002)(26005)(107886003)(4744005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qW33izrzgZ1Nn0fjKtHUFoDeIDZgtRYLFeV10InJsZ8ATuKQH8APBgc1ZU7v1epmqNC7cUO5FvBzVPuCykCZePvKIEWyIm8l5zR2ZLevKbU5zgDjBULWLWPhsS/2volZlHWOwNoezpeyDXTNXEzrJnxQvCIR9CCmQQJVZgj9VyWd9Bbn5zVFkjIZYvJHgLV+6SOJ/LHhWbVdZbZJ2MxYlgukAKpfBz1/2tHryZbO+sxlONUQS4mpPhEpsCoP6ajijGcZ8mHKOmgw0zXNs+AylU78F1+E+qGvjIMyL6PiUVwPCZ/RQCnhpQ8vZtIAWMMj6coNKyVjuLuBRWUW3dPHF9lluHF7/F1/jnL7lgJXyZZlkT4cJdj25iW4fdSZqdYLLW/sJRtQswnzw6hHfsPKwvTsIPHNRs2X/HqZzVCc/r/FmgflwjAklsR3aGA7ahZH4Fxj6VVRG+63nXxC3sU4sWCPBYAGl4zp7+I7FCtFyta7EBgXXbOLNnMgbeQh/0/xEusv5y1UhTcUfeXaX+sElfbEMFnXUUkW6tiso/gmmqzqiTAwZitw5B4a0rZcJHRX6DLvAx7Jmv3J/MU/cQYRh6o+dvSXHGV4J/v0tZfTt14HoW+5jjJrRWPWpwqZWKqaoyHRDX0wb3/oUUXJf4TO3Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4542.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae807379-120a-4a15-1fc9-08d837ab7b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 12:48:12.1885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNVY+U9nnNigHFy17c+Ugy/cBIysDckW8w5tWOEHrpkcUJrHhpMo0L1DaDrp8WrKe24jr9SlRfAY0JoyliZNghSXVSHQE+K2AkFu3JMHzuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,
Is there any chance to release mdadm soon?

Thanks,
Mariusz

-----Original Message-----
From: linux-raid-owner@vger.kernel.org <linux-raid-owner@vger.kernel.org> O=
n Behalf Of Tkaczyk, Mariusz
Sent: Wednesday, July 1, 2020 11:18 AM
To: Jes Sorensen <jes@trained-monkey.org>
Cc: linux-raid@vger.kernel.org; Baldysiak, Pawel <pawel.baldysiak@intel.com=
>
Subject: mdadm-4.2 release

Hi Jes,
It will be nice to release mdadm-4.2 soon. =A0If I remember correctly, rele=
ase has been planned for May- now is July.
Do you still working on it?
We are ok with releasing it on current HEAD.
Sorry for spam, resending as plain text.

Thanks,
Mariusz
