Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EABFB8A43
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 06:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbfITEvW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 20 Sep 2019 00:51:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfITEvW (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 20 Sep 2019 00:51:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6655DAE04;
        Fri, 20 Sep 2019 04:51:20 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "David F." <df7729@gmail.com>
Date:   Fri, 20 Sep 2019 14:51:12 +1000
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] udev: allow for udev attribute reading bug.
In-Reply-To: <CAGRSmLsH4a20Hed10ekGbprQXoXXasazgQT6cz+6dps7E1CUAA@mail.gmail.com>
References: <87impq9oh4.fsf@notabene.neil.brown.name> <CAGRSmLsH4a20Hed10ekGbprQXoXXasazgQT6cz+6dps7E1CUAA@mail.gmail.com>
Message-ID: <87a7aza7un.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Sep 19 2019, David F. wrote:

> does this apply to eudev as well?  I'm thinking of upgrading from an
> older udev to eudev on our boot media.

Apparently not.

udev_device_get_sysattr_value() calls a single
        size = read(fd, value, sizeof(value));
rather than fread().

NeilBrown


>
> On Tue, Sep 17, 2019 at 11:11 PM NeilBrown <neilb@suse.de> wrote:
>>
>>
>> There is a bug in udev (which will hopefully get fixed, but
>> we should allow for it anways).
>> When reading a sysfs attribute, it first reads the whole
>> value of the attribute, then reads again expecting to get
>> a read of 0 bytes, like you would with an ordinary file.
>> If the sysfs attribute changed between these two reads, it can
>> get a mixture of two values.
>>
>> In particular, if it reads when 'array_state' is changing from
>> 'clear' to 'inactive', it can find the value as "clear\nve".
>>
>> This causes the test for "|clear|active" to fail, so systemd is allowed
>> to think that the array is ready - when it isn't.
>>
>> So change the pattern to allow for this but adding a wildcard at
>> the end.
>> Also don't allow for an empty string - reading array_state will
>> never return an empty string - if it exists at all, it will be
>> non-empty.
>>
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>  udev-md-raid-arrays.rules | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/udev-md-raid-arrays.rules b/udev-md-raid-arrays.rules
>> index d3916651cf5c..c8fa8e89ef69 100644
>> --- a/udev-md-raid-arrays.rules
>> +++ b/udev-md-raid-arrays.rules
>> @@ -14,7 +14,7 @@ ENV{DEVTYPE}=="partition", GOTO="md_ignore_state"
>>  # never leave state 'inactive'
>>  ATTR{md/metadata_version}=="external:[A-Za-z]*", ATTR{md/array_state}=="inactive", GOTO="md_ignore_state"
>>  TEST!="md/array_state", ENV{SYSTEMD_READY}="0", GOTO="md_end"
>> -ATTR{md/array_state}=="|clear|inactive", ENV{SYSTEMD_READY}="0", GOTO="md_end"
>> +ATTR{md/array_state}=="clear*|inactive", ENV{SYSTEMD_READY}="0", GOTO="md_end"
>>  LABEL="md_ignore_state"
>>
>>  IMPORT{program}="BINDIR/mdadm --detail --no-devices --export $devnode"
>> --
>> 2.14.0.rc0.dirty
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2EWsAACgkQOeye3VZi
gblklhAAhjgDDPQDm9DlaHjmMlXuSIBc8F9ucgADFMVTfeuWTx6jssYl5higtTnN
v2Ug2rUqHgCKoUdyjDM8+INeMx902uk0eHMOIphO7CPDlWUPt16bjmKG9qpR+y71
o8RCZk88MwEP/ABf7N9d26YWd8jiugzXnJHCh2GSfGqZ///qZCTsNCAHlpqUsDjM
+8eAFMIl1Ea7w65BDD3/0N0o9iGmSLK9qpcnjyGxfBRaJCbhn7aHwHAnWIrqRLkv
/SKZh1F3xlW9z57NQ7APitBzFOYfBaj3RF0WLhNaU2JFqE0jpzYCer6o7YOCSRnt
nZVWKOEdMfkO1/L/30lkbtep7jCYm4qL8FOhJ0yaqhk/K6IC+mCPFUy++dm1SyCK
ugKVgDxjxxoki2P6YCdpMdzBA48qFZaYaWYvDeQg5X5/Qn792aGz0ohl67GxoWmZ
bxrrpKryVLRJ1At3dH/Uz8ryBEO9RVLI15ic9TcvOeX31OIneHi7pdrO0tE07zuu
KgPR5VcwKWjnQ3eyDeLYYehE09b3g68Gj/XV3gZT7Jq67y/yhIiVSzvGt6aipBgh
JhULwHCaBguptU16cWT+bXP+J42+7E2vmZCEt3i4Tvw8IIjwcE0i2CP96NQVu0an
aSx6L4G0ElPFRKAGJN3thcppt100xR0X2nING7pDqz4O9lTi4c4=
=RaAf
-----END PGP SIGNATURE-----
--=-=-=--
