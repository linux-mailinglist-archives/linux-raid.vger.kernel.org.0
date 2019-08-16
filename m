Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E698FD94
	for <lists+linux-raid@lfdr.de>; Fri, 16 Aug 2019 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHPITB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 16 Aug 2019 04:19:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:53611 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHPITB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 16 Aug 2019 04:19:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 01:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="328620040"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2019 01:14:26 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 IRSMSX151.ger.corp.intel.com (163.33.192.59) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 16 Aug 2019 09:14:25 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.73]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.87]) with mapi id 14.03.0439.000;
 Fri, 16 Aug 2019 09:14:26 +0100
From:   "Smolinski, Krzysztof" <krzysztof.smolinski@intel.com>
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
CC:     Jes Sorensen <jes.sorensen@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] mdadm: fixed mdadm compilation on gcc8
Thread-Topic: [PATCH] mdadm: fixed mdadm compilation on gcc8
Thread-Index: AQHVUb1eG41lRzJaNEeIDeHfxcbHbab40tgAgASdlBA=
Date:   Fri, 16 Aug 2019 08:14:25 +0000
Message-ID: <17A1AC191FC9154087149BFFF6E034224294D0A7@irsmsx105.ger.corp.intel.com>
References: <20190813095552.32445-1-mariusz.dabrowski@intel.com>
 <1a82bc79-0bc8-7686-daec-352a80f1f88d@molgen.mpg.de>
In-Reply-To: <1a82bc79-0bc8-7686-daec-352a80f1f88d@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGE0MzIzMTAtMWI3ZS00MzliLTk0NWItOWU1ZjMyNWIxOTE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2JTRXZ0TGtCUmFOVU00UTZiK3E2cDUwQ0VTd2VGdkZMVlJPUGZCWjdqZGlcLzNJcHdjZUdPTmI5bW9vK0p5b0YifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

PknigJlkIHVzZSBpbXBlcmF0aXZlIG1vb2QgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBhbmQgYmUg
bW9yZSBleHBsaWNpdC4NCj4NCj4+IG1kYWRtOiBVc2UgUEFUSF9NQVggb3ZlciBNQVhfU1lTRlNf
UEFUSF9MRU4NCj4NCj4+IEdDQzggbWFrZSBtb3JlIHN0cmljdCBjaGVja3Mgb2YgcG9zc2libGUg
dHJ1bmNhdGlvbiBkdXJpbmcgc25wcmludGYNCj4NCj5zL21ha2UvbWFrZXMvDQo+DQo+b3I6IEdD
QyA4IGNoZWNrcyBwb3NzaWJsZSB0cnVuY2F0aW9uIGR1cmluZyBzbnByaW50ZiBtb3JlIHN0cmlj
dGx5IHRoYW4NCj5HQ0MgNy4NCj4NCj4+IGNhbGxzIHRoYW4gR0NDNyB3aGljaCBjYXVzZSBjb21w
aWxhdGlvbiBlcnJvcnMuIFRoaXMgcGF0Y2gNCj4+IGZpeGVzIGNvbXBpbGF0aW9uIG9mIG1kYWRt
IG9uIEdDQzggY29tcGlsZXIuDQo+DQo+U28geW91IGluY3JlYXNlIHRoZSBidWZmZXIgc2l6ZSBm
cm9tIDEyMCB0byBQQVRIX01BWCAoNDA5Nik/IFdoYXQgaXMNCj50aGUgbG9naWMgYmVoaW5kIHRo
YXQgYmVzaWRlcyBqdXN0IGJlaW5nIGJpZ2dlcj8NCj4NCj5QQVRIX01BWCBzZWVtcyB0byBiZSB0
cmlja3k6IGh0dHBzOi8vZWtsaXR6a2Uub3JnL3BhdGgtbWF4LWlzLXRyaWNreQ0KDQpJIGFncmVl
IHdpdGggeW91IHJlZ2FyZGluZyBzb2x1dGlvbiB1c2luZyBQQVRIX01BWC4gTUFYX1NZU0ZTX1BB
VEhfTEVOIGRlZmluZXMgbWF4IHBhdGggYW5kIHRoaXMgdmFsdWUgc2hvdWxkIGJlIHVzZWQuIEkg
d2lsbCB1cGxvYWQgc2Vjb25kIHZlcnNpb24gb2YgcGF0Y2ggd2l0aCBjaGVjayBhZ2FpbnN0IGVy
cm9ycyBhbmQgdHJ1bmNhdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQo=
