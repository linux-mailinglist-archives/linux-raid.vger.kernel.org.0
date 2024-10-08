Return-Path: <linux-raid+bounces-2875-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0119952DF
	for <lists+linux-raid@lfdr.de>; Tue,  8 Oct 2024 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CA28468A
	for <lists+linux-raid@lfdr.de>; Tue,  8 Oct 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359411DFE0D;
	Tue,  8 Oct 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b="v7f8jnBP"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail.valdk.tel (mail.valdk.tel [185.177.150.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88C1E0B70
	for <linux-raid@vger.kernel.org>; Tue,  8 Oct 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.177.150.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399702; cv=none; b=MmmTOXRCQYds03GEBuM7P+zCoPA5dVLqZoj8fBgO8AS/noW0zwZQTfiIhq4ENha55X/J0PYMx1zdnw8TlgVCF3rXTs0w5t/4nDXbX4aMkJ2OdRPQsOBNgFWfbhJL3rb0u6l76RWt0Y41ln+D95RY8zB2rrf4VVgpj4US/EPWA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399702; c=relaxed/simple;
	bh=YXkziRCI+AiL1qp+9fpae0cfozwz5I0Xm26Di4hZTvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=afKlJxjERfIjHatTsqwIp/ouQ/HZVRg4XSzpEXYjUI8GCqkwHwzHBpxhaeIU/33yLCUOi4llyfr9HoU2qLcXvpvCxsKrD8UxP6DSM91kL9dv7IVYzdwfCmloSG4VDcL9VkZN1wkFFJVejvBV6j+/Iiu4NY4uOE8kLG7jOyIw28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru; spf=pass smtp.mailfrom=valdikss.org.ru; dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b=v7f8jnBP; arc=none smtp.client-ip=185.177.150.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valdikss.org.ru
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 377EE160C1CE;
	Tue,  8 Oct 2024 18:01:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
	s=msrv; t=1728399685; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-language:in-reply-to:references:autocrypt;
	bh=YXkziRCI+AiL1qp+9fpae0cfozwz5I0Xm26Di4hZTvk=;
	b=v7f8jnBP/Gb+vd5BzEBgkxh4H9EibvBZe4S+3Sf2OAtvtduJmMgrDho6EZawNuRHqxY9Eg
	iuG+8Wtj+70YupVhlV0VjFn+Og84ZZYfKz5nL7FGiavshig0H4j+tbs4CPq/gzJZXp8UpB
	gSphtwA/YNZyvsFUBsxxIB9l//MKboGINvhm7+L79dMA9ofeDzhuGYtrdWlXnYDhrgz+WL
	UH2MfSa6iQfyOJVP+rjbxZDm6u/OTV9QQY4PFbFTPPTsXCQDfbLg4JUNaMx2raF/Pbg7Wb
	QmQfbhoDqOs2pIbXmAZjxtxLKetsO2GYHMGx57XtzDAySWZ46BEFPpAihOlRlw==
Message-ID: <06206bdf-6d63-483a-8afc-d56d733db2ff@valdikss.org.ru>
Date: Tue, 8 Oct 2024 18:01:09 +0300
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Null dereference in raid10_size, I/O lockup afterwards
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-raid@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <0dd96820-fe52-4841-bc58-dbf14d6bfcc8@valdikss.org.ru>
 <e12e1789-5a07-4d42-8f06-afa99d820444@valdikss.org.ru>
 <3de753c8-86ee-6e7c-fe06-7c0693e95bbd@huaweicloud.com>
 <7a21c8d6-3012-6816-b1d8-0bebdd7b10cc@huaweicloud.com>
Content-Language: ru, en-US
From: ValdikSS <iam@valdikss.org.ru>
Autocrypt: addr=iam@valdikss.org.ru; keydata=
 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
 OEcVmRU/pw5/zoQyQg==
In-Reply-To: <7a21c8d6-3012-6816-b1d8-0bebdd7b10cc@huaweicloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rx1NRGe0ouNfgmMxvr92Dd0D"
X-Last-TLS-Session-Version: TLSv1.3

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rx1NRGe0ouNfgmMxvr92Dd0D
Content-Type: multipart/mixed; boundary="------------jWYHtgZwVSL2rr3QtIUJYznP";
 protected-headers="v1"
From: ValdikSS <iam@valdikss.org.ru>
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-raid@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
Message-ID: <06206bdf-6d63-483a-8afc-d56d733db2ff@valdikss.org.ru>
Subject: Re: Null dereference in raid10_size, I/O lockup afterwards
References: <0dd96820-fe52-4841-bc58-dbf14d6bfcc8@valdikss.org.ru>
 <e12e1789-5a07-4d42-8f06-afa99d820444@valdikss.org.ru>
 <3de753c8-86ee-6e7c-fe06-7c0693e95bbd@huaweicloud.com>
 <7a21c8d6-3012-6816-b1d8-0bebdd7b10cc@huaweicloud.com>
In-Reply-To: <7a21c8d6-3012-6816-b1d8-0bebdd7b10cc@huaweicloud.com>

--------------jWYHtgZwVSL2rr3QtIUJYznP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMTAuMjAyNCAwNTozMiwgWXUgS3VhaSB3cm90ZToNCj4+IOWcqCAyMDI0LzEwLzA1
IDEwOjU1LCBWYWxkaWtTUyDlhpnpgZM6DQo+Pj4gT24gMDUuMTAuMjAyNCAwNDozNSwgVmFs
ZGlrU1Mgd3JvdGU6DQo+Pj4+IEZlZG9yYSAzOSB3aXRoIDYuMTAuMTEtMTAwLmZjMzkga2Vy
bmVsIGRlcmVmZXJlbmNlcyBOVUxMIGluIA0KPj4+PiByYWlkMTBfc2l6ZSBhbmQgbG9ja3Mg
dXAgd2l0aCAzLWRyaXZlIHJhaWQxMCBjb25maWd1cmF0aW9uIHVwb24gaXRzIA0KPj4+PiBk
ZWdyYWRhdGlvbiBhbmQgcmVhdHRhY2htZW50Lg0KPj4+Pg0KPj4+PiBIb3cgdG8gcmVwcm9k
dWNlOg0KPj4+Pg0KPj4+PiAxLiBHZXQgMyBVU0IgZmxhc2ggZHJpdmVzDQo+Pj4+IDIuIG1k
YWRtIC0tY3JlYXRlIC1iIGludGVybmFsIC1sIDEwIC1uIDMgLXogMUcgL2Rldi9tZDAgL2Rl
di9zZGEgDQo+Pj4+IC9kZXYvc2RiIC9kZXYvc2RjDQo+Pj4+IDMuIFVucGx1ZyAyIFVTQiBk
cml2ZXMNCj4+Pj4gNC4gUGx1ZyBvbmUgb2YgdGhlIGRyaXZlIGFnYWluDQo+Pj4+DQo+Pj4+
IEhhcHBlbnMgZXZlcnkgdGltZSwgZXZlcnkgVVNCIGZsYXNoIHJlYXR0YWNobWVudC4NCj4+
Pg0KPj4+IFJlcHJvZHVjZWQgb24gNi4xMS4yLTI1MC52YW5pbGxhLmZjMzkueDg2XzY0DQo+
Pg0KPj4gQ2FuIHlvdSB1c2UgYWRkcjJsaW5lIG9yIGdkYiB0byBzZWUgd2hpY2ggY29kZWxp
bmUgaXMgdGhpcz8NCj4+DQo+PiBSSVA6IDAwMTA6cmFpZDEwX3NpemUrMHgxNS8weDcwIFty
YWlkMTBdDQoNCkl0J3MgcmFpZDEwLmM6Mzc2OCAoNi4xMC4xMSkNCmh0dHBzOi8vZ2l0aHVi
LmNvbS9ncmVna2gvbGludXgvYmxvYi84YTg4NmJlZTdhYTU3NDYxMWRmODNhMDI4YWI0MzVh
ZWVlMDcxZTAwL2RyaXZlcnMvbWQvcmFpZDEwLmMjTDM3NjgNCg0KcmFpZDEwX3NpemUoc3Ry
dWN0IG1kZGV2ICptZGRldiwgc2VjdG9yX3Qgc2VjdG9ycywgaW50IHJhaWRfZGlza3MpDQp7
DQoJc2VjdG9yX3Qgc2l6ZTsNCglzdHJ1Y3QgcjEwY29uZiAqY29uZiA9IG1kZGV2LT5wcml2
YXRlOw0KDQoJaWYgKCFyYWlkX2Rpc2tzKQ0KLS0+CQlyYWlkX2Rpc2tzID0gbWluKGNvbmYt
Pmdlby5yYWlkX2Rpc2tzLA0KCQkJCSBjb25mLT5wcmV2LnJhaWRfZGlza3MpOw0KCWlmICgh
c2VjdG9ycykNCgkJc2VjdG9ycyA9IGNvbmYtPmRldl9zZWN0b3JzOw0KDQoNCj4gIEZyb20g
Y29kZSByZXZpZXcsIGxvb2tzIGxpa2UgdGhpcyBjYW4gb25seSBoYXBwZW4gaWYgcmFpZDEw
X3J1bigpIHJldHVybg0KPiAwIHdoaWxlIG1kZGV2LT5wcml2YXRlKHRoZSByYWlkMTAgY29u
ZikgaXMgc3RpbGwgTlVMTC4gQ2FuIHlvdSBhbHNvIGdpdmUNCj4gdGhlIGZvbGxvd2luZyBw
YXRjaCBhIHRlc3Q/DQoNCkl0IHdvcmtzLCB0aGFua3MgYSBsb3QhIE5vIGRlcmVmZXJlbmNl
LCBubyBvb3BzLg0KDQpbICAgNDcuOTMzMTc4XSBzY3NpIGhvc3Q0OiB1c2Itc3RvcmFnZSA0
LTEuMzoxLjANClsgICA0OC43Nzg4MTVdIHNjc2kgMzowOjA6MDogRGlyZWN0LUFjY2VzcyAg
ICAgQVNvbGlkICAgVVNCIA0KICAgICAgUFE6IDAgQU5TSTogNg0KWyAgIDQ4Ljc3OTAyNF0g
c2NzaSAyOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBU29saWQgICBVU0IgDQogICAgICBQ
UTogMCBBTlNJOiA2DQpbICAgNDguNzc5OTY4XSBzZCAzOjA6MDowOiBBdHRhY2hlZCBzY3Np
IGdlbmVyaWMgc2cwIHR5cGUgMA0KWyAgIDQ4Ljc4MTEwMF0gc2QgMjowOjA6MDogQXR0YWNo
ZWQgc2NzaSBnZW5lcmljIHNnMSB0eXBlIDANClsgICA0OC43ODIxMTFdIHNkIDM6MDowOjA6
IFtzZGFdIDEyMjg4MDAwMSA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogDQooNjIuOSBHQi81
OC42IEdpQikNClsgICA0OC43ODIzMzZdIHNkIDI6MDowOjA6IFtzZGJdIDEyMjg4MDAwMSA1
MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogDQooNjIuOSBHQi81OC42IEdpQikNClsgICA0OC43
ODI0NzldIHNkIDM6MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmDQpbICAgNDgu
NzgyNDg3XSBzZCAzOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAyMyAwMCAwMCAwMA0KWyAg
IDQ4Ljc4MjY1OF0gc2QgMzowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGRpc2FibGVkLCBy
ZWFkIGNhY2hlOiANCmVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQpbICAg
NDguNzgyNjU4XSBzZCAyOjA6MDowOiBbc2RiXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0KWyAg
IDQ4Ljc4MjY2N10gc2QgMjowOjA6MDogW3NkYl0gTW9kZSBTZW5zZTogMjMgMDAgMDAgMDAN
ClsgICA0OC43ODI4MzFdIHNkIDI6MDowOjA6IFtzZGJdIFdyaXRlIGNhY2hlOiBkaXNhYmxl
ZCwgcmVhZCBjYWNoZTogDQplbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQ0K
WyAgIDQ4Ljc4NzU1Nl0gc2QgMjowOjA6MDogW3NkYl0gQXR0YWNoZWQgU0NTSSByZW1vdmFi
bGUgZGlzaw0KWyAgIDQ4Ljc4ODQwM10gc2QgMzowOjA6MDogW3NkYV0gQXR0YWNoZWQgU0NT
SSByZW1vdmFibGUgZGlzaw0KWyAgIDQ4LjkzMTY0M10gbWQvcmFpZDEwOm1kMDogbm90IGVu
b3VnaCBvcGVyYXRpb25hbCBtaXJyb3JzLg0KWyAgIDQ4Ljk0ODk5MF0gbWQ6IHBlcnMtPnJ1
bigpIGZhaWxlZCAuLi4NClsgICA0OC45Njk2OThdIHNjc2kgNDowOjA6MDogRGlyZWN0LUFj
Y2VzcyAgICAgQVNvbGlkICAgVVNCIA0KICAgICAgUFE6IDAgQU5TSTogNg0KWyAgIDQ4Ljk3
MDM4Ml0gc2QgNDowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMiB0eXBlIDANClsg
ICA0OC45NzE1MzRdIHNkIDQ6MDowOjA6IFtzZGNdIDEyMjg4MDAwMSA1MTItYnl0ZSBsb2dp
Y2FsIGJsb2NrczogDQooNjIuOSBHQi81OC42IEdpQikNClsgICA0OC45NzE4NjJdIHNkIDQ6
MDowOjA6IFtzZGNdIFdyaXRlIFByb3RlY3QgaXMgb2ZmDQpbICAgNDguOTcxODY4XSBzZCA0
OjA6MDowOiBbc2RjXSBNb2RlIFNlbnNlOiAyMyAwMCAwMCAwMA0KWyAgIDQ4Ljk3MjA1OF0g
c2QgNDowOjA6MDogW3NkY10gV3JpdGUgY2FjaGU6IGRpc2FibGVkLCByZWFkIGNhY2hlOiAN
CmVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQpbICAgNDguOTc2MjE2XSBz
ZCA0OjA6MDowOiBbc2RjXSBBdHRhY2hlZCBTQ1NJIHJlbW92YWJsZSBkaXNrDQpbICAgNDku
MDY3OTczXSBtZDA6IEFERF9ORVdfRElTSyBub3Qgc3VwcG9ydGVkDQoNCg0KDQo+IA0KPiBU
aGFua3MsDQo+IEt1YWkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL3JhaWQxMC5j
IGIvZHJpdmVycy9tZC9yYWlkMTAuYw0KPiBpbmRleCBmM2JmMTExNjc5NGEuLmI3ZjI1MzBh
ZTI1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZC9yYWlkMTAuYw0KPiArKysgYi9kcml2
ZXJzL21kL3JhaWQxMC5jDQo+IEBAIC00MDYxLDkgKzQwNjEsMTMgQEAgc3RhdGljIGludCBy
YWlkMTBfcnVuKHN0cnVjdCBtZGRldiAqbWRkZXYpDQo+ICDCoMKgwqDCoMKgwqDCoCB9DQo+
IA0KPiAgwqDCoMKgwqDCoMKgwqAgaWYgKCFtZGRldl9pc19kbShjb25mLT5tZGRldikpIHsN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmFpZDEwX3NldF9xdWV1
ZV9saW1pdHMobWRkZXYpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cmV0KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBkb24ndCBvdmVyd3Jp
dGUgcmV0IG9uIHN1Y2Nlc3MgKi8NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50IGVyciA9IHJhaWQxMF9zZXRfcXVldWVfbGltaXRzKG1kZGV2KTsNCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKSB7DQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBlcnI7DQo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVf
Y29uZjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiAgwqDCoMKgwqDC
oMKgwqAgfQ0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIC8qIG5lZWQgdG8gY2hlY2sgdGhhdCBl
dmVyeSBibG9jayBoYXMgYXQgbGVhc3Qgb25lIHdvcmtpbmcgDQo+IG1pcnJvciAqLw0KPiAN
Cj4gDQo+Pg0KPj4gVGhhbmtzLA0KPj4gS3VhaQ0KPj4NCj4+IC4NCj4+DQo+IA0KPiANCg==


--------------jWYHtgZwVSL2rr3QtIUJYznP--

--------------rx1NRGe0ouNfgmMxvr92Dd0D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEMiogvXcpmS32v71gXNcgLu+I93IFAmcFSTUFAwAAAAAACgkQXNcgLu+I93Ip
tw//QC1HWbpk9GF3Xo0SijFi2cYklYrpQ9HYKDAoujqLbLZJG5TmW2D5fjJst3EAgLN58YAIcNmX
8ZkbXRNoN6W4/akG5BjfjkxMq4RqKhbISS+OiGdBoA+scMWWntB4hhBqd0LMLDAgd8UWrv/ubPLb
vrAr295riU8uv/0TNHlEOKX2wsQUF+AvXKQO9VZWERq8bNLvEjxF8Hxes1U6aYLAV1gCvZttQL7i
9TCrXzt23bT2Eg8c9AwgI76ELJ3hyI569VFQKFlc0JMW0zBrjyckPgT6oAwqPOFISyTVJ9XXsS4A
fGj6Ca5NqdAHx504/8L38BLoTQ9XRzg7kPvwVPIzcxddiPXPATZeH+O68D0bdTcLZxeUD5Vzo1bX
ID6J5ct9hZ1F4tNm3MvxQ+CUTpTKShyLB9WwMgjJZlkGSVoXxakiN9ZgyxIHMaUkAq65BqJ4xdsR
A/gPn1LIQz5WuLD4dULKIIL5L0c+C7w/Iu0c5Ja5P/bPHh3d1cvcWqF6QEWMLCFY9Rr436e6vCmz
7LkVxWXBfYFAVHDEpu56KAXH3tKE6R6FisKliSCIlDvuZQbW8oXQpu711RuJ+9UXokPg6XbMjTT1
DRWhwLVTpv1ZLPWUoKUohapP7Ah1i1YZtIg3768dnE+WnfK3voJak/XZikin2EKsKtOiffI9YOqm
BPY=
=LqL/
-----END PGP SIGNATURE-----

--------------rx1NRGe0ouNfgmMxvr92Dd0D--

