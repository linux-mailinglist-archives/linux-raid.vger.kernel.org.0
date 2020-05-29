Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949AE1E8A82
	for <lists+linux-raid@lfdr.de>; Fri, 29 May 2020 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgE2V5U (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 29 May 2020 17:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2V5U (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 29 May 2020 17:57:20 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EB220810
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590789439;
        bh=svkerb82n/z3EPUW9ALxcCK3vCqOI+cgyyAhSGcbCig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P2VXzYoU9yx1214dfgIOjxTvyqtN+B8VGkYEgRPIHBGQSrqLsbw1IHv7TKXdGJ0XL
         i4CIXrB4ctzzPrAPHWAbO6Nsbppc8SPAiiCbygOehEx2caeqM8Thgdkno3us0Kmnk2
         7eAitW1hnZwpG/CGvc7nAfUZ3ZmJBHux9syhqolA=
Received: by mail-lj1-f169.google.com with SMTP id s1so1115501ljo.0
        for <linux-raid@vger.kernel.org>; Fri, 29 May 2020 14:57:19 -0700 (PDT)
X-Gm-Message-State: AOAM531rbnS9RUQMySGXdnr1nQP0TRnPPapCPypeFLFne29AMWDXcX7h
        GtAiDqSwx6YH9zUtNu0zw/oTOWzg2DOEo4KTNPw=
X-Google-Smtp-Source: ABdhPJzo5eMJbT8dCoPoC+fC1e/uNMYPSJDgozhWXuAIYyfGzONAdfd0D3ub4CmogSLs0pOOg4sb00zgSx6MDbATeHU=
X-Received: by 2002:a2e:b004:: with SMTP id y4mr5395673ljk.273.1590789437375;
 Fri, 29 May 2020 14:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <70dad446-7d38-fd10-130f-c23797165a21@yandex.pl> <56b68265-ca54-05d3-95bc-ea8ee0b227f6@yandex.pl>
 <CAPhsuW4WcqkDXOhcuG33bZtSEZ-V-KYPLm87piBH24eYEB0qVw@mail.gmail.com>
 <b9b6b007-2177-a844-4d80-480393f30476@yandex.pl> <CAPhsuW70NNozBmt1-zsM_Pk-39cLzi8bC3ZZaNwQ0-VgYsmkiA@mail.gmail.com>
 <f9b54d87-5b81-1fa3-04d5-ea86a6c062cb@yandex.pl> <CAPhsuW5ZfmCowTHNum5CSeadHqqPa5049weK6bq=m+JmnDE9Vg@mail.gmail.com>
 <d0340d7b-6b3a-4fd3-e446-5f0967132ef6@yandex.pl> <CAPhsuW4byXUvseqoj3Pw4r5nRGu=fHekdDec8FG6vj3of1wCyg@mail.gmail.com>
 <1cb6c63f-a74c-a6f4-6875-455780f53fa1@yandex.pl> <CAPhsuW6HdatOPJykqYCQs_7onWL1-AQRo05TygkXdRVSwAy_gQ@mail.gmail.com>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl> <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl> <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
In-Reply-To: <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 29 May 2020 14:57:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
Message-ID: <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000053e46805a6d087ab"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--00000000000053e46805a6d087ab
Content-Type: text/plain; charset="UTF-8"

On Fri, May 29, 2020 at 2:03 PM Song Liu <song@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 5:09 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
> >
> > On 5/28/20 5:06 PM, Song Liu wrote:
> > >
> > > For the next step, could you please try the following the beginning of
> > > --assemble
> > > run?
> > >
> > >     trace.py -M 10 'r::r5l_recovery_verify_data_checksum()(retval != 0)'
> > >
> > > Thanks,
> > > Song
> > >
> >
> > How long should I keep this one running ? So far - after ~1hr - nothing
> > got reported.
>
> We can stop it. It didn't really hit any data checksum error in early phase
> of the recovery. So it did found a long long journal to recover.

Could you please try the assemble again with the attached patch?

Thanks,
Song

--00000000000053e46805a6d087ab
Content-Type: application/octet-stream; 
	name="0001-debug-long-running-journal-recovery.patch"
Content-Disposition: attachment; 
	filename="0001-debug-long-running-journal-recovery.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kasqxk7t0>
X-Attachment-Id: f_kasqxk7t0

RnJvbSAzMTYwNTY4YTY5ZjM2YWJhZGY0M2JlNzNlY2M3OWQzN2M3MTc5NTZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPgpEYXRl
OiBGcmksIDI5IE1heSAyMDIwIDE0OjUzOjI4IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gZGVidWcg
bG9uZyBydW5uaW5nIGpvdXJuYWwgcmVjb3ZlcnkKCi0tLQogZHJpdmVycy9tZC9yYWlkNS1jYWNo
ZS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21kL3JhaWQ1LWNhY2hlLmMgYi9kcml2ZXJzL21k
L3JhaWQ1LWNhY2hlLmMKaW5kZXggOWI2ZGE3NTlkY2EyLi5iZjQ5YzRiZGM0YzggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbWQvcmFpZDUtY2FjaGUuYworKysgYi9kcml2ZXJzL21kL3JhaWQ1LWNhY2hl
LmMKQEAgLTIyNTMsNiArMjI1Myw5IEBAIHN0YXRpYyBpbnQgcjVjX3JlY292ZXJ5X2ZsdXNoX2xv
ZyhzdHJ1Y3QgcjVsX2xvZyAqbG9nLAogCiAJCXJldCA9IHI1Y19yZWNvdmVyeV9hbmFseXplX21l
dGFfYmxvY2sobG9nLCBjdHgsCiAJCQkJCQkgICAgICAmY3R4LT5jYWNoZWRfbGlzdCk7CisJCWlm
IChyZXQpCisJCQlwcl9pbmZvKCJyNWNfcmVjb3ZlcnlfYW5hbHl6ZV9tZXRhX2Jsb2NrKCkgcmV0
dXJucyAlZCBhdCBzZXEgJWxsdVxuIiwKKwkJCQlyZXQsIGN0eC0+c2VxKTsKIAkJLyoKIAkJICog
LUVBR0FJTiBtZWFucyBtaXNtYXRjaCBpbiBkYXRhIGJsb2NrLCBpbiB0aGlzIGNhc2UsIHdlIHN0
aWxsCiAJCSAqIHRyeSBzY2FuIHRoZSBuZXh0IG1ldGFibG9jawpAQCAtMjI2MCw2ICsyMjYzLDkg
QEAgc3RhdGljIGludCByNWNfcmVjb3ZlcnlfZmx1c2hfbG9nKHN0cnVjdCByNWxfbG9nICpsb2cs
CiAJCWlmIChyZXQgJiYgcmV0ICE9IC1FQUdBSU4pCiAJCQlicmVhazsgICAvKiByZXQgPT0gLUVJ
TlZBTCBvciAtRU5PTUVNICovCiAJCWN0eC0+c2VxKys7CisKKwkJaWYgKGN0eC0+c2VxICUgMTAw
MDAwID09IDApCisJCQlwcl9pbmZvKCIlcyBwcm9jZXNzaW5nIGN0eC0+c2VxICVsbHVcbiIsIF9f
ZnVuY19fLCBjdHgtPnNlcSk7CiAJCWN0eC0+cG9zID0gcjVsX3JpbmdfYWRkKGxvZywgY3R4LT5w
b3MsIGN0eC0+bWV0YV90b3RhbF9ibG9ja3MpOwogCX0KIApAQCAtMjM1OCw2ICsyMzY0LDcgQEAg
cjVjX3JlY292ZXJ5X3Jld3JpdGVfZGF0YV9vbmx5X3N0cmlwZXMoc3RydWN0IHI1bF9sb2cgKmxv
ZywKIAlzdHJ1Y3QgbWRkZXYgKm1kZGV2ID0gbG9nLT5yZGV2LT5tZGRldjsKIAlzdHJ1Y3QgcGFn
ZSAqcGFnZTsKIAlzZWN0b3JfdCBuZXh0X2NoZWNrcG9pbnQgPSBNYXhTZWN0b3I7CisJaW50IHRv
dGFsX3NoX3dyaXR0ZW4gPSAwOwogCiAJcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCk7CiAJ
aWYgKCFwYWdlKSB7CkBAIC0yNDE4LDkgKzI0MjUsMTMgQEAgcjVjX3JlY292ZXJ5X3Jld3JpdGVf
ZGF0YV9vbmx5X3N0cmlwZXMoc3RydWN0IHI1bF9sb2cgKmxvZywKIAkJY3R4LT5wb3MgPSB3cml0
ZV9wb3M7CiAJCWN0eC0+c2VxICs9IDE7CiAJCW5leHRfY2hlY2twb2ludCA9IHNoLT5sb2dfc3Rh
cnQ7CisJCWlmICh0b3RhbF9zaF93cml0dGVuKysgJSAxMDAwID09IDApCisJCQlwcl9pbmZvKCIl
cyByZXdyaXR0ZW4gJWQgc3RyaXBlcyB0byB0aGUgam91cm5hbCwgY3VycmVudCBjdHgtPnBvcyAl
bGx1IGN0eC0+c2VxICVsbHVcbiIsCisJCQkJX19mdW5jX18sIHRvdGFsX3NoX3dyaXR0ZW4sIGN0
eC0+cG9zLCBjdHgtPnNlcSk7CiAJfQogCWxvZy0+bmV4dF9jaGVja3BvaW50ID0gbmV4dF9jaGVj
a3BvaW50OwogCV9fZnJlZV9wYWdlKHBhZ2UpOworCXByX2luZm8oIiVzIGRvbmVcbiIsIF9fZnVu
Y19fKTsKIAlyZXR1cm4gMDsKIH0KIApAQCAtMjQzMSw2ICsyNDQyLDcgQEAgc3RhdGljIHZvaWQg
cjVjX3JlY292ZXJ5X2ZsdXNoX2RhdGFfb25seV9zdHJpcGVzKHN0cnVjdCByNWxfbG9nICpsb2cs
CiAJc3RydWN0IHI1Y29uZiAqY29uZiA9IG1kZGV2LT5wcml2YXRlOwogCXN0cnVjdCBzdHJpcGVf
aGVhZCAqc2gsICpuZXh0OwogCisJcHJfaW5mbygiJXMgZW50ZXJcbiIsIF9fZnVuY19fKTsKIAlp
ZiAoY3R4LT5kYXRhX29ubHlfc3RyaXBlcyA9PSAwKQogCQlyZXR1cm47CiAKQEAgLTI0NDMsOSAr
MjQ1NSwxMSBAQCBzdGF0aWMgdm9pZCByNWNfcmVjb3ZlcnlfZmx1c2hfZGF0YV9vbmx5X3N0cmlw
ZXMoc3RydWN0IHI1bF9sb2cgKmxvZywKIAkJcmFpZDVfcmVsZWFzZV9zdHJpcGUoc2gpOwogCX0K
IAorCXByX2luZm8oIiVzIGJlZm9yZSB3YWl0X2V2ZW50XG4iLCBfX2Z1bmNfXyk7CiAJLyogcmV1
c2UgY29uZi0+d2FpdF9mb3JfcXVpZXNjZW50IGluIHJlY292ZXJ5ICovCiAJd2FpdF9ldmVudChj
b25mLT53YWl0X2Zvcl9xdWllc2NlbnQsCiAJCSAgIGF0b21pY19yZWFkKCZjb25mLT5hY3RpdmVf
c3RyaXBlcykgPT0gMCk7CisJcHJfaW5mbygiJXMgYWZ0ZXIgd2FpdF9ldmVudFxuIiwgX19mdW5j
X18pOwogCiAJbG9nLT5yNWNfam91cm5hbF9tb2RlID0gUjVDX0pPVVJOQUxfTU9ERV9XUklURV9U
SFJPVUdIOwogfQpAQCAtMjQ2Myw2ICsyNDc3LDggQEAgc3RhdGljIGludCByNWxfcmVjb3Zlcnlf
bG9nKHN0cnVjdCByNWxfbG9nICpsb2cpCiAKIAljdHgtPnBvcyA9IGxvZy0+bGFzdF9jaGVja3Bv
aW50OwogCWN0eC0+c2VxID0gbG9nLT5sYXN0X2NwX3NlcTsKKwlwcl9pbmZvKCIlcyBzdGFydGlu
ZyBmcm9tIGN0eC0+cG9zICVsbHUgY3R4LT5zZXEgJWxsdSIsCisJCV9fZnVuY19fLCBjdHgtPnBv
cywgY3R4LT5zZXEpOwogCUlOSVRfTElTVF9IRUFEKCZjdHgtPmNhY2hlZF9saXN0KTsKIAljdHgt
Pm1ldGFfcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCk7CiAKQEAgLTI0ODQsNiArMjUwMCw5
IEBAIHN0YXRpYyBpbnQgcjVsX3JlY292ZXJ5X2xvZyhzdHJ1Y3QgcjVsX2xvZyAqbG9nKQogCXBv
cyA9IGN0eC0+cG9zOwogCWN0eC0+c2VxICs9IDEwMDAwOwogCisJcHJfaW5mbygiJXMgZmluaXNo
ZWQgc2Nhbm5pbmcgd2l0aCBjdHgtPnBvcyAlbGx1IGN0eC0+c2VxICVsbHUiLAorCQlfX2Z1bmNf
XywgY3R4LT5wb3MsIGN0eC0+c2VxKTsKKwogCWlmICgoY3R4LT5kYXRhX29ubHlfc3RyaXBlcyA9
PSAwKSAmJiAoY3R4LT5kYXRhX3Bhcml0eV9zdHJpcGVzID09IDApKQogCQlwcl9pbmZvKCJtZC9y
YWlkOiVzOiBzdGFydGluZyBmcm9tIGNsZWFuIHNodXRkb3duXG4iLAogCQkJIG1kbmFtZShtZGRl
dikpOwotLSAKMi4yNC4xCgo=
--00000000000053e46805a6d087ab--
